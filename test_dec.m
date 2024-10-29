% input real signal
fs = 50;
f = 16.5;
N = 50000;
x = sin(2*pi*f/fs*[0:50000]);

h = halfbandfilt(19,2);

% do efficient ddc
y = dec_directx2_hb_fs4_mix(x,h);

% test against brute force ddc 
% shift down by fs/4
x2 = x.*exp(-1i*pi/2*[0:length(x)-1]);

% zero out samples since above mix results in some small values
x2r = real(x2);
x2i = imag(x2);
x2r(2:2:end)  =0;
x2i(1:2:end) = 0;
x2 = complex(x2r,x2i);

% decimate - filter first
y2 = filter(h,1,x2);

%throw away samps
y2 = y2(1:2:end);

figure
plot(real(y(1:1000)))
hold
plot(real(y2(1:1000)))
grid

figure
plot(real(y2(100:25000-100))-real(y(100:25000-100)))
hold on
plot(imag(y2(100:25000-100))-imag(y(100:25000-100)))
grid
