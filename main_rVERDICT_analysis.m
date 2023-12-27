function data = main_rVERDICT_analysis(DataFolder, pythonpath)

disp(['//////   rVERDICT analysis of data: ' DataFolder '   \\\\\\'])

addpath(genpath('src'));
rng(123) % For reproducibility

%% Load the data
disp('   - Loading Data')
DataFilename = 'data';
data = load_data(DataFolder, DataFilename);
disp('   [DONE]')
%% Prepare data for DL fitting
disp('   - Preparing the Data for DL Fitting')
data = make_direction_average(data);
disp('   [DONE]')
%% Train DL model
disp('   - Training MLP')
SNR = 35;
train_MLP(data, SNR, pythonpath);
disp('   [DONE]')
%% Fit DL model
disp('   - Fitting MLP')
data = fit_MLP(data, pythonpath);
disp('   [DONE]')
%% Save maps
disp('   - Saving rVERDICT maps as nifti')
OutputFolder = fullfile(DataFolder, 'rVERDICT_output');
save_rVERDICT_maps(data, OutputFolder)
disp('   [DONE]')
disp('//////   FINISHED   \\\\\\')

end
