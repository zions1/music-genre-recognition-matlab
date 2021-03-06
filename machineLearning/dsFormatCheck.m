function [status, message]=dsFormatCheck(DS)
%dsFormatCheck: Check the format of the given dataset
%	Usage:
%		status=dsFormatCheck(DS)
%		[status, message]=dsFormatCheck(DS)
%
%	Description:
%		dsFormatCheck(DS) checks the format of the given dataset DS. It returns 1 if there is any errors in the format.
%		[status, message]=dsFormatCheck(DS) also returns the error message if any.
%
%	Example:
%		ds=prData('iris');
%		ds.output(1)=0;
%		[status, message]=dsFormatCheck(ds);
%		if status, fprintf('%s\n', message{1}); end
%
%	See also dsScatterPlot, dsScatterPlot3, dsProjPlot1, dsProjPlot2, dsProjPlot3.

%	Category: Dataset manipulation
%	Roger Jang, 20040910

if nargin<1, selfdemo; return; end

status=0;
message={};

% ====== Check if the input/output is real
if ~isreal(DS.input), status=1; message{end+1}=sprintf('DS.input is not real!\n'); end
if ~isreal(DS.output), status=1; message{end+1}=sprintf('DS.output is not real!\n'); end
% ====== Check if the input/output is nan
if any(any(isnan(DS.input))), status=1; message{end+1}=sprintf('DS.input contains nan!\n'); end
if any(any(isnan(DS.output))), status=1; message{end+1}=sprintf('DS.output contains nan!\n'); end
% ====== Check if the input/output is inf
if any(any(isinf(DS.input))), status=1; message{end+1}=sprintf('DS.input contains inf!\n'); end
if any(any(isinf(DS.output))), status=1; message{end+1}=sprintf('DS.output contains inf!\n'); end

% ====== Check if the output is from 1 to maxOutput
uniqOutput=unique(DS.output);
if ~isequal(1:length(uniqOutput), uniqOutput)
	status=1;
	message{end+1}=sprintf('DS.output has wrong format! (It should have a value from 1 to no. of classes.)\n');
end

% ====== Check if there is a feature of the same value across all training data
range=max(DS.input, [], 2)-min(DS.input, [], 2);
index=find(range==0);
if ~isempty(index)
	status=1;
	message{end+1}=sprintf('The following rows of DS.input has the same elements: %s', mat2str(index));
end

% ====== Check if the range varies too much
if max(range)/min(range)>10000
	status=1;
	message{end+1}=sprintf('max(range)/min(range)=%g>10000 ===> Perhaps you should normalize the data first.\n', max(range)/min(range));
end

% ====== Check if there are any duplicate input entries
% Is there a fast way to do this???

% ====== Self demo
function selfdemo
mObj=mFileParse(which(mfilename));
strEval(mObj.example);
