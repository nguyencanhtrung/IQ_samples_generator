%clear all
close all

% sampling_rate_tx = 307.2; % tx 307.2 Msample/s
% sampling_rate_rx = 153.6; % rx 153.6 Msample/s
% Trung sample
sampling_rate_Tr = 307.2; % rx 153.6 Msample/s


FFT_size = 5120;

% frequency_spacing_tx = sampling_rate_tx./2048; % = 0.15 Mhz = 150 Khz.
% frequency_spacing_rx = sampling_rate_rx./2048;  % = 75 Khz.

frequency_spacing_Tr= (sampling_rate_Tr*10^6)./FFT_size;  % 60Khz.
subcarrier_number_half = round(((100*10^6)./frequency_spacing_Tr)./2);

data_tx_R_QAM_L = simout(1:subcarrier_number_half)./sqrt(42);
data_tx_I_QAM_L = simout1(1:subcarrier_number_half)./sqrt(42);

data_tx_R_QAM_R = simout(subcarrier_number_half+1:subcarrier_number_half*2+1)./sqrt(42);
data_tx_I_QAM_R = simout1(subcarrier_number_half+1:subcarrier_number_half*2+1)./sqrt(42);
data_L = data_tx_R_QAM_L+i*data_tx_I_QAM_L;
data_R = data_tx_R_QAM_R+i*data_tx_I_QAM_R;

%data = [data_tx_R_QAM_L+i*data_tx_I_QAM_L ;zeros(1,1); data_tx_R_QAM_R+i*data_tx_I_QAM_R];

data_Tr_FFT = [zeros(1,1);data_L;zeros(3452,1);data_R];

data_TX_Tr = ifft(data_Tr_FFT,FFT_size)*32;
real_Tr = real(data_Tr_FFT);
imag_Tr = imag(data_Tr_FFT);
 t = 1:1:5120;
 real_Tr = [t' real_Tr];
 imag_Tr = [t' imag_Tr];
%  real_Tr = real_Tr';
%  imag_Tr = imag_Tr';
% tx = 100 Mhz and rx = 100 Mhz is bandwith.

