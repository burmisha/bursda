function plotEpipolars(epipolars)

[~,nn]=size(epipolars);
rikt = psphere([epipolars(2,:);-epipolars(1,:);zeros(1,nn)]);
punkter = to_unhom(cross(rikt,epipolars));
hold on;
for i=1:nn;
plot([punkter(1,i)-2000*rikt(1,i) punkter(1,i)+2000*rikt(1,i)], ...
     [punkter(2,i)-2000*rikt(2,i) punkter(2,i)+2000*rikt(2,i)],'-');
end