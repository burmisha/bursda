% CALIBRATIONDLT - computes camera projection matrix from 3d scene points
% and corresponding 2d image points with DLT(direct linear transformation).
%
% Usage:
%           P = CalibrationDLT(x, X)
%
% Input:
%           x : 3xn homogeneous image points
%           X : 4xn homogeneous scene points
%
% Output:
%           P : 3x4 camera projection matrix
%
% cf.:
%           x = P*X
%
% This code follows the algorithm given by
% [1] E. Trucco and A. Verri, "Introductory Techniques for 3-D
%     Computer Vision," pp. 132-134, 1998.
%
% Kim, Daesik
% Intelligent Systems Research Center
% Sungkyunkwan Univ. (SKKU), South Korea
% E-mail  : daesik80@skku.edu
% Homepage: http://www.daesik80.com
%           http://www.daesik80.com/matlabfns/matlabfns.htm
%
% June 2008  - Original version.

function P = CalibrationDLT(x, X)
    N = length(x); % Number of Points

    %% Compute the Camera Projection Matrix
    A = [X(1,:)'            X(2,:)'             X(3,:)'             ones(N,1) ...
         zeros(N,1)         zeros(N,1)          zeros(N,1)          zeros(N,1) ...
         -x(1,:)'.*X(1,:)'  -x(1,:)'.*X(2,:)'   -x(1,:)'.*X(3,:)'   -x(1,:)';
         zeros(N,1)         zeros(N,1)          zeros(N,1)          zeros(N,1) ...
         X(1,:)'            X(2,:)'             X(3,:)'             ones(N,1) ...
         -x(2,:)'.*X(1,:)'  -x(2,:)'.*X(2,:)'   -x(2,:)'.*X(3,:)'   -x(2,:)'];

    [~,~,V] = svd(A);
    P = reshape(V(:,12),4,3)';