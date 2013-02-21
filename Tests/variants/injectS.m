function variant=injectS(origin, names , val)
variant=origin;
for i=1:length(names)
    variant.(names{i})=val(i);
end