%% 解析报文， 读取数据 
data_dir = "../data";
file_name = "2021_04_02_14_00_32.dat1-1-0";
raw_file = fullfile(data_dir, file_name);
echo_tables = readDataFromRawEcho(raw_file);  % 19s?
% 基本参数， 脉冲宽度， PRT， 采样率， 波门前沿时间， 宽度采样点数
tau = echo_tables(1, 'PulseWidth').PulseWidth;tau = tau * 1e-6;
PRT = echo_tables(1, 'PRT').PRT;PRT = PRT * 1e-6;
Fs = echo_tables(1, 'BandWidth').BandWidth;Fs = Fs * 1e6;
wave_gate_front = echo_tables(1, 'WaveGateFront').WaveGateFront;
wave_gate_front = wave_gate_front * 1e-6;
wave_gate_width = echo_tables(1, 'WaveGateWidth').WaveGateWidth;
c = physconst('lightspeed');
% 提取快时间、慢时间矩阵
radar_data_2d = echo_tables.ComplexIQ;
radar_data_2d = cell2mat(struct2cell(radar_data_2d(1:end-1)));
%% 慢时间积累和功率-高度图
figure()
int_n = 1000;
data_seg = radar_data_2d(:, 1:int_n);
data_int = pulse_int(data_seg);
plot(data_int, 1:length(data_int)) % 写画功率谱图的函数
grid on

%% RTI 图
figure()
[rown, coln] = size(radar_data_2d);
int_time_n = floor(coln / int_n);
rti_data = ones(rown, int_time_n);
for i = 1:int_time_n 
    rti_data(:, i) = pulse_int(radar_data_2d(:, 1+int_n*(i-1):int_n*i));
end
imagesc(flipud(rti_data),[0.5e5 3e5])
% imagesc(flipud(rti_data))
colormap jet

%% 某高度点 PSD 图
figure()
taun = tau*Fs;
if mod(taun, 2) == 0
    taun = taun + 1;
end 
k = 200; 
n = 1*floor(taun/2);
samples = radar_data_2d(k - n:k + n, :); % 这里参数调整 增加点数
[r,~] = size(samples);
nfft = 2^nextpow2(r); nfft = nfft + 1024;   % 这里调整分辨率
[pxx,fr] = periodogram(samples,[],nfft,Fs);
pxx1 = fftshift(mean(pxx(:,1:100),2));
f = (-nfft/2:nfft/2-1)/nfft * Fs;
plot(f, pxx1, 'LineWidth', 1)
grid on ;hold on 
wind = hamming(r);
[pxx_hamming,fr] = periodogram(samples,wind,nfft,Fs);
pxx1_hamming = fftshift(mean(pxx_hamming(:,1:1000),2));
plot(f, pxx1_hamming, 'LineWidth', 1)
%% 通过某高度点 PSD 逆傅里叶变换得到 自相关序列 ACS
k_acs = fftshift(mean(abs(ifft(pxx(:,1:100))),2));
figure()
stem(k_acs)

%% PSD 图
figure()
res = [];
for i = 100:40:600
    k = i;
    n = floor(taun/2);
    samples = radar_data_2d(k - n:k + n, :);
    [r,~] = size(samples);
    nfft = 2^nextpow2(r);
    nfft = nfft;
    [pxx,fr] = periodogram(samples,[],nfft,Fs);
    pxx11 = fftshift(mean(pxx(:,1:100),2));
    res = [res;pxx11'];
end
imagesc(flipud(res))

figure()
res1 = [];
for i = 60:20:600
    k = i;
    n = floor(taun/2);
    samples = radar_data_2d(k - n:k + n, :);
    [r,~] = size(samples);
    nfft = 2^nextpow2(r);
    nfft = nfft;
    [pxx,fr] = periodogram(samples,hann(length(samples(:,1))),nfft,Fs);
    pxx12 = fftshift(mean(pxx(:,1:100),2));
    res1 = [res1;pxx12'];
end
imagesc(flipud(res1))











