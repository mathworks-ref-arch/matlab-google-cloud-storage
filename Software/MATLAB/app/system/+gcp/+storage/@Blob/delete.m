function result = delete(Blob,blobSourceOption)
%DELETE Deletes this blob
%
% USAGE:
%
%  blobSourceOption = gcp.storage.Blob.BlobSourceOption.generationMatch;
%  blob.delete(blobSourceOption)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Blob.html#delete-com.google.cloud.storage.Blob.BlobSourceOption...-
%


import com.google.cloud.storage.*;

result = Blob.Handle.delete(blobSourceOption.Handle);
% if result
%     fprintf("Deleted");
% else
%     fprintf("Not Deleted");
% end
end

