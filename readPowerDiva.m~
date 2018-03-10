function ch75 = readPowerDiva(read_raw)

    cd('/Users/reza/Documents/Matlab_-OrientTuning2Freq');

    addpath(genpath('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Exp_MATL_HCN_128_Avg(Full data)'));

    addpath(genpath('C:\Users\rezam\Dropbox\Research_Stuff\Neuro\Justin Gardner'));

    addpath(genpath('/Users/reza/mrTools'));
    
    addpath(genpath('/Users/reza/Documents/Matlab_-OrientTuning2Freq'));
    
    cd('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Exp_MATL_HCN_128_Avg(Full data)');

% read_raw:
% - 0 for raw EEG
% - 1 for processed data of each trial 
% - 2 for processed data of each condition (averaged trials)
file_directory = uigetdir();

files = dir(fullfile(file_directory, '*.mat'));

if read_raw == 0
    for c = 1:length(files) % this loop goes over all the files
        
            t = 1;
            B = [];% this needs to be blank before each condition loop because it will contain the data for each condition
        
        if fileNameChecker(files(c).name, 'Raw') == 1 % this checks to see if the name contains 'raw'
%             disp(files(i).name)
            % this if statement checks to see if the current file and
            % previous file have the same number of condition
            if c == 1
                compare = [];
                cond_num  = strsplit(files(c).name, '_');
                cond_num = cond_num(2);
            else
                cond_num  = strsplit(files(c).name, '_');
                compare = strsplit(files(c-1).name, '_');
            end
            
            if c <10
                c = strcat('0',num2str(c));
            else 
                c = num2str(c);
            end
            % this if statement separates the data from each condition
            if cond_num == compare
                
                temp = load(strcat('Raw_c0', num2str(c),'_t0', num2str('01'),'.mat'));
                raw_data = reshape(temp.RawTrial,[size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , 130]);
                B = cat(4, B, raw_data);
            else
                temp = load(strcat('Raw_c0', num2str(c),'_t0', num2str('01'),'.mat'));
                raw_data = reshape(temp.RawTrial,[size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , 130]);
                
            try
                
                
            end
        end
    end
end

   

end
