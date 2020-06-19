classdef BlobId  < gcp.storage.Object
% BLOBID Creates a blob identifier BlobId and returns the object BlobId
%
% BlobId is a Google Storage Object identifier.
% A BlobId object includes the name of the containing bucket,
% the blob's name and possibly the blob's generation.
%
% USAGE
%
%   storage = gcp.storage.Storage();
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%   bucket = storage.create(bucketInfo,bucketTargetOption);
%
%   blobId = gcp.storage.BlobId.of(bucket.bucketName,"uniqueblobname")
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/index.html
%
    properties
        
    end
    
    methods
        %% Constructor
        function obj = BlobId(varargin)
            % Setting up Logger
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';
            
            if nargin==1
                if isa(varargin{1},'com.google.cloud.storage.BlobId')
                    obj.Handle = varargin{1};
                else
                    write(logObj,'error','Expected usage is gcp.storage.BlobId.of()with required arguments')
                end
            end
        end
    end
    
    
    methods (Static)
        % Use below reference numbers to map library function signatures and static class methods
        %
        % 1
        % static BlobId	of(String bucket, String blobname)
        % Creates a blob identifier.
        %
        % 2
        % static BlobId	of(String bucket, String blobname, Long generation)
        % Creates a BlobId object.
        
        function blobId = of(varargin)
            % Setting up Logger
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';
            
            if nargin==2 % Function signature 1
                % Collecting input arguments existing bucket's name and
                % blob's name
                bucketName = varargin{1};
                blobName = varargin{2};
                
                % Creating Blob Identifier
                blobIdJ = javaMethod('of','com.google.cloud.storage.BlobId',bucketName,blobName);
                
                % Masking Java object into MATLAB class object
                blobId = gcp.storage.BlobId(blobIdJ);
                
            elseif nargin ==3 % Function signature 2
                % Collecting input arguments existing bucket's name and
                % blob's name and matching generation
                bucketName = varargin{1};
                blobName = varargin{2};
                generation = varargin{3};
                
                % Creating Blob Identifier
                blobIdJ = javaMethod('of','com.google.cloud.storage.BlobId',bucketName,blobName,generation);
                
                % Masking Java object into MATLAB class object
                blobId = gcp.storage.BlobId(blobIdJ);
            else
               write(logObj,'error','Expected number of inputs are different from supported function signature')
            end
            
        end %function
        
        
    end %methods
end %class