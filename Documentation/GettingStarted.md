# Getting Started

Once this package is installed and authentication is in place one can begin working with Google Cloud Storage™. The [Basic Usage](BasicUsage.md) document provides greater details on the functions being used in this first example. 

This is a simple example of creating listing and deleting buckets and bucket objects on Google cloud Storage. This example assumes that the bucket does not pre-exist.
```
% Create the Storage client
storage = gcp.storage.Storage()

storage = 

  Storage with properties:

    projectId: 'pfxxxxxoy'
       Handle: [1x1 com.google.cloud.storage.StorageImpl]

% Create a Bucket.
% Note: Google Cloud Storage provides naming guidelines. The name needs to be globally unique.
bucketName = 'com-myorg-mybucket';
bucketInfo = gcp.storage.BucketInfo.of(bucketName);
bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
bucket = storage.create(bucketInfo, bucketTargetOption)

bucket = 

  Bucket with properties:

     projectId: "pfxxxxxxoy"
    bucketName: "com-myorg-mybucket"
        Handle: [1x1 com.google.cloud.storage.Bucket]

% List Buckets with single or multiple BucketListOptions as filters

% Example of existing buckets to list from:
%
%        BucketName              Createtime                      Owner            
%    __________________    ______________________    _____________________________
%
%    "mymattestbucket1"    "07-Feb-2020 17:07:37"    "project-owners-46REDACTED89"
%    "newmattestbucket1"   "07-Feb-2020 19:07:37"    "project-owners-46REDACTED89"
%    "xymattestbucket1"    "07-Feb-2020 21:07:37"    "project-owners-46REDACTED89"

bucketListOption1 = gcp.storage.Storage.BucketListOption.userProject(storage.projectId);
bucketList = storage.list(bucketListOption1)

bucketList =

  1x3 cell array

    {1x1 gcp.storage.Bucket}    {1x1 gcp.storage.Bucket}    {1x1 gcp.storage.Bucket}

bucketListOption2 = gcp.storage.Storage.BucketListOption.prefix("my");
bucketList = storage.list(bucketListOption1,bucketListOption2)

bucketList =

  1x1 cell array

    {1x1 gcp.storage.Bucket}


% Create Blob object within Bucket

x = magic(4);
blob = bucket.create("unique_blobName",x)

blob = 

  Blob with properties:

         name: "unique_blobName.mat"
    projectId: "pftxxxxloy"
       Handle: [1x1 com.google.cloud.storage.Blob]

% List Blobs within Bucket with single or multiple BlobListOptions as Filters

% Example of Blobs to list from
%
%        blobName               bucketName              Createtime                                    Owner                          
%    _____________________    __________________    ______________________    _________________________________________________________
%
%    "unique_blobName.mat"    "mymattestbucket1"    "07-Feb-2020 17:07:38"    "user-46xxxxxxx89-compute@developer.gserviceaccount.com"
%    "image_blobName.mat"     "mymattestbucket1"    "07-Feb-2020 19:07:38"    "user-46xxxxxxx89-compute@developer.gserviceaccount.com"
    
blobListOption1 = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
blobs = storage.list( bucket.bucketName ,blobListOption1)

blobs =

    1x2 cell array

    {1x1 gcp.storage.Blob}  {1x1 gcp.storage.Blob}

blobListOption2 = gcp.storage.Storage.BlobListOption.prefix("un");
blobs = storage.list( bucket.bucketName ,blobListOption1,blobListOption2)

blobs =
  
    1x1 cell array

    {1x1 gcp.storage.Blob}


% Delete Blob Object

blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;
blob.delete(blobSourceOption)

ans =

  logical

   1

% Delete the Bucket
bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
bucket.delete(bucketSourceOption)

Deleted
ans =

  logical

   1
```

## Logging
When getting started or debugging it can be helpful to get more feedback. Once the Client has been created one can set the logging level to verbose as follows:
```
logObj = Logger.getLogger();
logObj.DisplayLevel = 'verbose';
```
See: [Logging](Logging.md) for more details.


[//]: #  (Copyright 2020 The MathWorks, Inc.)
