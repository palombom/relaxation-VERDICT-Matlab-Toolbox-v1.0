function data = load_data(DataFolder, DataFilename)

data = struct;

% Load nifti data
filename = fullfile(DataFolder, [DataFilename '.nii.gz']);
tmp = load_untouch_nii(filename);
data.nifti_header = tmp;
data.data = double(abs(tmp.img));
[sx,sy,sz,vols] = size(data.data);
data.dims = [sx sy sz vols];

% Load nifti mask
filename = fullfile(DataFolder, [DataFilename '_mask.nii.gz']);
tmp = load_untouch_nii(filename);
data.mask = double(abs(tmp.img));

% Load bvals
filename = fullfile(DataFolder, [DataFilename '.bval']);
tmp = importdata(filename);
data.bvals = tmp;
data.unique_bvals = unique(tmp);

% Load delta
filename = fullfile(DataFolder, [DataFilename '.delta']);
tmp = importdata(filename);
data.delta = tmp;

% Load smalldel
filename = fullfile(DataFolder, [DataFilename '.smalldel']);
tmp = importdata(filename);
data.smalldel = tmp;

% Load TE
filename = fullfile(DataFolder, [DataFilename '.te']);
tmp = importdata(filename);
data.TE = tmp;

% Load TR
filename = fullfile(DataFolder, [DataFilename '.tr']);
tmp = importdata(filename);
data.TR = tmp;

end