classdef BlobField  < gcp.storage.Object
% BLOBFIELD Returns Field Enums
%   Constructor used to get Blobfields within BlobGetOptions Class method call
%

% Copyright 2020 The MathWorks, Inc.
%
% Ref: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BlobField.html


properties
    BUCKET
    CONTENT_TYPE
    GENERATION
    ID
    METADATA
    METAGENERATION
    NAME
    OWNER
    RETENTION_EXPIRATION_TIME
    SIZE
    STORAGE_CLASS
    TIME_CREATED
    TIME_DELETED
    UPDATED
end

methods
	%% Constructor 
	function obj = BlobField(~, varargin)
        blob_field_str = {'BUCKET','CONTENT_TYPE', 'GENERATION', 'ID', 'METADATA', 'METAGENERATION','NAME','OWNER','RETENTION_EXPIRATION_TIME','SIZE','STORAGE_CLASS','TIME_CREATED','TIME_DELETED', 'UPDATED'} ;        
        for i =1:length(blob_field_str)
            blob_field_values(i) = javaMethod('valueOf','com.google.cloud.storage.Storage$BlobField',string(blob_field_str{i})); %#ok<AGROW>
        end
        
        obj.Handle = blob_field_values;
        obj.BUCKET = blob_field_values(1);
        obj.CONTENT_TYPE = blob_field_values(2);
        obj.GENERATION = blob_field_values(3);
        obj.ID = blob_field_values(4);
        obj.METADATA = blob_field_values(5);
        obj.METAGENERATION = blob_field_values(6);
        obj.NAME = blob_field_values(7);
        obj.OWNER = blob_field_values(8);
        obj.RETENTION_EXPIRATION_TIME = blob_field_values(9);
        obj.SIZE = blob_field_values(10);
        obj.STORAGE_CLASS = blob_field_values(11);
        obj.TIME_CREATED = blob_field_values(12);
        obj.TIME_DELETED = blob_field_values(13);
        obj.UPDATED = blob_field_values(14);
    end
       
end

end %class
