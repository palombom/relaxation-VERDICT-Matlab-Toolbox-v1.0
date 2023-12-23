function [] = apply_DL_simple(dataset_filename, pythonpath)

% Wrapper for a python script that tranin the MLP

python_filename = 'Apply_DL_for_rVERDICT.py';

disp('     * Fitting using the trained DL model');

tic

fid = fopen(python_filename, 'w');

fprintf(fid, 'import scipy.io\n');
fprintf(fid, 'import scipy\n');
fprintf(fid, 'import numpy as np\n');
fprintf(fid, 'import numpy.matlib\n');
fprintf(fid, 'import pickle\n');
fprintf(fid, 'from sklearn.neural_network import MLPRegressor\n');
fprintf(fid, 'from sklearn.preprocessing import MinMaxScaler\n');

fprintf(fid, 'print(''Loading trained MLP and scaler ...'')\n');
fprintf(fid, 'reg = pickle.load(open(''trainedDLmodel.sav'', ''rb''))\n');
fprintf(fid, 'scaler = pickle.load(open(''scaler.sav'', ''rb''))\n');

fprintf(fid, ['x_test = scipy.io.loadmat(''' dataset_filename ''')\n']);
fprintf(fid, 'TestSig = x_test[''Signal'']\n');
fprintf(fid, 'TestPredict=reg.predict(TestSig)\n');
fprintf(fid, 'TestPredict = scaler.inverse_transform(TestPredict)\n');
fprintf(fid, 'data = {}\n');
fprintf(fid, 'data[''DLprediction''] = TestPredict\n');
fprintf(fid, 'scipy.io.savemat(''rVERDICT_MLP_prediction.mat'',data)\n');
fprintf(fid, 'print(''DONE'')\n');

fclose(fid);

command = [pythonpath ' ' python_filename];
[~,~] = system(command);

tt = toc;

disp(['     * DL model fitted in ' num2str(round(tt)) 'sec.\n']);
end


