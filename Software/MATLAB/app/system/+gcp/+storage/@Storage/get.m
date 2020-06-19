function result = get(Storage,varargin)
% GET Returns requested bucket, blob or blobs
%   Returns null if not available
% 
% Usage
%
% 1. Get bucket Information
%
% Create bucket:
%
% storage = gcp.storage.Storage("gcp.json");
% bucketInfo = gcp.storage.BucketInfo.of("matlabpkarname3");
% bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
% bucketJ = storage.create(bucketInfo, bucketTargetOption);
%
% Get specified Bucket:
%
% bucketfields = gcp.storage.Storage.BucketField;
% bucketGetOption = gcp.storage.Storage.BucketGetOption.fields(bucketfields);
% bucket = storage.get(bucket.bucketName, bucketGetOption);
%
% 2. Get blob and blob Information
%
% Create bucket:
%
% storage = gcp.storage.Storage("credentials.json");
% bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
% bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.projectId);
% bucket = storage.create(bucketInfo, bucketTargetOption);
%
% Create blob: 
%
% blobInfo = gcp.storage.BlobInfo.newBuilder(bucket.bucketName,"uniqueblobname");
% blobTargetOption = gcp.storage.Storage.BlobTargetOption.userProject(storage.projectId);
% blob = storage.create(blobInfo, blobTargetOption)
%
% Get specified blob contained within a bucket:
%
% blobfields = gcp.storage.Storage.BlobField;
% blobGetOption = gcp.storage.Storage.BlobGetOption.fields(blobfields);
% blob = storage.get(bucket.bucketName,blob.name,blobGetOption)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Storage.html#get-java.lang.String-com.google.cloud.storage.Storage.BucketGetOption...-
%
%
% Supported Java Methods
%
% 1.
%  Blob	get(BlobId blob)
%
% 2.
% List<Blob>	get(BlobId... blobIds)
%
% 3.
% Blob	get(BlobId blob, Storage.BlobGetOption... options)
%
% 4.
% Bucket	get(String bucket, Storage.BucketGetOption... options)
%
% 5.
% Blob	get(String bucket, String blob, Storage.BlobGetOption... options)
%

%% Implementataion

if nargin==2
    %inputs can be single blobId or a list of blobIds Case 1 & 2
    if isa(varargin{1},'gcp.storage.BlobId')
        if size(varargin{1})<2
            blobId = varargin{1};
            blobJ = Storage.Handle.get(blobId.Handle);
            result = gcp.storage.Blob(blobJ,Storage.projectId);
        else
            inputids = varargin{1};%User input includes list of blobIds)
            % Converting MATLAB array to a Java array of type 'com.google.cloud.storage.BlobId'
            blobIds = javaArray('com.google.cloud.storage.BlobId',size(inputids,2));
            % Loop for querying blob information for every Blob with a
            % given BlobId in the javaArray
            for i=1:size(inputids,2)
                blobIds(i)=inputids(i).Handle;
                %Calling gcp.storage.Blob  constructor to returm a MATLAB
                %object witin the list
                blobsJ(i) = Storage.Handle.get(blobIds(i)); %#ok<AGROW>
                result(i) = gcp.storage.Blob(blobsJ(i),Storage.projectId);%#ok<AGROW> %list of blobs
            end
            
            
        end
    else
        warning("Unsupported case if input is Iterable<BlobId>");
    end %if blobId for single input
elseif nargin==3 
    %inputs from Case 3 & 4
    if ischar(varargin{1}) || isstring(varargin{1}) %3
        %User Inputs
        bucketName = varargin{1};
        bucketGetOption = varargin{2}.Handle;
        % Querying for bucket and bucket information
        bucketJ = Storage.Handle.get(bucketName,bucketGetOption);
        % Callin gcp.storage.Bucket constructor to return a MATLAB object
        result = gcp.storage.Bucket(Storage,bucketJ); %bucket
        % Creating a table to show bucket related information
   %     bucketinformation = getbucketinfotable(bucketJ);
   %     disp(bucketinformation)
    elseif isa(varargin{1},'gcp.storage.BlobId') %4
        %User Inputs
        blobId = varargin{1}.Handle;
        blobGetOptions = varargin{2}.Handle;
        % Querying for blob and blob information
        blobJ = Storage.Handle.get(blobId,blobGetOptions);
        % Calling gcp.storage.Blob constructor to return a MATLAB object
        result = gcp.storage.Blob(blobJ,Storage.projectId); %blob
        % Creating a table to show blob related information
   %     blobinformation = getblobinfotable(blobJ);
   %     disp(blobinformation)
    else
        warning('Expecting first input argument to be either a bucketName or a BlobId')
    end 
elseif nargin==4 %5
    %User Inputs
    bucketName = varargin{1};
    blobName= varargin{2};
    blobGetOption = varargin{3}.Handle;
    % Querying for blob and blob information
    blobJ = Storage.Handle.get(bucketName,blobName,blobGetOption);
    % Calling gcp.storage.Blob constructor to return a MATLAB object
    result = gcp.storage.Blob(blobJ,Storage.projectId);
    % Creating a table to show blob related information
   % blobinformation = getblobinfotable(blobJ);
   % disp(blobinformation)
else
    warning('Expecting number of input arguments to be either 1, 2 or 3')
end%if nargin
%% Unsupported
% List<Blob>	get(Iterable<BlobId> blobIds)
% Gets the requested blobs.
end %function
