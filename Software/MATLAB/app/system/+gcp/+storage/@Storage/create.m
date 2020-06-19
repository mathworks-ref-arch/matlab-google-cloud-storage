function result = create(Storage,varargin) 
% CREATE Creates a bucket or a blob (empty or with content)
%
% USAGE
%
%   bucket = storage.create(bucketInfo, bucketTargetOption)
%   blob = storage.create(blobInfo, blobTargetOption)
%
% Create a new bucket:
%
%  storage = gcp.storage.Storage();
%  bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%  bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%  bucket = storage.create(bucketInfo, bucketTargetOption)
%
%
% Create a new blob with no content:
%
%  storage = gcp.storage.Storage();
%  bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%  bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%  bucket = storage.create(bucketInfo, bucketTargetOption)
%
%  blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
%  blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
%  blob = storage.create(blobInfo, blobTargetOption)
% 

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library:https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Storage.html#create-com.google.cloud.storage.BlobInfo-com.google.cloud.storage.Storage.BlobTargetOption...-
%
% Supported Java Methods
%
% 1. Creates a new bucket.
%    Bucket	create(BucketInfo bucketInfo, Storage.BucketTargetOption... options)
% 
%
% 2. Creates a new blob with no content.
%    Blob	create(BlobInfo blobInfo, Storage.BlobTargetOption... options)
% 
%% Implementation
if nargin>1
    if nargin ==3
        
        if isa(varargin{1},'gcp.storage.BucketInfo') %1 empty bucket
            bucketInfo = varargin{1};
            bucketTargetOption = varargin{2};
            
            bucketJ = Storage.Handle.create(bucketInfo.Handle,bucketTargetOption.Handle);
            result= gcp.storage.Bucket(Storage,bucketJ);
        elseif isa(varargin{1},'gcp.storage.BlobInfo') %2 empty blob
            blobInfo = varargin{1};
            blobTargetOption = varargin{2};
        
            blobJ = Storage.Handle.create(blobInfo.Handle,blobTargetOption.Handle);
            result= gcp.storage.Blob(blobJ,Storage.projectId);
        else
            warning("Expected first argument to be of type BucketInfo or BlobInfo");
        end
%     elseif nargin==4 %blob with content
%         blobInfo = varargin{1};
%         blobTargetOption = varargin{3};
%         content = varargin{2};
%         %FUTURE SUPPORT : Understand data and file support
%         %CURRENT SUPPORT: Only strings. For elaborate support use
%         %Bucket.create('blobname', content);
%         blobJ = Storage.Handle.create(blobInfo.Handle,content ,blobTargetOption.Handle);
%         result = gcp.storage.Blob(blobJ,Storage.projectId);
    else
        warning("Unexpected number of inputs for function create");
    end
    
end
end %function
