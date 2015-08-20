# examples
These examples demonstrate how to run the wavelet scripts on a DEM, process the filter output, and plot the results.

#### Synthetic scarp
This example uses a simple vertical fault scarp with morphologic age 10<sup>1</sup> m<sup>2</sup>. The DEM is whitened with low-amplitude Gaussian noise. The filter identifies the area around the main fault scarp as having high signal-to-noise ratio.

#### Carrizo Plain, USA
Original data collected by the [National Center for Airborne Laser Mapping](http://dx.doi.org/10.5069/G99Z92TC), accessed through [OpenTopography](http://www.opentopography.org/).

In this oriented swath, the San Andreas Fault appears as a continuous fault scarp cross-cut by channels coming off of high topography to the northeast. The wavelet filter identifies this scarp as a group of high signal-to-noise features with an approximate morphologic age of 10<sup>2.5</sup> m<sup>2</sup>. Channels are also clearly resolved. Masking the filter output to exclude areas of low SNR reveals the salient diffusive features in the DEM.
