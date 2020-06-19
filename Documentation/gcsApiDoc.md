# MATLAB Interface *for Google Cloud Storage* API documentation


## Google Cloud Storage Interface Objects and Methods:
* @AnonymousStorage
* @Blob
* @BlobId
* @BlobInfo
* @Bucket
* @BucketInfo
* @Object
* @Storage



------

## @AnonymousStorage

### @AnonymousStorage/AnonymousStorage.m
```notalanguage
  ANONYMOUSSTORAGE A MATLAB interface for Google Cloud Storage
  Instantiate an anonymous Google Cloud Storage client, which can only access public files
 
 USAGE
  astorage = gcp.storage.AnonymousStorage();
 
  Only usage is in function: downloadpublicdataset(storage,bucketName, blobName, destination)



```

------


## @Blob

### @Blob/Blob.m
```notalanguage
  BLOB A Google cloud storage object
 
   Blob is a Google cloud storage object.
   Objects of this class are immutable. 
   Blob adds a layer of service-related functionality over BlobInfo.
 
   BLOB Class is used to mask Java object Blob
   It holds the Java Object in it's Handle



```
### @Blob/delete.m
```notalanguage
 DELETE Deletes this blob
 
  USAGE:
 
   blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;
   blob.delete(blobSourceOption)



```
### @Blob/downloadTo.m
```notalanguage
 DOWNLOADTO Downloads blob to a given path
 
  USAGE
 
    downloadLocation = /local/file/path
    blob.downloadTo(downloadLocation);



```
### @Blob/exists.m
```notalanguage
  EXISTS Checks if this blob exists.
 
  USAGE
 
     blob = bucket.create('uniqueblobname','filename.txt')
     blobSourceOption = gcp.storage.Blob.BlobSourceOption.userProject(blob.projectId);
     checkblob = blob.exists(blobSourceOption)



```

------


## @BlobId

### @BlobId/BlobId.m
```notalanguage
  BLOBID Creates a blob identifier BlobId and returns the object BlobId
 
  BlobId is a Google Storage Object identifier.
  A BlobId object includes the name of the containing bucket,
  the blob's name and possibly the blob's generation.
 
  USAGE
 
    storage = gcp.storage.Storage();
    bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
    bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
    bucket = storage.create(bucketInfo,bucketTargetOption);
 
    blobId = gcp.storage.BlobId.of(bucket.bucketName,"uniqueblobname")



```

------


## @BlobInfo

### @BlobInfo/BlobInfo.m
```notalanguage
  BLOBINFO Returns a BlobInfo builder where blob identity is set using
  the provided value
 
  BlobInfo can be used for Blob creation
  To construct a BlobInfo object you can use the method BlobInfo.newBuilder
 
  Usage:
 
    1. BlobId as input argument:
 
    storage = gcp.storage.Storage("credentials.json")
    bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
    bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
    bucket = storage.create(bucketInfo,bucketTargetOption);
    blobId	= gcp.storage.BlobId.of(bucket.bucketName, "uniqueblobname");
    blobInfo = gcp.storage.BlobInfo.newBuilder(blobId);
 
    2. BuckeInfo and a unique non-existent Blob name as input arguments:
 
    storage = gcp.storage.Storage();
    bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
    bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
    bucket = storage.create(bucketInfo,bucketTargetOption);
    blobInfo = gcp.storage.BlobInfo.newBuilder(bucketInfo,"uniqueblobname");
 
    3. An existing Bucket's name and a unique non-existent Blob name
 
    storage = gcp.storage.Storage();
    bucketInfo = gcp.storage.BucketInfo.of("uniquebucketnameforblob");
    bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
    bucket = storage.create(bucketInfo,bucketTargetOption);
    blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");



```

------


## @Bucket

