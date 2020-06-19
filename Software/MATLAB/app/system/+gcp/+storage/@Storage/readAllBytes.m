function content = readAllBytes(Storage,varargin)
%READALLBYTES Reads all the bytes from a blob
%   
% USAGE:
%
% 1. storage.readAllBytes(bucketName,blobName)
% 2. storage.readAllBytes(blobId)
%
%     where bucketName and blobName are of type string and refer to existing bucket and blob
%     blobId can be created using gcp.storage.BlobId.of()

% Copyright 2020 The MathWorks, Inc.
%
%% Implementation

import java.io.FileOutputStream

% Getting blobsourceoption with condition generationMatch()
blobSourceOption = gcp.storage.Storage.BlobSourceOption.userProject(Storage.projectId);

if size(varargin)==1
    % Input BlobId
    blobId = varargin{1};
    blobIdJ = blobId.Handle;
    % Call readAllBytes() to get content in bytes
    content = Storage.Handle.readAllBytes(blobIdJ,blobSourceOption.Handle);    
    
    %Open a file with filename as the blobName and give write permissions
    fo = FileOutputStream(string(blobIdJ.getName)); %(alternative command)
    %fileID = fopen(string(blobIdJ.getName),'w');
    
    %Write file to local disk
    fo.write(content); %(alternative command)
    %fwrite(fileID,content);
    
    %Close the file
    fo.close(); %(alternative command)
    %fclose(fileID);
    fprintf("Content written to %s",string(blobIdJ.getName));
    
elseif size(varargin,2)==2
    %collecting user inputs bucketName and blobName to download content
    %as bytes
    bucketName = varargin{1};
    blobName = varargin{2};
    
    % Call Java function readAllBytes() to get content in bytes
    content = Storage.Handle.readAllBytes(bucketName,blobName,blobSourceOption.Handle);
    
    %Open a file with filename as the blobName and give write permissions
    fo = FileOutputStream(blobName); %(alternative command)
    %fileID = fopen(blobName,'w');
    
    %Write file to local disk
    if ~isempty(content)
        %fwrite(fileID,content);
        fo.write(content); %(alternative command)
        %fclose(fileID);
        fo.close(); %(alternative command)
        fprintf("Content written to %s",blobName);
    else
        fprintf("No content within %s",blobName);
        fo.close(); %(alternative command)
        %fclose(fileID);
    end
else
    warning('Cannot read blob content, expecting either blobId as input or both bucketName and BlobName');
end

end

