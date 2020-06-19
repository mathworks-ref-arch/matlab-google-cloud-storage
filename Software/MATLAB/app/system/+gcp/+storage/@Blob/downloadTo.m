function downloadTo(Blob,folderpath)
%DOWNLOADTO Downloads blob to a given path
%
% USAGE
%
%   downloadLocation = /local/file/path
%   blob.downloadTo(downloadLocation);
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library : https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Blob.html#downloadTo-java.nio.file.Path-com.google.cloud.storage.Blob.BlobSourceOption...-

import java.nio.file.FileSystems

try
    
    % Constructing FileSystem path
    % Handling extraction of folderpath, filename and extension
    [~,filename,ext] = fileparts(char(Blob.Handle.getName()));
    % Name of local file
    localblobName = sprintf('%s%s',filename,ext);
    
    
    % Java File path Object creation
    javapath = FileSystems.getDefault().getPath(folderpath,localblobName);
    % Downloading Blob content to path contained within Java FileSystem path
    Blob.Handle.downloadTo(javapath)
    
    
    % Java string formation
    pathstr = javapath.toString;
    
    % Notifying download completion
    fprintf('file downloaded to %s',pathstr);

catch ME
    rethrow(ME)
end

% blobNameSplit = strsplit(blobName,'.');
% if numel(blobNameSplit) == 0
%     warning("Blob name is not valid")
% else
%     if numel(blobNameSplit) == 1
%         % no extension found
%         % local blob file name
%         blobFileSplit = strsplit(blobNameSplit,'/');
%         blobFilename = blobFileSplit{end};
%         % Constructing full blobname
%         localblobName = blobFilename;
%     else
%         extension = blobNameSplit{end};
%         % local blob file name
%         blobFileSplit = strsplit(blobNameSplit{end-1},'/');
%         blobFilename = blobFileSplit{end};
%         % Constructing full blobname
%         localblobName = [blobFilename '.' extension];
%     end
%end    
end



