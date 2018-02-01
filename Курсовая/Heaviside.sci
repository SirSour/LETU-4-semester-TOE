function result = Heaviside(n)
    result = 0*n;
    result(find(n >= 0)) = 1;
endfunction
