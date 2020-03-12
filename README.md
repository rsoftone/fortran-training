# Just Enough Fortran for reworking inherited code

Course online materials:
https://sway.office.com/FrztLkLkmyxuMAlT

## Quickstart
### Option A: Using Docker on your own computer
#### Windows 10: 
* Install Docker: https://www.docker.com/products/docker-desktop
* In Computer Management, add your username to the 'docker-users' local group
* Restart your computer
* Open Powershell
* Enter command:

```
docker run -it --rm --name fort2 -v $PWD\Documents:/home/pipelines dbjochym/gfortran_static_lapack_blas
```

* You are now in the container...enter the following commands:

```
cd /home/pipelines
git clone https://github.com/rsoftone/fortran-training.git
cd fortran-training/docker/src
chmod u+x helper.sh
```
* To change the code, use your editor to open C:\Users\"YOUR NAME"\fortran-training\docker\src\000-lu.f90
* To compile and run, use (in the container) the commands:
```
./helper.sh 000-lu
```

### Option B: Using NCI Gadi
#### Windows 10:
* Open Powershell
* If ssh is not enabled on your Windows 10, please see the instructions [here](https://www.howtogeek.com/336775/how-to-enable-and-use-windows-10s-built-in-ssh-commands/)
* Login to Gadi:
```
ssh YOUR_USERNAME@gadi.nci.org.au
```
* You are now in the login node of the cluster...enter the following commands:
```
git clone https://github.com/rsoftone/fortran-training.git
cd fortran-training/gadi/src
chmod u+x helper.sh
```
* To change the code, use your editor to open ~/fortran-training/gadi/src/000-lu.f90
* To compile and run, use (on Gadi's login node!) the commands:
```
./helper.sh 000-lu
```
## 20 things to know about Fortran
### 1: Fortran is not case sensitive
In contrast, Python, Julia, C/C++ and most modern languages treat uppercase and lowercase as different cases.
### 2: Indented code is not required
In contrast, Python requires indents as part of its language block syntax.
### 3: '!' indicates the start of a comment
Q: How do you comment out an entire block in Fortran?

A: You can't! (maybe your IDE will help you...)
### 4: '&', at the end of a line, means line continuation
You may need this if you exceed 132 characters on a line.  A blank line, or a comment, can come after the '&'
### 5: Fortran number values have a 'kind'
Q: What is the difference between '1.23e0' and '1.23d0'?

A: '1.23e0' is 'single precision'

A: '1.23d0' is 'double precision'

Q: What 'kind' is the value: '1.23'?

A: (Default)/Single precision

### 6: 'implicit none' + "Specification" section for variables
! Always use 'implicit none'; and immediately after, declare all variables
### 7: Fortran variables are 'typed'
Numeric
```
real :: r
double precision :: x
double complex :: z
integer :: j
logical :: b
```
Non-numeric
```
character :: s
```
### 8: Type conversions for numeric variables
During assignment and initialisation : Yes
```
integer :: a
a = 1.0d0 ! Interpreted as a = int(1.0d0,kind=kind(a))
```
In the argument of procedure calls: No!
