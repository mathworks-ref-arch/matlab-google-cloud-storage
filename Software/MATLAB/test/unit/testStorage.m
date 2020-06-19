classdef testStorage < matlab.unittest.TestCase
    % TESTSTORAGE Unit Test for Storage Class and methods such as create(),
    % get(), list(), deleteObject() and readAllBytes()
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
            write(testCase.logObj,'debug','Testing testStorageConstructor');
            % Create the object
            actSolution = gcp.storage.Storage();%storage client
            
            %Verify the object class
            testCase.verifyClass(actSolution,'gcp.storage.Storage');
        end
        
        function testHandle(testCase)
            write(testCase.logObj,'debug','Testing storage Handle');
            
            %Create storage Object
            storage = gcp.storage.Storage();
            
            %Verify if Handle exists and is not empty
            testCase.verifyNotEmpty(storage.Handle);
            
            %Verify if Handle is of the right class
            testCase.verifyClass(storage.Handle,'com.google.cloud.storage.StorageImpl');
        end
        
        function testStoragecreate(testCase)
            write(testCase.logObj,'debug','Testing testStoragecreate method'); 
            
            % Create Storage Client
            storage = gcp.storage.Storage();
            
            %% Creating bucket for testing storage.get for return type bucket
            
            % Create BucketTargetOption
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
               
            write(testCase.logObj,'debug','Testing class bucketTargetOption');
            % Verify Class for BucketTargetOption
            testCase.verifyClass(bucketTargetOption,'gcp.storage.Storage.BucketTargetOption');
            
            % Verify Handle for BucketTargetOption exists
            testCase.verifyNotEmpty(bucketTargetOption.Handle);
            
            % Verify Class for BucketTargetOption Handle
            testCase.verifyClass(bucketTargetOption.Handle,'com.google.cloud.storage.Storage$BucketTargetOption[]');
            
            % Create BucketInfo
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);

            
            % Verify BucketInfo Class and Handle
            write(testCase.logObj,'debug','Testing class bucketInfo');
             
            % Verify Class for BucketInfo
            testCase.verifyClass(bucketInfo,'gcp.storage.BucketInfo');
            
            % Verify HAndle for BucketInfo exists
            testCase.verifyNotEmpty(bucketInfo.Handle);
            
            % Verify Class for BucketInfo Handle exists
            testCase.verifyClass(bucketInfo.Handle,'com.google.cloud.storage.BucketInfo');
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            % Verify Class for Bucket
            testCase.verifyClass(bucket,'gcp.storage.Bucket');
            
            % Verify if Bucket Handle exists
            testCase.verifyNotEmpty(bucket.Handle);
            
            % Verify Class for Bucket Handle
            testCase.verifyClass(bucket.Handle,'com.google.cloud.storage.Bucket');
            
            % Create BlobInfo
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
            
            % Create BlobTargetOption
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
            
            % Create Test Blob
            blob = storage.create(blobInfo, blobTargetOption);
            
            % Verify Class for Bucket properties bucketName and projectid
            testCase.verifyClass(bucket.bucketName,'string');
            testCase.verifyClass(bucket.projectId,'string');
            
            % Verify Class for Blob
            testCase.verifyClass(blob,'gcp.storage.Blob');
            
            %Verify if Blob exists
            testCase.verifyNotEmpty(blob.Handle);
            
            %Verify Class for Blob Handle
            testCase.verifyClass(blob.Handle,'com.google.cloud.storage.Blob');
            
            %Verify Class for Blob properties name and projectid
            testCase.verifyClass(blob.name,'string');
            testCase.verifyClass(blob.projectId,'string');

           %% Delete the blob after test to make bucket empty
            write(testCase.logObj,'debug','Testing Blob Deletion using method storage.deleteObject()');
            
            % Create BlobId object
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            
            %Verify Class for BlobInfo
            testCase.verifyClass(blobId,'gcp.storage.BlobId');
            
            %Verify BlobInfo is not empty
            testCase.verifyNotEmpty(blobId.Handle);
            
            %Verify Class for BlobInfo Handle
            testCase.verifyClass(blobId.Handle,'com.google.cloud.storage.BlobId');
            
            % Delete Test Blob to empty Test Bucket
            tf = storage.deleteObject(blobId);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf);
            
            %% Delete the empty bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion using method storage.deleteObject()');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Verify Class for BucketSourceOption
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Storage.BucketSourceOption');
            
            % Verify BucketSourceOption is not empty
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            
             % Verify Class for BucketSourceOption Handle
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Storage$BucketSourceOption[]');
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if deleted successfully
            testCase.verifyTrue(tf);

        end
        
        function testStoragelist(testCase)
            write(testCase.logObj,'debug','Testing storage.list() for Buckets and Blobs');
            % Create the client and initialize
            storage = gcp.storage.Storage();
            
            % Create BucketTargetOption
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            
            % Create BucketInfo
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
            
            % Create BucketListOption
            bucketListOption1 = gcp.storage.Storage.BucketListOption.userProject(storage.projectId);
            bucketListOption2 = gcp.storage.Storage.BucketListOption.prefix("pf");
           
            % Get Bucket List
            [bucketList, bucketStructArray] = storage.list(bucketListOption1,bucketListOption2);
            
            % Verify Class for BucketList
            testCase.verifyEqual(class(bucketList),'cell');
            
            % Verify Class for BucketList
            testCase.verifyEqual(class(bucketStructArray),'cell');
            
            % Verify BucketList is not empty
            testCase.verifyNotEmpty(bucketList);
            
            % Verify Class for Bucket within BucketListArray
            bucketnew = bucketList{1};
            testCase.verifyClass(bucketnew,'gcp.storage.Bucket');
            
            % Verify Class for BucketStruct within InfoCellArray
            bucketinfo = bucketStructArray{1};
            testCase.verifyNotEmpty(bucketinfo);
            testCase.verifyClass(bucketinfo,'struct');
            
            % Create a Blob
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(bucket.projectId);
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
            blob1 = storage.create(blobInfo,blobTargetOption);
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname1");
            blob2 = storage.create(blobInfo,blobTargetOption);
            
            % Get Blob List
            blobListOption1 = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
            blobListOption2 = gcp.storage.Storage.BlobListOption.prefix("un");
            [blobList, blobStructArray] = storage.list(bucket.bucketName,blobListOption1,blobListOption2);
            
            % Verify Class for BlobList
            testCase.verifyEqual(class(blobList),'cell');
            
            % Verify Class for BlobStructArray
            testCase.verifyEqual(class(blobStructArray),'cell');
                                               
            % Verify BlobList is not empty
            testCase.verifyNotEmpty(blobList);
            testCase.verifyNotEmpty(blobStructArray);
            
            % Verify class of object Blob within BlobListArray
            blobget = blobList{1};
            testCase.verifyClass(blobget,'gcp.storage.Blob');
            
            % Verify Class for BlobStruct within InfoCellArray
            blobinfo = blobStructArray{1};
            testCase.verifyClass(blobinfo,'struct');
            
            %% Delete the blob after test to make bucket empty
            write(testCase.logObj,'debug','Testing Blob Deletion using method storage.deleteObject()');
            
            % create BlobId
            blobId1 = gcp.storage.BlobId.of(bucket.bucketName,blob1.name);
            blobId2 = gcp.storage.BlobId.of(bucket.bucketName,blob2.name);
            % Verify Class for BlobInfo Handle
            testCase.verifyClass(blobId1,'gcp.storage.BlobId');
            testCase.verifyNotEmpty(blobId1.Handle);
            testCase.verifyClass(blobId1.Handle,'com.google.cloud.storage.BlobId');
            
            % Delete Test Blob to empty Test Bucket
            tf = storage.deleteObject(blobId1);
            testCase.verifyTrue(tf);
            tf = storage.deleteObject(blobId2);
            testCase.verifyTrue(tf);
            %% Delete the empty bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion using method storage.deleteObject()');
            
            % Create BucketSourceOption
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Verify Class for BucketTargetOption Handle
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Storage.BucketSourceOption');
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Storage$BucketSourceOption[]');
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if Bucket deleted successfully
            testCase.verifyTrue(tf);
                        
        end
        
        function testStorageget(testCase)
           write(testCase.logObj,'debug','Testing testStorageGet method');
           
            storage = gcp.storage.Storage();
            %% Creating bucket for testing storage.get for return type bucket
            
            % Create BucketTargetOption
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
           
            % Verify Class for BucketTargetOption Handle
            write(testCase.logObj,'debug','Testing class bucketTargetOption');
            
            testCase.verifyClass(bucketTargetOption,'gcp.storage.Storage.BucketTargetOption');
            testCase.verifyNotEmpty(bucketTargetOption.Handle);
            testCase.verifyClass(bucketTargetOption.Handle,'com.google.cloud.storage.Storage$BucketTargetOption[]');
            
            % Create BucketInfo
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Verify Class for BucketInfo Handle
            write(testCase.logObj,'debug','Testing class bucketInfo');
             
            testCase.verifyClass(bucketInfo,'gcp.storage.BucketInfo');
            testCase.verifyNotEmpty(bucketInfo.Handle);
            testCase.verifyClass(bucketInfo.Handle,'com.google.cloud.storage.BucketInfo');
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
           
            % Cretae BucketField for constructing BucketGetOption
            bucketfields = gcp.storage.Storage.BucketField;
            write(testCase.logObj,'debug','Testing class BucketField');
            testCase.verifyClass(bucketfields,'gcp.storage.Storage.BucketField');
            
            % Create BucketGetOption
            bucketGetOption = gcp.storage.Storage.BucketGetOption.fields(bucketfields);
            write(testCase.logObj,'debug','Testing class BucketGetOption');
            testCase.verifyClass(bucketGetOption,'gcp.storage.Storage.BucketGetOption');
            testCase.verifyNotEmpty(bucketGetOption.Handle);
            testCase.verifyClass(bucketGetOption.Handle,'com.google.cloud.storage.Storage$BucketGetOption[]');
            
            % Getting Bucket
            bucketget = storage.get(bucket.bucketName, bucketGetOption);
            write(testCase.logObj,'debug','Got bucket information. Now verifying..');
            
            % Verify Class for Bucket obtained by BucketGetOption
            testCase.verifyClass(bucketget,'gcp.storage.Bucket');
            
            % Verify Bucket Handle exists
            testCase.verifyNotEmpty(bucket.Handle);
            
            % Verify Class for Bucket Handle
            testCase.verifyClass(bucket.Handle,'com.google.cloud.storage.Bucket');
            
            %% Creating Blobs for testing storage.get() for return type blob
            
            %  Create BlobTargetOption
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
            write(testCase.logObj,'debug','Testing class BlobTargetOption');
            
            % Verify BlobTargetOption Class and Handle
            testCase.verifyClass(blobTargetOption,'gcp.storage.Storage.BlobTargetOption');
            testCase.verifyNotEmpty(blobTargetOption.Handle);
            testCase.verifyClass(blobTargetOption.Handle,'com.google.cloud.storage.Storage$BlobTargetOption[]');
            
            % Create BlobInfo
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
            
            % Verify BlobInfo Class and Handle
            write(testCase.logObj,'debug','Testing class BlobInfo');
            testCase.verifyClass(blobInfo,'gcp.storage.BlobInfo');
            testCase.verifyNotEmpty(blobInfo.Handle);
            testCase.verifyClass(blobInfo.Handle,'com.google.cloud.storage.BlobInfo');
            
            % Create Blob
            blob = storage.create(blobInfo, blobTargetOption);
            write(testCase.logObj,'debug','Created blob');

            %% Testing BlobField and BlobGetOption
            
            % Create BlobInfo for BlobGetOption construction
            blobfields = gcp.storage.Storage.BlobField;
            write(testCase.logObj,'debug','Testing class Blobfield');
            testCase.verifyClass(blobfields,'gcp.storage.Storage.BlobField');
            
            % Create BlobGetOption to query Blob Info
            blobGetOption = gcp.storage.Storage.BlobGetOption.fields(blobfields);
            write(testCase.logObj,'debug','Testing class BlobGetOption');
            testCase.verifyClass(blobGetOption,'gcp.storage.Storage.BlobGetOption');
            testCase.verifyNotEmpty(blobGetOption.Handle);
            testCase.verifyClass(blobGetOption.Handle,'com.google.cloud.storage.Storage$BlobGetOption[]');
            
            % Get Blob Information
            blob = storage.get(bucket.bucketName,blob.name,blobGetOption);
            write(testCase.logObj,'debug','Got blob information. Now verifying..');
            
            %% Verify blob Class
            testCase.verifyClass(blob,'gcp.storage.Blob');
            
            % Verify Blob Handle exists
            testCase.verifyNotEmpty(blob.Handle);
            
            % Verify Blob Handle Class
            testCase.verifyClass(blob.Handle,'com.google.cloud.storage.Blob');
            
            % Verify Class for Blob properties
            testCase.verifyClass(blob.name,'string');
            testCase.verifyClass(blob.projectId,'string');

           %% Delete the blob after test to make bucket empty
            write(testCase.logObj,'debug','Testing Blob Deletion using method storage.deleteObject()');
           
            % Create BlobId object
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            
            % Verify BlobInfo Class and Handle
            testCase.verifyClass(blobId,'gcp.storage.BlobId');
            testCase.verifyNotEmpty(blobId.Handle);
            testCase.verifyClass(blobId.Handle,'com.google.cloud.storage.BlobId');
            
            % Delete Test Blob to empty Bucket
            tf = storage.deleteObject(blobId);
            testCase.verifyTrue(tf);
            
            %% Delete the empty bucket after test
            write(testCase.logObj,'debug','Testing Bucket Deletion using method storage.deleteObject()');
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Verify BucketTargetOption Class and Handle
            testCase.verifyClass(bucketSourceOption,'gcp.storage.Storage.BucketSourceOption');
            testCase.verifyNotEmpty(bucketSourceOption.Handle);
            testCase.verifyClass(bucketSourceOption.Handle,'com.google.cloud.storage.Storage$BucketSourceOption[]');
            
            % Delete Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if Delete Successfully
            testCase.verifyTrue(tf);

        end
        
        function testStoragedelete(testCase)
            write(testCase.logObj,'debug','Testing testStorageGet method');
            
            % Create Storage Client 
            storage = gcp.storage.Storage();
            %% Creating bucket for testing storage.get for return type bucket
            
            % Create BucketTargetOption
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);

            % Create BucketInfo
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
        
            %% Creating Blobs for testing storage.get() for return type blob
            
            % Create BlobTargetOption
            blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
          
            % Create BlobInfo
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
                      
            % Create Blob
            blob = storage.create(blobInfo, blobTargetOption);
           
            % Create BlobId
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            tf = storage.deleteObject(blobId);
            testCase.verifyTrue(tf);
            
            % Create BucketSourceOption object to help bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            testCase.verifyTrue(tf);

        end
        
        function testStoragereadAllbytes(testCase)
            write(testCase.logObj,'debug','Testing testStoragereadAllbytes method');
            
            % Create Storage Client   
            storage = gcp.storage.Storage();
            
            %% Creating bucket for testing storage.get for return type bucket
            
            % Create BucketTargetOption
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);

            % Create BucketInfo
            bucketInfo = gcp.storage.BucketInfo.of([storage.projectId '-' char(replace(string(now),{'.'},'-'))]);
            
            % Create Test Bucket
            bucket = storage.create(bucketInfo, bucketTargetOption);
        
            %% Creating Blobs for testing storage.get() for return type blob
                      
            % Create Test Blob
            blob = bucket.create("newblob", 2);           
            storage.readAllBytes(bucket.bucketName,blob.name);
            delete(char(blob.name))  
            
            % Clean up Test Blob and Bucket
            blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);
            tf = storage.deleteObject(blobId);
            testCase.verifyTrue(tf);
            
            % Create BucketSourceOption to delete Test Bucket
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Delete Test Bucket
            tf = storage.deleteObject(bucket.bucketName, bucketSourceOption);
            
            % Verify if successfully deleted
            testCase.verifyTrue(tf);
                      
        end
        
    end
    
end