### @Bucket/Bucket.m
```notalanguage
 BUCKET A Google cloud storage bucket



```
### @Bucket/create.m
```notalanguage
 CREATE Creates a new Blob within a Storage Bucket
 
    USAGE
 
     Create a new blob with file content(.mat or .csv or .txt file)
 
     Create a new blob with MATLAB workspace variable
 
     Create a new blob with plain text strings :
 
       blob = bucket.create(varargin)
 
        1. Here varargin{1} is "unique_blobName" and varargin{2} is file to be
           uploaded i.e. filename.mat
 
           storage = gcp.storage.Storage('credentials<REDACTED>_path.json');
           bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
           bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
           bucket = storage.create(bucketInfo, bucketTargetOption)
           blob = bucket.create("unique_blobName","filename.mat")
 
       2. Here varargin{1} is "unique_blobName" and varargin{2} is file to be
          uploaded i.e. filename.mat
 
          storage = gcp.storage.Storage();
          bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
          bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
          bucket = storage.create(bucketInfo, bucketTargetOption)
          blob = bucket.create("unique_blobName","filename.txt")
 
       3. Here varargin{1} is "unique_blobName" and varargin{2} is a MATLAB
          workspace variable, which will be saved as a matfile locally
          before upload
 
          storage = gcp.storage.Storage();
          bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
          bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
          bucket = storage.create(bucketInfo, bucketTargetOption)
          blob = bucket.create("unique_blobName",MATLAB_workspace_variable)
 
       4. Here varargin{1} is "unique_blobName" and varargin{2} is a string
          to be uploaded
 
          storage = gcp.storage.Storage('credentials<REDACTED>_path.json');
          bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
          bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
          bucket = storage.create(bucketInfo, bucketTargetOption)
          blob = bucket.create("unique_blobName","text string to be uploaded")



```
### @Bucket/delete.m
```notalanguage
 DELETE Deletes this bucket.
 
  Note: Bucket needs to be empty for deletion. Delete Blob objects within a
  container before calling delete on a given Bucket object
 
  USAGE
        
        storage = gcp.storage.Storage('credentials<REDACTED>_path.json');
        bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
        bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
        bucket = storage.create(bucketInfo, bucketTargetOption)
        bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
 
        bucket.delete(bucketSourceOption)



```
### @Bucket/exists.m
```notalanguage
 EXISTS Checks if this bucket exists.
 
  USAGE:
     bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
     bucket.exists(bucketSourceOption);



```
### @Bucket/get.m
```notalanguage
 GETLOB Returns the requested blob or null if not found
 
  USAGE
 
     blobName = "existingblobname";
     bucket_field_values = gcp.storage.Storage.BucketField;
     blobGetOption = gcp.storage.BlobGetOption.fields(bucket_field_values)
     blob = bucket.get(blobName,blobGetOption);



```
### @Bucket/list.m
```notalanguage
 LIST Lists the bucket's blobs.
 
  USAGE
 
    storage = gcp.storage.Storage('credentials.json')
    bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
    bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
    bucket = storage.create(bucketInfo, bucketTargetOption)
 
    blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId)
 
    blobList = bucket.list(blobListOption1,...,...,...,blobListOption2, blobListOptionN)
            or
    [blobList, blobStructList] = bucket.list(blobListOption1,...,...,...,blobListOption2, blobListOptionN)



```

------


## @BucketInfo

### @BucketInfo/BucketInfo.m
```notalanguage
  BUCKETINFO Google Storage bucket metadata
 
  BUCKETINFO.BUILDER Builder for BucketInfo
  
 
  USAGE
 
    1. Use method gcp.storage.BucketInfo.newbuilder()
 
       storage = gcp.storage.Storage();
       bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
 
       bucketInfo = gcp.storage.BucketInfo.newbuilder("bucketName");
      
         or
         
       bucketInfo = gcp.storage.BucketInfo.newbuilder("bucketName","bucketlocation");
         
         or
         
       bucketInfo = gcp.storage.BucketInfo.newbuilder("bucketName","bucketlocation","storageclass");
   
    2. Use method gcp.storage.BucketInfo.of()
 
       storage = gcp.storage.Storage();
       bucketTargetOption = gcp.storage.Storage.bucketTargetOption.userProject(storage.ProjectId);
       bucket = storage.create("uniquebucketName",bucketTargetOption);
       bucketInfo = gcp.storage.BucketInfo.of(bucket.bucketName);



```

