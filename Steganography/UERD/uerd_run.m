function uerd_run(iname,oname,ALPHA)
WET_COST = 1e10;
js = jpeg_read(iname);
coefc = js.coef_arrays{1};
quant = js.quant_tables{1};
[rho_p1, rho_m1] = uerd(coefc, quant, WET_COST);
coefs = pm1_simulator(coefc, rho_p1, rho_m1, ALPHA*nnz(coefc));
js.coef_arrays{1} = coefs;
jpeg_write(js, oname);
end
