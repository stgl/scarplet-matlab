## scarplet
Scripts for detecting scarp-like features in airborne laser swath mapping (ALSM) data using wavelet analysis.

#### Installation and usage
Nothing special. These scripts work under recent versions of MATLAB; R2012a+ should do the trick. GNU Octave's `fft` behaves differently by default and will give unexpected results (i.e., the full imaginary value of the FT).

To run these scripts on new data, get a copy of your DEM in ESRI ASCII grid format and import it using the `dem2mat` utility. Convert results back to ESRI/GDAL-friendly format with `mat2dem`. The `wavelet_filtertile` function returns grids of best-fit wavelet parameters that can be exported in the same way.

You can plot filter output over a hillshade with `plotscarplet` if you compute slope magnitudes and azimuths for your DEM. A simple whitening utility is also included to add noise to DEMs with areas of missing data. 

#### Examples
The examples directory contains an example of filtering a synthetic DEM and an application to real-world data from the Carrizo Plain, California, USA. 

#### References
For details, see:  
Hilley, G. E., DeLong, S., Prentice, C., Blisniuk, K., and Arrowsmith, J. R., 2010, Morphologic dating of fault scarps using airborne laser swath mapping (ALSM) data, Geophysical Research Letters, 37, L04301, doi:[10.1029/2009GL042044](http://dx.doi.org/10.1029/2009GL042044).

Please cite this paper if you use these scripts in published work.

#### Contact
Questions? Comments? Complaints?  
Robert Sare [rmsare@stanford.edu](mailto:rmsare@NOSPAMstanford.edu)  
**[STGL](https://pangea.stanford.edu/researchgroups/tectonicgeomorph/)**
