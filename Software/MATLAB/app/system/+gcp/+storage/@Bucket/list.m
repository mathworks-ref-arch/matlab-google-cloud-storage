function [blobList, blobInfo] = list(Bucket,varargin)
%LIST Lists the bucket's blobs.
%
% USAGE
%
%   storage = gcp.storage.Storage('credentials.json')
%   bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
%   bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%   bucket = storage.create(bucketInfo, bucketTargetOption)
%
%   blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId)
%
%   blobList = bucket.list(blobListOption1,...,...,...,blobListOption2, blobListOptionN)
%           or
%   [blobList, blobStructList] = bucket.list(blobListOption1,...,...,...,blobListOption2, blobListOptionN)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Bucket.html#list-com.google.cloud.storage.Storage.BlobListOption...-
%
%
% Supported Java method
%
% Returns the paginated list of Blob in this bucket
% com.google.api.gax.paging.Page<Blob>	list(Storage.BlobListOption... options)
%

%% Implementation
import com.google.cloud.storage.*;

if nargin < 1
     warning('Expected inputs for listing blobs. Refer help bucket.list()');
else
    % get single or multiple bloblistoption
    % create nx1 dimensional blobListOptionArray for bucket.list()
     n = numel(varargin);
     blobListOption = varargin;               
     blobListOptionArrayJ = javaArray('com.google.cloud.storage.Storage$BlobListOption',n);

     for i =1:n
         blobListOptionArrayJ(i) = blobListOption{i}.Handle;
     end
% Querying Blobs within Bucket
blobsJ = Bucket.Handle.list(blobListOptionArrayJ);

% Creating an iterator object for reading Blobs from the list
blobIteratorJ = blobsJ.iterateAll().iterator();

%Empty array and table for returning data
blobList = {};
count = 0;
blobInfo = {};

%Iterate till Blobs exist in the list
while(blobIteratorJ.hasNext())
    count = count +1;
    blobItemJ = blobIteratorJ.next();
    % Calling Blob constructor to return MATLAB datatype gcp.storage.Blob
    % for the user
    blobList{count} = gcp.storage.Blob(blobItemJ,(Bucket.projectId)); %#ok<AGROW>
    % Lisiting Blob information in MATLAB atrcuts with fields for better
    % exploration
    blobstruct = struct;
    blobstruct.blobname = string(blobItemJ.getName);
    blobstruct.bucket = string(blobItemJ.getBucket);
    blobstruct.createtime = string(datetime(double(blobItemJ.getCreateTime)/1000.0,'convertfrom','posixtime','TimeZone','UTC'));
    blobstruct.owner = string(blobItemJ.getOwner);

    % assign struct to an array
    blobInfo{count} = blobstruct; %#ok<AGROW>
    
end
end
end %function

