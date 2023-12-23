function [] = save_rVERDICT_maps(data, OutputFolder)

tmp = data.nifti_header;

mask = data.mask;
m=mask(:);

prediction = abs(data.DLprediction);

fic = prediction(:,1);
fic(fic<0) = 0;

fees = prediction(:,2);
fees(fees<0) = 0;

fvasc = 1 - fic - fees;
fvasc(fvasc<0) = 0;

f_ic = fic ./ (fic + fees + fvasc);
f_ees = fees ./ (fic + fees + fvasc);
f_vasc = fvasc ./ (fic + fees + fvasc);

sx = data.dims(1);
sy = data.dims(2);
sz = data.dims(3);
vols = size(prediction, 2);

map_name = {'f_vasc', 'f_ic', 'f_ees', 'R', 'D_ees', 'T1', 'T2_ic', 'T2_vasc_ees', 'S0'};

for i=1:numel(map_name)
    
    map = zeros(sx*sy*sz, 1);
    
    if i==1
        
        map(m==1) = f_vasc;
        
    elseif i == 2
        
        map(m==1) = f_ic;
        
    elseif i==3
        
        map(m==1) = f_ees;
        
    elseif i==4
        
        map(m==1) = prediction(:,3);
        
    elseif i==5
        
        map(m==1) = prediction(:,8);
        
    elseif i==6
        map(m==1) = prediction(:,7);
        
    elseif i==7
        map(m==1) = prediction(:,5);
        
    elseif i==8
        map(m==1) = prediction(:,4);
        
    elseif i==9
        
        map(m==1) = prediction(:,6).*data.Smax;
        
    end
    
    map = reshape(map, [sx sy sz]);
    tmp.img = map;
    tmp.hdr.dime.dim(1) = 3;
    tmp.hdr.dime.dim(5) = 1;
    tmp.hdr.dime.datatype = 16;
    tmp.hdr.dime.bitpix = 32;
    mkdir(OutputFolder);
    filename = fullfile(OutputFolder, [map_name{i} '.nii.gz']);
    save_untouch_nii(tmp, filename);
    
end

end
    
