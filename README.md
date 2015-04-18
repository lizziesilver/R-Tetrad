# R-Tetrad
Utility functions for interfacing R with Tetrad.

################################################################################
# About Tetrad
################################################################################

Tetrad is free software for learning causal networks from observational data. 

For more information about Tetrad, see the website:
http://www.phil.cmu.edu/projects/tetrad/

Tetrad has a limited command line version. Command line jars are available
in the download directory. The source code for the entirety of Tetrad is 
there too. Download directory:
http://www.phil.cmu.edu/projects/tetrad_download/download/


################################################################################
# About this repository
################################################################################

I frequently want to compare the Tetrad implementation of an algorithm with the 
implementation in the pcalg package in R. Unfortunately Tetrad is not available
in R. The simplest solution I've found is to use the command line version of 
Tetrad, write the output of both Tetrad and pcalg to file, and then compare the
outputs within either Tetrad or R.	

This repository collects the input and output functions for doing that. 