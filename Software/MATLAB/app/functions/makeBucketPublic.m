function response = makeBucketPublic(storage,bucketName)
%MAKEBUCKETPUBLIC function for making your bucket public, and hence all the
%objects within bucket
%
% USAGE
%
% % create authenticated Client
%   storage = gcp.storage.Storage('credentials.json');
%
% % get bucketName from the bucket object
%   bucketName = bucket.bucketName
%
% % make this bucket and it's contents public
%   makeBucketPublic(storage,bucketName)

% Copyright 2020 The MathWorks, Inc.
%
% Google Doc Ref: https://cloud.google.com/storage/docs/access-control/making-data-public#buckets

import com.google.cloud.storage.StorageRoles;
import com.google.cloud.Identity;
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GCS';

if ~isequal(class(storage),'gcp.storage.Storage')
    write(logObj,'error','Storage client should be of class gcp.storage.Storage');
else
    % getting Java object from Handle
    storageJ = storage.Handle;
    
    % get bucketSourceOption for your bucket
    bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
    
    % getting original bucket policy
    originalPolicyJ = storageJ.getIamPolicy(bucketName, bucketSourceOption.Handle);
    
    % create Policy Builder
    policyBuilderJ = originalPolicyJ.toBuilder;
    
    % create Identity Array
    Idarr = javaArray('com.google.cloud.Identity',1);
    Idarr(1) = Identity.allUsers();
    
    response = storageJ.setIamPolicy(bucketName,policyBuilderJ.addIdentity(StorageRoles.objectViewer(), Identity.allUsers(), Idarr).build(),bucketSourceOption.Handle);
    
    fprintf('\n Bucket %s is now publicly readable',bucketName);
    
    response = response.toString;
    fprintf('\n\n New policy for %s is %s \n\n',bucketName,response);
end
end

