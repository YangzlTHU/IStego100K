function [RGB,pallcom]= GrayHILLPmapcomplex(cover_path,payload,T)

cover = double(imread(cover_path));
m = payload*numel(cover);
[X,Y,Z] = size(cover);
cover = reshape(cover,X,[]);
[rhoP1,rhoM1] = HILLCost(cover_path);

[pChangeP1,pChangeM1] = gailv(cover, rhoP1, rhoM1, m);
pall = pChangeP1 + pChangeM1;

pallsumall = sum(pall(:));
pallsort = sort(pall(:),'descend');
pallsum = pallsort(1);

i =1;
while pallsum<T*pallsumall
    i = i+1;
    pallsum = pallsum+pallsort(i);
    if i == numel(pallsort)
        break
    end
end

pallt = pallsort(i);
pallcom = double(pall>pallt);
pallcom = reshape(pallcom,X,Y,Z);
pChangeP1 = reshape(pChangeP1,X,Y,Z);
pChangeM1 = reshape(pChangeM1,X,Y,Z);

RGB(1) = ternary_entropyf(pChangeP1(:,:,1), pChangeM1(:,:,1))./m;
RGB(2) = ternary_entropyf(pChangeP1(:,:,2), pChangeM1(:,:,2))./m;
RGB(3) = ternary_entropyf(pChangeP1(:,:,3), pChangeM1(:,:,3))./m;

function [pChangeP1,pChangeM1] = gailv(x, rhoP1, rhoM1, m)

    n = numel(x);   
    lambda = calc_lambda(rhoP1, rhoM1, m, n);
    pChangeP1 = (exp(-lambda .* rhoP1))./(1 + exp(-lambda .* rhoP1) + exp(-lambda .* rhoM1));
    pChangeM1 = (exp(-lambda .* rhoM1))./(1 + exp(-lambda .* rhoP1) + exp(-lambda .* rhoM1));
    
    
    
   
    function lambda = calc_lambda(rhoP1, rhoM1, message_length, n)

        l3 = 1e+3;
        m3 = double(message_length + 1);
        iterations = 0;
        while m3 > message_length
            l3 = l3 * 2;
            pP1 = (exp(-l3 .* rhoP1))./(1 + exp(-l3 .* rhoP1) + exp(-l3 .* rhoM1));
            pM1 = (exp(-l3 .* rhoM1))./(1 + exp(-l3 .* rhoP1) + exp(-l3 .* rhoM1));
            m3 = ternary_entropyf(pP1, pM1);
            iterations = iterations + 1;
            if (iterations > 10)
                lambda = l3;
                return;
            end
        end        
        
        l1 = 0; 
        m1 = double(n);        
        lambda = 0;
        
        alpha = double(message_length)/n;
   
        while  (double(m1-m3)/n > alpha/1000.0 ) && (iterations<30)
            lambda = l1+(l3-l1)/2; 
            pP1 = (exp(-lambda .* rhoP1))./(1 + exp(-lambda .* rhoP1) + exp(-lambda .* rhoM1));
            pM1 = (exp(-lambda .* rhoM1))./(1 + exp(-lambda .* rhoP1) + exp(-lambda .* rhoM1));
            m2 = ternary_entropyf(pP1, pM1);
    		if m2 < message_length
    			l3 = lambda;
    			m3 = m2;
            else
    			l1 = lambda;
    			m1 = m2;
            end
    		iterations = iterations + 1;
        end
    end
    

end
    function Ht = ternary_entropyf(pP1, pM1)
        p0 = 1-pP1-pM1;
        P = [p0(:); pP1(:); pM1(:)];
        H = -((P).*log2(P));
        H((P<eps) | (P > 1-eps)) = 0;
        Ht = sum(H);
    end
end