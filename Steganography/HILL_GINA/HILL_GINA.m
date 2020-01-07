function stego = HILL_GINA(cover_path,payload,threshold)

cover = double(imread(cover_path));

[rhoP_ini,rhoM_ini] = HILLCost(cover_path);
    
[RGB,pallcom]= GrayHILLPmapcomplex(cover_path,payload,threshold);

stego = cover;

H = [0 1 0;1 0 1;0 1 0];
for k=[2 1 3]
    for ij = [1 1 2 2;1 2 2 1]
        i = ij(1);
        j = ij(2);
        % [rhoP,rhoM] = HILLCost(stego(:,:,k));
        [rhoP,rhoM] = deal(rhoP_ini(:,:,k),rhoM_ini(:,:,k));
        diff = zeros(size(cover(:,:,1)));
        diff1 = stego(:,:,k) - cover(:,:,k);
        diff1 = imfilter(diff1,H);
        if (k==2)
            diff(i:2:end,j:2:end) = diff1(i:2:end,j:2:end);
        else
            diffG = stego(:,:,2) - cover(:,:,2);
            diff3 = diffG.*pallcom(:,:,k);
            diff(i:2:end,j:2:end) = diff1(i:2:end,j:2:end)+diff3(i:2:end,j:2:end);
        end
        rhoP(diff>0) = rhoP(diff>0)./9;
        rhoM(diff<0) = rhoM(diff<0)./9;
        stego(i:2:end,j:2:end,k) = CMDGrayEmbeddingSimulator(cover(i:2:end,j:2:end,k), rhoP(i:2:end,j:2:end), rhoM(i:2:end,j:2:end), 3*RGB(k)*payload*numel(cover(i:2:end,j:2:end,k)), false,i+2*j+k);
    end
end
end




