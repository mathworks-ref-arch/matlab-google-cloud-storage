classdef BucketTargetOption  < gcp.storage.Object
% BUCKETTARGETOPTION Class for specifying bucket target options
% 
% USAGE
%
% bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BucketTargetOption.html
%
%
% Supported Java Methods
%
% static Storage.BucketTargetOption	userProject(String userProject)

%% Implementation
properties  
end

methods
	%% Constructor 
    function obj = BucketTargetOption(varargin)
        if nargin==1
            if isa(varargin{1},'com.google.cloud.storage.Storage$BucketTargetOption[]')
                obj.Handle = varargin{1};
            else
                warning('Expecting Input to be of type Storage$BucketTargetOption')
                warning('Use gcp.storage.Storage$BucketTargetOption.userProject method to create one')
            end
        end
    end
end%methods

methods (Static)
    
    function bucketTargetOptionArray = userProject(projectId)
        import com.google.cloud.storage.*;
        
        bucketTargetOption = javaMethod('userProject','com.google.cloud.storage.Storage$BucketTargetOption',projectId);
        bucketTargetOptionArray = javaArray('com.google.cloud.storage.Storage$BucketTargetOption',1);
        bucketTargetOptionArray(1) = bucketTargetOption;
        bucketTargetOptionArray = gcp.storage.Storage.BucketTargetOption(bucketTargetOptionArray);
    end %function
    
end%methods

end %class

% Unsupported Java Methods
%
% static Storage.BucketTargetOption	metagenerationMatch()
% Returns an option for bucket's metageneration match.
%
% static Storage.BucketTargetOption	metagenerationNotMatch()
% Returns an option for bucket's metageneration mismatch.
% 
% static Storage.BucketTargetOption	predefinedAcl(Storage.PredefinedAcl acl)
% Returns an option for specifying bucket's predefined ACL configuration.
% 
% static Storage.BucketTargetOption	predefinedDefaultObjectAcl(Storage.PredefinedAcl acl)
% Returns an option for specifying bucket's default ACL configuration for blobs.
% 
% static Storage.BucketTargetOption	projection(String projection)
% Returns an option to define the projection in the API request.