------


## @Object

### @Object/Object.m
```notalanguage
  OBJECT Root object for GCP.STORAGE



```

------


## @Storage

### @Storage/Storage.m
```notalanguage
  STORAGE A MATLAB interface for Google Cloud Storage
 
 USAGE
 
  storage = gcp.storage.Storage("credentials.json");
 
  Ref: https://cloud.google.com/storage/docs/reference/libraries
 
  Property : projectId
 
  Methods : create(), get(), delete(), list(), readAllbytes()



```
### @Storage/create.m
```notalanguage
  CREATE Creates a bucket or a blob (empty or with content)
 
  USAGE
 
    bucket = storage.create(bucketInfo, bucketTargetOption)
    blob = storage.create(blobInfo, blobTargetOption)
 
  Create a new bucket:
 
   storage = gcp.storage.Storage();
   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
   bucket = storage.create(bucketInfo, bucketTargetOption)
 
 
  Create a new blob with no content:
 
   storage = gcp.storage.Storage();
   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
   bucket = storage.create(bucketInfo, bucketTargetOption)
 
   blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
   blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
   blob = storage.create(blobInfo, blobTargetOption)



```
### @Storage/deleteObject.m
```notalanguage
  DELETE Deletes the requested blobs or buckets
 
  Bucket Deletion: Accepts an optional userProject Storage.BucketSourceOption option which
  defines the project id to assign operational costs
 
  Blob Deletion: Accepts an optional userProject Storage.BlobSourceOption option which
  defines the project id to assign operational costs. Can also accept BlobId
 
  Usage
 
  1. Delete a Bucket
 
   Create bucket:
 
   storage = gcp.storage.Storage();
   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
   bucket = storage.create(bucketInfo, bucketTargetOption)
 
   Delete bucket:
 
   bucketSourceOption = gcp.storage.Storage.BucketSourceOption.userProject(storage.projectId);
   storage.deleteObject(bucket.bucketName, bucketSourceOption)
 
 
  2. Delete a blob
 
   Create bucket:
 
   storage = gcp.storage.Storage();
   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
   bucket = storage.create(bucketInfo, bucketTargetOption)
  
   Create blob:
 
   blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"mynewname");
   blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
   blob = storage.create(blobInfo, blobTargetOption)
  
   Delete blob:
 
   blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name)
   storage.deleteObject(blobId)



```
### @Storage/get.m
```notalanguage
  GET Returns requested bucket, blob or blobs
    Returns null if not available
  
  Usage
 
  1. Get bucket Information
 
  Create bucket:
 
  storage = gcp.storage.Storage("gcp.json");
  bucketInfo = gcp.storage.BucketInfo.of("matlabpkarname3");
  bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
  bucketJ = storage.create(bucketInfo, bucketTargetOption);
 
  Get specified Bucket:
 
  bucketfields = gcp.storage.Storage.BucketField;
  bucketGetOption = gcp.storage.Storage.BucketGetOption.fields(bucketfields);
  bucket = storage.get(bucket.bucketName, bucketGetOption);
 
  2. Get blob and blob Information
 
  Create bucket:
 
  storage = gcp.storage.Storage("credentials.json");
  bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
  bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
  bucket = storage.create(bucketInfo, bucketTargetOption);
 
  Create blob: 
 
  blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
  blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
  blob = storage.create(blobInfo, blobTargetOption)
 
  Get specified blob contained within a bucket:
 
  blobfields = gcp.storage.Storage.BlobField;
  blobGetOption = gcp.storage.Storage.BlobGetOption.fields(blobfields);
  blob = storage.get(bucket.bucketName,blob.name,blobGetOption)



```
### @Storage/list.m
```notalanguage
  LIST Lists the project's bucket and blobs
 
  USAGE
 
  List buckets:
 
    storage = gcp.storage.Storage();
    bucketListOption = gcp.storage.Storage.BucketListOption.userProject(storage.projectId);
    bucketList = storage.list(bucketListOption1,bucketListOption2,...,bucketListOptionN);
            or
    [bucketList, bucketStructList] = storage.list(bucketListOption1,bucketListOption2,...,bucketListOptionN);
 
  List blobs:
 
    storage = gcp.storage.Storage();
    blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
    blobList = storage.list(bucket.bucketName,blobListOption1,...,...,...,blobListOption2, blobListOptionN);
                        or
    [blobList, blobsStructList] = storage.list(bucket.bucketName,blobListOption1,...,...,...,blobListOption2, blobListOptionN)



```
### @Storage/readAllBytes.m
```notalanguage
 READALLBYTES Reads all the bytes from a blob
    
  USAGE:
 
  1. storage.readAllBytes(bucketName,blobName)
  2. storage.readAllBytes(blobId)
 
      where bucketName and blobName are of type string and refer to existing bucket and blob
      blobId can be created using gcp.storage.BlobId.of()



```

