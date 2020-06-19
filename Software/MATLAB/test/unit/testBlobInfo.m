classdef testBlobInfo < matlab.unittest.TestCase
% TESTBLOBINFO This is a test for class gcp.storage.BlobInfo
%
%   BLOBINFO Returns a BlobInfo builder where blob identity is set using the provided valu
%
% Usage:
%
%   1.
%   storage = gcp.storage.Storage("credentials.json")
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
%   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%   blobId	= gcp.storage.BlobId.of(bucket.bucketName, "uniqueblobname");
%   blobInfo = gcp.storage.BlobInfo.newBuilder(blobId);
%
%   2.
%   storage = gcp.storage.Storage();
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
%   bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%   blobInfo = gcp.storage.BlobInfo.newBuilder(bucketInfo,"uniqueblobname");
%
%   3.
%   storage = gcp.storage.Storage()
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
%   bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%   blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
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
            
            % Create BucketSourceOption object to help with test bucket deletion
            bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
            
            % Deleting Test buckets
            tf = storage.deleteObject('uniquetestbucketblobinfo', bucketSourceOption);
            testCase.verifyTrue(tf);
        end
    end
    
    methods (Test)
        function testBlobInfoCreate1(testCase)
            % Create Storage Client
            storage = gcp.storage.Storage();
            write(testCase.logObj,'debug','Storage Client created');
            
            % Create BucketInfo
            bucketInfo = gcp.storage.BucketInfo.of('uniquetestbucketblobinfo');
            write(testCase.logObj,'debug','Bucket Info created');
            
            % Create BucketTargetOption
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            write(testCase.logObj,'debug','BucketTargetOption created');
            
            % Create Test Bucket to contain the Test Blob
            bucket = storage.create(bucketInfo,bucketTargetOption);
            write(testCase.logObj,'debug','Bucket created');
            
            % Create BlobId for constructing BlobInfo
            blobId	= gcp.storage.BlobId.of(bucket.bucketName, "uniqueblobname");
            write(testCase.logObj,'debug','BlobId created');
            
            blobInfo = gcp.storage.BlobInfo.newBuilder(blobId);
            write(testCase.logObj,'debug','BlobInfo created');
            
            write(testCase.logObj,'debug','Testing BlobInfo Object');
            testCase.verifyNotEmpty(blobInfo);
            testCase.verifyClass(blobInfo,'gcp.storage.BlobInfo');
        end
        
        function testBlobInfoCreate2(testCase)
            storage = gcp.storage.Storage();
            write(testCase.logObj,'debug','Storage Client created');
            
            bucketInfo = gcp.storage.BucketInfo.of('uniquetestbucketblobinfo');
            write(testCase.logObj,'debug','Bucket Info created');
            
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            write(testCase.logObj,'debug','BucketTargetOption created');
            
            bucket = storage.create(bucketInfo,bucketTargetOption);
            write(testCase.logObj,'debug','Bucket created');
            
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucketInfo,"uniqueblobname");
            write(testCase.logObj,'debug','BlobInfo created');
            
            write(testCase.logObj,'debug','Testing BlobInfo Object');
            testCase.verifyNotEmpty(blobInfo);
            testCase.verifyClass(blobInfo,'gcp.storage.BlobInfo');
        end
        
        function testBlobInfoCreate3(testCase)
            storage = gcp.storage.Storage();
            write(testCase.logObj,'debug','Storage Client created');
            
            bucketInfo = gcp.storage.BucketInfo.of('uniquetestbucketblobinfo');
            write(testCase.logObj,'debug','Bucket Info created');
            
            bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
            write(testCase.logObj,'debug','BucketTargetOption created');
            
            bucket = storage.create(bucketInfo,bucketTargetOption);
            write(testCase.logObj,'debug','Bucket created');
            
            blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
            write(testCase.logObj,'debug','BlobInfo created');
            
            write(testCase.logObj,'debug','Testing BlobInfo Object');
            testCase.verifyNotEmpty(blobInfo);
            testCase.verifyClass(blobInfo,'gcp.storage.BlobInfo');
        end
        
    end
    
end

