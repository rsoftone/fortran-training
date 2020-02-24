# Just Enough Fortran for reworking inherited code

Course online materials:
https://sway.office.com/FrztLkLkmyxuMAlT

## Quickstart
Windows users: 
For this example we will work in the directory

C:\Users\REPLACE-WITH-YOUR-DOCUMENTS-PATH


* Start Powershell
* In Powershell issue the command:

```
docker run -it --rm --name fort2 -v C:\Users\REPLACE-WITH-YOUR-DOCUMENTS-PATH:/home/pipelines dbjochym/gfortran_static_lapack_blas
```

* In the container

```
cd /home/pipelines
git clone https://github.com/rsoftone/fortran-training.git
cd fortran-training/docker/src
./helper.sh 000-lu
```
