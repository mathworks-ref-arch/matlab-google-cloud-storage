function blob = create(Bucket,varargin)
%CREATE Creates a new Blob within a Storage Bucket
%
%   USAGE
%
%    Create a new blob with file content(.mat or .csv or .txt file)
%
%    Create a new blob with MATLAB workspace variable
%
%    Create a new blob with plain text strings :
%
%      blob = bucket.create(varargin)
%
%       1. Here varargin{1} is "unique_blobName" and varargin{2} is file to be
%          uploaded i.e. filename.mat
%
%          storage = gcp.storage.Storage('credentials<REDACTED>_path.json');
%          bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
%          bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%          bucket = storage.create(bucketInfo, bucketTargetOption)
%          blob = bucket.create("unique_blobName","filename.mat")
%
%      2. Here varargin{1} is "unique_blobName" and varargin{2} is file to be
%         uploaded i.e. filename.mat
%
%         storage = gcp.storage.Storage();
%         bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
%         bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%         bucket = storage.create(bucketInfo, bucketTargetOption)
%         blob = bucket.create("unique_blobName","filename.txt")
%
%      3. Here varargin{1} is "unique_blobName" and varargin{2} is a MATLAB
%         workspace variable, which will be saved as a matfile locally
%         before upload
%
%         storage = gcp.storage.Storage();
%         bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
%         bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%         bucket = storage.create(bucketInfo, bucketTargetOption)
%         blob = bucket.create("unique_blobName",MATLAB_workspace_variable)
%
%      4. Here varargin{1} is "unique_blobName" and varargin{2} is a string
%         to be uploaded
%
%         storage = gcp.storage.Storage('credentials<REDACTED>_path.json');
%         bucketTargetOption = gcp.storage.Storage.BucketTargetOption.userProject(storage.ProjectId);
%         bucketInfo = gcp.storage.BucketInfo.of("uniquebucketname");
%         bucket = storage.create(bucketInfo, bucketTargetOption)
%         blob = bucket.create("unique_blobName","text string to be uploaded")
%

% Copyright 2020 The MathWorks, Inc.
%
% Reference Client Library : https://googleapis.dev/java/google-cloud-clients/0.119.0-alpha/com/google/cloud/storage/package-summary.html
%
%
% Supported Java Methods
%
%  Blob	create(String blob, byte[] content, Bucket.BlobTargetOption... options)
%
%  Blob	create(String blob, byte[] content, String contentType, Bucket.BlobTargetOption... options)
%
%  Blob	create(String blob, InputStream content, Bucket.BlobWriteOption... options)
%
%  Blob	create(String blob, InputStream content, String contentType, Bucket.BlobWriteOption... options)
%

%% Implementation
% import 'java.io.InputStream'
% import 'java.io.ByteArrayInputStream'


%% Checks
blobName = varargin{1};
try
    if ~ischar(blobName) && ~isstring(blobName)
        warning('Expected blobName to be of type char')
        % exit
    end
    
    if size(varargin)==0
        warning('Expecting input arguments such as blobName, (content to be uploaded): filename, variable, strings and blobWriteoption or blobTargetOption');
        % exit
    end
catch ME
    rethrow(ME)
end

%% Creating blobTargetOption and blobWriteOption
% used for small text strings
blobTargetOption = gcp.storage.Bucket.BlobTargetOption.userProject(Bucket.projectId);

% used for larger content
blobWriteOption = gcp.storage.Bucket.BlobWriteOption.userProject(Bucket.projectId);

%% Check Input type to create content
input = varargin{2};