------

## Google Cloud Storage Interface Related Functions:
### functions/Logger.m
```notalanguage
  Logger - Object definition for Logger
  ---------------------------------------------------------------------
  Abstract: A logger object to encapsulate logging and debugging
            messages for a MATLAB application.
 
  Syntax:
            logObj = Logger.getLogger();
 
  Logger Properties:
 
      LogFileLevel - The level of log messages that will be saved to the
      log file
 
      DisplayLevel - The level of log messages that will be displayed
      in the command window
 
      LogFile - The file name or path to the log file. If empty,
      nothing will be logged to file.
 
      Messages - Structure array containing log messages
 
  Logger Methods:
 
      clearMessages(obj) - Clears the log messages currently stored in
      the Logger object
 
      clearLogFile(obj) - Clears the log messages currently stored in
      the log file
 
      write(obj,Level,MessageText) - Writes a message to the log
 
  Examples:
      logObj = Logger.getLogger();
      write(logObj,'warning','My warning message')
 



```
### functions/downloadPublicDataset.m
```notalanguage
 DOWNLOADPUBLICDATASET function for downloading a public dataset
 
  The input arguments expected are:
     * Unauthenticated Storage client to the public bucket
     * Bucket Name
     * Blob Name: Name of the remote public file to download e.g. "publicfile.txt";
     * Destination: Local path where the file should be downloaded
 
  EXAMPLE:
 
    storage = gcp.storage.AnonymousStorage;
    downloadpublicdataset(storage,'gcp-public-data','folder1/folder2/my_public_file.png',pwd)



```
### functions/gcsroot.m
```notalanguage
  GCSROOT returns location of tooling



```
### functions/getblobinfo.m
```notalanguage
  GETBLOBINFOTABLE Returns blob properties in the form of a struct
 
  Input is a list of Blob objects
  Properties for every blob are queried in the function ans assigned to a
  struct. Every struct representing every blob is assigned to an array
  named blobinformation and returned as function output in the order of the
  blobs contained within the input argument.
 
  Note: Some properties of the blob might be missing based on the user's
  access rights to the blob



```
### functions/getbucketinfo.m
```notalanguage
  GETBUCKETINFOTABLE Returns bucket properties in the form of a struct
 
  Input is a Bucket object
 
  Properties of the bucket are queried in the function ans assigned to a
  struct. The struct is named bucketinformation and returned as function output
 
  Note: Some properties of the bucket might be missing based on the user's
  access rights to the bucket in a given project



```
### functions/gsutil.m
```notalanguage
  Usage: gsutil [-D] [-DD] [-h header]... [-m] [-o] [-q] [command [opts...] args...]
 
  Available commands:
    acl              Get, set, or change bucket and/or object ACLs
    bucketpolicyonly Configure Bucket Policy Only (Beta)
    cat              Concatenate object content to stdout
    compose          Concatenate a sequence of objects into a new composite object.
    config           Obtain credentials and create configuration file
    cors             Get or set a CORS JSON document for one or more buckets
    cp               Copy files and objects
    defacl           Get, set, or change default ACL on buckets
    defstorageclass  Get or set the default storage class on buckets
    du               Display object size usage
    hash             Calculate file hashes
    help             Get help about commands and topics
    hmac             CRUD operations on service account HMAC keys.
    iam              Get, set, or change bucket and/or object IAM permissions.
    kms              Configure Cloud KMS encryption
    label            Get, set, or change the label configuration of a bucket.
    lifecycle        Get or set lifecycle configuration for a bucket
    logging          Configure or retrieve logging on buckets
    ls               List providers, buckets, or objects
    mb               Make buckets
    mv               Move/rename objects
    notification     Configure object change notification
    perfdiag         Run performance diagnostic
    rb               Remove buckets
    requesterpays    Enable or disable requester pays for one or more buckets
    retention        Provides utilities to interact with Retention Policy feature.
    rewrite          Rewrite objects
    rm               Remove objects
    rsync            Synchronize content of two buckets/directories
    setmeta          Set metadata on already uploaded objects
    signurl          Create a signed url
    stat             Display object status
    test             Run gsutil unit/integration tests (for developers)
    ubla             Configure Uniform bucket-level access
    update           Update to the latest gsutil release
    version          Print version info about gsutil
    versioning       Enable or suspend versioning for one or more buckets
    web              Set a main page and/or error page for one or more buckets
 
  Additional help topics:
    acls             Working With Access Control Lists
    anon             Accessing Public Data Without Credentials
    apis             Cloud Storage APIs
    crc32c           CRC32C and Installing crcmod
    creds            Credential Types Supporting Various Use Cases
    dev              Contributing Code to gsutil
    encoding         Filename encoding and interoperability problems
    encryption       Using Encryption Keys
    metadata         Working With Object Metadata
    naming           Object and Bucket Naming
    options          Top-Level Command-Line Options
    prod             Scripting Production Transfers
    projects         Working With Projects
    retries          Retry Handling Strategy
    security         Security and Privacy Considerations
    subdirs          How Subdirectories Work
    support          Google Cloud Storage Support
    throttling       Throttling gsutil
    versions         Object Versioning and Concurrency Control
    wildcards        Wildcard Names
 
  Use gsutil help <command or topic> for detailed help.
 



```
### functions/makeBucketPublic.m
```notalanguage
 MAKEBUCKETPUBLIC function for making your bucket public, and hence all the
 objects within bucket
 
  USAGE
 
  % create authenticated Client
    storage = gcp.storage.Storage('credentials.json');
 
  % get bucketName from the bucket object
    bucketName = bucket.bucketName
 
  % make this bucket and it's contents public
    makeBucketPublic(storage,bucketName)



```
### functions/makeObjectPublic.m
```notalanguage
 MAKEOBJECTPUBLIC function for making your object public
 
  Expected inputs include:
    * storage - authenticated client
    * blobId  - object/blob identifier for a blob you have access to
 
  USAGE
     % create storage client
        storage = gcp.storage.Storage('credentials.json');
     % create bucket
        bucket = storage.create(bucketInfo, bucketTargetOption);
     % create blob
        blob = bucket.create(blobname, content);
     % create blobId
        blobId = gcp.storage.BlobId.of(bucket.bucketName,blob.name)
     % make your blob public
        acl = makeObjectPublic(storage,blobId);



```



------------    

[//]: # (Copyright 2020 The MathWorks, Inc.)
