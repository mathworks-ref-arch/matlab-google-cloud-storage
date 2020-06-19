classdef testBucket < matlab.unittest.TestCase
    % TESTBUCKET Unit Test for Bucket Class and methods such as create(),
    % delete(), exists(), get(), list()
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
            write(testCase.logObj,'debug','Testing testBucketConstructor');
            
            % Create the storage Client
            storage = gcp.storage.Storage();           
            
            % Create BucketTargetOption for constructing Bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            write(testCase.logObj,'debug','Testing BucketTargetOption');
            
            % Verify Class for BucketTargetOption Handle
            testCase.verifyClass(bucketTargetOption,'gcp.storage.Storage.BucketTargetOption');
            
            % Verify Handle for BucketTargetOption exists
            testCase.verifyNotEmpty(bucketTargetOption.Handle);
            
            % Verify Class for BucketTargetOption Handle
            testCase.verifyClass(bucketTargetOption.Handle,'com.google.cloud.storage.Storage$BucketTargetOption[]');
            
            % Create BucketInfo for constructing Bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
                       
            write(testCase.logObj,'debug','Testing BucketInfo');
            
            % Verify BucketInfo Class
            testCase.verifyClass(bucketInfo,'gcp.storage.BucketInfo');
            
            % Verify Handle for BucketInfo Class exists
            testCase.verifyNotEmpty(bucketInfo.Handle);
            
            % Verify Class for BucketInfo Handle
            testCase.verifyClass(bucketInfo.Handle,'com.google.cloud.storage.BucketInfo');
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            write(testCase.logObj,'debug','Bucket Created');
            
            % Verify Class for Bucket
            testCase.verifyClass(bucket,'gcp.storage.Bucket');
            
            % Verify if Handle exists for Bucket
            testCase.verifyNotEmpty(bucket.Handle);
            
            % Verify class for Bucket Handle
            testCase.verifyClass(bucket.Handle,'com.google.cloud.storage.Bucket');
            
            % Verify Class for Bucket properties bucketName and projectid
            testCase.verifyClass(bucket.bucketName,'string');
            testCase.verifyClass(bucket.projectId,'string');
            
            % Delete the bucket after test
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
           
            % Verify Class for BucketSourceOption
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Storage.BucketSourceOption');
            
            % Verify Handle for BucketSourceOption Class
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
            % Verify Class for BucketSourceOption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Storage$BucketSourceOption[]');
            
            % Delete Test Bucket
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf);           
        end
        
        function testBucketcreate(testCase)
            write(testCase.logObj,'debug','Testing Bucket.create() method');
            
            % Creating Storage client
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption for constructing Test Bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo for constructing Test Bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
           
            % Create content for upload
            x = magic(4);
            
            % Save content in temporary File
            save('mydata.mat','x');
            
            % Create Test Blobs using all function signatures in
            % bucket.create()
            
            % Input arguments : Blobname and Filename for upload
            blob1 = bucket.create("unique_blobName1",'mydata.mat');
            
            % Input arguments : Blobname and Workspace variable
            blob2 = bucket.create("unique_blobName2",x);
            
            % Input arguments : Blobname and string
            blob3 = bucket.create("unique_blobName3","hi, how are you?");
            
            % Verify Blob Class for all Test Blobs
            testCase.verifyClass(blob1,'gcp.storage.Blob');
            testCase.verifyClass(blob2,'gcp.storage.Blob');
            testCase.verifyClass(blob3,'gcp.storage.Blob');
            
            %Verify Handle for Blob Objects
            testCase.verifyNotEmpty(blob1.Handle);
            testCase.verifyNotEmpty(blob2.Handle);
            testCase.verifyNotEmpty(blob3.Handle);
            
            %Verify Class for Blob Object Handle
            testCase.verifyClass(blob1.Handle,'com.google.cloud.storage.Blob');
            testCase.verifyClass(blob2.Handle,'com.google.cloud.storage.Blob');
            testCase.verifyClass(blob3.Handle,'com.google.cloud.storage.Blob');
            
            % Verify Class for Blob Object properties name and projectid
            testCase.verifyClass(blob1.name,'string');
            testCase.verifyClass(blob1.projectId,'string');
            testCase.verifyClass(blob2.name,'string');
            testCase.verifyClass(blob2.projectId,'string');
            testCase.verifyClass(blob3.name,'string');
            testCase.verifyClass(blob3.projectId,'string');
            
            %% Delete the blobs after test
            write(testCase.logObj,'debug','Testing Blob Deletion method storage.deleteObject');
            
            % Create BlobId for all Test Blobs
            blobId1 = gcp.storage.BlobId.of(bucket.bucketName,blob1.name);
            blobId2 = gcp.storage.BlobId.of(bucket.bucketName,blob2.name);
            blobId3 = gcp.storage.BlobId.of(bucket.bucketName,blob3.name);
            
            % Verify Class for BlobInfo Object created above
            testCase.verifyClass(blobId1,'gcp.storage.BlobId');
            testCase.verifyNotEmpty(blobId1.Handle);
            testCase.verifyClass(blobId1.Handle,'com.google.cloud.storage.BlobId');
            
            % Verify Handle exists for BlobInfo Objects
            testCase.verifyClass(blobId2,'gcp.storage.BlobId');
            testCase.verifyNotEmpty(blobId2.Handle);
            testCase.verifyClass(blobId2.Handle,'com.google.cloud.storage.BlobId');
            
            % Verify class for BlobInfo Handle
            testCase.verifyClass(blobId3,'gcp.storage.BlobId');
            testCase.verifyNotEmpty(blobId3.Handle);
            testCase.verifyClass(blobId3.Handle,'com.google.cloud.storage.BlobId');
            
            % Delete Test Blobs to empty Test Bucket
            tf = storage.deleteObject(blobId1);
            testCase.verifyTrue(tf); % Verify if successfully deleted
                        
            tf = storage.deleteObject(blobId2);
            testCase.verifyTrue(tf); % Verify if successfully deleted
                        
            tf = storage.deleteObject(blobId3);
            testCase.verifyTrue(tf); % Verify if successfully deleted
            
            % Deleting static files created temporarily
             delete mydata.mat;
            

            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            
            % Create BucketSourceOption for bucket.delete()
            bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
            
            % Verify bucketSourceOption Class
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Bucket.BucketSourceOption');
            
            % Verify Handle for BucketSourceOption Class
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
            % Verify class for BucketsourceOption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Bucket$BucketSourceOption[]');
            
            % Delete Bucket
            tf = bucket.delete(bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
            
        end
        
        function testBucketdelete(testCase)
            write(testCase.logObj,'debug','Testing Bucket.delete() method');
            
            % Create Storage Client
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption for constructing Test Bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo for constructing Test Bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);

            % Create BucketSourceOption for bucket.delete()
            bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
            
            % Verify bucketSourceOption Class
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Bucket.BucketSourceOption');
            
            % Verify Handle for BucketSourceOption Class
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
            % Verify class for BucketsourceOption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Bucket$BucketSourceOption[]');
            
            % Delete Bucket
            tf = bucket.delete(bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
        end
        
        function testBucketexists(testCase)
            write(testCase.logObj,'debug','Testing Bucket.exists() method');
            
            % Create Storage Client
            storage = gcp.storage.Storage();
            
            % Create bucketTargetOption for constructing bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo for constructing bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
           
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            % Create BucketSourceOption for bucket.exists method
            bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
            
            % Verify Class for BucketSourceOption
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Bucket.BucketSourceOption');
            
            % Verify Handle for BucketSourceOption
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
            % Verify Class for BucketSourceoption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Bucket$BucketSourceOption[]');
            
            % Query if Bucket exists
            tf = bucket.exists(bucketSourceOption);
            
            % Verify if existing bucket has been queried
            testCase.verifyTrue(tf);

            write(testCase.logObj,'debug','Testing Bucket Deletion method bucket.delete');
            
            % Deleting Test Bucket
            tf = bucket.delete(bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
        end
        
        function testBucketget(testCase)
            write(testCase.logObj,'debug','Testing Bucket.get() method');
            
            % Create Storage Client
            storage = gcp.storage.Storage();
           
            % Create BucketTargetOption for constructing Bucket
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo for constructing Bucket
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            % Create BlobTargetOption for constructing Blob
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
            
            % Testing BlobTargetOption Class and Handle
            write(testCase.logObj,'debug','Testing BlobTargetOption');
            
            % Verify Class for BlobTargetOption
            testCase.verifyClass(blobTargetOption,'gcp.storage.Storage.BlobTargetOption');
            
            % Verify Handle for BlobTargetOption
            testCase.verifyNotEmpty(blobTargetOption.Handle);
            
            % Verrfiy Class for BlobTargetOption Handle
            testCase.verifyClass(blobTargetOption.Handle,'com.google.cloud.storage.Storage$BlobTargetOption[]');
            
            % Create BlobInfo for constructing Blob
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
           
            write(testCase.logObj,'debug','Testing BlobInfo');
            % Verify BlobInfo Class
            testCase.verifyClass(blobInfo,'gcp.storage.BlobInfo');
            
            % Verify Handle for BlobInfo exists
            testCase.verifyNotEmpty(blobInfo.Handle);
            
            % Verify class for BlobInfo Handle
            testCase.verifyClass(blobInfo.Handle,'com.google.cloud.storage.BlobInfo');
            
            % Create Test Blob
            blob = storage.create(blobInfo, blobTargetOption);
            
            % Verify Blob Class
            testCase.verifyClass(blob,'gcp.storage.Blob');
            
            % Verify Blob Handle exists
            testCase.verifyNotEmpty(blob.Handle);
            
            % Verify Class for Blob Handle
            testCase.verifyClass(blob.Handle,'com.google.cloud.storage.Blob');
            
            % Verify Class for Blob properties name and projectid
            testCase.verifyClass(blob.name,'string');
            testCase.verifyClass(blob.projectId,'string');
            
            blobName = blob.name;
            
            % Create BlobFields for getting Blob content
            blobfields = gcp.storage.Storage.BlobField;
            write(testCase.logObj,'debug','Testing class Blobfield');
            
            % Verify Class for BlobField
            testCase.verifyClass(blobfields,'gcp.storage.Storage.BlobField');
            
            % Create BlobGetOption using Blobfields
            blobGetOption = gcp.storage.Storage.BlobGetOption.fields(blobfields);
            write(testCase.logObj,'debug','Testing class BlobGetOption');
            
            % Verify Class for BlobGetOption
            testCase.verifyClass(blobGetOption,'gcp.storage.Storage.BlobGetOption');
            
            % Verify Handle for BlobGetOption exists
            testCase.verifyNotEmpty(blobGetOption.Handle);
            
            % Verify Class for BlobGetOption class
            testCase.verifyClass(blobGetOption.Handle,'com.google.cloud.storage.Storage$BlobGetOption[]');
            
            % Get Blob using BlobGetOption
            blob = bucket.get(blobName,blobGetOption);
            
            % Verify Blob Class
            testCase.verifyClass(blob,'gcp.storage.Blob');
            
            % Verify Handle for Blob exists
            testCase.verifyNotEmpty(blob.Handle);
            
            % Verify Class for Blob Handle
            testCase.verifyClass(blob.Handle,'com.google.cloud.storage.Blob');
            
            % Verify Class for Blob properties bucketName and projectid
            testCase.verifyClass(blob.name,'string');
            testCase.verifyClass(blob.projectId,'string');
            
            
            %% Delete the blob after test
            write(testCase.logObj,'debug','Testing Blob Deletion method storage.deleteObject');
            
            % Create BlobId for Test Blob
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            
            % Delete Test Blob to empty Test Bucket
            tf = storage.deleteObject(blobId);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf); 
            
            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf);

            
        end
        
        function testBucketlist(testCase)
            write(testCase.logObj,'debug','Testing Bucket.list() method');
            % Create Storage Client
            storage = gcp.storage.Storage();
            
            % Creating BucketTargetOption
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            % Create Blob Target Option for Storage Client
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
           
            % Creating multiple Test Blobs
            blob1 = storage.create(gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"abc"),blobTargetOption);
            blob2 = storage.create(gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"def"),blobTargetOption);
            blob3 = storage.create(gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"ghi"),blobTargetOption);
            
            % Creating BlobListOption for Listing Blobs
            blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
            blobListOption1 = gcp.storage.Storage.BlobListOption.prefix("g");
            
            % Verify class for BlobListOption
            testCase.verifyClass(blobListOption,'gcp.storage.Storage.BlobListOption');
            
            % Verify Handle for BlobListOption exists
            testCase.verifyNotEmpty(blobListOption.Handle);
            
            % Verify Class for BlobListOption Handle
            testCase.verifyClass(blobListOption.Handle,'com.google.cloud.storage.Storage$BlobListOption');
                 
            write(testCase.logObj,'debug','Testing BlobList');           

            % List Blobs
            [blobList, blobStructArray] = bucket.list(blobListOption,blobListOption1);
            
            % blobListOption alone ensure 3 blobs being listed
            % blobListOption and blobListOption1 together ensure only one
            % blob being listed
                        
            % Verify Class for BlobList
            testCase.verifyClass(blobList,'cell');
            
            % Verify only 1 blob returned in the list based on list options
            % provided
            
            testCase.verifyEqual(numel(blobList),1);
            
            % Verify Class for Array of structures containing Blob information
            testCase.verifyClass(blobStructArray,'cell');
            
            % Verify BlobList is not empty
            testCase.verifyNotEmpty(blobList);
            
            % Accessing Blob from BlobList
            blobfromlist = blobList{1};  
            
            % Verifying Blob accessed is not empty
            testCase.verifyNotEmpty(blobfromlist.Handle);
            
            % Verifying Class for Blob accessed
            testCase.verifyClass(blobfromlist.Handle,'com.google.cloud.storage.Blob');
            
            % Accessing BlobInfo from BlobStructArray
            blobinfo = blobStructArray{1};  
            
            % Verifying BlobInfo struct is not empty
            testCase.verifyNotEmpty(blobinfo);
            
            % Verifying Class for BlobInfo struct accessed
            testCase.verifyClass(blobinfo,'struct');
            
            %% Delete the blob after test
            write(testCase.logObj,'debug','Testing Blob Deletion method storage.deleteObject');
            
            % Create BlobId for all Test Blobs
            blobId1 = gcp.storage.BlobId.of(bucket.bucketName,blob1.name);
            blobId2 = gcp.storage.BlobId.of(bucket.bucketName,blob2.name);
            blobId3 = gcp.storage.BlobId.of(bucket.bucketName,blob3.name);
                        
            % Delete Test Blobs empty Test Buckets
            tf = storage.deleteObject(blobId1);
            testCase.verifyTrue(tf); % Verify if deleted successfully
            
            tf = storage.deleteObject(blobId2);
            testCase.verifyTrue(tf); % Verify if deleted successfully
            
            tf = storage.deleteObject(blobId3);
            testCase.verifyTrue(tf); % Verify if deleted successfully
            
            %% Delete the bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion method storage.deleteObject');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf);
        end
        
    end
    
end

