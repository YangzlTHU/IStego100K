function [rhoP1,rhoM1] = HILLCost(cover_path)

wetCost = 10^10;
if ischar(cover_path)
    cover = double(imread(cover_path));
else
    cover = double(cover_path);
end


[covermat_path,cover_name,ext] = fileparts(cover_path);
covermat_path = [covermat_path,'HILLrho','/',cover_name,'.mat'];
if exist(covermat_path,'file')
    load(covermat_path);
else

H1 = [-1 2 -1;
      2 -4 2;
      -1 2 -1];
%% Get 2D low-pass filters - average filter
L1 = fspecial('average',[3 3]);
L2 = fspecial('average',[15 15]);

%% Get embedding costs
% inicialization
cover = double((cover));
[X,Y,Z] = size(cover);
if(Z==3)
    cover = reshape(cover,X,[]);
end

% p = params.p;
p = -1;
sizeCover = size(cover);

% add padding
padSize = max(size(H1));
coverPadded = padarray(cover, [padSize padSize], 'symmetric');


% compute residual
R = conv2(coverPadded, H1, 'same');
% compute suitability
xi = conv2(abs(R), L1, 'same');
% compute embedding costs \rho
rho = conv2(( (xi.^p) ) .^ (-1/p), L2 , 'same');
% correct the suitability shift if filter size is even
if mod(size(H1, 1), 2) == 0, rho = circshift(rho, [1, 0]); end;
if mod(size(H1, 2), 2) == 0, rho = circshift(rho, [0, 1]); end;
% remove padding
rho = rho(((size(rho, 1)-sizeCover(1))/2)+1:end-((size(rho, 1)-sizeCover(1))/2), ((size(rho, 2)-sizeCover(2))/2)+1:end-((size(rho, 2)-sizeCover(2))/2));


% adjust embedding costs
rho(rho > wetCost) = wetCost; % threshold on the costs
rho(isnan(rho)) = wetCost; % if all xi{} are zero threshold the cost
if(Z==3)
    rho = reshape(rho,X,Y,Z);
    cover = reshape(cover,X,Y,Z);
end

[save_path,~,~] = fileparts(covermat_path);

if ~exist(save_path,'dir'); mkdir(save_path); end

save(covermat_path,'rho');
end

rhoP1 = rho;
rhoM1 = rho;
rhoP1(cover==255) = wetCost; % do not embed +1 if the pixel has max value
rhoM1(cover==0) = wetCost; % do not embed -1 if the pixel has min value

end
