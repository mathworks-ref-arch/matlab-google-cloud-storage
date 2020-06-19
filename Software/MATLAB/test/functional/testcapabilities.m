classdef testcapabilities < matlab.unittest.TestCase
% TESTTESTCAPABILITIES This is a functional test of CRUD Operations
% 
% Copyright 2020 The MathWorks, Inc.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Please add your test cases below 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (TestMethodSetup)
        function testSetup(testCase)

        end
    end
    
    methods (TestMethodTeardown)
        function testTearDown(testCase)

        end
    end

    methods (Test)
        function testCRUDOperations(testCase)
             % TESTS ENTIRE CRUD FLOW FOR GCS PACKAGE
            %% Imports
            import com.google.cloud.storage.*;
            import com.google.cloud.storage.Storage;
            
            %% Creating storage client
            storage = gcp.storage.Storage();
            testCase.verifyClass(storage,'gcp.storage.Storage');
            
            %% Creating empty Bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            testCase.verifyClass(bucketInfo,'gcp.storage.BucketInfo');
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            testCase.verifyClass(bucketTargetOption,'gcp.storage.Storage.BucketTargetOption');
            bucket = storage.create(bucketInfo, bucketTargetOption);
            testCase.verifyClass(bucket, 'gcp.storage.Bucket');
            
            %% List Buckets
            bucketListOption = gcp.storage.Storage.BucketListOption.userProject(storage.projectId);
            testCase.verifyClass(bucketListOption,'gcp.storage.Storage.BucketListOption');
        
            buckets = storage.list(bucketListOption);
            testCase.verifyNotEmpty(buckets);
            %% Create data object (Blob) within Bucket
            x = magic(4);
            blob = bucket.create("unique_blobName",x);
            testCase.verifyClass(blob,'gcp.storage.Blob');
            %delete(char(blob.name));%clearing local mat file
            
            %% List Blobs within Bucket
            
            % Create info blobListOption for project
            blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
            testCase.verifyClass(blobListOption,'gcp.storage.Storage.BlobListOption');
            
            %Query and List Blobs in this project
            blobs = bucket.list(blobListOption);
            testCase.verifyNotEmpty(blobs);
            
            %% Download Blob
            downloadpath=tempdir;
            blob.downloadTo(downloadpath)%provide custom path

            %% Removing local mat file
            delete([downloadpath char(blob.name)]);
            
            %% GetBlobInfo
            
            % Get List of fields for querying information about blobs
            blobfields = gcp.storage.Storage.BlobField;
            
            % Create blobGetOption using the above fields before querying the blob information
            blobGetOption = gcp.storage.Storage.BlobGetOption.fields(blobfields);
            testCase.verifyClass(blobGetOption,'gcp.storage.Storage.BlobGetOption');
            
            % Query and get Blob Information and(or) Blob content
            blob = bucket.get(blob.name,blobGetOption);
            
            %% Read All content from Blob
            blobContent = storage.readAllBytes(string(bucket.bucketName),string(blob.name));
            testCase.verifyNotEmpty(blobContent);
            % Removing local mat file
            delete(char(blob.name));
            
            %% Creating BlobsourceOptions
            deleteblobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;
            checkblobSourceOption = gcp.storage.Blob.BlobSourceOption.userProject(blob.projectId);
            
            %% Deleting Blob
            blob.delete(deleteblobSourceOption);
            
            %% Check if blob Exists
            checkBlob = blob.exists(checkblobSourceOption);
            testCase.verifyFalse(checkBlob);
            %% Creating BucketsourceOptions
            bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
            
            %% Deleting Bucket (Bucket Needs to be empty)
            bucket.delete(bucketSourceOption);
            
            %% Check if bucket Exists
            checkBucket = bucket.exists(bucketSourceOption);
            testCase.verifyFalse(checkBucket);
        end

    end
    
end

