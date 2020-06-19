classdef AnonymousStorage  < gcp.storage.Object
% ANONYMOUSSTORAGE A MATLAB interface for Google Cloud Storage
% Instantiate an anonymous Google Cloud Storage client, which can only access public files
%
%USAGE
% astorage = gcp.storage.AnonymousStorage();
%
% Only usage is in function: downloadpublicdataset(storage,bucketName, blobName, destination)
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/StorageOptions.html#getUnauthenticatedInstance--
% Documentation: https://cloud.google.com/storage/docs/access-public-data
    
    properties
        
    end
    
    methods
        function obj = AnonymousStorage(varargin)
            import com.google.cloud.storage.*
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';
            
            
            if ~usejava('jvm')
                write(logObj,'error','MATLAB must be used with the JVM enabled');
            end
            if verLessThan('matlab','9.2') % R2017a
                write(logObj,'error','MATLAB Release 2017a or newer is required');
            end
            
            
            % Intialize Anonymous Storage Client
            storageOptionsJ = javaMethod('getUnauthenticatedInstance','com.google.cloud.storage.StorageOptions');
            storageJ = storageOptionsJ.getService(); %storage object
            obj.Handle = storageJ;
        end
        
    end
end

