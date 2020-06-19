classdef Bucket < gcp.storage.Object
%BUCKET A Google cloud storage bucket

% Copyright 2020 The MathWorks, Inc.
%

    properties
        projectId
        bucketName
    end
    
    methods
        % Bucket Constructor
        function obj = Bucket(StorageObj,bucket)
            import com.google.cloud.storage.*;
            import com.google.cloud.storage.BucketInfo;
            
            obj.Handle = bucket;
            obj.bucketName = string(bucket.getName);
            obj.projectId = string(StorageObj.projectId);
        end
        
        function result = delete(Bucket,bucketSourceOption)
                       
            %Returns boolean 1 if deleted and boolean 0 if not
            %Bucket needs to be empty for deletion
            result = Bucket.Handle.delete(bucketSourceOption.Handle);
            if result
                fprintf("Deleted");
            else
                fprintf("Not Deleted");
            end
            
        end%function
                              
    end%methods
    
end %class

