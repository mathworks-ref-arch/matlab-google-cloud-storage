function bucketinformation = getbucketinfo(bucketJ) 
% GETBUCKETINFOTABLE Returns bucket properties in the form of a struct
%
% Input is a Bucket object
%
% Properties of the bucket are queried in the function ans assigned to a
% struct. The struct is named bucketinformation and returned as function output 
%
% Note: Some properties of the bucket might be missing based on the user's
% access rights to the bucket in a given project

% Copyright 2020 The MathWorks, Inc.
%
%% Set default Property-Value Pairs 

s = struct;

s.bucketName = string(bucketJ.getName());
s.location = string(bucketJ.getLocation());
s.locationType = string(bucketJ.getLocationType());
s.metageneration = string(bucketJ.getMetageneration());
s.owner = string(bucketJ.getOwner());
s.storageclass = string(bucketJ.getStorageClass().name());
s.createtime = string(datetime(double(bucketJ.getCreateTime)/1000,'ConvertFrom','posixtime','TimeZone','UTC'));

bucketinformation = s; %return information
end %function


% bucketinformation = table(string(bucketJ.getName()),...
%             string(bucketJ.getLocation()),...
%             string(bucketJ.getLocationType()),...
%             string(bucketJ.getMetageneration()),...
%             string(bucketJ.getOwner()),...
%             string(bucketJ.getStorageClass().name()),...
%             string(datetime(double(bucketJ.getCreateTime),'ConvertFrom', 'epochtime','Epoch','1970-01-01','TicksPerSecond',1000)),...%string(bucketJ.getCreateTime()),...
%             'VariableNames',{'NAME', 'LOCATION', 'LOCATION_TYPE', 'METAGENERATION','OWNER','STORAGE_CLASS', 'TIME_CREATED'});
%         
