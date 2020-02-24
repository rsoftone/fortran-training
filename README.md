# Just Enough Fortran for reworking inherited code

Course online materials:
https://sway.office.com/FrztLkLkmyxuMAlT

## Quickstart
Windows users: 
Download the zip file for this repository and expand it in C:\Users\REPLACE-WITH-YOUR-DOCUMENTS-PATH...

Then:

* Start Powershell
* In Powershell issue the command:

```
docker run -it --rm --name fort2 -v C:\Users\REPLACE-WITH-YOUR-DOCUMENTS-PATH\docker\src:/home/pipelines dbjochym/gfortran_static_lapack_blas
```

* In the container

```
cd /home/pipelines
chmod u+x helper.sh
./helper.sh 000-lu
```
