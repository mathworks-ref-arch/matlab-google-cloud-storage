function blobinformation = getblobinfo(blobsJ)
% GETBLOBINFOTABLE Returns blob properties in the form of a struct
%
% Input is a list of Blob objects
% Properties for every blob are queried in the function ans assigned to a
% struct. Every struct representing every blob is assigned to an array
% named blobinformation and returned as function output in the order of the
% blobs contained within the input argument.
%
% Note: Some properties of the blob might be missing based on the user's
% access rights to the blob

% Copyright 2020 The MathWorks, Inc.
%

%% Set default Property-Value Pairs (Comment/Delete this section if not used)
number_of_blobs = length(blobsJ);

for i=1:number_of_blobs
    s = struct;
    blobJ = blobsJ(i);
    s.blobname = string(blobJ.getName());
    s.bucket = string(blobJ.getBucket());
    s.generation = string(blobJ.getGeneration());
    s.generationId = string(blobJ.getGeneratedId());
    s.owner = string(blobJ.getOwner());
    s.blobsize = string(blobJ.getSize());
    s. storageclass = string(blobJ.getStorageClass().name());
    s.createtime = string(datetime(double(blobJ.getCreateTime)/1000,'ConvertFrom', 'posixtime','TimeZone','UTC'));
    s.lastupdated = string(blobJ.getUpdateTime());
    blobinformation(i) = s; %#ok<AGROW>
end
end %function


%  blobinformation = vertcat(blobinformation,...
%         table(string(blobJ.getName()),...
%         string(blobJ.getBucket()),...
%         string(blobJ.getGeneration()),...
%         string(blobJ.getGeneratedId()),...
%         string(blobJ.getOwner()),...
%         string(blobJ.getSize()),...
%         string(blobJ.getStorageClass().name()),...
%         string(datetime(double(blobJ.getCreateTime),'ConvertFrom', 'epochtime','Epoch','1970-01-01','TicksPerSecond',1000)),...%string(blobJ.getCreateTime()),...
%         string(blobJ.getUpdateTime()),...
%         'VariableNames',{'NAME','BUCKET','GENERATION', 'ID','OWNER','SIZE','STORAGE_CLASS','TIME_CREATED','UPDATED'}));
