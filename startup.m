disp('YES SIR Inc')
path = fileparts( mfilename('fullpath') );

ds_path = fullfile(path, 'DataStructures');
if exist(ds_path,'dir')
    addpath(ds_path);
end

ts_path = fullfile(path, 'Tabu Search');
if exist(ts_path,'dir')
    addpath(ts_path);
end

aco_path = fullfile(path, 'ACO');
if exist(aco_path,'dir')
    addpath(aco_path);
end

ga_path = fullfile(path, 'Genetic Algorithm');
if exist(ga_path,'dir')
    addpath(ga_path);
end

clear path ds_path ts_path ga_pathaco_path
