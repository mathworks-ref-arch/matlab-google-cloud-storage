classdef testBlobId < matlab.unittest.TestCase
% TESTBLOBID This is a test for class gcp.storage.BlobId
%
%   USAGE
%
%   storage = gcp.storage.Storage();
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%   blobId = gcp.storage.BlobId.of(bucket.bucketName,"uniqueblobname")
%
%   Test focusses on BlobId creation methods
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
            % Creating Storage client for tearing down test buckets and
            % blobs
            storage = gcp.storage.Storage();
            write(testCase.logObj,'debug','Storage Client created');
            
            % Delete the blob after test
            write(testCase.logObj,'debug','Testing Blob Deletion method storage.delete');
            
            % Creating BlobId object
            blobId = gcp.storage.BlobId.of('uniquetestblobidbucket',"uniqueblobname");
            
            % Deleting test blobs to make test buckets empty and ready for
            % deletion
            tf = storage.deleteObject(blobId);
            testCase.verifyTrue(tf);
            
            %Create BucketSourceOption object to help with test bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Deleting Test buckets
            tf = storage.deleteObject('uniquetestblobidbucket', bucketSourceOption);
            testCase.verifyTrue(tf);
        end
    end
    
    methods (Test)
        function testBlobIdunit(testCase)
            storage = gcp.storage.Storage();
            write(testCase.logObj,'debug','Storage Client created');
            
            bucketInfo = gcp.storage.BucketInfo.of('uniquetestblobidbucket');
            write(testCase.logObj,'debug','Bucket Info created');
            
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            write(testCase.logObj,'debug','BucketTargetOption created');
            
            bucket = storage.create(bucketInfo,bucketTargetOption);
            write(testCase.logObj,'debug','Bucket created');
            
            % Create BlobTargetOption
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
            
            %Verify blobTargetOption Class and Handle
            write(testCase.logObj,'debug','Testing BlobTargetOption');
            
            testCase.verifyClass(blobTargetOption,'gcp.storage.Storage.BlobTargetOption');
            testCase.verifyNotEmpty(blobTargetOption.Handle);
            testCase.verifyClass(blobTargetOption.Handle,'com.google.cloud.storage.Storage$BlobTargetOption[]');
            
            % Create BlobInfo
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
            
            %Verify blobInfo Class and Handle of BlobInfo
            write(testCase.logObj,'debug','Testing BlobInfo');
            
            testCase.verifyClass(blobInfo,'gcp.storage.BlobInfo');
            testCase.verifyNotEmpty(blobInfo.Handle);
            testCase.verifyClass(blobInfo.Handle,'com.google.cloud.storage.BlobInfo');
            
            % Create Blob
            blob = storage.create(blobInfo, blobTargetOption);
            
            % Create BlobId
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            write(testCase.logObj,'debug','BlobId created');
            
            % Testing BlobId Object creation
            write(testCase.logObj,'debug','Testing BlobId Object');
            testCase.verifyNotEmpty(blobId);
            testCase.verifyClass(blobId,'gcp.storage.BlobId');
        end
        
    end
    
end

