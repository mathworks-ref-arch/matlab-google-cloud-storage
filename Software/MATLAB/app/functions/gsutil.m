function varargout = gsutil(varargin)
% Usage: gsutil [-D] [-DD] [-h header]... [-m] [-o] [-q] [command [opts...] args...]
%
% Available commands:
%   acl              Get, set, or change bucket and/or object ACLs
%   bucketpolicyonly Configure Bucket Policy Only (Beta)
%   cat              Concatenate object content to stdout
%   compose          Concatenate a sequence of objects into a new composite object.
%   config           Obtain credentials and create configuration file
%   cors             Get or set a CORS JSON document for one or more buckets
%   cp               Copy files and objects
%   defacl           Get, set, or change default ACL on buckets
%   defstorageclass  Get or set the default storage class on buckets
%   du               Display object size usage
%   hash             Calculate file hashes
%   help             Get help about commands and topics
%   hmac             CRUD operations on service account HMAC keys.
%   iam              Get, set, or change bucket and/or object IAM permissions.
%   kms              Configure Cloud KMS encryption
%   label            Get, set, or change the label configuration of a bucket.
%   lifecycle        Get or set lifecycle configuration for a bucket
%   logging          Configure or retrieve logging on buckets
%   ls               List providers, buckets, or objects
%   mb               Make buckets
%   mv               Move/rename objects
%   notification     Configure object change notification
%   perfdiag         Run performance diagnostic
%   rb               Remove buckets
%   requesterpays    Enable or disable requester pays for one or more buckets
%   retention        Provides utilities to interact with Retention Policy feature.
%   rewrite          Rewrite objects
%   rm               Remove objects
%   rsync            Synchronize content of two buckets/directories
%   setmeta          Set metadata on already uploaded objects
%   signurl          Create a signed url
%   stat             Display object status
%   test             Run gsutil unit/integration tests (for developers)
%   ubla             Configure Uniform bucket-level access
%   update           Update to the latest gsutil release
%   version          Print version info about gsutil
%   versioning       Enable or suspend versioning for one or more buckets
%   web              Set a main page and/or error page for one or more buckets
% 
% Additional help topics:
%   acls             Working With Access Control Lists
%   anon             Accessing Public Data Without Credentials
%   apis             Cloud Storage APIs
%   crc32c           CRC32C and Installing crcmod
%   creds            Credential Types Supporting Various Use Cases
%   dev              Contributing Code to gsutil
%   encoding         Filename encoding and interoperability problems
%   encryption       Using Encryption Keys
%   metadata         Working With Object Metadata
%   naming           Object and Bucket Naming
%   options          Top-Level Command-Line Options
%   prod             Scripting Production Transfers
%   projects         Working With Projects
%   retries          Retry Handling Strategy
%   security         Security and Privacy Considerations
%   subdirs          How Subdirectories Work
%   support          Google Cloud Storage Support
%   throttling       Throttling gsutil
%   versions         Object Versioning and Concurrency Control
%   wildcards        Wildcard Names
% 
% Use gsutil help <command or topic> for detailed help.       
%

% Copyright 2020 The MathWorks, Inc.
%

%% 
try
% Pass through and check if user wants a display
    if nargout==0
        echoFlag = '-echo';
    else
        echoFlag ='';
    end
% clusters cli command
cli_cmd = 'gsutil';

% Pass User inputs
[varargout{1},varargout{2}] = system([cli_cmd,' ',strjoin(varargin)],echoFlag);

% Handle output for easy parsing e.g. --output JSON which will be a MATLAB
% structure to parse

% Get all input args
splitargs = strsplit(strjoin(varargin));
% Check for specified output arg --output-format
% if table or text output is requested and and output variable is
% provided then a char object if an output type is not provided JSON
% is the default which is decoded to a struct if an output variable is
% provided
if length(splitargs) > 1
    if strcmpi(splitargs{end-1},'--output')
    % if json argout provided decode it else just leave varargout{2} as is
        if strcmpi(splitargs{end},'JSON')
            % Decode the output
            if nargout==2
                try
                    varargout{2} = jsondecode(varargout{2});
                catch ME
                    fprintf('Check whether output is a supported JSON format \n');
                    fprintf('Try gsutil %s -h to know more about the syntax \n',string(splitargs{1,1}));
                    rethrow(ME);
                end
            end
        end
    else
    % no --output argument provided, thus json by default
    % Decode the output
    
        if nargout==2
            %varargout{2} = jsondecode(varargout{2});
            formatSpec = 'If you want to see the result in a json format, pass --output JSON or for tabular format pass --output TABLE\n';
            fprintf(formatSpec);
        end
    end
end
catch ME
   % setenv('LD_LIBRARY_PATH',ldPath);
    rethrow(ME);
end

end

