classdef BucketInfo  < gcp.storage.Object
% BUCKETINFO Google Storage bucket metadata
%
% BUCKETINFO.BUILDER Builder for BucketInfo
% 
%
% USAGE
%
%   1. Use method gcp.storage.BucketInfo.newbuilder()
%
%      storage = gcp.storage.Storage();
%      bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%
%      bucketInfo = gcp.storage.BucketInfo.newbuilder("bucketName");
%     
%        or
%        
%      bucketInfo = gcp.storage.BucketInfo.newbuilder("bucketName","bucketlocation");
%        
%        or
%        
%      bucketInfo = gcp.storage.BucketInfo.newbuilder("bucketName","bucketlocation","storageclass");
%  
%   2. Use method gcp.storage.BucketInfo.of()
%
%      storage = gcp.storage.Storage();
%      bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
%      bucket = storage.create("uniquebucketName",bucketTargetOption);
%      bucketInfo = gcp.storage.BucketInfo.of(bucket.bucketName);
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/index.html
%
%
% Supported Java Methods
%
%  static BucketInfo.Builder	newBuilder(String name)
%
%  static BucketInfo	of(String name)
%    
%% Implemenntation
properties
    
end

methods
	%% Constructor 
	function obj = BucketInfo(varargin)
         % Constructor BucketInfo calls build() on the return type BucketInfo$BuilderImpl
         % to always return gcp.storage.BucketInfo with Handle of class 'com.google.cloud.storage.BucketInfo'
        if nargin==1
            if isa(varargin{1},'com.google.cloud.storage.BucketInfo')
                obj.Handle = varargin{1};
            elseif isa(varargin{1},'com.google.cloud.storage.BucketInfo$BuilderImpl')
                obj.Handle = varargin{1}.build();
            else
                warning('Expected usage is gcp.storage.BucketInfo.newBuilder() or gcp.storage.BucketInfo.of()with required arguments')
            end
        end
	end
end

methods (Static)
    % static BucketInfo.Builder	newBuilder(String name)
    % Returns a BucketInfo builder where the bucket's name is set to the provided name.
    function bucketInfo = newBuilder(varargin)
        bucketname = varargin{1};
        bucketInfoBuilder = javaMethod('newBuilder','com.google.cloud.storage.BucketInfo',bucketname);

        if nargin == 2
            bucketlocation = varargin{2};
            bucketInfoBuilder = bucketInfoBuilder.setLocation(bucketlocation);
        end
        if nargin == 3
            storageclass = varargin{3};
            if isstring(storageclass)
               storageclassJ = javaMethod('valueOf','com.google.cloud.storage.StorageClass',storageclass);
               if isa(storageclassJ,'com.google.cloud.storage.StorageClass')
                   bucketInfoBuilder.setStorageClass(storageclassJ);
               else
                   fprintf("Enter a valid storage class");
               end
            else
                fprintf('Expecting a string input for Storage Class such as "STANDARD", "NEARLINE", "COLDLINE"');
            end
            fprintf('Setting Storage Class for Bucket');
        end
        bucketInfo = gcp.storage.BucketInfo(bucketInfoBuilder);
    end
    
    % static BucketInfo	of(String name)
    % Creates a BucketInfo object for the provided bucket name.    
    function bucketInfo = of(bucketname)
        bucketInfo = javaMethod('of','com.google.cloud.storage.BucketInfo',bucketname);
        bucketInfo = gcp.storage.BucketInfo(bucketInfo);
    end
    
end %methods

end %class