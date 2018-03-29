function z = frequencyPlot(cond, conditions_to_visualize, channel_to_visualize)
% cond = 1;
% conditions_to_visualize = '18-27';



% cond = 3;
% conditions_to_visualize = '18,27, 7';


% this block checks the conditions_to_visualize entry and splits it into a
% matrix of condition numbers
if exist('conditions_to_visualize', 'var') == 0 
    disp('please enter a valid condition 1-9 ');
    return
elseif contains(conditions_to_visualize, ',')
    
    conditions_to_visualize = str2double(strsplit(conditions_to_visualize,','));
    
elseif contains(conditions_to_visualize, '-')
    
    conditions_to_visualize = str2double(strsplit(conditions_to_visualize,'-'));
    conditions_to_visualize = conditions_to_visualize(1):conditions_to_visualize(2);
else
    disp('please enter a valid condition');
    return
end

if lower(cond) == 'raw'
    cond = 3;
elseif cond == 'trial'
    cond = 1;
elseif lower(cond) == 'axx'
    cond = 2;
end


if cond == 3
    data = readPowerDiva(cond);
else
    [~, ampl] = readPowerDiva(cond);
end

if exist('channel_to_visualize', 'var') == 0
    channel_to_visualize = 75; %the default channel to analyze in case no argument is passed for it
end



% this if block determines the size of the subplot plot
if length(conditions_to_visualize) == 1
    [subplot_x, subplot_y] = subplot_num_gen(1);
    conditions_to_visualize = [conditions_to_visualize;conditions_to_visualize]; %this ensures that the loop below will work
else
    [subplot_x, subplot_y] = subplot_num_gen(length(conditions_to_visualize)); % this finds the
    % optimal dimensions for the subplot
end


if cond == 3
    a = squeeze(data(:,2:size(data,2) - 1, channel_to_visualize, :,:)); % excluding the first and the last epochs from the analysis
    % a = squeeze(data(:,:, channel_to_visualize, :,:));
    new_dimensions = [size(data,1)*2, (size(data,2)-2)/2, size(data,4), size(data,5)]; % reshaping it because we want to
    % use 2 second epochs for plotting frequency ampl. This increases the
    % resolution to 0.5 hz as opposed to 1 hz.
    a = reshape(a, new_dimensions);
    a = squeeze(mean(mean(a,2),3)); % averaging epochs
    jj = 1; % loop counter
    
    if exist('ampls', 'var') ==1
        clear ampls
    end
    
%     ampls = zeros(str2double(conditions_to_visualize(2))...
%         - str2double(conditions_to_visualize(1))+1,2);
    for i = 1: length(conditions_to_visualize)
        ampls(i,:) = freq_ampl(a(:,i), 420, 100);
    end
    
    ampls = max(max(ampls)); % this variable is used to normalize the scale of
    % y-axis across all graphs
    
    
    for c = conditions_to_visualize % looping over conditions
        
        
        x = 0:1000/size(data,1):1000;
        x = x(1:size(data,1)); %timestamp for graphing
        
        subplot(subplot_x, subplot_y, jj)
        freq_plot(a(:, conditions_to_visualize(jj)), 420, 100)
        ylim([0, ampls]);
        title(strcat({'Condition'}, {' '}, {num2str(conditions_to_visualize(jj))}))
        jj = jj+1;
    end
    
    
    
    %*************************************************************
    %*************************************************************
    
    % this section is for plotting freq ampl of processed Axx files w.o trial data
    
    %*************************************************************
    %*************************************************************
    
elseif cond == 2
    jj = 1;
    a = squeeze(ampl (:, channel_to_visualize, :));
    ampl_scale = a(:, conditions_to_visualize);
    ampl_scale = max(max(ampl_scale));
    
    for c = conditions_to_visualize
        
        subplot(subplot_x, subplot_y, jj)
        
        hold on;
        axx_freq_plot(a(:,conditions_to_visualize(jj)));
        ylim([0, ampl_scale]);
        
        title(strcat({'Condition'}, {' '}, {num2str(conditions_to_visualize(jj))}))
        jj = jj +1;
    end
    
    
elseif cond == 1
    jj = 1;
    a = squeeze(mean(ampl,3));
    a = squeeze(a (:, channel_to_visualize, :));
    
    ampl_scale = a(:, conditions_to_visualize);
    ampl_scale = max(max(ampl_scale));
    
    for c = conditions_to_visualize % looping over conditions
        
        subplot(subplot_x, subplot_y, jj)
        
        hold on;
        axx_freq_plot(a(:,conditions_to_visualize(jj)));
        ylim([0, ampl_scale]);
        
        title(strcat({'Condition'}, {' '}, {num2str(conditions_to_visualize(jj))}))
        jj = jj +1;
    end
    
end


end

