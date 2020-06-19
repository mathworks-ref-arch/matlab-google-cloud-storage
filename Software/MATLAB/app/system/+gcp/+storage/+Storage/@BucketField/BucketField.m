classdef BucketField  < gcp.storage.Object
% BUCKETFIELD Returns Field Enums for Bucket Information
% 
% Used as input argument for fields method of class Storage.BucketGetOption
%
% USAGE
%
% bucketField = gcp.storage.Storage.BucketField
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.BucketField.html
%

%% Implementation

properties
    LOCATION
    LOCATION_TYPE
    METAGENERATION
    NAME
    OWNER
    STORAGE_CLASS
    TIME_CREATED 
    VERSIONING
end

methods
	%% Constructor 
	function obj = BucketField(varargin)
        flag = false;
        if ~isempty(varargin)
            if ischar(varargin{1})
                if isequal(varargin{1},'public')
                    bucket_field_str = {'LOCATION', 'LOCATION_TYPE','STORAGE_CLASS', 'TIME_CREATED'};
                    flag = true;
                end
            end
        else
            bucket_field_str = {'LOCATION', 'LOCATION_TYPE', 'METAGENERATION', 'NAME', 'OWNER','STORAGE_CLASS', 'TIME_CREATED', 'VERSIONING'};
        end

        for i =1:length(bucket_field_str)
            bucket_field_values(i) = javaMethod('valueOf','com.google.cloud.storage.Storage$BucketField',string(bucket_field_str{i})); %#ok<AGROW>
        end
        
        obj.Handle = bucket_field_values;
        if ~flag
            obj.LOCATION = bucket_field_values(1);
            obj.LOCATION_TYPE = bucket_field_values(2);
            obj.METAGENERATION = bucket_field_values(3);
            obj.NAME = bucket_field_values(4);
            obj.OWNER = bucket_field_values(5);
            obj.STORAGE_CLASS = bucket_field_values(6);
            obj.TIME_CREATED = bucket_field_values(7);
            obj.VERSIONING = bucket_field_values(8);
        else
            obj.LOCATION = bucket_field_values(1);
            obj.LOCATION_TYPE = bucket_field_values(2);
            obj.STORAGE_CLASS = bucket_field_values(3);
            obj.TIME_CREATED = bucket_field_values(4);
            
        end
    end%function
    
end%methods

end %class