classdef BucketSourceOption  < gcp.storage.Object
% BUCKETSOURCEOPTION Class for specifying bucket source options
%   
% USAGE
% 
% bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference client Library: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BucketSourceOption.html
%
% Supported Java Methods
%
% static Storage.BucketSourceOption	userProject(String userProject)
%

%% Implementation

properties
end

methods
	%% Constructor 
	function obj = BucketSourceOption(varargin)
         if nargin==1
            if isa(varargin{1},'com.google.cloud.storage.Storage$BucketSourceOption[]')
                obj.Handle = varargin{1};
            else
                warning('Expecting Input to be of type Storage.BucketSourceOption')
                warning('Use gcp.storage.Storage.BucketSourceOption.userProject method to create one')
            end
        end
    end%function
end%methods

methods (Static)
    
    function bucketSourceOptionArray = userProject(projectId)
        import com.google.cloud.storage.*;
        
        bucketSourceOption = javaMethod('userProject','com.google.cloud.storage.Storage$BucketSourceOption',projectId);
        bucketSourceOptionArray = javaArray('com.google.cloud.storage.Storage$BucketSourceOption',1);
        bucketSourceOptionArray(1) = bucketSourceOption;
        bucketSourceOptionArray = gcp.storage.Storage.BucketSourceOption(bucketSourceOptionArray);
    end%function
    
end%methods

end %class

% Unsupported Java Methods
%
% static Storage.BucketSourceOption	metagenerationMatch(long metageneration)
% Returns an option for bucket's metageneration match.
% 
% static Storage.BucketSourceOption	metagenerationNotMatch(long metageneration)
% Returns an option for bucket's metageneration mismatch.