classdef BlobSourceOption < gcp.storage.Object
% BLOBSOURCEOPTION Class for specifying blob source options.
%  
% USAGE
%
%   blobSourceOption = gcp.storage.Storage.BlobSourceOption.
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BlobSourceOption.html
%
% Supported Java Methods:
%
%  static Storage.BlobSourceOption	userProject(String userProject)
% 
%  static Storage.BlobSourceOption	generationMatch()



%% Implementation
    
    properties       
    end
    
    methods
        %% Constructor
        function obj = BlobSourceOption(varargin)
            import com.google.cloud.storage.*;
            if nargin == 1
                if isa(varargin{1},'com.google.cloud.storage.Storage$BlobSourceOption[]')
                    obj.Handle = varargin{1};
                else
                    warning('Expecting Input to be of type Storage.BlobSourceOption')
                    warning('Use gcp.storage.Storage.BlobSourceOption.userProject method to create one')
                end
            end
        end%function
        
    end%methods
    
    methods (Static)

        function blobSourceOptionArray = userProject(projectId)
            blobSourceOption = javaMethod('userProject','com.google.cloud.storage.Storage$BlobSourceOption',projectId);
            blobSourceOptionArray = javaArray('com.google.cloud.storage.Storage$BlobSourceOption',1);
            blobSourceOptionArray(1) = blobSourceOption;
            blobSourceOptionArray = gcp.storage.Storage.BlobSourceOption(blobSourceOptionArray);
        end%function
     
        function blobSourceOptionArray = generationMatch()
            blobSourceOption = javaMethod('generationMatch','com.google.cloud.storage.Storage$BlobSourceOption',projectId);
            blobSourceOptionArray = javaArray('com.google.cloud.storage.Storage$BlobSourceOption',1);
            blobSourceOptionArray(1) = blobSourceOption;
            blobSourceOptionArray = gcp.storage.Storage.BlobSourceOption(blobSourceOptionArray);
        end%function

    end%methods
    
end %class

% Unsupported Java Methods: 
%
% static Storage.BlobSourceOption	decryptionKey(Key key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
%
% static Storage.BlobSourceOption	decryptionKey(String key)
% Returns an option to set a customer-supplied AES256 key for server-side encryption of the blob.
%
% static Storage.BlobSourceOption	generationMatch(long generation)
% Returns an option for blob's data generation match.
% 
% static Storage.BlobSourceOption	generationNotMatch()
% Returns an option for blob's data generation mismatch.
% 
% static Storage.BlobSourceOption	generationNotMatch(long generation)
% Returns an option for blob's data generation mismatch.
% 
% static Storage.BlobSourceOption	metagenerationMatch(long metageneration)
% Returns an option for blob's metageneration match.
% 
% static Storage.BlobSourceOption	metagenerationNotMatch(long metageneration)
% Returns an option for blob's metageneration mismatch.