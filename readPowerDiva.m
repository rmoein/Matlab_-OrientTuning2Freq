function ch75 = readPowerDiva(read_raw)


        cd('/Users/reza/Documents/Matlab_-OrientTuning2Freq');

        addpath(genpath('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Exp_MATL_HCN_128_Avg(Full data)'));

        addpath(genpath('C:\Users\rezam\Dropbox\Research_Stuff\Neuro\Justin Gardner'));

        addpath(genpath('/Users/reza/mrTools'));

        addpath(genpath('/Users/reza/Documents/Matlab_-OrientTuning2Freq'));

        cd('/Users/reza/Dropbox/Research_Stuff/Neuro/Justin Gardner/Matlab Files/20180309/Exp_MATL_HCN_128_Avg');

    % read_raw:
    % - 0 for raw EEG
    % - 1 for processed data of each trial 
    % - 2 for processed data of each condition (averaged trials)
    file_directory = uigetdir();

    files = dir(fullfile(file_directory, '*.mat'));

    read_raw = 3;
    jj = 1;

    if read_raw == 3
        files = conditionChecker(files, 3); %filtering the list of files 

        [num_conditions, num_trials] = experiment_numbers(files); % this function 
    % finds the number of conditions and trials in each directory. 
    output = zeros([size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , ...
        size(temp.RawTrial,2), num_conditions*num_trials]);% this needs to be blank before each condition loop because it will contain the data for each condition
        for c = 1:num_conditions % this loop goes over all the files


            if c <10
                c2 = strcat('0',num2str(c));
            else 
                c2 = num2str(c);
            end

            for t = 1: num_trials


                temp = load(strcat('Raw_c0', num2str(c2),'_t0', num2str('01'),'.mat'));
    %             raw_data = temp.RawTrial;
                raw_data = reshape(temp.RawTrial,[size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , 130]);
    % I'm exluding the above code because I don't want to reshape the file. The
    % point of this function is to spit out the data the way its found, not to
    % do anything to it. 
              output(:,:,:,jj) = raw_data;

    %         % this if statement checks to see if the current file and
    %         % previous file have the same number of condition
    %         if c == 1
    %             compare = [];
    %             cond_num  = strsplit(char(files(c)), '_');
    %             cond_num = cond_num(2);
    %         else %if fileNameChecker(chatfiles(c-1), 'Raw')
    %             cond_num  = strsplit(char(files(c)), '_');
    %             cond_num = cond_num(2);
    %             compare = strsplit(char(files(c-1)), '_');
    %             compare = compare(2);
    %         end
    % 
    %         if c <10
    %             c = strcat('0',num2str(c));
    %         else 
    %             c = num2str(c);
    %         end
    % %         % this if statement separates the data from each condition
    %         if cond_num == compare
    % 
    %             temp = load(strcat('Raw_c0', num2str(c),'_t0', num2str('01'),'.mat'));
    %             raw_data = reshape(temp.RawTrial,[size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , 130]);
    %             B = cat(4, B, raw_data);
    %         else
    %             temp = load(strcat('Raw_c0', num2str(c),'_t0', num2str('01'),'.mat'));
    %             raw_data = reshape(temp.RawTrial,[size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs , 130]);
    %         end
            jj = jj+1;
            end
        disp(strcat('sorting the data for condition ', num2str(c)));


        disp(repmat('.',1,c));


        end
        output = reshape(output, [size(temp.RawTrial,1)/temp.NmbEpochs, temp.NmbEpochs ,...
            size(temp.RawTrial,2), num_trials, num_conditions]);
    end
   


   

end
