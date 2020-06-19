function blob = get(Bucket,blobName,blobGetOption)
%GETLOB Returns the requested blob or null if not found
%
% USAGE
%
%    blobName = "existingblobname";
%    bucket_field_values = gcp.storage.Storage.BucketField;
%    blobGetOption = gcp.storage.BlobGetOption.fields(bucket_field_values)
%    blob = bucket.get(blobName,blobGetOption);
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Bucket.html#get-java.lang.String-com.google.cloud.storage.Storage.BlobGetOption...-


%Supported Java methods
%
% Blob	get(String blob, Storage.BlobGetOption... options)
%
%% Implementation

%Querying Blob and it's field information
blobJ = Bucket.Handle.get(blobName,blobGetOption.Handle);

%Calling Blob constructor to convert Java datatype to gcp.storage.Blob
%MATLAB object
blob = gcp.storage.Blob(blobJ,Bucket.projectId);
end
%%---------------------UnSupported methods-----------------%%
% List<Blob>	get(Iterable<String> blobNames)
% Returns a list of requested blobs in this bucket.

% List<Blob>	get(String blobName1, String blobName2, String... blobNames)
% Returns a list of requested blobs in this bucket.