classdef BlobGetOption <gcp.storage.Object
%BLOBGETOPTION Class for specifying blob get options
%
% USAGE
%
%   1. blobGetOption = gcp.storage.Storage.BlobGetOption.generationMatch
%   2. blobGetOption = gcp.storage.Storage.BlobGetOption.userProject(storage.projectId)
%

% Copyright 2020 The MathWorks, Inc.
%
% Ref: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BlobGetOption.html


%% Implementation     
    properties
        
    end
    
    methods
        %% Constructor
        function obj = BlobGetOption(varargin)
            import com.google.cloud.storage.*;
            if nargin == 1
                if isa(varargin{1},'com.google.cloud.storage.Storage$BlobGetOption[]')
                    obj.Handle = varargin{1};
                else
                    warning('Expecting Input to be of type Storage.BlobGetOption')
                    warning('Use gcp.storage.Storage.BlobGetOption.userProject method to create one')
                end
            end
        end
        
    end
    
    methods (Static)
        % static Storage.BlobGetOption	decryptionKey(Key key)
        % Returns an option to set a customer-supplied AES256 key for server-side decryption of the blob.
        % static Storage.BlobGetOption	decryptionKey(String key)
        % Returns an option to set a customer-supplied AES256 key for server-side decryption of the blob.
        function blobGetOptionArray = decryptionKey(key)
            if ischar(key)
                blobGetOption = javaMethod('decryptionKey','com.google.cloud.storage.Storage$BlobGetOption',key);
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
            else
                blobGetOption = javaMethod('decryptionKey','com.google.cloud.storage.Storage$BlobGetOption',key);
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
            end
            blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
        end%function
              
        % static Storage.BlobGetOption	fields(Storage.BlobField... fields)
        % Returns an option to specify the blob's fields to be returned by the RPC call.
        function blobGetOptionArray = fields(BlobField)
            blobGetOption = javaMethod('fields','com.google.cloud.storage.Storage$BlobGetOption',BlobField.Handle);
            blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
            blobGetOptionArray(1) = blobGetOption;
            blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
        end
        % static Storage.BlobGetOption	generationMatch()
        % Returns an option for blob's data generation match.
         % static Storage.BlobGetOption	generationMatch(long generation)
        % Returns an option for blob's data generation match.
        function blobGetOptionArray = generationMatch(varargin)
            if nargin==0
                blobGetOption = javaMethod('generationMatch','com.google.cloud.storage.Storage$BlobGetOption');
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
                blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
            elseif nargin==1
                generation = varargin{1};
                blobGetOption = javaMethod('generationMatch','com.google.cloud.storage.Storage$BlobGetOption',generation);
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
                blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
            else
                warning('Expecting zero or 1 input of type long')               
            end
        end %function
        
        % static Storage.BlobGetOption	generationNotMatch()
        % Returns an option for blob's data generation mismatch.
            % static Storage.BlobGetOption	generationNotMatch(long generation)
        % Returns an option for blob's data generation mismatch.
        
        function blobGetOptionArray = generationNotMatch(varargin)
            if nargin==0
                blobGetOption = javaMethod('generationNotMatch','com.google.cloud.storage.Storage$BlobGetOption');
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
                blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
            elseif nargin==1
                generation = varargin{1};
                blobGetOption = javaMethod('generationNotMatch','com.google.cloud.storage.Storage$BlobGetOption',generation);
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
                blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
            else
                warning('Expecting zero or 1 input of type long')               
            end
        end %function

        % static Storage.BlobGetOption	metagenerationMatch(long metageneration)
        % Returns an option for blob's metageneration match.
        
        function blobGetOptionArray = metagenerationMatch(metageneration)           
                blobGetOption = javaMethod('metagenerationMatch','com.google.cloud.storage.Storage$BlobGetOption',metageneration);
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
                blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
        end %function
        
        % static Storage.BlobGetOption	metagenerationNotMatch(long metageneration)
        % Returns an option for blob's metageneration mismatch.
         function blobGetOptionArray = metagenerationNotMatch(metageneration)           
                blobGetOption = javaMethod('metagenerationNotMatch','com.google.cloud.storage.Storage$BlobGetOption',metageneration);
                blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
                blobGetOptionArray(1) = blobGetOption;
                blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
        end %function
        
        % static Storage.BlobGetOption	userProject(String userProject)
        % Returns an option for blob's billing user project.
        function blobGetOptionArray = userProject(projectId)
            blobGetOption = javaMethod('userProject','com.google.cloud.storage.Storage$BlobGetOption',projectId);
            blobGetOptionArray = javaArray('com.google.cloud.storage.Storage$BlobGetOption',1);
            blobGetOptionArray(1) = blobGetOption;
            blobGetOptionArray = gcp.storage.Storage.BlobGetOption(blobGetOptionArray);
        end%function
        
    end
end %class