%%
% conditions note:
% C1: f1 = 3, f2 = 5, contrast: 40, 40, orientation: 0,0
% C2: contrast: contrast: 40, 40, orientation: 0,7
% C3: contrast: 40, 40, orientation: 0,15
% C4: contrast: 40, 40, orientation: 0,30
% C5: contrast: 40, 40, orientation: 0, 45
% C6: contrast: 40, 40, orientation: 0, 70
% C7: contrast: 40, 40, orientation: 0, 90
% C8: contrast: 40, 0, orientation: 0, 0
% C9: contrast: 0, 40, orientation: 0, 180


% has to be in the working directory of the file 
clear; clc;
a = dir;
cd('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Matlab Data files/Exp_MATL_HCN_128_Avg');
addpath(genpath('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Matlab Data files/Exp_MATL_HCN_128_Avg'));

file_names = {};
all_data = [];
temp = [];
j = 1;

% this loop collects the Wave data from all the files and stores it in
% all_data structure (different trials are stored in the third dimension
% while the first dimension contains each opoch and second dim is each channel)

for i = 4:12
    file_names{j} = a(i).name;
    if i == 4
        temp  = load(char(file_names(j)));
        all_data = temp.Wave;
        all_data_amp = temp.Amp;
    else
        temp  = load(char(file_names(j)));
        all_data = cat(3,all_data, temp.Wave);
        all_data_amp = cat(3,all_data_amp, temp.Amp);
    end
    j= j+1;
end

%
% Separating channel 75 data and looking at that data alone 
channel_25_data = all_data(:, 75, :);

channel_25_data = reshape(channel_25_data,[420,9]);

degrees = [0, 7, 15, 30, 45, 70, 90];


% plot(degrees,mean(channel_25_data(:,1:7),1))
% xlabel('degrees')
% ylabel('Response Amplitude (microVolts)')




% Separating more channels and analyzing them
% these channels are channel 71, 72, 74, 75, 76, 81, 82
% 
% desired_channels = [71, 72, 74, 75, 76, 81, 82];
% 
% for i = 1:length(desired_channels)
%     subplot(3,3,i)
%     temp_data = all_data(:, desired_channels(i), :);
%     temp_data = reshape(temp_data,[420,9]);
%     plot(degrees,mean(temp_data(:,1:7),1))
%     hold on;
%     xlabel('degrees')
%     ylabel('Response Amplitude (microVolts)')
%     title(strcat('Channel ', num2str(desired_channels(i))))
%     
% end
% 
% % legend('71', '72', '74', '75', '76', '81', '82') 


%

desired_channels = [71, 72, 74, 75, 76, 81, 82];

degrees = [0, 7, 15, 30, 45, 70, 90];

for i = 1:length(desired_channels)
    subplot(3,3,i)
%     for j = [7, 11, 14, 21, 22, 33]
        temp_data = all_data_amp(:, desired_channels(i), :);
        temp_data = reshape(temp_data,[105,9]);
        
        plot(squeeze(all_data_amp([7, 11, 14, 21, 22, 33],i,1:7))')
        legend('1f1', '1f2', '2f1', '3f1', '2f2', '3f2')
%         if mod(j,11) == 0
%             plot(degrees,temp_data(j ,1:7), '--r')
%             hold on;
%         else
%             plot(degrees,temp_data(j ,1:7), '-g')
%             hold on; 
%          
%         end
        
%     end
    xlabel('degrees')
    ylabel('Response Amplitude (microVolts)')
    title(strcat('Channel ', num2str(desired_channels(i))))
    
end


%%
a = squeeze(all_data_amp([7, 11, 14, 21, 22, 33],75,:))';
a = a(1:7,:);
plot(degrees,a)
xlabel('degrees')
ylabel('Response Amplitude (microVolts)')
title(strcat('Channel ', num2str(75)))
legend('1f1', '1f2', '2f1', '3f1', '2f2', '3f2')
xticks([0 7 15 30 45 70 90])

%%
% make sure the units are right. frequency plot for each grating 

% plot the data for each grating to see if you see the frequency 
% - plot each epoch and for trial and compare them 

% graph amplitude spectrum for each trial. make a magnitude and phase plot 
% just for the two gratings alone. 


% magnitude and phase graphs. phase should be similar between 3 and 5 hz 
c = all_data_amp(:, :, 9);

plot(squeeze(c(:,75)));

%%

cd('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Exp_MATL_HCN_128_Avg(Full data)')

m = Wave; 
c = corrcoef(m(:,:)); 
imagesc(c)
cb = colorbar; 
ylabel(cb,'correlation coefficient') 
% graph time series, frequency graphs, and phase magnitude 

% add the times series data together and deduct them and see if it looks
% like the combined experiment. if it is linear, yo will see similar graphs
% this should work better when the orientations are far apart. as they get
% closer you see more nonlinearly 