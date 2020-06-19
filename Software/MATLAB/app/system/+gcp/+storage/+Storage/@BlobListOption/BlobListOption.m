classdef BlobListOption < gcp.storage.Object
% BLOBLISTOPTION Class for specifying blob list options
%   
% USAGE
%
% Returns an option to define the billing user project. 
% This option is required by buckets with `requester_pays` flag enabled to assign operation costs.
%
%   blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId)
%
% If currentdirectory method is specified, results are returned in a directory-like mode.
% Blobs whose names, after a possible prefix(String), do not contain the '/' delimiter are returned as is.
% Blobs whose names, after a possible prefix(String), contain the '/' delimiter, will have their name truncated
% after the delimiter and will be returned as Blob objects
% where only BlobInfo.getBlobId(), BlobInfo.getSize() and BlobInfo.isDirectory() are set.
% 
% For such directory blobs, (BlobId.getGeneration() returns null), BlobInfo.getSize() returns 0
% while BlobInfo.isDirectory() returns true. Duplicate directory blobs are omitted.
%
%    blobListOption = gcp.storage.Storage.BlobListOption.currentDirectory()
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Libraray: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BlobListOption.html
%
%
% Supported Java Methods: 
%
% static Storage.BlobListOption	userProject(String userProject)
% Returns an option to define the billing user project
%
% static Storage.BlobListOption	currentDirectory()
% If specified, results are returned in a directory-like mode.
%
% static Storage.BlobListOption	prefix(String prefix)
% Returns an option to set a prefix to filter results to blobs whose names begin with this prefix.
%
%% Implementation    
    properties       
    end
    
    methods
        %% Constructor
        function obj = BlobListOption(varargin)
            import com.google.cloud.storage.*;
            if nargin==1
            if isa(varargin{1},'com.google.cloud.storage.Storage$BlobListOption')
                obj.Handle = varargin{1};
            else
                warning('Expecting Input to be of type Storage.BlobListOption')
                warning('Use gcp.storage.Storage.BlobListOption.userProject method to create one')
            end
            end
        end
       
    end
    
    methods (Static)
        function blobListOption = userProject(projectId)
            blobListOption = javaMethod('userProject','com.google.cloud.storage.Storage$BlobListOption',projectId);
            blobListOption = gcp.storage.Storage.BlobListOption(blobListOption);
        end%function
        
        function blobListOption = currentDirectory()
            blobListOption = javaMethod('currentDirectory','com.google.cloud.storage.Storage$BlobListOption');
            blobListOption = gcp.storage.Storage.BlobListOption(blobListOption);
        end%function
        
        function blobListOption = prefix(prefix)
            blobListOption = javaMethod('prefix','com.google.cloud.storage.Storage$BlobListOption',prefix);
            blobListOption = gcp.storage.Storage.BlobListOption(blobListOption);
        end%function
    end%methods
end %class

% Unsupported Java methods
%
% static Storage.BlobListOption	fields(Storage.BlobField... fields)
% Returns an option to specify the blob's fields to be returned by the RPC call.
%
% static Storage.BlobListOption	pageSize(long pageSize)
% Returns an option to specify the maximum number of blobs returned per page.
%
% static Storage.BlobListOption	pageToken(String pageToken)
% Returns an option to specify the page token from which to start listing blobs.
%
% static Storage.BlobListOption	versions(boolean versions)
% If set to true, lists all versions of a blob.