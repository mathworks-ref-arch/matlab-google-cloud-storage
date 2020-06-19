classdef BlobTargetOption < gcp.storage.Object
% BLOBTARGETOPTION Class for specifying blob target options
%
% USAGE
%
% blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId)'
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BlobTargetOption.html
%
% Supported Java Methods
%
% static Storage.BlobTargetOption	userProject(String userProject)
%


%% Implementation
    
    properties
    end
    
    methods
        %% Constructor
        function obj = BlobTargetOption(varargin)
            import com.google.cloud.storage.*;
            if nargin == 1
                if isa(varargin{1},'com.google.cloud.storage.Storage$BlobTargetOption[]')
                    obj.Handle = varargin{1};
                else
                    warning('Expecting Input to be of type Storage.BlobTargetOption')
                    warning('Use gcp.storage.Storage.BlobTargetOption.userProject method to create one')
                end
            end
        end
        
    end
    
    methods (Static)
        
        function blobTargetOptionArray = userProject(projectId)
            blobTargetOption = javaMethod('userProject','com.google.cloud.storage.Storage$BlobTargetOption',projectId);
            blobTargetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobTargetOption',1);
            blobTargetOptionArray(1) = blobTargetOption;
            blobTargetOptionArray = gcp.storage.Storage.BlobTargetOption(blobTargetOptionArray);
        end%function
        
    end%methods
    
end %class

% Unsupported Java Methods:

% static Storage.BlobTargetOption	disableGzipContent()
% Returns an option for blob's data disabledGzipContent.
% 
% static Storage.BlobTargetOption	doesNotExist()
% Returns an option that causes an operation to succeed only if the target blob does not exist.
% 
% static Storage.BlobTargetOption	encryptionKey(Key key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Storage.BlobTargetOption	encryptionKey(String key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Storage.BlobTargetOption	generationMatch()
% Returns an option for blob's data generation match.
% 
% static Storage.BlobTargetOption	generationNotMatch()
% Returns an option for blob's data generation mismatch.
% 
% static Storage.BlobTargetOption	kmsKeyName(String kmsKeyName)
% Returns an option to set a customer-managed key for server-side encryption of the blob.
% 
% static Storage.BlobTargetOption	metagenerationMatch()
% Returns an option for blob's metageneration match.
% 
% static Storage.BlobTargetOption	metagenerationNotMatch()
% Returns an option for blob's metageneration mismatch.
% 
% static Storage.BlobTargetOption	predefinedAcl(Storage.PredefinedAcl acl)
% Returns an option for specifying blob's predefined ACL configuration.