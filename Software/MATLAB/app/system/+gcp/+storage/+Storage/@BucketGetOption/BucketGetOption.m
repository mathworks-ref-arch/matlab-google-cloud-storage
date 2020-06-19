classdef BucketGetOption < gcp.storage.Object
% BUCKETGETOPTION Class for specifying bucket get options.
%   
% USAGE
%
% 1. bucketGetOption = gcp.storage.Storage.BucketGetOption.fields(gcp.storage.Storage.BucketField);
%
% 2. bucketGetOption = gcp.storage.Storage.BucketGetOption.userProject(storage.projectId)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BucketGetOption.html
%
% Supported Java Methods
%
% static Storage.BucketGetOption	userProject(String userProject)
% Returns an option for bucket's billing user project.
%
% static Storage.BucketGetOption	fields(Storage.BucketField... fields)
% Returns an option to specify the bucket's fields to be returned by the RPC call.
%

    
 
%% Implementation

properties
end

methods
	%% Constructor 
    function obj = BucketGetOption(varargin)
        if nargin==1
            if isa(varargin{1},'com.google.cloud.storage.Storage$BucketGetOption[]')
                obj.Handle = varargin{1};
            else
                warning('Expecting Input to be of type Storage.BucketGetOption')
                warning('Use gcp.storage.Storage.BucketGetOption.userProject method to create one')
            end
        end
    end
end

methods (Static)
 
    function bucketGetOptionArray = userProject(projectId)
        import com.google.cloud.storage.*;

        bucketGetOption = javaMethod('userProject','com.google.cloud.storage.Storage$BucketGetOption',projectId);
        bucketGetOptionArray = javaArray('com.google.cloud.storage.Storage$BucketGetOption',1);
        bucketGetOptionArray(1) = bucketGetOption;
        bucketGetOptionArray = gcp.storage.Storage.BucketGetOption(bucketGetOptionArray);
    end%function
    
    function bucketGetOptionArray = fields(BucketField)
        bucketGetOption = javaMethod('fields','com.google.cloud.storage.Storage$BucketGetOption',BucketField.Handle);
        bucketGetOptionArray = javaArray('com.google.cloud.storage.Storage$BucketGetOption',1);
        bucketGetOptionArray(1) = bucketGetOption;
        bucketGetOptionArray = gcp.storage.Storage.BucketGetOption(bucketGetOptionArray);
    end%function
    
end %methods

end %class

% Unsupported Java Methods
%
% static Storage.BucketGetOption	metagenerationMatch(long metageneration)
% Returns an option for bucket's metageneration match.
%
% static Storage.BucketGetOption	metagenerationNotMatch(long metageneration)
% Returns an option for bucket's metageneration mismatch.