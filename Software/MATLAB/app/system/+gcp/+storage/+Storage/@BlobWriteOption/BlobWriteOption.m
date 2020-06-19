classdef BlobWriteOption < gcp.storage.Object
% BLOBWRITEOPTION Class for specifying blob write options
%  
% USAGE
%
% blobWriteOption =  gcp.storage.Storage.BlobWriteOption.userProject(storage.projectId);
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BlobWriteOption.html
%
%
% Supported Java Methods
%
% static Storage.BlobWriteOption	userProject(String userProject)

%% Implementation    
    properties       
    end
    
    methods
        %% Constructor
        function obj = BlobWriteOption(varargin)
            import com.google.cloud.storage.*;
            if isa(varargin{1},'com.google.cloud.storage.Storage$BlobWriteOption[]')
                obj.Handle = varargin{1};
            else
                warning('Expecting Input to be of type Storage.BlobWriteOption')
                warning('Use gcp.storage.Storage.BlobWriteOption.userProject method to create one')
            end
        end
        
    end
    
    methods (Static)
        
        function blobWriteOptionArray = userProject(projectId)
            blobWriteOption = javaMethod('userProject','com.google.cloud.storage.Storage$BlobWriteOption',projectId);
            blobWriteOptionArray = javaArray('com.google.cloud.storage.Storage$BlobWriteOption',1);
            blobWriteOptionArray(1) = blobWriteOption;
            blobWriteOptionArray = gcp.storage.Storage.BlobWriteOption(blobWriteOptionArray);
        end%function
        
    end %methods(Static)
    
end %class

% Unsupported Java Methods
%
% static Storage.BlobWriteOption	crc32cMatch()
% Returns an option for blob's data CRC32C checksum match.
%
% static Storage.BlobWriteOption	doesNotExist()
% Returns an option that causes an operation to succeed only if the target blob does not exist.
% 
% static Storage.BlobWriteOption	encryptionKey(Key key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Storage.BlobWriteOption	encryptionKey(String key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Storage.BlobWriteOption	generationMatch()
% Returns an option for blob's data generation match.
% 
% static Storage.BlobWriteOption	generationNotMatch()
% Returns an option for blob's data generation mismatch.
% 
% static Storage.BlobWriteOption	kmsKeyName(String kmsKeyName)
% Returns an option to set a customer-managed KMS key for server-side encryption of the blob.
% 
% static Storage.BlobWriteOption	md5Match()
% Returns an option for blob's data MD5 hash match.
% 
% static Storage.BlobWriteOption	metagenerationMatch()
% Returns an option for blob's metageneration match.
% 
% static Storage.BlobWriteOption	metagenerationNotMatch()
% Returns an option for blob's metageneration mismatch.
% 
% static Storage.BlobWriteOption	predefinedAcl(Storage.PredefinedAcl acl)
% Returns an option for specifying blob's predefined ACL configuration.