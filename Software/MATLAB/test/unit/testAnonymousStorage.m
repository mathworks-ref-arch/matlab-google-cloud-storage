classdef testAnonymousStorage < matlab.unittest.TestCase
% TESTANONYMOUSSTORAGE This is a test for anonymous storage client and
% functions 'makeBucketPublic.m', 'makeObjectPublic.m' and 'downloadPublicDataset.m'
%
% Copyright 2020 The MathWorks, Inc.
%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Please add your test cases below
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties
        logObj
    end
    
    methods (TestMethodSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLevel = 'verbose';
        end
    end
    
    methods (TestMethodTeardown)
        function testTearDown(testCase)
            
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            write(testCase.logObj,'debug','Testing testAnonymousStorageConstructor');
            
            % Create storage Client
            astorage = gcp.storage.AnonymousStorage;
            
            write(testCase.logObj,'debug','Anonymous Storage Client created');
            
            %Verify the object class
            testCase.verifyClass(astorage,'gcp.storage.AnonymousStorage');
            
            % Verify Handle for AnonymousStorage Class exists
            testCase.verifyNotEmpty(astorage.Handle);
            
            % Verify Class for AnonymousStorage Handle
            testCase.verifyClass(astorage.Handle,'com.google.cloud.storage.StorageImpl');
            
        end
        
        function testdownloadpublicdataset(testCase)
            write(testCase.logObj,'debug','Testing function downloadPublicDataset');
            
            % Create storage Client
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption for constructing bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo for constructing bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            write(testCase.logObj,'debug','Bucket created');
            
            % Create content for constructing Blob object
            x=magic(4);
            
            % Create Blob
            blob = bucket.create("uniqueblobname", x);
            
            write(testCase.logObj,'debug','Blob created.Now Testing ');
            
            % Making Object Public
            write(testCase.logObj,'debug','Blob created. Now testing makeObjectPublic');
            
            % Create Blob Id for making the Blob public
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            
            acl = makeObjectPublic(storage,blobId);
            
            % Verifying ACL for ALLUSERS
            write(testCase.logObj,'debug','Verifying ACL for ALLUSERS returned by makeObjectPublic');
            
            % Verify the acl response object class
            testCase.verifyClass(acl,'struct');
            
            % Verify Entity to be "allUsers"
            testCase.assertEqual(acl.entity,"allUsers");
            
            % Verify Role to be "READER"
            testCase.assertEqual(acl.Role,"READER");
            
            % Verify Handle Exists
            testCase.assertNotEmpty(acl.Handle);
            
            % Verify Handle class for ACL Java Object
            testCase.assertClass(acl.Handle,'com.google.cloud.storage.Acl');
            
            % Downloading the public blob object with unauthenticated
            % anonymous Storage client
            
            % Create storage Client
            astorage = gcp.storage.AnonymousStorage;
            
            % Using default temporary directory for download
            downloadLocation = tempdir;
            
            % Download public object blob
            fullfilepath = downloadPublicDataset(astorage,bucket.bucketName,blob.name, downloadLocation);
            
            % Verify if file exists on the specified path
            % 'downloadLocation'
            tf = isfile(char(fullfilepath));
            testCase.verifyTrue(tf);
            
            % Inject delay to avoid incomplete downloads
            pause(1)
            
            % Clearing local file after test completion
            delete(char(fullfilepath))
            
            
            %% Free up resources on test completion
            
            %% Delete the blobs after test
            
            % Delete Test Blobs to empty Test Bucket
            tf = storage.deleteObject(blobId);
            testCase.verifyTrue(tf); % Verify if successfully deleted

            %% Delete Test Bucket
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf);
            write(testCase.logObj,'debug','Bucket Deletion post test completion');
            
            write(testCase.logObj,'debug','Finished testing makeObjectPublic');
            write(testCase.logObj,'debug','Finished testing downloadPublicDataset');
            
            
        end
        
        function testmakebucketpublic(testCase)
            write(testCase.logObj,'debug','Testing function makeBucketPublic');
            
            % Create storage Client
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption for constructing bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo for constructing bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-')) '1']);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            write(testCase.logObj,'debug','Bucket created');
            
            % Create content for constructing Blob object
            x=magic(4);
            
            % Create Blob
            blob = bucket.create("uniqueblobname", x);
            
            write(testCase.logObj,'debug','Blob created.Now Testing Bucket being made public ');
            
            % make bucket public
            response = makeBucketPublic(storage,bucket.bucketName);
            
            % Downloading the public bucket objects with unauthenticated
            % anonymous Storage client without explicitly making the
            % objects public
            
            % Create storage Client
            astorage = gcp.storage.AnonymousStorage;
            
            % Get all Blobs in this public bucket for download test
            blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
            bloblist = bucket.list(blobListOption);
            
            % Using default temporary directory for download
            downloadLocation = tempdir;
            for i = 1:numel(bloblist)
                blob = bloblist{i};
                % Download public object blob
                fullfilepath = downloadPublicDataset(astorage,bucket.bucketName,blob.name, downloadLocation);
                
                % Verify if file exists on the specified path
                % 'downloadLocation'
                tf = isfile(char(fullfilepath));
                testCase.verifyTrue(tf);
                
                % Inject delay to avoid incomplete downloads
                pause(1)
                
                % Clearing local file after test completion
                delete(char(fullfilepath))
                               
            end
            
            %% Delete the blobs after test
            
            % Delete Test Blobs to empty Test Bucket
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            tf = storage.deleteObject(blobId);
            testCase.verifyTrue(tf); % Verify if successfully deleted
            
            %% Free up resources on test completion
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf);
            write(testCase.logObj,'debug','Bucket Deletion post test completion');
            write(testCase.logObj,'debug','Finished testing makeBucketPublic');
            write(testCase.logObj,'debug','Finished testing downloadPublicDataset');
        end
    end
    
end

