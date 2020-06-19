classdef BucketSourceOption  < gcp.storage.Object
% BUCKETSOURCEOPTION Class for specifying bucket source options when Bucket
% methods are used.
%
% USAGE
%
% bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch()
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Bucket.BucketSourceOption.html
%
%
% Supported Java Methods
%
% static Bucket.BucketSourceOption	userProject(String userProject)
%
% static Bucket.BucketSourceOption	metagenerationMatch()

properties
    
end

methods
	%% Constructor 
	function obj = BucketSourceOption(varargin)
        if nargin==1
            if isa(varargin{1},'com.google.cloud.storage.Bucket$BucketSourceOption[]')
                obj.Handle = varargin{1};
            else
                warning('Expecting Input to be of type Bucket.BucketSourceOption')
                warning('Use gcp.storage.Bucket.BucketSourceOption.userProject method to create one')
            end
        end
    end
end

methods (Static)

    function bucketSourceOptionArray = userProject(projectId)
        import com.google.cloud.storage.*;
        
        bucketSourceOption = javaMethod('userProject','com.google.cloud.storage.Bucket$BucketSourceOption',projectId);
        bucketSourceOptionArray = javaArray('com.google.cloud.storage.Bucket$BucketSourceOption',1);
        bucketSourceOptionArray(1) = bucketSourceOption;
        bucketSourceOptionArray = gcp.storage.Bucket.BucketSourceOption(bucketSourceOptionArray);
    end
    
    function bucketSourceOptionArray = metagenerationMatch()
        import com.google.cloud.storage.*;
        
        bucketSourceOption = javaMethod('metagenerationMatch','com.google.cloud.storage.Bucket$BucketSourceOption');
        bucketSourceOptionArray = javaArray('com.google.cloud.storage.Bucket$BucketSourceOption',1);
        bucketSourceOptionArray(1) = bucketSourceOption;
        bucketSourceOptionArray = gcp.storage.Bucket.BucketSourceOption(bucketSourceOptionArray);
    end
end

end %class

% Unsupported Java Methods
%
% static Bucket.BucketSourceOption	metagenerationNotMatch()
% Returns an option for bucket's metageneration mismatch.