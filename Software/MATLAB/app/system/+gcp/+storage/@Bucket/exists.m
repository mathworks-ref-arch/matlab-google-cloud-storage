function result = exists(Bucket,bucketSourceOption)
%EXISTS Checks if this bucket exists.
%
% USAGE:
%    bucketSourceOption = gcp.storage.Bucket.BucketSourceOption.metagenerationMatch;
%    bucket.exists(bucketSourceOption);
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Bucket.html#exists-com.google.cloud.storage.Bucket.BucketSourceOption...-
%
% Supported method 
%
% boolean	exists(Bucket.BucketSourceOption... options)
% 

%% Query for Bucket

import com.google.cloud.storage.*;
%Returns boolean 1 if exists and boolean 0 if not
result = Bucket.Handle.exists(bucketSourceOption.Handle);

end%function

