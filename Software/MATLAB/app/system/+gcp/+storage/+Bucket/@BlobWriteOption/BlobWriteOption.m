classdef BlobWriteOption < gcp.storage.Object
% BLOBWRITEOPTION Class for specifying blob write options when Bucket methods are used.
%
% USAGE
%
% blobWriteOption = gcp.storage.Bucket.BlobWriteOption.userProject(bucket.projectId)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Bucket.BlobWriteOption.html
%
%
% Supported Java Methods 
%
% static Bucket.BlobWriteOption	userProject(String userProject)
% Returns an option for blob's billing user project.
 
%% Implementation   
    properties
    end
    
    methods
        %% Constructor
        function obj = BlobWriteOption(varargin)
            import com.google.cloud.storage.*;
            if nargin == 1
                if isa(varargin{1},'com.google.cloud.storage.Bucket$BlobWriteOption[]')
                    obj.Handle = varargin{1};
                else
                    warning('Expecting Input to be of type Bucket.BlobWriteOption')
                    warning('Use gcp.storage.Bucket.BlobWriteOption.userProject method to create one')
                end
            end
            
        end%function
        
    end%methods
    
    methods (Static)
        
        function blobWriteOptionArray = userProject(projectId)
            blobWriteOption = javaMethod('userProject','com.google.cloud.storage.Bucket$BlobWriteOption',projectId);
            blobWriteOptionArray = javaArray('com.google.cloud.storage.Bucket$BlobWriteOption',1);
            blobWriteOptionArray(1) = blobWriteOption;
            blobWriteOptionArray = gcp.storage.Bucket.BlobWriteOption(blobWriteOptionArray);
        end%function
        
    end %methods
    
end %class

% Unsupported Java Methods
%
% static Bucket.BlobWriteOption	crc32cMatch(String crc32c)
% Returns an option for blob's data CRC32C checksum match.
%
% static Bucket.BlobWriteOption	doesNotExist()
% Returns an option that causes an operation to succeed only if the target blob does not exist.
% 
% static Bucket.BlobWriteOption	encryptionKey(Key key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Bucket.BlobWriteOption	encryptionKey(String key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
% 
% static Bucket.BlobWriteOption	generationMatch(long generation)
% Returns an option for blob's data generation match.
% 
% static Bucket.BlobWriteOption	generationNotMatch(long generation)
% Returns an option for blob's data generation mismatch.
% 
% static Bucket.BlobWriteOption	md5Match(String md5)
% Returns an option for blob's data MD5 hash match.
% 
% static Bucket.BlobWriteOption	metagenerationMatch(long metageneration)
% Returns an option for blob's metageneration match.
% 
% static Bucket.BlobWriteOption	metagenerationNotMatch(long metageneration)
% Returns an option for blob's metageneration mismatch.
% 
% static Bucket.BlobWriteOption	predefinedAcl(Storage.PredefinedAcl acl)
% Returns an option for specifying blob's predefined ACL configuration.