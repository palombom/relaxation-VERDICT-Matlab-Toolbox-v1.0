function data  = make_direction_average(data)

bvals = data.bvals;
delta = data.delta;
smalldel = data.smalldel;
TE = data.TE;
TR = data.TR;
data_tmp = data.data;
mask = data.mask;

bunique = unique(bvals);
TEunique = unique(TE);
TRunique = unique(TR);

Sdiravg = [];
b_for_fit = [];
TE_for_fit = [];
TR_for_fit = [];
delta_for_fit = [];
smalldel_for_fit = [];

c = 1;

for i=1:numel(TRunique)
    for j=1:numel(TEunique)
        for k=1:numel(bunique)

            condition = bvals==bunique(k) & TE==TEunique(j) & TR==TRunique(i);

            if sum(condition)>0

                Sdiravg(:,:,:,c) = nanmean(data_tmp(:,:,:,condition), 4);

                b_for_fit = [b_for_fit, bunique(k)];
                TE_for_fit = [TE_for_fit, TEunique(j)];
                TR_for_fit = [TR_for_fit, TRunique(i)];
                delta_for_fit = [delta_for_fit, nanmean(delta(condition))];
                smalldel_for_fit = [smalldel_for_fit, nanmean(smalldel(condition))];

                c = c+1;
            end

        end
    end
end

b_for_fit(b_for_fit<=0) = 1e-6;
TE_for_fit(TE_for_fit<=0) = 1e-6;
TR_for_fit(TR_for_fit<=0) = 1e-6;
delta_for_fit(delta_for_fit<=0) = 1e-6;
smalldel_for_fit(smalldel_for_fit<=0) = 1e-6;

data.Sdiravg = Sdiravg;
data.b_for_fit = b_for_fit;
data.TE_for_fit = TE_for_fit;
data.TR_for_fit = TR_for_fit;
data.delta_for_fit = delta_for_fit;
data.smalldel_for_fit = smalldel_for_fit;

ROI = reshape(Sdiravg, [size(Sdiravg,1).*size(Sdiravg,2).*size(Sdiravg,3), size(Sdiravg,4)]);
m = mask(:);

ROI = ROI(m==1,:);

data.ROI = ROI;

Smax = max(ROI,[],2).*2;
data.ROI_norm = ROI./Smax;
data.Smax = Smax;

end