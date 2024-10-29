function h=halfbandfilt(Ntaps, B, Fs)

%----------------------------------------------------
% creates a half-band filter using Kaiser windowing
% N: number of taps
% B: kaiser beta
% Fs: sample frequency (Hz)

% Author:  J. Shima
%----------------------------------------------------

% the filter must abide by Nt=4N-1, or N = (Nt+1)/4
while( rem((Ntaps+1),4) ~=0)
    Ntaps = Ntaps + 1;  
end

if(~exist('B'))
    B = 3;
end
	
if(~exist('Fs'))
    Fs = 1;
end
	
k = [-(Ntaps-1)/2:(Ntaps-1)/2];

% windowed FIR with wc = pi/2
h = sin(pi*k/2)./(pi*k);
h = h.*kaiser(length(h),B)';

%enforce zero coeffs
h(2:2:end) = 0;
h((length(h)+1)/2) = 0.5;  % center tap is 0.5

% Misc Plotting Stuff
NFFT = 1024;
H = fft(h,NFFT);
freq = [0:NFFT-1]*Fs/NFFT - Fs/2;
plot(freq,fftshift(20*log10(abs(H))))
title(['Kaiser windowed half-band freq response, B=',num2str(B)]); xlabel('Freq (Hz)'); ylabel('Mag(dB)');
grid on;
disp(['Made a ',num2str(Ntaps),'-tap windowed half-band FIR'])
