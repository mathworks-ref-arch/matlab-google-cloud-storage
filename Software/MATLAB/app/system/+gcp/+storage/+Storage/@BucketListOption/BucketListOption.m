classdef BucketListOption < gcp.storage.Object
% BUCKETLISTOPTION Class for specifying bucket list options
%
% USAGE
%
% 1. bucketListOption = gcp.storage.Storage.userProject(storage.projectId);
%
% 2. bucketListOption = gcp.storage.Storage. prefix("bucketname_prefix");
%

% Copyright 2020 The MathWorks, Inc.
%
% Ref https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BucketListOption.html
%
% Supported Java Methods
%
% static Storage.BucketListOption	userProject(String userProject)
% Note: If you are using this method make sure your service account is listed for the project containing the bucket and storage account
%
% static Storage.BucketListOption	prefix(String prefix)
% Returns an option to set a prefix to filter results to buckets whose names begin with this prefix.
%
% static Storage.BucketListOption	fields(Storage.BucketField... fields)
% Returns an option to specify the bucket's fields to be returned by the RPC call.

    %% Implementation
    
    properties
    end
    
    methods
        %% Constructor
        function obj = BucketListOption(varargin)
            if nargin==1
                if isa(varargin{1},'com.google.cloud.storage.Storage$BucketListOption')
                    obj.Handle = varargin{1};
                else
                    warning('Expecting Input to be of type Storage$BucketListOption')
                    warning('Use gcp.storage.Storage$BucketListOption.userProject method to create one')
                end
            end
        end%function
    end%methods
    
    methods (Static)
        
        function bucketListOption = userProject(projectId)
            import com.google.cloud.storage.*;
            bucketListOption = javaMethod('userProject','com.google.cloud.storage.Storage$BucketListOption',projectId);
            bucketListOption = gcp.storage.Storage.BucketListOption(bucketListOption);
        end%function
        
        function bucketListOption = prefix(prefix)
            import com.google.cloud.storage.*;
            bucketListOption = javaMethod('prefix','com.google.cloud.storage.Storage$BucketListOption',prefix);
            bucketListOption = gcp.storage.Storage.BucketListOption(bucketListOption);
        end%function
        
        function bucketListOption= fields(bucketfields)
            % bucketfields should be of class
            % gcp.storage.Storage.BucketField
            bucketfieldsJ = bucketfields.Handle;
            bucketListOption = javaMethod('fields','com.google.cloud.storage.Storage$BucketListOption',bucketfieldsJ);
            bucketListOption = gcp.storage.Storage.BucketListOption(bucketListOption);
        end%function
    end%methods
    
end %class

% Unsupported Java Methods
%
% static Storage.BucketListOption	pageSize(long pageSize)
% Returns an option to specify the maximum number of buckets returned per page.
%
% static Storage.BucketListOption	pageToken(String pageToken)
% Returns an option to specify the page token from which to start listing buckets.
%