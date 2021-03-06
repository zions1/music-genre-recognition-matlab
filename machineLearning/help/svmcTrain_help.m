%% svmcTrain
% Training SVM (support vector machine) classifier
%% Syntax
% * 		cPrm=svmcTrain(DS)
% * 		cPrm=svmcTrain(DS, opt)
% * 		[cPrm, ~, recogRate, hitIndex]=svmcTrain(DS, ...)
%% Description
%
% <html>
% <p>cPrm=svmcTrain(DS) returns the parameters of SVM (support vector machine) based on the given dataset DS.
% <p>opt=svmcTrain('defaultOpt') returns the default options for SVM. You can modify the options if necessary, and send the options for training a SVM: <p><tt>cPrm=svmcTrain(DS, opt)</tt>
% <p>Note that this function calls the mex files of libsvm which are available at "http://www.csie.ntu.edu.tw/~cjlin/libsvm/".
% </html>
%% Example
%%
%
DS=prData('iris');
trainSet.input=DS.input(:, 1:2:end); trainSet.output=DS.output(:, 1:2:end);
testSet.input=DS.input(:, 2:2:end);  testSet.output=DS.output(:, 2:2:end);
[cPrm, logLike1, recogRate1]=svmcTrain(trainSet);
[computedClass, logLike2, recogRate2, hitIndex]=svmcEval(testSet, cPrm);
fprintf('Inside recog. rate = %g%%\n', recogRate1*100);
fprintf('Outside recog. rate = %g%%\n', recogRate2*100);
%% See Also
% <svmcEval_help.html svmcEval>.
