function result = delete(Bucket,bucketSourceOption)
%DELETE Deletes this bucket.
%
% Note: Bucket needs to be empty for deletion. Delete Blob objects within a
% container before calling delete on a given Bucket object
%
% USAGE
%       
%       storage = gcp.storage.Storage('credentials<REDACTED>_path.json');
%       bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%       bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%       bucket = storage.create(bucketInfo, bucketTargetOption)
%       bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
%
%       bucket.delete(bucketSourceOption)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Bucket.html#delete-com.google.cloud.storage.Bucket.BucketSourceOption...-
%

% Supported Java methods
%
% boolean	delete(Bucket.BucketSourceOption... options)


%% Deleting this bucket
import com.google.cloud.storage.*;

%Returns boolean 1 if deleted and boolean 0 if not
%Bucket needs to be empty for deletion
result = Bucket.Handle.delete(bucketSourceOption.Handle);
if result
    fprintf("Deleted");
else
    fprintf("Not Deleted");
end

end%function