if nargin == 3
    blobName = char(blobName);
    if ischar(input) || isstring(input)
        % condition is true input argument as filename or a textstr
        
        %% Check if input is a file
        if isfile(which(char(input)))
            % To extract extension, filename should be greater than 3
            % characters
            if length(char(input))>3
                % convert to char if input is of string format
                input = char(input);
                % extract file extension 
                splits = strsplit(input,'.'); %e.g. {'filename'} {'mat'}
                extension = splits{end};
                extension = ['.' extension]; % '.mat'
                
                % Creating valid IANA MIME spec
                % Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
                
                if strcmp(extension,'.txt')
                    typestr = 'text/plain';
                elseif strcmp(extension,'.mat')
                    typestr = 'application/x-mat';
                elseif strcmp(extension, '.jpg') || strcmp(extension, '.png') || strcmp(extension, '.bmp') || strcmp(extension, '.gif')
                    typestr = ['image/' extension(2:end)];
                elseif strcmp(extension, '.avi') || strcmp(extension, '.mov') || strcmp(extension, '.mpg') || strcmp(extension, '.mp4') || strcmp(extension, '.mj2') || strcmp(extension, '.wmv')
                    typestr = ['video/' extension(2:end)];
                elseif strcmp(extension, '.csv') || strcmp(extension, '.html')
                    typestr = ['text/' extension(2:end)];
                elseif strcmp(extension, '.wav') || strcmp(extension, '.flac') || strcmp(extension, '.mp3') || strcmp(extension, '.aif') || strcmp(extension, '.aifc') || strcmp(extension, '.au') || strcmp(extension, '.ogg')
                    typestr = ['audio/' extension(2:end)];
                else
                    typestr = ['application/x-' extension(2:end)];
                end
                
                % Creating FileStream content from File 
                content = javaObject('java.io.FileInputStream',which(input));
                
                % Check if blobname already has extension
                splits = strsplit(blobName,'.');
                if numel(splits)>1
                    ext = char(splits{end});
                    if isequal(ext,extension(2:end))
                        % if extension extracted from blobname is same as
                        % fileextension, then remove extension from blob
                        % creation
                        extension = "";
                    end
                end
                    
                % Creating a Blob
                blobJ = Bucket.Handle.create(strcat(blobName,extension),content,typestr,blobWriteOption.Handle);
                              
                %% Removing checks on file format. Allowing upload of all and any file format
                
            end
            
        else
            %% Condition in this else block is true for input type text which is not a filename.
            
            % Upcoming section uploads string to the Blob which could also
            % be a jsonencoded string of a MATLAB workspace variable
            
            % Convert MATLAB text to java string
            javastr = javaObject('java.lang.String',string(input));
            
            % Convert string to Bytearray
            bytearray =javastr.getBytes();
            
            % Larger bytearrays are recommended to use 'BlobWriteOption' Class for upload
            
            % Smaller ByteArray uploads are recommended to use 'BlobTargetOption' Class for upload 
            
            % Reference: https://googleapis.dev/java/google-cloud-clients/latest/com/google/cloud/storage/Bucket.html#create-java.lang.String-byte:A-com.google.cloud.storage.Bucket.BlobTargetOption...-
            
            if length(bytearray)>1000
                % Creating byte stream
                content = ByteArrayInputStream(javastr.getBytes());
                
                % Using BlobWriteOption for bytearray longer than 1000 bytearray elements
                blobJ = Bucket.Handle.create(blobName,content,'text/plain',blobWriteOption.Handle);
            else
                % Using BlobTargetOption for bytearray smaller than 1000 bytearray elements
                blobJ = Bucket.Handle.create(blobName,bytearray,'text/plain',blobTargetOption.Handle);
            end
        end
    else
        
        % Expecting input argument to be a variable in MATLAB workspace of type numeric values, structures, tables etc, 
        % and an additional input varargin{2} to be a local filename to save the variable as a mat file temporarily
        % and also to name the blob.
        
        % This part of the code will save the variable as a .mat file and then upload.
        
        %Checking if the matfile to be created with blobName.mat already exists in the directory
        if isfile(which([blobName '.mat']))
            warning('%s file already exists.\nCannot save data to a local mat file for upload.\nTry using a different name',[blobName '.mat']);
            %exit
        else
            
            % No conflicts with existing mat file
            % Save mat file locally
            save([blobName '.mat'],'input');
            
            % Create Bytestream content from mat file
            content = javaObject('java.io.FileInputStream',which([blobName '.mat']));
            
            % Create blob with name of the matfile created
            blobJ = Bucket.Handle.create([blobName '.mat'],content,'application/matlab-mat',blobWriteOption.Handle);
            
            % Remove temporarily created mat file from local disk
            delete([blobName '.mat']);
        end
    end
end
% Calling Blob constructor gcp.storage.Blob to return MATLAB object Blob
% and mask Java object within the object Handle

    blob = gcp.storage.Blob(blobJ,Bucket.projectId);
end %function