classdef BlobTargetOption < gcp.storage.Object
% BLOBTARGETOPTION Class for specifying blob target options when Bucket methods are used
%
% USAGE
% 
% blobTargetOption = gcp.storage.Bucket.BlobTargetOption.userProject(bucket.projectId)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Bucket.BlobTargetOption.html
%
%
% Supported Java Methods 
%
% static Bucket.BlobTargetOption	userProject(String userProject)

%% Implementation    
    properties
       
    end
    
    methods
        %% Constructor
        function obj = BlobTargetOption(varargin)
            import com.google.cloud.storage.*;
            if nargin == 1
                if isa(varargin{1},'com.google.cloud.storage.Bucket$BlobTargetOption[]')
                    obj.Handle = varargin{1};
                else
                    warning('Expecting Input to be of type Bucket.BlobTargetOption')
                    warning('Use gcp.storage.Bucket.BlobTargetOption.userProject method to create one')
                end
            end
        end
        
    end
    
    methods (Static)
   
        function blobTargetOptionArray = userProject(projectId)
            blobTargetOption = javaMethod('userProject','com.google.cloud.storage.Bucket$BlobTargetOption',projectId);
            blobTargetOptionArray = javaArray('com.google.cloud.storage.Bucket$BlobTargetOption',1);
            blobTargetOptionArray(1) = blobTargetOption;
            blobTargetOptionArray = gcp.storage.Bucket.BlobTargetOption(blobTargetOptionArray);
        end%function
        
    end%methods
    
end %class

% Unsupported Java Methods
%
% static Bucket.BlobTargetOption	doesNotExist()
% Returns an option that causes an operation to succeed only if the target blob does not exist.
% 
% static Bucket.BlobTargetOption	encryptionKey(Key key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Bucket.BlobTargetOption	encryptionKey(String key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Bucket.BlobTargetOption	generationMatch(long generation)
% Returns an option for blob's data generation match.
% 
% static Bucket.BlobTargetOption	generationNotMatch(long generation)
% Returns an option for blob's data generation mismatch.
% 
% static Bucket.BlobTargetOption	kmsKeyName(String kmsKeyName)
% Returns an option to set a customer-managed KMS key for server-side encryption of the blob.
% 
% static Bucket.BlobTargetOption	metagenerationMatch(long metageneration)
% Returns an option for blob's metageneration match.
% 
% static Bucket.BlobTargetOption	metagenerationNotMatch(long metageneration)
% Returns an option for blob's metageneration mismatch.
% 
% static Bucket.BlobTargetOption	predefinedAcl(Storage.PredefinedAcl acl)
% Returns an option for specifying blob's predefined ACL configuration.