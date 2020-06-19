classdef BlobInfo  < gcp.storage.Object
% BLOBINFO Returns a BlobInfo builder where blob identity is set using
% the provided value
%
% BlobInfo can be used for Blob creation
% To construct a BlobInfo object you can use the method BlobInfo.newBuilder
%
% Usage:
%
%   1. BlobId as input argument:
%
%   storage = gcp.storage.Storage("credentials.json")
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
%   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%   blobId	= gcp.storage.BlobId.of(bucket.bucketName, "uniqueblobname");
%   blobInfo = gcp.storage.BlobInfo.newBuilder(blobId);
%
%   2. BuckeInfo and a unique non-existent Blob name as input arguments:
%
%   storage = gcp.storage.Storage();
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
%   bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%   blobInfo = gcp.storage.BlobInfo.newBuilder(bucketInfo,"uniqueblobname");
%
%   3. An existing Bucket's name and a unique non-existent Blob name
%
%   storage = gcp.storage.Storage();
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
%   bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%   blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/index.html
    properties
        
    end
    
    methods
        %% Constructor
        function obj = BlobInfo(varargin)
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';
            if nargin==1
                if isa(varargin{1},'com.google.cloud.storage.BlobInfo$BuilderImpl')
                    obj.Handle = varargin{1}.build();
                else
                    write(logObj,'error','Expected usage is gcp.storage.BlobInfo.newBuilder() with required arguments');
                end
            end
        end
    end
    
    methods (Static)
        
        %Use below reference numbers to map library function signatures and static class methods
        %
        %1
        % static BlobInfo.Builder	newBuilder(BlobId blobId)
        % Returns a BlobInfo builder where blob identity is set using the provided value.
        
        %2
        % static BlobInfo.Builder	newBuilder(BucketInfo bucketInfo, String name)
        % Returns a BlobInfo builder where blob identity is set using the provided values.
        
        %3
        % static BlobInfo.Builder	newBuilder(String bucket, String name)
        % Returns a BlobInfo builder where blob identity is set using the provided values.
        
        %4
        % static BlobInfo.Builder	newBuilder(BucketInfo bucketInfo, String name, Long generation)
        % Returns a BlobInfo builder where blob identity is set using the provided values.
        
        %5
        % static BlobInfo.Builder	newBuilder(String bucket, String name, Long generation)
        % Returns a BlobInfo builder where blob identity is set using the provided values.
        
        function blobInfoBuilder = newBuilder(varargin)
            % Setting up Logger
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';
            if nargin==1%1
                
                %Use BlobId to create BlobInfo
                blobId = varargin{1};
                blobInfoBuilderJ = javaMethod('newBuilder','com.google.cloud.storage.BlobInfo',blobId.Handle);
                
                %Using MATLAB Class gcp.storage.BlobInfo to mask Java
                %object
                blobInfoBuilder = gcp.storage.BlobInfo(blobInfoBuilderJ);
                
            elseif nargin ==2
                
                if ischar(varargin{1}) || isstring(varargin{1})%3
                    %Use BucketName and BlobName to construct BlobInfo
                    bucketName = varargin{1};
                    blobName = varargin{2};
                    
                    blobInfoBuilder = javaMethod('newBuilder','com.google.cloud.storage.BlobInfo',bucketName,blobName);
                    
                    %Using MATLAB Class gcp.storage.BlobInfo to mask Java
                    %object
                    blobInfoBuilder = gcp.storage.BlobInfo(blobInfoBuilder);
                    
                elseif isa(varargin{1},'gcp.storage.BucketInfo')%2
                    %Use BucketInfo object and BlobName to construct BlobInfo
                    bucketInfo = varargin{1};
                    blobName = varargin{2};
                    blobInfoBuilder = javaMethod('newBuilder','com.google.cloud.storage.BlobInfo',bucketInfo.Handle,blobName);
                    
                    %Using MATLAB Class gcp.storage.BlobInfo to mask Java
                    %object
                    blobInfoBuilder = gcp.storage.BlobInfo(blobInfoBuilder);
                    
                else
                    write(logObj,'error','No matching Function Signature');
                end
                
            elseif nargin==3
                
                if ischar(varargin{1}) || isstring(varargin{1})%5
                    %Use BucketName, BlobName and matching Generation to construct BlobInfo
                    bucketName = varargin{1};
                    blobName = varargin{2};
                    generation = varargin{3};
                    
                    blobInfoBuilder = javaMethod('newBuilder','com.google.cloud.storage.BlobInfo',bucketName,blobName,generation);
                    
                    %Using MATLAB Class gcp.storage.BlobInfo to mask Java
                    %object
                    blobInfoBuilder = gcp.storage.BlobInfo(blobInfoBuilder);
                    
                elseif isa(varargin{1},'gcp.storage.BucketInfo')%4
                    %Use BucketInfo, BlobName and matching Generation to construct BlobInfo
                    bucketInfo = varargin{1};
                    blobName = varargin{2};
                    generation = varargin{3};
                    
                    blobInfoBuilder = javaMethod('newBuilder','com.google.cloud.storage.BlobInfo',bucketInfo.Handle,blobName,generation);
                    
                    %Using MATLAB Class gcp.storage.BlobInfo to mask Java
                    %object
                    blobInfoBuilder = gcp.storage.BlobInfo(blobInfoBuilder);
                else
                    write(logObj,'error','No matching Function Signature');
                end
                
            else
                write(logObj,'error','Expecting different number of input arguments. No matching Function Signature');
            end
            
        end
    end%methods
    
end %class