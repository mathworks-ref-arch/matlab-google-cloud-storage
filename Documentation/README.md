# MATLAB® Interface *for Google Cloud Storage™*

```Cloud Storage``` allows world-wide storage and retrieval of any amount of data at any time. You can use Cloud Storage for a range of scenarios including serving website content, storing data for archival and disaster recovery, or distributing large data objects to users via direct download.
Standard Storage is best for data that is frequently accessed ("hot" data) and/or stored for only brief periods of time.
When used in a region, Standard Storage is appropriate for storing data in the same location as Google Kubernetes Engine clusters or Compute Engine instances that use the data.

```Buckets``` are the basic containers that hold your data. Everything that you store in Cloud Storage must be contained in a bucket. You can use buckets to organize your data and control access to your data, but unlike directories and folders, you cannot nest buckets. Because there are limits to bucket creation and deletion, you should design your storage applications to favor intensive object operations and relatively few buckets operations.

```Blob Objects``` are the individual pieces of data that you store in Cloud Storage. There is no limit on the number of objects that you can create in a bucket.
Blob Objects have two components: object data and object metadata. Object data is typically a file that you want to store in Cloud Storage. Object metadata is a collection of name-value pairs that describe various object qualities.

Workflow Examples for cloud storage client and gsutil can be found at ```Software\MATLAB\script\Examples``` 

## Contents
1. [Installation](Installation.md)
2. [Authentication](Authentication.md)
3. [Getting Started](GettingStarted.md)
4. [BasicUsage](BasicUsage.md)
5. [Logging](Logging.md)        
5. [Environments](SupportedEnvironments.md)          
7. [References](References.md)
8. Appendix   
    * [Building the SDK](Rebuild.md)
    * [Using gsutil tool](gsutil.md)
9. [Full API documentation](gcsApiDoc.md)


-----
  

[//]: #  (Copyright 2020 The MathWorks, Inc.)