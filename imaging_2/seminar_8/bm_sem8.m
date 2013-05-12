clear all

load lines.mat
whos

for i=1:size(startpoints,2)
    x1 = startpoints(1,i);
    x2 = endpoints(1,i);
    y1 = startpoints(2,i);
    y2 = endpoints(2,i);
    line([x1; x2], [y1; y2],'Color',[0.2 0.2 0.2])
end

us2homo = @(x) [x(:); 1]
homo2us = @(x) x(1:2)./x(3);

H1 = [sqrt(3), -1, 1; 1 sqrt(3) 1; 0 0 2];
H2 = [1 -1 1; 1 1 0; 0 0 1];
H3 = [1 1 0; 0 2 0; 0 0 1];
H4 = [sqrt(3), -1, 1; 1 sqrt(3) 1; 0.25 0.5 2];

H=H1;
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);
    x2 = endpoints(1,i);
    y1 = startpoints(2,i);
    y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);
    p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);
    d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[0.2 0.8 0]);
end

H=H2;
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);   p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);           d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[0 0.5 0.5]);
end
H=H3;
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);   p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);           d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[1 0 0]);
end
H=H4;
for i=1:size(startpoints,2)
    x1 = startpoints(1,i);      x2 = endpoints(1,i);
    y1 = startpoints(2,i);      y2 = endpoints(2,i);
    p1 = H*us2homo([x1; y1]);   p2 = H*us2homo([x2; y2]);
    d1 = homo2us(p1);           d2 = homo2us(p2);
    line([d1(1); d2(1)], [d1(2); d2(2)],'Color',[1 0 0]);
end
axis equal
