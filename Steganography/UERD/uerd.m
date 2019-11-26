function [rho_p1, rho_m1] = uerd(coef, quant, wet_cost)

[row, col] = size(coef);
blk_row = row / 8;
blk_col = col / 8;
bquant_func = @(x) x ./ quant;

blk_energy = zeros(blk_row, blk_col);
dct_energy = blkproc(abs(coef), [8 8], bquant_func);
for brow_idx = 1:blk_row
    for bcol_idx = 1:blk_col
        beg_row = (brow_idx - 1) * 8 + 1;
        end_row = brow_idx * 8;
        beg_col = (bcol_idx - 1) * 8 + 1;
        end_col = bcol_idx * 8;
        blk_energy(brow_idx, bcol_idx) = ...
            sum(sum(dct_energy(beg_row:end_row, beg_col:end_col)));
    end
end
msk_energy = [0.25 0.25 0.25
              0.25 1.00 0.25
              0.25 0.25 0.25];
blk_energy = imfilter(blk_energy, msk_energy, 'same', 'replicate');
denominator = zeros(row, col);
for brow_idx = 1:blk_row
    for bcol_idx = 1:blk_col
        beg_row = (brow_idx - 1) * 8 + 1;
        end_row = brow_idx * 8;
        beg_col = (bcol_idx - 1) * 8 + 1;
        end_col = bcol_idx * 8;
        denominator(beg_row:end_row, beg_col:end_col) = ...
            blk_energy(brow_idx, bcol_idx) * ones(8, 8);
    end
end
denominator(denominator == 0.0) = 10*eps;

numerator_unit = quant;
numerator_unit(1, 1) = (numerator_unit(1, 2) + numerator_unit(2, 1)) / 2;
numerator = repmat(numerator_unit, [blk_row blk_col]);

rho = numerator ./ denominator;
rho(rho >= wet_cost) = wet_cost;
rho_p1 = rho;
rho_m1 = rho;

rho_p1(rho_p1 > wet_cost) = wet_cost;
rho_p1(isnan(rho_p1)) = wet_cost;    
rho_p1(coef > 1023) = wet_cost;
    
rho_m1(rho_m1 > wet_cost) = wet_cost;
rho_m1(isnan(rho_m1)) = wet_cost;
rho_m1(coef < -1023) = wet_cost;



end