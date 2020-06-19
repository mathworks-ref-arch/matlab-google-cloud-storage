classdef testBlob < matlab.unittest.TestCase
% TESTBLOB This is a test for class Blob and methods such as exists(),
% delete() and downloadTo()
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
            write(testCase.logObj,'debug','Testing testBlobConstructor');
            
            % Create storage Client
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption for constructing bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);           
            
            % Create BucketInfo for constructing bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket 
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            write(testCase.logObj,'debug','Bucket created');
            
            % Create BlobTargetOption for constructing Blob
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
            
            write(testCase.logObj,'debug','Testing BlobTargetOption');
            
            % Verify BlobTargetOption Class
            testCase.verifyClass(blobTargetOption,'gcp.storage.Storage.BlobTargetOption');
            
            % Verify Handle for BlobTargetOption Object
            testCase.verifyNotEmpty(blobTargetOption.Handle);
            
            % Verify Class for BlobTargetOption Handle
            testCase.verifyClass(blobTargetOption.Handle,'com.google.cloud.storage.Storage$BlobTargetOption[]');
            
            % Create BlobInfo
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");

            write(testCase.logObj,'debug','Testing BlobInfo');
            
            % Verify BlobInfo Class
            testCase.verifyClass(blobInfo,'gcp.storage.BlobInfo');
            
            % Verify Handle for BlobInfo Class exists
            testCase.verifyNotEmpty(blobInfo.Handle);
            
            % Verify Class for BlobInfo Handle
            testCase.verifyClass(blobInfo.Handle,'com.google.cloud.storage.BlobInfo');
            
            % Create Test Blob
            blob = storage.create(blobInfo, blobTargetOption);
            
            % Verify Blob Class
            testCase.verifyClass(blob,'gcp.storage.Blob');
            
            % Verify Handle for Blob exists
            testCase.verifyNotEmpty(blob.Handle);
            
            % Verify  class for Blob Handle
            testCase.verifyClass(blob.Handle,'com.google.cloud.storage.Blob');
            
            % Verify Class for Bucket properties bucketName and projectid
            testCase.verifyClass(blob.name,'string');
            testCase.verifyClass(blob.projectId,'string');
            
            %% Delete the blob after test
            
            write(testCase.logObj,'debug','Testing Blob Deletion method storage.delete');
            
            % Create BlobId
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            
            % Verify Class for BlobId
            testCase.verifyClass(blobId,'gcp.storage.BlobId');
            
            % Verify Handle for BlobId Class exists
            testCase.verifyNotEmpty(blobId.Handle);
            
            % Verify Class for BlobId HAndle
            testCase.verifyClass(blobId.Handle,'com.google.cloud.storage.BlobId');
            
            % Delete Test Blob to empty Test Bucket
            tf = storage.deleteObject(blobId);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Verify Class for BucketTargetOption Object
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Storage.BucketSourceOption');
           
            % Verify Handle for BucketSourceOption class exists
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
            % Verify Class for BucketSourceOption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Storage$BucketSourceOption[]');
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
        end
        
        function testBlobdelete(testCase)
            write(testCase.logObj,'debug','Testing method Blob.delete()');
            
            % Create storage Client
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption for constructing bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);           
            
            % Create BucketInfo for constructing bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket 
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            write(testCase.logObj,'debug','Bucket created');

            % Creating Blob
            
            % Create BlobTargetOption for constructing Blob
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
            
            % Create BlobInfo
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
            
            % Create Test Blob
            blob = storage.create(blobInfo, blobTargetOption);
            
            % Verify Blob Class
            testCase.verifyClass(blob,'gcp.storage.Blob');
            
            % Verify Handle for Blob exists
            testCase.verifyNotEmpty(blob.Handle);
            
            % Verify  class for Blob Handle
            testCase.verifyClass(blob.Handle,'com.google.cloud.storage.Blob');

            % Verify Class for Blob properties name and projectid
            testCase.verifyClass(blob.name,'string');
            testCase.verifyClass(blob.projectId,'string');
            
            % Create BlobSourceOption
            blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;
            
            % Verify Class for BlobSourceOption object
            testCase.verifyClass(blobSourceOption,'gcp.storage.Blob.BlobSourceOption');
            
            % Verify Handle for BlobSourceOption Class exists
            testCase.verifyNotEmpty(blobSourceOption.Handle);
            
            % Verify Class for BlobSourceOption Handle
            testCase.verifyClass(blobSourceOption.Handle,'com.google.cloud.storage.Blob$BlobSourceOption[]');
            
            % Delete Test Blob
            tf = blob.delete(blobSourceOption);
            write(testCase.logObj,'debug','Testing Blob deletion');
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Verify Class for BucketTargetOption Object
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Storage.BucketSourceOption');
           
            % Verify Handle for BucketSourceOption class exists
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
            % Verify Class for BucketSourceOption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Storage$BucketSourceOption[]');
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
        end
        
        function testBlobdownloadTo(testCase)
            write(testCase.logObj,'debug','Testing method Blob.downloadTo()');

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
            
            write(testCase.logObj,'debug','Blob created. Now testing download to a local folder');
            
            % Downloading the remote blob object to a
            % downloadLocation on local file system
            % Using default temporary directory for download
            downloadLocation = tempdir;
            blob.downloadTo(downloadLocation);
            
            % Finding parser for given OS
            % parser = filesep;            
            
            % Verify if file exists on the specified path
            % 'downloadLocation'
            tf = isfile(char(strcat(downloadLocation,blob.name)));
            testCase.verifyTrue(tf);
            
            % Inject delay to avoid incomplete downloads
            pause(1)
            
            % Clearing local file after test completion
            delete(char(strcat(downloadLocation,blob.name)))
            
            %% Delete the blob after test
            
            % Construct BlobSourceOption for blob.delete()
            blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;          
            
            % Delete blob to empty Test bucket
            tf = blob.delete( blobSourceOption);
            
            % Verify if Blob deleted successfully
            testCase.verifyTrue(tf);
            
            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            
            % Create BucketSourceOption
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if Test bucket deleted successfully
            testCase.verifyTrue(tf);
                
        end
        
        function testBlobexists(testCase)
            write(testCase.logObj,'debug','Testing method Blob.exists()');
            
            % Create storage Client
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption for constructing bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);           
            
            % Create BucketInfo for constructing bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket 
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            write(testCase.logObj,'debug','Bucket created');

            % Creating Blob
            
            % Create BlobTargetOption for constructing Blob
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
            
            % Create BlobInfo
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
            
            % Create Test Blob
            blob = storage.create(blobInfo, blobTargetOption);
            
            % Verify Blob Class
            testCase.verifyClass(blob,'gcp.storage.Blob');
            
            % Verify Handle for Blob exists
            testCase.verifyNotEmpty(blob.Handle);
            
            % Verify  class for Blob Handle
            testCase.verifyClass(blob.Handle,'com.google.cloud.storage.Blob');

            % Verify Class for Blob properties name and projectid
            testCase.verifyClass(blob.name,'string');
            testCase.verifyClass(blob.projectId,'string');
            
            % Create Blob.BlobSourceOption for blob.exists()
            blobSourceOption = gcp.storage.Blob.BlobSourceOption.userProject(blob.projectId);
            
            % Query if Test Blob exists remotely
            tf = blob.exists(blobSourceOption);
            testCase.verifyTrue(tf);
            
            %% Delete the blob after test
            
            write(testCase.logObj,'debug','Testing Blob Deletion method storage.delete');
            
            % Create BlobId
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            
            % Verify Class for BlobId
            testCase.verifyClass(blobId,'gcp.storage.BlobId');
            
            % Verify Handle for BlobId Class exists
            testCase.verifyNotEmpty(blobId.Handle);
            
            % Verify Class for BlobId HAndle
            testCase.verifyClass(blobId.Handle,'com.google.cloud.storage.BlobId');
            
            % Delete Test Blob to empty Test Bucket
            tf = storage.deleteObject(blobId);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Verify Class for BucketTargetOption Object
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Storage.BucketSourceOption');
           
            % Verify Handle for BucketSourceOption class exists
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
            % Verify Class for BucketSourceOption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Storage$BucketSourceOption[]');
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
        end
        
    end
    
end

