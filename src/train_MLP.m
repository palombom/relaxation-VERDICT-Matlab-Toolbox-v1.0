function [] = train_MLP(data, SNR, pythonpath)

Nset = 1e4;

% Read acquisition details
B = data.b_for_fit./1e3; %in ms/um2
TE = data.TE_for_fit.*1e3; %in ms
TR = data.TR_for_fit.*1e3; %in ms
delta = data.delta_for_fit.*1e3; % in ms
smalldel = data.smalldel_for_fit.*1e3; % in ms

%Define the rVERDICT model and model parameters intervals for building the
%training set

fellipse = @(p,x) exp(-x.*p(2)).*sqrt(pi./(4.*x.*(p(1)-p(2)))).*erf(sqrt(x.*(p(1)-p(2))));
fstick = @(p,x) fellipse([p,0],x);
fsphere = @(p,x) exp(- my_murdaycotts_multipleTimes(delta,smalldel,p,2,x) );
fball = @(p,x) exp(-p.*x);

T = drchrnd([1 1 1], round(Nset));
p1 = T(:,1); % fic
p2 = T(:,2); % fees
p3 = (15-0.01).*rand(Nset,1)+0.01;   % Ric
p4 = (800-150).*rand(Nset,1)+150;    % T2vasc/ees
p5 = (150-1).*rand(Nset,1)+1;        % T2ic
p6 = (1-0.1).*rand(Nset,1)+0.1;      % S0
p7 = (4e3-10).*rand(Nset,1)+10;      % T1
p8 = (3-0.5).*rand(Nset,1)+0.5;      % Dees

p_fit = [p1 p2 p3 p4 p5 p6 p7 p8];

% rVERDICT model 
f = @(p,x) p(6).*(1-exp(-TR./p(7))).*( (1-p(1)-p(2)).*exp(-TE./p(4)).*fstick(8,x) + ...
                                        p(1).*exp(-TE./p(5)).*fsphere(p(3),x) + ...
                                        p(2).*exp(-TE./p(4)).*fball(p(8), x) );

% Build the training set
database = zeros(size(p_fit,1), numel(B));

for i=1:size(p_fit,1)

    database(i,:) = f(p_fit(i,:),B);

end

params = p_fit;

database_train = database;
params_train = params;

% Add experimental SNR for training

% Gaussian noise
%database_train_noisy = database_train + 1./SNR(1).*randn(size(database_train));

% Rician noise
database_train_noisy = sqrt((database_train + 1./SNR.*randn(size(database_train))).^2 + (1./SNR.*randn(size(database_train))).^2);

params_train_noisy = params_train;

% Multiple random Rician noise in the range [25 100]

%SNR = (100 - 25).*rand(size(database_train)) + 25;
%database_train_noisy = sqrt((database_train + 1./SNR.*randn(size(database_train))).^2 + (1./SNR.*randn(size(database_train))).^2);

% Save the training set
trainingset_filename = 'database_train_DL_rVERDICT_noisy.mat';
save(trainingset_filename, 'database_train_noisy', 'params_train_noisy');

train_DL_simple(trainingset_filename, pythonpath);

end