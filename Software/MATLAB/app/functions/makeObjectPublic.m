function acl = makeObjectPublic(storage,blobId)
%MAKEOBJECTPUBLIC function for making your object public
%
% Expected inputs include:
%   * storage - authenticated client
%   * blobId  - object/blob identifier for a blob you have access to
%
% USAGE
%    % create storage client
%       storage = gcp.storage.Storage('credentials.json');
%    % create bucket
%       bucket = storage.create(bucketInfo, bucketTargetOption);
%    % create blob
%       blob = bucket.create(blobname, content);
%    % create blobId
%       blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name)
%    % make your blob public
%       acl = makeObjectPublic(storage,blobId);

% Copyright 2020 The MathWorks, Inc.
%
% Google doc Ref: https://cloud.google.com/storage/docs/access-public-data
% Java API Doc: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Acl.html
%
import com.google.cloud.storage.Acl;

% Setting up Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GCS';

% Check if Storage client is valid
if ~isequal(class(storage),'gcp.storage.Storage')
    write(logObj,'error','Storage client should be of class gcp.storage.Storage');
else
    % get client handle
    storageJ = storage.Handle;
    
    % create aclUser - forAllUsers
    aclUser = javaMethod('ofAllUsers','com.google.cloud.storage.Acl$User');
    % create aclrole forAllUsers as READER
    aclRole = javaMethod('valueOf','com.google.cloud.storage.Acl$Role','READER');
    % apply User Role for given blob of a bucket through an authenticated
    % client with EDITOR access
    aclresponse = storageJ.createAcl(blobId.Handle,javaMethod('of','com.google.cloud.storage.Acl',aclUser,aclRole));
    
    % create MATLAB response object for acl
    acl.entity = string(aclresponse.getEntity);
    acl.Role = string(aclresponse.getRole);
    acl.Etag = string(aclresponse.getEtag);
    acl.Id = string(aclresponse.getId);
    acl.Handle = aclresponse;
    
    blobIdJ = blobId.Handle;
    bucketName = blobIdJ.getBucket;
    blobName = blobIdJ.getName;
    fprintf('Object %s in bucket %s was made publicly readable',blobName,bucketName);
end
end

