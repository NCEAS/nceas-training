---
title: "Why considering Python"
author: "Julien Brun, NCEAS - OSS2017"
output:
  slidy_presentation: default
  ioslides_presentation: default
---

## The Why <img style="float: right;width: 300px;" src="images/python.png">



<img style="align: Left;width: 700px;" src="images/IEEE_spectrum.png">

http://spectrum.ieee.org/computing/software/the-2017-top-programming-languages

## The Why

Here are some reasons why you might want to dive into Python:

- The syntax is sleek and object oriented
- It is fast for a scripting language (a lot of C bindings)
- It scales up to large data pretty easily (RAM, multiprocessing and native integration of main big data tools)
- It is ubiquitous
- It is well-suited for geoprocessing
- Great and large community and open source

. . .

#### ... But importantly, you might not have the choice!!


## Scientific Python

- Convenience of use: IPython and Jupyter notebooks
- [SciPy.org](http://scipy.org)
- [NumPy](http://www.numpy.org), [Matplotlib](http://matplotlib.org), [SciPy library](http://scipy.org/scipylib/index.html), [Sympy](http://sympy.org/en/index.html), [Pandas](http://pandas.pydata.org) and [statsmodels](http://www.statsmodels.org/stable/index.html)
- Data visualization: [matplotlib](https://matplotlib.org/), [pandas](http://pandas.pydata.org/), [seaborn](https://seaborn.pydata.org/), [ggplot](http://ggplot.yhathq.com/)
- Interactive data viz: [bokeh](http://bokeh.pydata.org/en/latest/docs/gallery.html), [plotly](https://plot.ly/python/), [pygal](http://www.pygal.org/en/stable/), and [d3py](https://github.com/mikedewar/d3py) 


## Scientific Python

- Machine learning: [scikit-learn](http://scikit-learn.org/stable/) and [mlpy](http://mlpy.sourceforge.net/)
- Image processing: [scikit-image](http://scikit-image.org/)
- Data liberation: [requests](http://docs.python-requests.org/en/latest/) and [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
- Text mining: [NLTK](http://www.nltk.org/)


## Geospatial

- Spatial analysis: [PySal](http://pysal.readthedocs.io/en/latest/),[osgeo](https://wiki.osgeo.org/wiki/OSGeo_Python_Library)  
- Working with vector data: [Shapely](http://toblerity.org/shapely/project.html), [Fiona](https://pypi.python.org/pypi/Fiona), [ogr bindings](https://pcjericks.github.io/py-gdalogr-cookbook/) and [GeoPandas](http://geopandas.org/)
- Working with raster data: [gdal bindings](http://trac.osgeo.org/gdal/wiki/GdalOgrInPython), [GRASS bindings](https://grasswiki.osgeo.org/wiki/GRASS_Python_Scripting_Library), [georasters](https://pypi.python.org/pypi/georasters/), [pygeoprocessing](https://pypi.python.org/pypi/pygeoprocessing), [rasterio](https://github.com/mapbox/rasterio), [PyNIO for hierarchical data](http://www.pyngl.ucar.edu/Nio.shtml) 
- GIS software bindings: [PyQGIS](http://docs.qgis.org/testing/en/docs/pyqgis_developer_cookbook/) and [ArcPy](http://pro.arcgis.com/en/pro-app/arcpy/get-started/a-quick-tour-of-arcpy.htm) 
- geodata viz: [basemap](http://matplotlib.org/basemap/), [Kartograph](http://kartograph.org/), [mapnik](http://mapnik.org/), [Descartes](https://pypi.python.org/pypi/descartes), [PyNGL](http://www.pyngl.ucar.edu/Examples/index.shtml), [geoplotlib](https://github.com/andrea-cuttone/geoplotlib)


## Demo!


## References

- Python for R users: <https://github.com/NCEAS/training-jupyter-notebook/blob/master/python4Rusers.md>
- Quick intro to Jupyter notebooks: <https://github.com/NCEAS/training-jupyter-notebook/blob/master/jupyter-notebook-overview.md>
- [Ipython](http://ipython.org)
- [Official Python Tutorials](https://docs.python.org/2.7/tutorial/)
- [video: 10-minute tour of pandas](https://vimeo.com/59324550)
- [The Hitchhiker's guide to Python](http://docs.python-guide.org/en/latest/)
- [How To Think Like a Computer Scientist](http://openbookproject.net/thinkcs/python/english2e/)
-  [Dive into Python](http://www.diveintopython.net)
-  [Python Glossary](https://docs.python.org/2/glossary.html#term-generator)


## Python Distributions

For Windows users: 

- [WinPython](http://winpython.sourceforge.net/)
- [Anaconda](https://store.continuum.io/cshop/anaconda/)
- [miniconda](https://conda.io/miniconda.html)
- [Canopy](https://www.enthought.com/products/canopy/)

### Note for ArcGIS users

**IMPORTANT**: If you install anaconda on your machine and ArcGIS is already installed, please do the following to avoid breaking ArcGIS, **uncheck the checkboxes**:

1. make Anaconda the default Python
2. add Anaconda's Python to the PATH.


## Python Distributions

For Mac users:

- Homebrew: <http://python-guide-pt-br.readthedocs.io/en/latest/starting/install3/osx/> 