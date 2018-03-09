function z = readPowerDiva(read_raw)

    cd('/Users/reza/Documents/Matlab_-OrientTuning2Freq');

    addpath(genpath('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Exp_MATL_HCN_128_Avg(Full data)'));

    addpath(genpath('C:\Users\rezam\Dropbox\Research_Stuff\Neuro\Justin Gardner'));

    addpath(genpath('/Users/reza/mrTools'));

% read_raw:
% - 0 for raw EEG
% - 1 for processed data of each trial 
% - 2 for processed data of each condition (averaged trials)
file_directory = uigetdir();

files = dir(fullfile(file_directory, '*.mat'));

if read_raw == 0
    for i = 1:length(files)
        fileNameChecker(files(i), 'Raw')
        z = disp(files(i))
    end
end

   

end
