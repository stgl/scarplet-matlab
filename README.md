# scarplet
Scripts for detecting scarp-like features in airborne laser swath mapping (ALSM) data using wavelet analysis.

# Installation
Nothing special. These scripts work under recent versions of MATLAB; R2012a should do the trick. GNU Octave's fft behaves differently by default and will give unexpected results (i.e., the full imaginary value of the FFT).

To run these scripts on new data, get a copy of your DEM in ESRI ASCII format and import it using the dem2mat utility. Convert results back to ESRI/GDAL-friendly format with mat2dem. A generic whitening utility is also included.

# Examples
The examples directory contains two examples of filtering synthetic DEMs, and one application to real-world data from the Carrizo Plain, California, USA. 

# References
For details, please see:
Hilley, G. E., DeLong, S., Prentice, C., Blisniuk, K., and Arrowsmith, J. R., 2010, Morphologic dating of fault scarps using airborne laser swath mapping (ALSM) data, Geophys. Res. Lett., 37, L04301, doi:10.1029/2009GL042044.

Please cite this paper if you use these scripts in published work.

# Contact
Questions? Comments? Complaints?
Robert Sare rmsare@stanford.edu
