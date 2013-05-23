clear all

us2homo = @(x) [x; ones(1, size(x,2))];
homo2us = @(x) x(1:(end-1),:)./(ones(size(x,1)-1,1)*x(end,:));
%% Projective transornations: load data
load lines.mat

close all
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    line([x1; x2], [y1; y2],'Color',[0.2 0.2 0.2])
end

H1 = [sqrt(3), -1, 1; 1 sqrt(3) 1; 0 0 2];
H2 = [1 -1 1; 1 1 0; 0 0 1];
H3 = [1 1 0; 0 2 0; 0 0 1];
H4 = [sqrt(3), -1, 1; 1 sqrt(3) 1; 0.25 0.5 2];

%% use matrix H1
H=H1;
close all
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);   p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);           d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[0 0.71 0.71], 'LineSmoothing','on');
    line([x1; x2], [y1; y2],            'Color',[0.2 0.2 0.2])
end

%% use matrix H2
H=H2;
close all
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);   p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);           d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[0 0.71 0.71], 'LineSmoothing','on');
    line([x1; x2], [y1; y2],            'Color',[0.2 0.2 0.2])
end

%% use matrix H3
H=H3;
close all
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);   p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);           d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[0 0.71 0.71], 'LineSmoothing','on');
    line([x1; x2], [y1; y2],            'Color',[0.2 0.2 0.2])
end

%% use matrix H4
H=H4;
close all
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);   p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);           d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[0 0.71 0.71], 'LineSmoothing','on');
    line([x1; x2], [y1; y2],            'Color',[0.2 0.2 0.2])
end
axis equal

%% 3D to 2D. Plot
load 3Dto2D.mat

P = homo2us(U);
idx = 1:1:size(P,2);
plot3(P(1,idx),P(2,idx),P(3,idx),'.', 'markersize',1)

c1 = homo2us(null(P1));
c2 = homo2us(null(P2));
n1 = P1(3,1:3);
n2 = P2(3,1:3);
%% Plot camera positions
hold on
quiver3(c1(1),c1(2),c1(3),n1(1),n1(2),n1(3),2, 'linewidth',2);
quiver3(c2(1),c2(2),c2(3),n2(1),n2(2),n2(3),2, 'linewidth',2);
hold off

%% Image from camera 1
H1 = homo2us(P1*U);
plot(H1(1,:), H1(2,:), 'r.', 'markersize',1)

%% Image from camera 2
H2 = homo2us(P2*U);
plot(H2(1,:), H2(2,:), 'r.', 'markersize',1)

%% Calibration of cameras. Load data
load calibration.mat

x1 = cell2mat(x(1));
P1 = CalibrationDLT(x1, us2homo(model))
x2 = cell2mat(x(2));
P2 = CalibrationDLT(x2, us2homo(model))

%% Count all the matrices
[K1,RT] = rq(P1(1:3,1:3));
R1 = RT';
T1 = -(K1*RT)\P1(1:3,4);
K1
[R1, T1]

[K2,RT] = rq(P2(1:3,1:3));
R2 = RT';
T2 = -(K2*RT)\P2(1:3,4);
K2
[R2, T2]

%% Count errors
Err_1 = sqrt(sum(sum((homo2us(x1) - homo2us(P1*us2homo(model))).^2))/size(model,2))
Err_2 = sqrt(sum(sum((homo2us(x2) - homo2us(P2*us2homo(model))).^2))/size(model,2))
close all