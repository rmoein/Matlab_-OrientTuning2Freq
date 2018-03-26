function [output_wave, output_freq_ampl] = readPowerDiva(read_raw)


cd('/Users/reza/Documents/Matlab_-OrientTuning2Freq');
addpath(genpath('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Exp_MATL_HCN_128_Avg(Full data)'));

addpath(genpath('C:\Users\rezam\Dropbox\Research_Stuff\Neuro\Justin Gardner'));

addpath(genpath('/Users/reza/mrTools'));

addpath(genpath('/Users/reza/Documents/Matlab_-OrientTuning2Freq'));

cd('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Matlab Files/20180309/Exp_MATL_HCN_128_Avg');





% read_raw:
% you have three conditions:
% 1) is Axx_trials, which returns the list of Axx trial files (these are
% the Axx files that contain trial files)
% 2) is Axx files. These are averaged files of all trials for each
% condition
% 3) Raw files. These files contain the raw EEG files for all trials and
% conditions
file_directory = uigetdir();

files = dir(fullfile(file_directory, '*.mat'));

jj = 1;

%*************************************************************
%*************************************************************

% this section is for reading the raw EEG data

%*************************************************************
%*************************************************************

if read_raw == 3
    files = conditionChecker(files, 3); %filtering the list of files
    
    [num_conditions, num_trials] = experiment_numbers(files); % this function
    % finds the number of conditions and trials in each directory.
    
    % in this section, I'm trying to preallocate the output variable to
    % increase the speed of the program. For this to happen, we need to know
    % the information about experiment. So I'm instructing the program to open
    % the first raw file and store it in "temp" variable so that we extract the
    % number of electrodes,etc.
    
    temp = load('Raw_c001_t001.mat');
    output_wave = zeros([size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , ...
        size(temp.RawTrial,2), num_conditions*num_trials]);% this needs to be blank before each condition loop because it will contain the data for each condition
    
    disp(strcat({'this directory contains '}, {num2str(num_conditions)}, {' conditions and '}...
        ,{num2str(num_trials)}, {' trials.'}))
    
    pause(0.5)
    for c = 1:num_conditions % this loop goes over all the files
        
        
        if c <10
            c2 = strcat('0',num2str(c));
        else
            c2 = num2str(c);
        end
        
        for t = 1: num_trials
            
            if t <10
                t = strcat('0',num2str(t));
            else
                t = num2str(t);
            end
            
            temp = load(strcat('Raw_c0', num2str(c2),'_t0', num2str(t),'.mat'));
            %             raw_data = temp.RawTrial;
            raw_data = reshape(temp.RawTrial,[size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , size(temp.RawTrial,2)]);
            raw_data = temp.Ampl(1) * double(raw_data) + temp.Shift(1); % changing the scale of the data to micro volts
            output_wave(:,:,:,jj) = raw_data;
            
            jj = jj+1;
        end
        disp(strcat('sorting the data for condition ', num2str(c)));
        
        if c == num_conditions
            
            disp('Done :)');
        end
        
        
    end
    output_wave = reshape(output_wave, [size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs ,...
        size(temp.RawTrial,2), num_trials, num_conditions]);
    output_freq_ampl = nan;
end

%*************************************************************
%*************************************************************

% this section is for reading the processed Axx files w.o trial data

%*************************************************************
%*************************************************************

if read_raw == 2
    files = conditionChecker(files, 2); %filtering the list of files
    
    [num_conditions, ~] = experiment_numbers(files); % this function
    % finds the number of conditions and trials in each directory.
    
    % in this section, I'm trying to preallocate the output variable to
    % increase the speed of the program. For this to happen, we need to know
    % the information about experiment. So I'm instructing the program to open
    % the first raw file and store it in "temp" variable so that we extract the
    % number of electrodes,etc.
    
    temp = load('Axx_c001.mat');
    output_wave = zeros([size(temp.Wave,1), size(temp.Wave,2) , ...
        num_conditions]);% this needs to be blank before each condition loop because it will contain the data for each condition
    
    output_freq_ampl = zeros([size(temp.Amp,1), size(temp.Amp,2), num_conditions]);
    
    disp(strcat({'this directory contains '}, {num2str(num_conditions)}, {' conditions and '}));
    
    pause(0.5)
    for c = 1:num_conditions % this loop goes over all the files
        
        
        if c <10
            c2 = strcat('0',num2str(c));
        else
            c2 = num2str(c);
        end


        temp = load(strcat('Axx_c0', num2str(c2),'.mat'));
       
        output_wave(:,:,jj) = temp.Wave; % the Axx processed EEG data.
        % data dimensions go like this: output (EEG data, Number of channel
        %, condition)
        output_freq_ampl (:, :, jj) = temp.Amp; % frequency amplitudes calculated by power diva
        
        jj = jj+1; % adding one to the loop iteration variable 

        disp(strcat('sorting the data for condition ', num2str(c)));
        
        if c == num_conditions
            
            disp('Done :)');
        end
        
        
    end

end


%*************************************************************
%*************************************************************

% this section is for reading the processed Axx files WITH trial data

%*************************************************************
%*************************************************************

if read_raw == 1
    files = conditionChecker(files, 1); %filtering the list of files
    
    [num_conditions, ~] = experiment_numbers(files); % this function
    % finds the number of conditions and trials in each directory.
    
    % in this section, I'm trying to preallocate the output variable to
    % increase the speed of the program. For this to happen, we need to know
    % the information about experiment. So I'm instructing the program to open
    % the first raw file and store it in "temp" variable so that we extract the
    % number of electrodes,etc.
    
    temp = load('Axx_c001_trials.mat');
    output_wave = zeros([size(temp.Wave,1), size(temp.Wave,2) , ...
        size(temp.Wave,3), num_conditions]);% this needs to be blank before each condition loop because it will contain the data for each condition
    
    output_freq_ampl = zeros([size(temp.Amp,1), size(temp.Amp,2), size(temp.Amp,3), num_conditions]);
    
    disp(strcat({'this directory contains '}, {num2str(num_conditions)}))
    
    pause(0.5)
    for c = 1:num_conditions % this loop goes over all the files
        
        
        if c <10
            c2 = strcat('0',num2str(c));
        else
            c2 = num2str(c);
        end
        
       
            temp = load(strcat('Axx_c0', num2str(c2),'_trials.mat'));
            %             raw_data = temp.RawTrial;
            output_wave(:,:, :, jj) = temp.Wave; % the Axx processed EEG data.
            % data dimensions go like this: output (EEG data, Number of channel
            %, condition)
            output_freq_ampl (:, :,:, jj) = temp.Amp; % frequency amplitudes calculated by power diva
            
            jj = jj+1;
      
        disp(strcat('sorting the data for condition ', num2str(c)));
        
        if c == num_conditions
            
            disp('Done :)');
        end
        
        
    end

end



end
