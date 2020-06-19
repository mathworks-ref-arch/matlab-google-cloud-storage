function [result,bStruct] =  list(Storage,varargin)
% LIST Lists the project's bucket and blobs
%
% USAGE
%
% List buckets:
%
%   storage = gcp.storage.Storage();
%   bucketListOption = gcp.storage.Storage.BucketListOption.userProject(storage.projectId);
%   bucketList = storage.list(bucketListOption1,bucketListOption2,...,bucketListOptionN);
%           or
%   [bucketList, bucketStructList] = storage.list(bucketListOption1,bucketListOption2,...,bucketListOptionN);
%
% List blobs:
%
%   storage = gcp.storage.Storage();
%   blobListOption = gcp.storage.Storage.BlobListOption.userProject(storage.projectId);
%   blobList = storage.list(bucket.bucketName,blobListOption1,...,...,...,blobListOption2, blobListOptionN);
%                       or
%   [blobList, blobsStructList] = storage.list(bucket.bucketName,blobListOption1,...,...,...,blobListOption2, blobListOptionN)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Storage.html#list-com.google.cloud.storage.Storage.BucketListOption...-
%
% Supported Method Calls
%
% 1. List Buckets:
%   com.google.api.gax.paging.Page<Bucket>	list(Storage.BucketListOption... options)
%
% 2. List Blobs:
%   com.google.api.gax.paging.Page<Blob>	list(String bucket, Storage.BlobListOption... options)
%

%% Implementation
result = {};

if nargin < 1
    warning('Expected inputs for listing buckets or blobs. Refer help storage.list()');
else
    %case for bucket list
    if isa(varargin{1},'gcp.storage.Storage.BucketListOption')
        bucketListOptions = varargin;
        n = numel(bucketListOptions);
        bucketListOptionArrayJ = javaArray('com.google.cloud.storage.Storage$BucketListOption',n);
        for i =1:n
            bucketListOptionArrayJ(i) = varargin{i}.Handle;
        end
        
        %Query bucket list
        bucketsJ = Storage.Handle.list(bucketListOptionArrayJ);
        
        % Create MATLAB Iterator to read bucket from
        bucketIteratorJ = bucketsJ.iterateAll().iterator();
        
        result = {}; %bucketList
        count = 0;
        bucketInfo = {};
        
        % Iterate and read buckets of the bucket list till list is not
        % empty
        while(bucketIteratorJ.hasNext())
            count = count +1;
            bucketItemJ = bucketIteratorJ.next();
            % Call gcp.storage.Bucket constructor to return MATLAB object
            % within a cell array bucketList
            result{count} = gcp.storage.Bucket(Storage,bucketItemJ); %#ok<AGROW>
            % Convert Bucket information to a MATLAB table for user to read from
            bucketstruct = struct;
            bucketstruct.bucketname = string(bucketItemJ.getName);
            bucketstruct.createtime = string(datetime(double(bucketItemJ.getCreateTime)/1000.0,'convertfrom','posixtime','TimeZone','UTC'));
            bucketstruct.owner = string(bucketItemJ.getOwner);
            % assign struct with bucket info to an array element
            bucketInfo{count} = bucketstruct; %#ok<AGROW>
        end%while
        bStruct = bucketInfo;
        %return array of bucket info structs
    elseif ischar(varargin{1}) || isstring(varargin{1})
        %User Inputs
        n = numel(varargin);
        bucketName = varargin{1};
       % blobListOption = varargin{2:n}; 
       % Intsead of using the cell array 
       % we are looping through the list options in varargin from 2nd input
       % arg onwards - Line 90-92
                
        blobListOptionArrayJ = javaArray('com.google.cloud.storage.Storage$BlobListOption',n-1);
        
        for i =1:n-1
            blobListOptionArrayJ(i) = varargin{i+1}.Handle;
        end
        
        %Query list of Blobs within a Bucket
        blobsJ = Storage.Handle.list(bucketName,blobListOptionArrayJ);
        blobIteratorJ = blobsJ.iterateAll().iterator();
        
        result = {}; %to contain blobList
        count = 0;
        blobInfo = {};
        
        %Iterate and Read blobs till list has items
        while(blobIteratorJ.hasNext())
            count = count +1;
            blobItemJ = blobIteratorJ.next();
            
            % Call gcp.storage.Blob constructor to return MATLAB object
            result{count} = gcp.storage.Blob(blobItemJ,(Storage.projectId)); %#ok<AGROW>
            
            % Create MATLAB struct with information about blobs returned by
            % list()
            blobstruct = struct;
            blobstruct.blobname = string(blobItemJ.getName);
            blobstruct.bucket = string(blobItemJ.getBucket);
            blobstruct.createtime = string(datetime(double(blobItemJ.getCreateTime)/1000.0,'convertfrom','posixtime','TimeZone','UTC'));
            blobstruct.owner = string(blobItemJ.getOwner);
            % assign struct to an array
            blobInfo{count} = blobstruct; %#ok<AGROW>
            
        end%while
        
        % return array of structs
        bStruct = blobInfo;
        % return blob list
    else
        warning('Expected first input argument to be either of type gcp.storage.Storage.BucketListOption or string');
    end%if check for listing bucket or blob

end%if check for atleast one input

end %function
