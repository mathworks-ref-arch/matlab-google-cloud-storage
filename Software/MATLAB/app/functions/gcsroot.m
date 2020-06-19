function [out] = gcsroot(varargin)
% GCSROOT returns location of tooling

% Copyright 2020 The MathWorks, Inc.
%

out = fileparts(fileparts(fileparts(mfilename('fullpath'))));

end %function
