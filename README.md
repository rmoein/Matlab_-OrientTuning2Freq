# Matlab_-OrientTuning2Freq

There are three main functions in this repository (the rest of them are dependencies for these main functions). 

1) readPowerDiva
2) frequencyPlot
3) timeSeriesPlot

### readPowerDiva
this function reads the .mat exported files from power diva and saves them in one or two variables. There are three possilble inputs for this function:

1) reads Axx files that include each individual trial for each condition ( readPowerDiva(1) ) 
2) reads reading processed Axx data ( readPowerDiva(2) ) 
3) reads raw EEG data (readPowerDiva(3) )

Depending on the option you choose, you will have different outputs. The output is either just "output_wave" variable (for conditions 1 and 3) or "output_wave" and "output_freq_ampl" for condition 2 (since this condition includes processed data from Power Diva, and the frequency amplitudes are exported from Power Diva as well). 

***********************
Running This Function
**********************

Example: run readPowerDiva(3) ==> Select desired directory where exported files are located (this example reads all of the raw EEG files within the directory.)

### frequencyPlot
this function plots the frequency amplitudes of EEG data obtained from PowerDiva up to 50 Hz of frequency. 

***********
Input Variables
***********

"cond" relates to the sort of data you would like to analyze (see above). Your options are: 
 1) Axx_trial 
 2) Axx 
 3) Raw EEG


"conditions to visualize" is the conditions within the directory you would
like to visualize. This is variable, depending on your data. For instance, your experiment may contain 10 different conditions. This function lets you visualize all of them in any order you prefer. 

"channel to visualize" refers to the channel (out of the 128) that you
would like to analyze. If you don't pass any argument for this, the
program goes for the default channel, which is 75. 

***********************
Running This Function
**********************

A sample command would be:
frequencyPlot (3, '1-9', 75) .then select the directory where the Power
Diva files are located.

the above command visualizes the Raw EEG data for conditions 1 to 9 from
channel 75. 

you also have the option of plotting the conditions of choice by using the a
format such as: frequencyPlot (3, '1,5,7,20') which will plot the
frequncy plot of conditions 1,5,7, and 20. 

![alt text](https://image.ibb.co/cOHd6c/untitled.jpg)


### timeSeriesPlot

This function plots the time series EEG data obtained from Power Diva. 

***********
Input Variables
***********

"cond" relates to the sort of data you would like to analyze. Your options are: 
 1) Axx_trial 
 2) Axx 
 3) Raw EEG

"conditions to visualize" is the conditions within the directory you would
like to visualize. This is variable, depending on your data. 

"channel to visualize" refers to the channel (out of the 128) that you
would like to analyze. If you don't pass any argument for this, the
program goes for the default channel, which is 75. 

***********************
Running This Function
**********************

A sample command would be:
timeSeriesPlot (3, '1-9', 75) . Then select the directory where the Power
Diva files are located. The above command visualizes the Raw EEG data for conditions 1 to 9 from
channel 75. 

You also have the option of plotting the conditions of choice by using the a
format such as: frequencyPlot (3, '1,5,7,20') which will plot the
frequncy plot of conditions 1,5,7, and 20. 

![alt text](https://image.ibb.co/mdRMRc/untitled2.jpg)
