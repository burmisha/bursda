function [points] = to_unhom(hom_points)

hom_points  = hom_points ./ repmat(hom_points(end, :), [size(hom_points, 1) 1]);
points = hom_points(1:end-1,:);

end