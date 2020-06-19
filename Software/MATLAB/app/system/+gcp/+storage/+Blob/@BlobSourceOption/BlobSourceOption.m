classdef BlobSourceOption < gcp.storage.Object
% BLOBSOURCEOPTION Class for specifying blob source options when Blob methods are used
%
%USAGE:
%
% blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch()
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Blob.BlobSourceOption.html
%
%
% Supported Java Methods
%
% static Storage.BlobSourceOption	userProject(String userProject)
% Returns an option for blob's billing user project.
%
% static Storage.BlobSourceOption	generationMatch()
% Returns an option for blob's data generation match.

%% Implementation    
    properties
    end
    
    methods
        %% Constructor
        function obj = BlobSourceOption(varargin)
            import com.google.cloud.storage.*;
            if nargin == 1
                if isa(varargin{1},'com.google.cloud.storage.Blob$BlobSourceOption[]')
                    obj.Handle = varargin{1};
                else
                    warning('Expecting Input to be of type Blob.BlobSourceOption')
                    warning('Use gcp.storage.Blob.BlobSourceOption.userProject method to create one')
                end
            end %if nargin
        end %function
    end %methods
        
    methods (Static)
                
        function blobSourceOptionArray = userProject(projectId)
            blobSourceOption = javaMethod('userProject','com.google.cloud.storage.Blob$BlobSourceOption',projectId);
            blobSourceOptionArray = javaArray('com.google.cloud.storage.Blob$BlobSourceOption',1);
            blobSourceOptionArray(1) = blobSourceOption;
            blobSourceOptionArray = gcp.storage.Blob.BlobSourceOption(blobSourceOptionArray);
        end%function
        

        function blobSourceOptionArray = generationMatch()
            blobSourceOption = javaMethod('generationMatch','com.google.cloud.storage.Blob$BlobSourceOption');
            blobSourceOptionArray = javaArray('com.google.cloud.storage.Blob$BlobSourceOption',1);
            blobSourceOptionArray(1) = blobSourceOption;
            blobSourceOptionArray = gcp.storage.Blob.BlobSourceOption(blobSourceOptionArray);
        end%function
        
    end %methods
end %class

% Unsupported Java Methods
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