function result = exists(Blob,blobSourceOption)
% EXISTS Checks if this blob exists.
%
% USAGE
%
%    blob = bucket.create('uniqueblobname','filename.txt')
%    blobSourceOption = gcp.storage.Blob.BlobSourceOption.userProject(blob.projectId);
%    checkblob = blob.exists(blobSourceOption)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Blob.html#exists-com.google.cloud.storage.Blob.BlobSourceOption...-
%
% Supported JAVA method
%   boolean	exists(Blob.BlobSourceOption... options)
%   Checks if this blob exists.

    result = Blob.Handle.exists(blobSourceOption.Handle);
end

