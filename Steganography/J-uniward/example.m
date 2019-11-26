% -------------------------------------------------------------------------
% Copyright (c) 2013 DDE Lab, Binghamton University, NY.
% All Rights Reserved.
% -------------------------------------------------------------------------
% Permission to use, copy, modify, and distribute this software for
% educational, research and non-profit purposes, without fee, and without a
% written agreement is hereby granted, provided that this copyright notice
% appears in all copies. The program is supplied "as is," without any
% accompanying services from DDE Lab. DDE Lab does not warrant the
% operation of the program will be uninterrupted or error-free. The
% end-user understands that the program was developed for research purposes
% and is advised not to rely exclusively on the program for any reason. In
% no event shall Binghamton University or DDE Lab be liable to any party
% for direct, indirect, special, incidental, or consequential damages,
% including lost profits, arising out of the use of this software. DDE Lab
% disclaims any warranties, and has no obligations to provide maintenance,
% support, updates, enhancements or modifications.
% -------------------------------------------------------------------------
% Contact: vojtech_holub@yahoo.com | fridrich@binghamton.edu | February
% 2013
%          http://dde.binghamton.edu/download/stego_algorithms/
% -------------------------------------------------------------------------

clc;clear all; close all; fclose all;

for i=856:1230
  
addpath(fullfile('..','JPEG_Toolbox'));

%% Settings
payload = 0.2;   % measured in bits per non zero AC coefficients
coverPath = strcat('/home/sjy/st/J-UNIWARD_matlab/Canada_cut/',num2str(i),'.jpg');
stegoPath = strcat('/home/sjy/st/J-UNIWARD_matlab/Canada_s/',num2str(i),'.jpg');

tStart = tic;

%% Embedding
S_STRUCT = J_UNIWARD(coverPath, payload);

%% Plots
tEnd = toc(tStart);
jpeg_write(S_STRUCT, stegoPath);

C_STRUCT = jpeg_read(coverPath);
C_SPATIAL = double(imread(coverPath));
S_SPATIAL = double(imread(stegoPath));

nzAC = nnz(C_STRUCT.coef_arrays{1})-nnz(C_STRUCT.coef_arrays{1}(1:8:end,1:8:end));

figure;
imshow(uint8(C_SPATIAL));
title('Cover image');

figure;
imshow(uint8(S_SPATIAL));
title('Stego image');

figure; 
diff = S_STRUCT.coef_arrays{1}~=C_STRUCT.coef_arrays{1};
imshow(diff);
title('Changes in DCT domain (in standard JPEG grid)');

figure;
[row, col] = find(diff);
row = mod(row-1, 8)+1;
col = mod(col-1, 8)+1;
vals = zeros(8, 8);
for i=1:numel(row)
    vals(row(i), col(i)) = vals(row(i), col(i))+1;
end
bar3(vals, 'detached');
xlabel('cols');
ylabel('rows');

figure;
diff = S_SPATIAL-C_SPATIAL;
cmap = colormap('Bone');
imshow(diff, 'Colormap', cmap);
c=colorbar('Location', 'SouthOutside');
caxis([-20, 20]);
title('Changes in spatial domain caused by DCT embedding');

figure;
h = hist(diff(:), -20:1:20);
bar(-20:1:20, h);
set(gca, 'YScale', 'log');
xlabel('pixel difference in spatial domain');
ylabel('occurrences');
title('Number of pixel differencees in spatial domain');

figure;
hRange = -50:50;
changePos = (C_STRUCT.coef_arrays{1}~=S_STRUCT.coef_arrays{1});
coverChDCT = C_STRUCT.coef_arrays{1}(changePos);
histAll = hist(C_STRUCT.coef_arrays{1}(:), hRange);
histChanges = hist(coverChDCT(:), hRange);
[AX, h1, h2] = plotyy(hRange(2:end-1), histChanges(2:end-1), hRange(2:end-1), histChanges(2:end-1) ./ histAll(2:end-1));
set(get(AX(1),'Ylabel'),'String','Number of changed DCT coefficients');
set(get(AX(2),'Ylabel'),'String','Probability of change');
xlabel('DCT value');
hold off;

fprintf('\nElapsed time: %.4f s, change rate per nzAC: %.4f, nzAC: %d', tEnd, sum(S_STRUCT.coef_arrays{1}(:)~=C_STRUCT.coef_arrays{1}(:))/nzAC, nzAC);

end