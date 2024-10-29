function y = dec_directx2_hb_fs4_mix(x,h)
%----------------------------------------------------
% Mixes and  decimates input signal x2 w/ efficient DDC
% x: input signal (real-valued) samples (1xL)
% h: halfband filter coeff vector (1XN)
%
% Author:  J. Shima
%----------------------------------------------------

%dec by 2, HB filter coeffs sent in

N = length(h);
L = length(x);

%mix down by Fs/4
v = [1, -1i, -1, 1i];
mix = repmat(v, [1 round(L/4)+1]);
mix = mix(1:L);

%x = x.* exp(-1i*pi/2*[0:L-1]);
x = x.* mix;

xr = real(x);
xi = imag(x);

yr = zeros(1,floor(L/2));
yi = yr;

% set up 2 history buffers for I/Q
histr = zeros(1,N);  histi = histr;

%put in first sample
histr(end) = xr(1);
histi(end) = xi(1);

%center tap of HB filter
ctap = (N-1)/2+1;
ind = [2, 3];

for m=1:floor(L/2)-1
    
   %I signal used HB coeffs 
   yr(m) = sum(h(1:2:end).*histr(1:2:end)); 
   
   %Q signal is center value scaled.
   yi(m) = 1/2* histi(ctap);    
   
   %update filter histories
   histr = [histr(3:end) xr(ind)];
   histi = [histi(3:end) xi(ind)];
   ind = ind + 2;
end

%this is the analytic complex-valued output signal
y = complex(yr,yi);
    
   
    
