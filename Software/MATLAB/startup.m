function startup(varargin)
%% STARTUP - Script to add my paths to MATLAB path
% This script will add the paths below the root directory into the MATLAB
% path. It will omit the SVN and other crud.  You may modify undesired path
% filter to your desire.

% Copyright 2020 The MathWorks, Inc.
%
%% Find if Google Common Package  is set
flag = 1;
f = fileparts(pwd);
parts = strsplit(string(f),filesep);
parts_needed = parts(1:end-2);
top_dir = strjoin(parts_needed,filesep);

gcp_commons_dir = strcat(top_dir, filesep, 'matlab-gcp-common');
if exist(gcp_commons_dir,'dir')
    % Add to path if the file exists
    path_to_gcp_jar = strcat(gcp_commons_dir, filesep, 'Software', filesep, 'MATLAB', filesep, 'lib', filesep, 'jar',filesep,'google-gcp-common-sdk-0.1.0.jar');  
    if exist(path_to_gcp_jar,'file')
        % Check if already on java class path
        % Get current java class path dynamic
        jpath = javaclasspath('-dynamic');
        % Check if jar already exists
        
        if ~any(strcmp(jpath,path_to_gcp_jar))
            javaaddpath(path_to_gcp_jar)
            disp(strcat("Library was not on path. Adding ",path_to_gcp_jar));
        else
            disp(strcat("Found ",path_to_gcp_jar, " on path"));
        end
    else
        disp(strcat(path_to_gcp_jar, " cannot be found"));
        flag = 0;
    end
else
    disp("matlab-gcp-common does not exist at the same directory level as matlab-google-cloud-storage");
    flag = 0;
end


%%
if flag==1

appStr = 'Adding Google-Cloud-Sorage SDK Paths';
disp(appStr);
disp(repmat('-',1,numel(appStr)));

%% Set up the paths to add to the MATLAB path
% This should be the only section of the code that you need to modify
% The second argument specifies whether the given directory should be
% scanned recursively
here = fileparts(mfilename('fullpath'));

rootDirs={fullfile(here,'app'),true;...
    fullfile(here,'lib'),false;...
    fullfile(here,'config'),false;...
    fullfile(here,'script'),false;...
    fullfile(here,'sys','modules'),true;...
    fullfile(here,'public'),true;...
    };

%% Add the framework to the path
iAddFilteredFolders(rootDirs);

%% Handle the modules for the project.
disp('Initializing all modules');
modRoot = fullfile(here,'sys','modules');

% Get a list of all modules
mList = dir(fullfile(modRoot,'*.'));
for mCount = 1:numel(mList)
	% Only add proper folders
	dName = mList(mCount).name;
	if ~strcmpi(dName(1),'.')
		% Valid Module name
		candidateStartup = fullfile(modRoot,dName,'startup.m');
		if exist(candidateStartup,'file')
			% We have a module with a startup
			run(candidateStartup);
		else
			% Create a cell and add it recursively to the path
			iAddFilteredFolders({fullfile(modRoot,dName), true});
		end
	end

end

end
end

%% iAddFilteredFolders Helper function to add all folders to the path
function iAddFilteredFolders(rootDirs)
% Loop through the paths and add the necessary subfolders to the MATLAB path
for pCount = 1:size(rootDirs,1)

	rootDir=rootDirs{pCount,1};
    if rootDirs{pCount,2}
        % recursively add all paths
        rawPath=genpath(rootDir);

		if ~isempty(rawPath)
			rawPathCell=textscan(rawPath,'%s','delimiter',pathsep);
		    rawPathCell=rawPathCell{1};
        else
            rawPathCell = {rootDir};
		end

    else
        % Add only that particular directory
        rawPath = rootDir;
        rawPathCell = {rawPath};
    end

	% remove undesired paths
	svnFilteredPath=strfind(rawPathCell,'.svn');
	gitFilteredPath=strfind(rawPathCell,'.git');
	slprjFilteredPath=strfind(rawPathCell,'slprj');
	sfprjFilteredPath=strfind(rawPathCell,'sfprj');
	rtwFilteredPath=strfind(rawPathCell,'_ert_rtw');

	% loop through path and remove all the .svn entries
	if ~isempty(svnFilteredPath)
		for pCount=1:length(svnFilteredPath) %#ok<FXSET>
			filterCheck=[svnFilteredPath{pCount},...
				gitFilteredPath{pCount},...
				slprjFilteredPath{pCount},...
				sfprjFilteredPath{pCount},...
				rtwFilteredPath{pCount}];
			if isempty(filterCheck)
				iSafeAddToPath(rawPathCell{pCount});
			else
				% ignore
			end
		end
	else
		iSafeAddToPath(rawPathCell{pCount});
	end

end


end

%% Helper function to add to MATLAB path.
function iSafeAddToPath(pathStr)

% Add to path if the file exists
if exist(pathStr,'dir')
	disp(['Adding ',pathStr]);
	addpath(pathStr); 
else
	disp(['Skipping ',pathStr]);
end

end