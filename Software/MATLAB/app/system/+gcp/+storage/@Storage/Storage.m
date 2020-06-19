classdef Storage  < gcp.storage.Object
    % STORAGE A MATLAB interface for Google Cloud Storage
    %
    %USAGE
    %
    % storage = gcp.storage.Storage("credentials.json");
    %
    % Ref: https://cloud.google.com/storage/docs/reference/libraries
    %
    % Property : projectId
    %
    % Methods : create(), get(), delete(), list(), readAllbytes()
    %

    % Copyright 2020 The MathWorks, Inc.
    %
    % Reference Client Library: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Storage.html


    properties
        projectId;
    end

    methods

        function obj = Storage(varargin)

            import com.google.cloud.storage.*
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'GCP:GCS';


            if ~usejava('jvm')
                write(logObj,'error','MATLAB must be used with the JVM enabled');
            end
            if verLessThan('matlab','9.2') % R2017a
                write(logObj,'error','MATLAB Release 2017a or newer is required');
            end

            if nargin>0
                credentialsFilePath = which(varargin{1});
                if isempty(credentialsFilePath)
                    write(logObj,'error',['Could not find the file ' varargin{1} ' on path']);
                end
            else
                try
                    % Load credentials for client
                    credentialsFilePath = getenv('GOOGLE_APPLICATION_CREDENTIALS');
                catch
                    warning('Expecting json file(credentials.json) containing credentials within %s\config or an input with filename for the credentials',gcsroot);
                    credentialsFilePath = which('credentials.json');
                end
            end

            import com.google.auth.oauth2.GoogleCredentials;
            %credentialsFilePath = which('credentials.json');
            fileStreamJ = javaObject('java.io.FileInputStream',credentialsFilePath);
            credentialsJ = javaMethod('fromStream','com.google.auth.oauth2.GoogleCredentials',fileStreamJ);

            % Intialize Storage Client
            storageOptionsJ = javaMethod('getDefaultInstance','com.google.cloud.storage.StorageOptions');
            storageJ = storageOptionsJ.newBuilder().setCredentials(credentialsJ).build().getService(); %storage object
            obj.Handle = storageJ;

            %Assigning projectId class property
            obj.projectId = char(obj.Handle.getOptions.getDefaultProjectId);
        end

        % set a custom path to a json credentials file and reintialize Storage
        % and its properties
        function obj = setcredentialsFilePath(obj, credFile)
            %Create a logger object
            logObj = Logger.getLogger();

            if ischar(credFile)
                credentialsFilePath = which(credFile);
                fileStreamJ = javaObject('java.io.FileInputStream',credentialsFilePath);
                credentialsJ = javaMethod('fromStream','com.google.auth.oauth2.GoogleCredentials',fileStreamJ);

                % Reintialize Storage Client
                storageOptionsJ = javaMethod('getDefaultInstance','com.google.cloud.storage.StorageOptions');
                storageJ = storageOptionsJ.newBuilder().setCredentials(credentialsJ).build().getService();
                obj.Handle = storageJ;

                %Reassigning projectId class property
                obj.projectId = obj.Handle.getOptions.getDefaultProjectId;
            else
                write(logObj,'error','Expected credentialsFilePath of type character vector');
                warning('Expected credentialsFilePath of type character vector');
            end

        end

    end

end %class
