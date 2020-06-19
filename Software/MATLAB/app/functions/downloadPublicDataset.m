function pathstr = downloadPublicDataset(storage,bucketName, blobName, folderpath)
%DOWNLOADPUBLICDATASET function for downloading a public dataset
%
% The input arguments expected are:
%    * Unauthenticated Storage client to the public bucket
%    * Bucket Name
%    * Blob Name: Name of the remote public file to download e.g. "publicfile.txt";
%    * Destination: Local path where the file should be downloaded
%
% EXAMPLE:
%
%   storage = gcp.storage.AnonymousStorage;
%   downloadpublicdataset(storage,'gcp-public-data','folder1/folder2/my_public_file.png',pwd)

% Copyright 2020 The MathWorks, Inc.
%
% Reference: https://cloud.google.com/storage/docs/access-public-data

% Setting up Logger
logObj = Logger.getLogger();
logObj.MsgPrefix = 'GCP:GCS';

% Check if Storage client is valid
if ~isequal(class(storage),'gcp.storage.AnonymousStorage')
    write(logObj,'error','Storage client should be of class gcp.storage.Storage');
else
% Obtain the Storage object from the Handle
storageJ = storage.Handle;

% Create BlobId for the public object
blobId = gcp.storage.BlobId.of(bucketName,blobName);

% Get Blob
blobJ = storageJ.get(blobId.Handle);

% Download Blob
import java.nio.file.FileSystems

try
    
%     % Constructing FileSystem path
%     % Handling extraction of folderpath, filename and extension
     [~,filename,ext] = fileparts(char(blobName));
     % Name of local file
     localblobName = sprintf('%s%s',filename,ext);
    
    
    % Java File path Object creation
    javapath = FileSystems.getDefault().getPath(folderpath,localblobName);
    % Downloading Blob content to path contained within Java FileSystem path
    blobJ.downloadTo(javapath)
    
    
    % Java string formation
    pathstr = javapath.toString;
    
    % Notifying download completion
    fprintf('dataset downloaded to %s',pathstr);

catch ME
    rethrow(ME)
end

end
end

