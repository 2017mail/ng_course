function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
param_vec = [0.01 0.03 0.1 0.3 1 3 10 30]';
m = length(param_vec);
errors = zeros(m,m);
for i = 1:m
	for j = 1:m
		model = svmTrain(X, y, param_vec(i), @(x1, x2) gaussianKernel(x1, x2, param_vec(j)));
		predictions = svmPredict(model,Xval);
		errors(i,j) = mean(double(predictions ~= yval));
	endfor
endfor


A = errors;
[min_C_errors, min_C_index] = min(A,[],1);
[min_sigma_error, min_sigma_index] = min(min_C_errors);
C = param_vec(min_C_index(min_sigma_index));
sigma = param_vec(min_sigma_index);

% =========================================================================

end