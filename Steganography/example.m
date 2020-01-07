clc;clear all; close all; fclose all;
addpath('jpeg_toolbox'); % add jpeg toolbox path
cover_img = 'test.jpg'; % cover image path
payload = 0.1; % embedding rate

%% steg by J_uniward
addpath('J-uniward');
j_uniward_img = 'test_Juniward.jpg';
jpeg_write(J_UNIWARD(cover_img, payload), j_uniward_img);

%% steg by nsF5
addpath('nsF5');
nsF5_img = 'test_nsF5.jpg';
random_seed = 99;
nsf5_simulation(cover_img, nsF5_img, payload, random_seed);

%% steg by UERD
addpath('UERD');
uerd_img = 'test_UERD.jpg';
uerd_run(cover_img, uerd_img, payload);

%% steg by HILL_GINA
addpath('HILL_GINA');
hill_gina_img = 'test_HILL_GINA.jpg';
threshold = 30;
stego = HILL_GINA(cover_img, payload, threshold);
imwrite(stego/255, hill_gina_img);