# Basic Usage

## Initializing a client
The first step is to create a storage client to connect to Google Cloud Storage Interface™.
You can create a client by calling the Storage class with or without explicitly providing your credentials as follows:
```
storage = gcp.storage.Storage();
```
In the above section, the Storage class expects to find a ```credentials.json``` file on path with credentials for your Google cloud account.
If you wish to use different credentials frequently, you could explicitly mention the new credentials as an input parameter to the Storage class everytime you create a client.
The credentials just need to be on MATLAB path.
```
storage = gcp.storage.Storage("google-project-credentials.json");
```
The storage class you set for an object affects the object's availability and pricing model.
Standard Storage is best for data that is frequently accessed ("hot" data) and/or stored for only brief periods of time.
You can change the storage class of an existing object either by rewriting the object or by using Object Lifecycle Management.
For more details please see: <https://cloud.google.com/storage/docs/storage-classes#standard>

By default the package will provide minimal feedback however one can increase the level of feedback by altering the logging level to 'verbose', see [Logging](Logging.md) for more details.

## Create a bucket on Google Cloud Storage
Buckets are the basic containers that hold your data. Everything that you store in Cloud Storage must be contained in a bucket.
You can use buckets to organize your data and control access to your data, but unlike directories and folders, you cannot nest buckets. Because there are limits to bucket creation and deletion, you should design your storage applications to favor intensive object operations and relatively few buckets operations.
For more details please see [Reference](https://cloud.google.com/storage/docs/key-terms#buckets)

**Note:**
* Google cloud storage bucket names are globally unique, so once a bucket name has been taken by any user, another bucket with that same name cannot be created. [Ref](https://cloud.google.com/storage/docs/naming#requirements)
* There is a per-project rate limit to bucket creation and deletion [Ref](https://cloud.google.com/storage/quotas)
* There is an update limit on each bucket of once per second

Create a bucket by calling the `create()` method as follows:
```
storage = gcp.storage.Storage();
bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
bucket = storage.create(bucketInfo, bucketTargetOption);
```

To determine if a bucket already exists, list the existing buckets using the `list()` method
or use the `exist()` method to check for a specific bucket.

## Listing existing buckets
`list()` returns a list of buckets and with accessible metadata.
`BucketListOption` single or multiple can be passed within the list() method as a filter to list relevant buckets 
```
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

% Use prefix() method to filter buckets with bucket names starting with a certain pattern
bucketListOption2 = gcp.storage.Storage.BucketListOption.prefix("my");

% The number of bucketListOptions that can be passed as an input to list() method is atleast one
bucketList = storage.list(bucketListOption1,bucketListOption2)

bucketList =

  1x1 cell array

    {1x1 gcp.storage.Bucket}


```
## Note:

The ```gcp.storage.Storage.BucketListOption.userProject("projectid")``` method for BlobListOption will work for service accounts having access to the project containing the bucket containing the blobs.
If you do not have access you may receive an error similar to **"testaccxxxxxxsim@pREDACTEDy.iam.gserviceaccount.com does
not have storage.buckets.list access to project '46REDACTED89'."**
If this is the case you might consider using other methods such as ```prefix()``` or ```fields()``` as an option to construct BucketListOption object.

## Check if a bucket exists
`exists()` returns true or false.
```
bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
bucket.exists(bucketSourceOption);
```

##Get bucket information/metadata
`get()` returns metadata associated with a bucket
```
bucketGetOption = gcp.storage.Storage.BucketGetOption.userProject(storage.projectId);
storage.get(bucket.bucketName, bucketGetOption)

ans = 

  Bucket with properties:

     projectId: "pfREDACTEDoy"
    bucketName: "pfREDACTEDtestgbqbucketjson"
        Handle: [1×1 com.google.cloud.storage.Bucket]
```
You can alternatively create ```gcp.storage.Storage.BucketGetOption``` with the method ```fields()``` instead of using ```userProject```.

## Upload data as an object(Blob) within a bucket
Once a bucket has been created one can store data in it assuming one has write permission for the bucket in question. 
```bucket.create()``` enables blob object creation with content on Google Cloud Storage.
The API supports:
    * upload for files(.txt, .csv, .mat etc) containing arbitrary data
    * upload for existing MATLAB workspace variable. Note: '.mat' gets appended to the blobname in this case

The following example shows a .mat file (holding 10000 random numbers) can be uploaded to a bucket. The object "key" is the unique name by which the object is known within the bucket.
```
% create and initialize the client
storage = gcp.storage.Storage();

% create bucket to hold the data object
bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
bucket = storage.create((bucketInfo, bucketTargetOption);

% create empty blob object (optional)
blobInfo = gcp.storage.BlobInfo.newbuilder(bucket.bucketName,"uniqueblobname");
blobTargetOption = gcp.storage.Storage.userProject(storage.projectId);
blob = storage.create(blobInfo, blobTargetOption)

% directly create blob object with file content from an existing file "filename.mat"
blob = bucket.create("unique_blobName","filename.mat")
```

The following example shows fileupload syntax for ```bucket.create()```
```
%or directly create blob object with MATLAB workspace variable 'x'

blob = bucket.create("unique_blobName",x)

blob = 

  Blob with properties:

         name: "unique_blobName.mat"
    projectId: "pfREDACTEDoy"
       Handle: [1x1 com.google.cloud.storage.Blob]

Note: '.mat' gets appended if the input is a variable in MATLAB workspace

```

As an alternative to .mat file, the workspace variable x can also be jsonencoded into a JSON string and passed as string through ```bucket.create ```

```
x = 

  struct with fields:

        name: "abc"
         age: 26
    children: 0

>> x = jsonencode(x)

x =

    '{"name":"abc","age":26,"children":false}'

blob = bucket.create("unique_blobName",x);

% You can now read blob data from cloud without writing it to disk as mat file
% as follows

blobId =  gcp.storage.BlobId.of(bucket.bucketName,blob.name)
bytecontent  = storage.readAllBytes(blobId);
byte2str = [native2unicode(bytecontentrx)]';
readvartable = jsondecode(byte2str)

readvartable =

     '{"name":"abc","age":26,"children":false}'
```
## Note: Object Immutability

* Objects are immutable, which means that an uploaded object cannot change throughout its storage lifetime. An object's storage lifetime is the time between successful object creation (upload) and successful object deletion.
* It's possible to overwrite objects. It happens atomically — until the new upload completes the old version of the object will be served to readers, and after the upload completes the new version of the object will be served to readers.
* There is no limit to how frequently you can create or update different objects in a bucket.
* A single particular object can only be updated or overwritten up to once per second. Updating the same object more frequently than once per second may result in 429 Too Many Requests errors

Get more details here: [Reference](https://cloud.google.com/storage/docs/key-terms#immutability)

## Make an object or a blob within a bucket Publicly Readable

The 'makeObjectPublic()` function can be used to make individual objects readable to everyone on the public internet.

```
blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name);

acl = makeObjectPublic(storage,blobId)

aclresponse =

Acl{entity=allUsers, role=READER, etag=CKP66cfLhugCEAI=, id=pfREDACTEDoy-737856-5899/unique_blobName3/1583523185720611/allUsers}

Object unique_blobName3 in bucket pftREDACTEDoy-xxxxx-5899 was made publicly readable
acl = 

  struct with fields:

    entity: [1x1 java.lang.String]
      Role: [1x1 java.lang.String]
      Etag: [1x1 java.lang.String]
        Id: [1x1 java.lang.String]
    Handle: [1x1 com.google.cloud.storage.Acl]
```

## Make a bucket and all it's objects Publicly Readable

The 'makeBucketPublic()` function can be used to make all objects within a  given bucket readable to everyone on the public internet.

```
% create authenticated Client
 storage = gcp.storage.Storage('credentials.json');

    storage = 

      Storage with properties:

        projectId: 'pREDACTEDy'
           Handle: [1x1 com.google.cloud.storage.StorageImpl]

% get bucketName from the bucket object
bucketName = bucket.bucketName

    bucketName =

        'pftREDACTED-6358'

% make this bucket and it's contents public
response = makeBucketPublic(storage,bucketName)

    Bucket pfREDACTEDxxxx58 is now publicly readable

    New policy for pftxxxREDACTEDxxxx8 is Policy{bindings={roles/storage.legacyBucketOwner=[projectEditor:pfREDACTEDoy, projectOwner:pfREDACTEDoy], roles/storage.legacyBucketReader=[projectViewer:pfREDACTEDoy], roles/storage.objectViewer=[allUsers]}, etag=CAI=, version=0}

    response =

        Policy{bindings={roles/storage.legacyBucketOwner=[projectEditor:pfREDACTEDoy, projectOwner:pfREDACTEDoy], roles/storage.legacyBucketReader=[projectViewer:pfREDACTEDoy], roles/storage.objectViewer=[allUsers]}, etag=CAI=, version=0}

```
## List objects within a bucket

Just as buckets were listed, object can also be listed. 
The `list()` method returns a list of object names and accessible metadata.
All objects in a bucket can be queried using the `list()` method.
```
bloblist = bucket.list(blobListOption1, blobListOption2, ... , blobListOptionN);

% or

[bloblist, blobstructlist] = bucket.list(blobListOption1, blobListOption2, ... , blobListOptionN);

% Example: Blobs to list from
%
%        blobName               bucketName              Createtime                                    Owner                          
%    _____________________    __________________    ______________________    _________________________________________________________
%
%    "unique_blobName.mat"    "mymattestbucket1"    "07-Feb-2020 17:07:38"    "user-46xxxxxxx89-compute@developer.gserviceaccount.com"
%    "image_blobName.mat"     "mymattestbucket1"    "07-Feb-2020 19:07:38"    "user-46xxxxxxx89-compute@developer.gserviceaccount.com"
%  
%
    
blobListOption1 = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
blobslist = storage.list(bucket.bucketName ,blobListOption1)

blobslist =

    1x2 cell array

    {1x1 gcp.storage.Blob}  {1x1 gcp.storage.Blob}

blobListOption2 = gcp.storage.Storage.BlobListOption.prefix("un");
[blobslist, blobstructlist] = storage.list( bucket.bucketName ,blobListOption1,blobListOption2)

blobslist =
  
    1x1 cell array

    {1x1 gcp.storage.Blob}


blobstructlist =

  1x1 cell array

    {1x1 struct}


blobstructlist{1}

ans = 

  struct with fields:

      blobname: "unique_blobName.mat"
        bucket: "mymattestbucket1"
    createtime: "07-Feb-2020 17:07:38"
         owner: "user-46xxxxxxx89-compute@developer.gserviceaccount.com"


```
## Note: 

The ```gcp.storage.Storage.BlobListOption.userProject("projectid")``` method for BlobListOption will work for service accounts having access to the project containing the bucket containing the blobs.
If you do not have access you may receive an error similar to  **"message" : "tesREDACTEDsim@pREDACTEDy.iam.gserviceaccount.com does not
have storage.objects.list access to 'testbucketxxxname'." **
If this is the case you might consider using other methods such as ```prefix()``` or ```currentDirectory()``` as an option to construct BucketListOption object.


## Get specified blob contained within a bucket:
`get()` Returns requested blob that already exists.

``` 
blobGetOption = gcp.storage.Storage.BlobGetOption.userProject(storage.projectId)

blobGetOption = 

  BlobGetOption with properties:

    Handle: [1x1 com.google.cloud.storage.Storage$BlobGetOption[]]

blob = storage.get(bucket.bucketName,'mynewblob2.mat',blobGetOption);


blob = 

  Blob with properties:

         name: "mynewblob2.mat"
    projectId: "pfREDACTEDoy"
       Handle: [1x1 com.google.cloud.storage.Blob]
  blob = storage.get(bucket.bucketName,blobname,blobGetOption);
```

Check if blob object exists :
`exists()` returns true or false.
```
blobSourceOption = gcp.storage.Blob.BlobSourceOption.userProject(blob.projectId);
checkblob = blob.exists(blobSourceOption)

ans =

  logical

   1
```
**Note:** If you have limited permissions to the project, you might want to use the method ```generationMatch()``` instead of ```userProject()```

## Download Blob object
Retrieving data from blob using the API is straightforward using method 'downloadTo()'. 
You can download the object to a local directory in the same format as it was uploaded e.g. a file "filename.mat" once uploaded as a blob, can be downloaded locally and will be named as *filename.mat*.

```
blob.downloadTo("local-filesystem-path");

   'file downloaded to C:\Users\xxx\xxxx\datafromgcs.csv'
```
**Note:** If the method will result in a file being overwritten a warning is produced and the operation does not proceeds.
You will need to remove the existing local copy of the file with the same name and run the above commands.

## Retrieve data from blob
You can also read the blob content in the form of bytes using the method 'readAllBytes()'. this method also creates a local file containing the blob content.
Following are two ways in which the method `readAllBytes()` can be called. Expect an array with bytecontent returned in MATLAB workspace.
 
```
content = storage.readAllBytes("existingbucketName","existingblobName");

```

or

```
blobId = gcp.storage.BlobId.of("existingbucketName","existingblobName")
content = storage.readAllBytes(blobId)
```
Note: Make sure you have the file extension included in the blob name 
e.g. .mat would have been appended if you had missed providing it within the filename while creating blob with a MATLAB workspace variable.


## Delete a Blob object
Removes the specified object from the specified bucket. Unless versioning has been turned on for the bucket, there is no way to undelete an object, so use caution when deleting objects.
```
storage = gcp.storage.Storage();

blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name)

blobId = 

  BlobId with properties:

    Handle: [1x1 com.google.cloud.storage.BlobId]
    
storage.deleteObject(blobId)

ans =

  logical

   1
```


## Deleting a bucket
Buckets cannot be deleted if they are not empty. An empty bucket can be deleted using ```bucket.delete()```
You will also need enough permissions to exercise this method.
```
storage = gcp.storage.Storage();

bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId)

bucketSouceOption = 

  BucketSourceOption with properties:

    Handle: [1x1 com.google.cloud.storage.Storage$BucketSourceOption[]]
    
storage.deleteObject(bucket.bucketName, bucketSourceOption)

ans =

  logical

   1

```

A bucket must first be empty of objects in order to delete it.

**CAUTION** - since bucket names are globally unique, you may not be able to recreate a bucket of the same name immediately. It might take some time before the name can be reused.


[//]: #  (Copyright 2020 The MathWorks, Inc.)
