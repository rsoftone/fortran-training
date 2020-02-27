# Just Enough Fortran for reworking inherited code

Course online materials:
https://sway.office.com/FrztLkLkmyxuMAlT

## Quickstart
Option A: Using Docker on your own computer

Windows 10: 
* Install Docker: https://www.docker.com/products/docker-desktop
* In Computer Management, add your username to the 'docker-users' local group
* Restart your computer
* Open Powershell
* Enter command:

```
docker run -it --rm --name fort2 -v $PWD\Documents:/home/pipelines dbjochym/gfortran_static_lapack_blas
```

* In the container

```
cd /home/pipelines
git clone https://github.com/rsoftone/fortran-training.git
cd fortran-training/docker/src
./helper.sh 000-lu
```

* To change the code, use your editor to open C:\Users\REPLACE-WITH-YOUR-DOCUMENTS-PATH\fortran-training\docker\src\000-lu.f90
