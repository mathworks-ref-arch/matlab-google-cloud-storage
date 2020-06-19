function result = deleteObject(Storage,varargin)
% DELETE Deletes the requested blobs or buckets
%
% Bucket Deletion: Accepts an optional userProject Storage.BucketSourceOption option which
% defines the project id to assign operational costs
%
% Blob Deletion: Accepts an optional userProject Storage.BlobSourceOption option which
% defines the project id to assign operational costs. Can also accept BlobId
%
% Usage
%
% 1. Delete a Bucket
%
%  Create bucket:
%
%  storage = gcp.storage.Storage();
%  bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%  bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%  bucket = storage.create(bucketInfo, bucketTargetOption)
%
%  Delete bucket:
%
%  bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
%  storage.deleteObject(bucket.bucketName, bucketSourceOption)
%
%
% 2. Delete a blob
%
%  Create bucket:
%
%  storage = gcp.storage.Storage();
%  bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%  bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%  bucket = storage.create(bucketInfo, bucketTargetOption)
% 
%  Create blob:
%
%  blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"mynewname");
%  blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
%  blob = storage.create(blobInfo, blobTargetOption)
% 
%  Delete blob:
%
%  blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name)
%  storage.deleteObject(blobId)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Storage.html#delete-java.lang.String-com.google.cloud.storage.Storage.BucketSourceOption...-
%
% Supported Java Method Calls
%
% Below numbers can be used as reference to map client library functions to
% supported MATLAB static methods implemented below
%
% 1. boolean	delete(BlobId blob)
%
% 2. List<Boolean>	delete(BlobId... blobIds)
%
% 3. boolean	delete(String bucket, Storage.BucketSourceOption... options)
%
% 4. boolean	delete(BlobId blob, Storage.BlobSourceOption... options)
%
% 5. boolean	delete(String bucket, String blob, Storage.BlobSourceOption... options)
% 

%% Implementation

if nargin==2
    
    % Inputs can be list of blobIds or a single blobId Case 1 & 2
    if isa(varargin{1},'gcp.storage.BlobId')
        if size(varargin{1})<2
            blobId = varargin{1}.Handle;
            result = Storage.Handle.delete(blobId);
        else
            inputids = varargin{1};
            blobIds = javaArray('com.google.cloud.storage.BlobId',size(inputids,2));
            for i=1:size(inputids,2)
                blobIds(i)=inputids(i).Handle;
            end
            result = Storage.Handle.delete(blobIds);
        end
    else
        warning("Unsupported case if input is Iterable<BlobId>");
    end
    
elseif nargin==3
    
    % Verifying Input arguments from Case 3 & 4
    if ischar(varargin{1}) || isstring(varargin{1})
        bucketName = varargin{1};
        bucketSourceOption = varargin{2}.Handle;
        result = Storage.Handle.delete(bucketName,bucketSourceOption);
    elseif isa(varargin{1},'gcp.storage.BlobId')
        blobId = varargin{1}.blobId;
        blobSourceOption = varargin{2}.Handle;
        result = Storage.Handle.delete(blobId,blobSourceOption);
    else
        warning('Expecting first input argument to be either a bucketName or a BlobId')
    end 
    
elseif nargin==4
    bucketName = varargin{1};
    blobName= varargin{2};
    blobSourceOption = varargin{2}.Handle;
    result = Storage.Handle.delete(bucketName,blobName,blobSourceOption);
    
else
    warning('Expecting number of input arguments to be either 1, 2 or 3')
    
end%if nargin

%% Unsupported method calls
% List<Boolean>	delete(Iterable<BlobId> blobIds)
% Deletes the requested blobs.
end %function
