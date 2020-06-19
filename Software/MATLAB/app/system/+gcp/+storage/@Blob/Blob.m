classdef Blob < gcp.storage.Object
% BLOB A Google cloud storage object
%
%  Blob is a Google cloud storage object.
%  Objects of this class are immutable. 
%  Blob adds a layer of service-related functionality over BlobInfo.
%
%  BLOB Class is used to mask Java object Blob
%  It holds the Java Object in it's Handle
%  

% Copyright 2020 The MathWorks, Inc.
%
%  Reference Client Library: https://googleapis.dev/java/google-cloud-storage/latest/com/google/cloud/storage/Blob.html
%

properties
    name
    projectId
end

methods
	%% Constructor 
	function obj = Blob(blobJ,projectId)
        obj.name = string(blobJ.getName);
        obj.projectId = string(projectId);
        obj.Handle = blobJ;
    end
    
    function result = delete(Blob,blobSourceOption)
                
        result = Blob.Handle.delete(blobSourceOption.Handle);
%         if result
%             fprintf("Deleted");
%         else
%             fprintf("Not Deleted");
%         end
    end
    
end

end %class