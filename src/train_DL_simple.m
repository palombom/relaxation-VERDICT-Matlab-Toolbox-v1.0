function [] = train_DL_simple(trainingset_filename, pythonpath)

% Wrapper for a python script that tranin the MLP

python_filename = 'Train_DL_for_rVERDICT.py';

disp('     * Training the DL model');

tic

fid = fopen(python_filename, 'w');

fprintf(fid, 'import scipy\n');
fprintf(fid, 'import numpy as np\n');
fprintf(fid, 'import numpy.matlib\n');
fprintf(fid, 'import pickle\n');
fprintf(fid, 'from sklearn.neural_network import MLPRegressor\n');
fprintf(fid, 'from sklearn.preprocessing import MinMaxScaler\n');
fprintf(fid, 'print(''Loading training set...'')\n');
fprintf(fid, ['x_train = scipy.io.loadmat(''' trainingset_filename ''')\n']); 
fprintf(fid, 'TrainSig = x_train[''database_train_noisy'']\n');
fprintf(fid, 'TrainParam = x_train[''params_train_noisy'']\n');

fprintf(fid, 'print(''Setting up the DL model...'')\n');

fprintf(fid, 'reg = MLPRegressor(hidden_layer_sizes=(150, 150, 150),  activation=''relu'', solver=''adam'', alpha=0.001, batch_size=100, learning_rate=''adaptive'', learning_rate_init=0.001, power_t=0.5, max_iter=1000, shuffle=True, random_state=1, tol=0.0001, verbose=False, warm_start=False, momentum=0.9, nesterovs_momentum=True, early_stopping=True, validation_fraction=0.20, beta_1=0.9, beta_2=0.999, epsilon=1e-08)\n');

fprintf(fid, 'scaler = MinMaxScaler(copy=True, feature_range=(0, 1))\n');
fprintf(fid, 'scaler.fit(TrainParam)\n');
fprintf(fid, 'TrainParam=scaler.transform(TrainParam)\n');

fprintf(fid, 'print(''Training the DL model...'')\n');
fprintf(fid, 'reg.fit(TrainSig,TrainParam)\n');

fprintf(fid, 'print(''Saving the trained DL model...'')\n');
fprintf(fid, 'filename = ''trainedDLmodel.sav''\n');
fprintf(fid, 'pickle.dump(reg, open(filename, ''wb''))\n');
fprintf(fid, 'filename = ''scaler.sav''\n');
fprintf(fid, 'pickle.dump(scaler, open(filename, ''wb''))\n');

fprintf(fid, 'print(''DONE'')\n');

fclose(fid);

command = [pythonpath ' ' python_filename];
[~,~] = system(command);

tt = toc;

disp(['     * DL model trained in ' num2str(round(tt)) 'sec.']);
end


