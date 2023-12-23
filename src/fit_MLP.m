function data = fit_MLP(data, pythonpath)

Signal = data.ROI_norm;
Signal(isnan(Signal)) = 0;
Signal(isinf(Signal)) = 0;

dataset_filename = 'dataset.mat';
save(dataset_filename, 'Signal');

apply_DL_simple(fullfile(pwd, dataset_filename), pythonpath)

tmp = load('rVERDICT_MLP_prediction.mat');
data.DLprediction = tmp.DLprediction;

end