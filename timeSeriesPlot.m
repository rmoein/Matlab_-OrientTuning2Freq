function z = timeSeriesPlot(cond, conditions_to_visualize, channel_to_visualize)

% time/freq, channel_to_visualize)

% cond = 1; 
% channel_to_visualize = 75;
conditions_to_visualize = strsplit(conditions_to_visualize,'-');

if lower(cond) == 'raw'
    cond = 3;
elseif cond == 'trial'
    cond = 1;
elseif lower(cond) == 'axx'
    cond = 2;
end
     

data = readPowerDiva(cond);

if isempty(channel_to_visualize) == 1
    channel_to_visualize = 75; %the default channel to analyze
end


% mode = 'time'; %or freq

[subplot_x, subplot_y] = subplot_num_gen(str2double(conditions_to_visualize(2))...
    - str2double(conditions_to_visualize(1))+1); % this finds the
% optimal dimensions for the subplot

if cond == 3
    a = data(:,2:11, :, :,:); % excluding the first and the last epochs from the analysis
    a = squeeze(mean(data,2));
    a = squeeze(a(:, channel_to_visualize, :, :));
    jj = 1;
    for c = str2double(conditions_to_visualize(1)): str2double(conditions_to_visualize(2)) % looping over conditions
        
        temp = a(:,:,c);
        
        x = 0:1000/size(temp,1):1000;
        x = x(1:size(temp,1)); %timestamp for graphing
        
        subplot(subplot_x, subplot_y, jj)
        
        for t = 1:size(data,4) % looping over trials
            
            if t < size(data,4)
                hold on;
                plot (x, temp(:,t), 'color',[.5,.5,.5])
                xlabel('Time (ms)')
                ylabel('Signal Amplitude (uV)')
                
            else
                
                hold on;
                plot (x, temp(:,t), 'color',[.5,.5,.5])
                xlabel('Time (ms)')
                ylabel('Signal Amplitude (uV)')
                
                plot(x, mean(temp,2), 'r', 'LineWidth',2)
                hold off;
            end
        end
        title(strcat({'Condition'}, {' '}, {num2str(c)}))
        jj = jj+1;
    end
    
    
elseif cond == 2
    jj = 1;
    a = squeeze(data (:, channel_to_visualize, :));
    
    for c = str2double(conditions_to_visualize(1)): str2double(conditions_to_visualize(2)) % looping over conditions
        
        x = 0:1000/size(a,1):1000;
        x = x(1:size(a,1)); %timestamp for graphing
        
        subplot(subplot_x, subplot_y, jj)
        
        hold on;
        plot (x, a(:,c), 'b', 'LineWidth',2)
        xlabel('Time (ms)')
        ylabel('Signal Amplitude (uV)')
        title(strcat({'Condition'}, {' '}, {num2str(c)}))
        jj = jj +1;
    end
    
elseif cond == 1
    a = data(:, :, :,:);
    a = squeeze(a(:, channel_to_visualize, :, :));
    jj = 1;
    for c = str2double(conditions_to_visualize(1)): str2double(conditions_to_visualize(2)) % looping over conditions

        temp = a(:,:,c);

        x = 0:1000/size(temp,1):1000;
        x = x(1:size(temp,1)); %timestamp for graphing

        subplot(subplot_x, subplot_y, jj)

        for t = 1:size(data,3) % looping over trials

            if t < size(data,3)
                hold on;
                plot (x, temp(:,t), 'color',[.5,.5,.5])
                xlabel('Time (ms)')
                ylabel('Signal Amplitude (uV)')

            else

                hold on;
                plot (x, temp(:,t), 'color',[.5,.5,.5])
                xlabel('Time (ms)')
                ylabel('Signal Amplitude (uV)')

                plot(x, mean(temp,2), 'r', 'LineWidth',2)
                hold off;
            end
        end
        title(strcat({'Condition'}, {' '}, {num2str(c)}))
        jj = jj+1;
    end



end


end
%
%
%