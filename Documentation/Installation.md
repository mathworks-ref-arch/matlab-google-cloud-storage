# Installation

## Installing on Windows® and Linux
The easiest way to install this package and all required dependencies is to clone the top-level repository using:

```bash
git clone --recursive https://github.com/mathworks-ref-arch/mathworks-gcp-support.git
```
This is what your top level directory<sup>1</sup> should look like:

![Folder structure](images/folderstructure.PNG)

### Build the matlab-gcp-common SDK for Java components
The MATLAB code uses the matlab-gcp-common SDK for Java and can be built using:
```bash
cd mathworks-gcp-support/matlab-gcp-common/Software/Java
mvn clean package
```
More details can be found here: [Build](Rebuild.md)

Once built, use the ```mathworks-gcp-support/matlab-google-cloud-storage/Software/MATLAB/startup.m``` function to initialize the interface.
```MATLAB
cd('mathworks-gcp-support/matlab-google-cloud-storage/Software/MATLAB')
startup
```

The package is now ready for use. MATLAB can be configured to call ```startup.m``` on start if preferred so that the package is always available automatically. For further details see: [https://www.mathworks.com/help/matlab/ref/startup.html](https://www.mathworks.com/help/matlab/ref/startup.html)

## Notes:

<sup>1</sup> Used with permission from Microsoft.

[//]: #  (Copyright 2020 The MathWorks, Inc.)
