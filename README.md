# Matlab_-OrientTuning2Freq

There are three main functions in this repository. 

1) readPowerDiva
2) frequencyPlot
3) timeSeriesPlot

### readPowerDiva
this function reads the .mat exported files from power diva. There are three possilble inputs for this function:

1) for reading Axx files that include each individual trial for each condition 
2) for reading processed Axx data 
3) for reading raw EEG data

Depending on the option you choose, you will have different outputs. The output is either just "output_wave" variable (for conditions 1 and 3) or "output_wave" and "output_freq_ampl" for condition 2 (since this condition includes processed data from Power Diva, and the frequency amplitudes are exported from Power Diva as well). 

