# Just Enough Fortran for reworking inherited code

Course online materials:
https://sway.office.com/FrztLkLkmyxuMAlT

Additional materials:
https://docs.google.com/presentation/d/1qm7PymEsud4qpEGCpemQ5XWmfTKTWRk86_W0oiKlvvI/edit?usp=sharing_eip&ts=5e3cd155

## Quickstart
### Option A: Using Docker on your own computer
#### Mac OS:
* Install [Docker](https://www.docker.com/products/docker-desktop) 
* Start Docker Desktop
* When informed that "Docker Desktop needs privileged access", click: OK (and then enter your password)
* Wait until "Docker Desktop is starting" is completed
* Open Terminal
* Enter command:

```
docker run -it --rm --name fort2 -v $PWD/Documents:/home/pipelines junglegreen/fortran-training
```
* If asked, allow your Documents directory to be shared/accessed

#### Windows 10 (Pro or Enterprise): 
* Install Docker: https://www.docker.com/products/docker-desktop
* In Computer Management, add your username to the 'docker-users' local group
* Restart your computer
* If it does not run on startup, start Docker Desktop
* Open Powershell
* Enter command:

```
docker run -it --rm --name fort2 -v $PWD\Documents:/home/pipelines junglegreen/fortran-training
```
* If asked, allow your Documents directory to be shared/accessed

#### Both Mac OS and Windows 10 (Pro or Enterprise):
* Inside the container...enter the following commands:

```
cd /home/pipelines
git clone https://github.com/rsoftone/fortran-training.git
cd fortran-training/docker/src
chmod u+x helper.sh
```
* To change the code, use your editor to open C:\Users\YOUR-NAME\Documents\fortran-training\docker\src\000-lu.f90
* To compile and run, use (in the container) the commands:
```
./helper.sh 000-lu
```

### Option B: Using NCI Gadi
#### Mac OS
* Open Terminal
#### Windows 10:
* Open Powershell
* If ssh is not enabled on your Windows 10, please see the instructions [here](https://www.howtogeek.com/336775/how-to-enable-and-use-windows-10s-built-in-ssh-commands/)
#### Both Mac OS and Windows 10
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

## Fortran condensed reference card
https://michaelgoerz.net/refcards/fortran_refcard_a4.pdf

## 20 things to know about Fortran
### 1: Fortran is not case sensitive
In contrast, Python, Julia, C/C++ and most modern languages treat uppercase and lowercase as different cases.

Tip: Follow the convention used in your inherited code
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
### 9: Strings are character arrays with a specific length (len)
```
character(len=10) :: s1,s2
character(len=20) :: s3
s1 = "Hello"
s2 = "World"
s3 = trim(s1) // " " // trim(s2)  ! Concatenation operator //
print *,"Complete message: ", s3
```
### 10: A subroutine contained in a parent program can access parent variables
```
program pg10
    implicit none
    integer :: q1, i141, i42
    i141 = 141
    i42  = 42
    q1   = 11
    call insub1(q1)
    print *, "q1: ", q1
    print *, "i42: ", i42

contains
    subroutine insub1(qin)
        implicit none
        integer, intent(inout) :: qin
        qin = qin + i141
        i42 = 1042
        return
    end subroutine insub1

end program pg10
```
### 11: common blocks are for globals
Tip: main program should have all common blocks
```
program pg11
    implicit none
    integer :: q1,i141,i42
    common /gblk1/ i42, i141
    i141 = 141
    i42 = 42
    q1 = 11
    call exsub1(q1) 
    print *, “q1: ”, q1
    print *, “i42: ” , i42
end program pg11
subroutine exsub1(qin)
    implicit none
    integer, intent(inout) :: qin
    integer :: i42,i141
    common /gblk1/ i42,i141
    qin = qin + i141
    i42 = 1042
    return
end subroutine exsub1
```
### 12: A module interfaces to subroutines (and globals!) that are used in many places
```
module ex12module
        implicit none
        save
        private
        public :: modsub1, seti141, geti42
        integer :: i42,i141
        contains 
        subroutine modsub1(q) 
            implicit none
            integer, intent(inout) :: q
            q = q + i141
            i42 = 11242
            return
        end subroutine modsub1
        subroutine seti141(inp) 
            implicit none
            integer, intent(in) :: inp
            i141 = inp
            return
        end subroutine seti141
        integer function geti42() 
            implicit none
            geti42 = i42
        end function geti42
end module ex12module
program pg12
        use ex12module
        implicit none
        integer :: q1
        q1 = 1
        print *, “q1: ”, q1
        call seti141(11) 
        call modsub1(q1)
        print *, “q1: ” , q1
        q1 = geti42()
        print *, “q1: ” , q1
end program pg12
```
### 13: Profiling with system_clock
```
integer(kind=8) :: ibegin, irate, iend
call system_clock(ibegin, irate)
!
! Your code goes here
!
call system_clock(iend)
print *, "Elapsed time: ", real(iend-ibegin)/real(irate)
```
### 14: Integer arithmetic is truncated (not rounded)
```
integer:: i1,i2
i1 = 1 + 3/2
i2 = 1 + 2/3
print *, "i1: ", i1
print *, "i2: ", i2
```
### 15: Arrays up to 7 dimensions
Fortran arrays are n-dimensional, where: 1 <= n <= 7
```
mat_a(i,j)  ! A matrix is a 2-dimensional array
a4m(ux,uy,uz,ut)  ! A 4-dimensional array
```
Array dimensions map to integer values /( 1,2,3,4,5,6,7 /)

i, ux are the leading dimension (value 1) of mat_a and a4m respectively.  This means they get filled up first...
### 16: Fortran is column-major
Whereas Python, C/C++ is row-major.  eg this matrix
```
 1  100
 10 1000
```
| Memory Location | Fortran (also Julia, Matlab, R) | C/C++, Python |
| --------------- | ------------------------------- | ------------- |
| Base | 1 | 1 |
| Base + 1 | 10 | 100 |
| Base + 2 | 100 | 10 |
| Base + 3 | 1000 | 1000 |

### 17: Array indexing starts at 1
```
integer, parameter :: mml=8
double precision :: mat_a(mml,mml)
character(len=64) :: dfmt
write(dfmt, ‘(a,i0,a)’) ‘(‘ , mml , ‘f7.1)’
mat_a = 10 ! Sets all elements to 10
mat_a(1,1) = 0 ! Element in row 1, column 1
write(*,dfmt) transpose(mat_a)
```
### 18: Array slicing uses ':'
```
integer, parameter :: mml=8
double precision :: mat_a(mml,mml)
character(len=64) :: dfmt
write(dfmt, ‘(a,i0,a)’) ‘(‘ , mml , ‘f7.1)’
mat_a(:,2) = 100 ! Set all elements of column 2
mat_a(2:4,1) = 0 ! Rows 2-4, column 1
mat_a(1,3:8:2) = 5 ! Row 1, columns 3 + stride of 2, until 8
write(*,dfmt) transpose(mat_a)
```
### 19: 'reshape' is the high-dimensional version of 'transpose'
```
program pg19
    implicit none
    integer :: flatarray(24),     &
               matDTQ(2,3,4), &         
               matTQD(3,4,2), & 
               matQTD(4,3,2)
    character(len=64) :: dfmt
    write(dfmt, ‘(a,i0,a)’) ‘(‘ , ubound(matDTQ,2), ‘i5.1)’
    flatarray = [1, 2, 3, 4, 5, 6, &
                 7, 8, 9, 10, 11, 12, &
                 13, 14, 15, 16, 17, 18, &
                 19, 20, 21, 22, 23, 24]

    matDTQ = reshape(flatarray, &
             shape(matDTQ), order=[1,2,3])

    write(*,dfmt) transpose(matDTQ(:,:,1))
    
    matTQD = reshape(matDTQ, &
             shape(matTQD), order=[3,1,2])

    matQTD = reshape(matDTQ, &
             shape(matQTD), order=[3,2,1])
end program pg19
```
### 20: Linear algebra: use BLAS + LAPACK (or MKL) wherever possible
## Fortran77
### 1: Fortran77 is **not** free form
Columns have specific entries/values...

**Comments** have: character 'c' , or character '*', in **column 1**
### 2: Statements begin at column 7 and finish as column 72
Unless it meets the criteria for a comment, the characters in columns 1-5 are used to **label** the proceeding code statement

Q: Is a label required for each code statement?

A: No
### 3: '!' is not a standard Fortran77 comment
```
******
****** #3: ! is not a standard Fortran77 comment
******
      REAL  r  ! This comment is not valid in Fortran77 
      DOUBLE PRECISION  x
! This comment is also not valid…
      COMPLEX  z
c     This is a valid comment
c         And so is this
```
### 4: Non-blank at column 6 means line continuation
Tip: Use '&' or '+'
### 5: Fortran77 values do not have the concept of 'kind'
REAL - usually 4 bytes: 1.23e2

DOUBLE PRECISION - usually 8 bytes: 1.23d2

INTEGER - usually 4 bytes: 123
### 6: IMPLICIT NONE
Always use IMPLICIT NONE

Without this...**all** undeclared variables are assumed to be REAL, **except** those that **start** with the characters:
* i, j, k, l, m, n (these are assumed to be INTEGER)

Note that you can also override this...
### 7: Variable names are restricted to max. 6 letters
**First letter** must be a **character [a-zA-Z]**

Except for the first letter, digits [0-9] are allowed as well
### 8: Use PARAMETER for constants
```
***** Fortran77 example: 000-lu77.f
*****
      PROGRAM pg
      IMPLICIT NONE
      INTEGER           mml
      PARAMETER(mml=3)
      INTEGER           i,retinfo
      DOUBLE PRECISION  meye(mml,mml)
      CHARACTER*512     dfmt
      WRITE(dfmt, '(a,i0,a)')
     &            '(' , mml , 'f7.2)'
      meye = 0.0d0
      DO i = 1,mml
          meye(i,i) = 1.0d0
      END DO
      retinfo = INT(meye(2,2))
***** Output will appear transposed
      WRITE(*,dfmt) meye
      WRITE(*,*) 'Return:',retinfo
      END PROGRAM pg
***** End of example Fortran77
```
### 9: Strings are CHARACTER arrays
```
***** Fortran77 strings 
      PROGRAM sld9
      IMPLICIT NONE
      CHARACTER*10    s1
      CHARACTER*(*)   s2
      CHARACTER*20    s3
      PARAMETER(s2 = “World!”)
      s1 = “Hello”
      s3 = TRIM(s1) // “ ” // s2
      PRINT *, “Complete message:  ” , s3
      END PROGRAM sld9
```
### 10: Statement function for scalars
```
***** Fortran77 function
      PROGRAM sld10
      IMPLICIT NONE
      REAL        zph
      COMPLEX     zorig, z1
      zph(z1) = ATAN2(AIMAG(z1),REAL(z1))
***** Assign zorig = 0 – 1i
      zorig = (0,-1)
      WRITE(*,*) zph(zorig)
      WRITE(*,*) zorig%RE,’ ’,zorig%IM
      END PROGRAM sld10
```
### 11: No recursion allowed in Fortran77
! Legacy codes frequently have: 'GO TO some-number-label'
```
***** Fortran77 GO TO…
      PROGRAM sld11
      IMPLICIT NONE
      INTEGER         n,nidx,nmax
      PARAMETER(nmax=5)
      DO 10, nidx = 1,3
          WRITE(*,*) "Enter a number:"
    5     READ(*,*) n
          IF (n .LT. nmax) THEN
              GO TO 5
          END IF 
   10 CONTINUE
      END PROGRAM sld11
```
### 12: Arguments that are modified in subroutines are reflected in the parent variable
! Avoid numeric values as arguments

Analogous to C++ pass-by-reference
```
***** F77 assignment to argument
      PROGRAM sld12
      IMPLICIT NONE
      INTEGER n,ier        
      WRITE(*,*) "Enter a number:“
      READ(*,'(i32)',IOSTAT=ier) n
      IF ( ier .EQ. 0) THEN
	      CALL add0(n,n)
          WRITE(*,*) n
      END IF
      END PROGRAM sld12
*****
      SUBROUTINE add0(ain0,ain1)
      INTEGER ain0,ain1
      ain1 = ain0+ain1
      END SUBROUTINE
```
### 13: Pass array bounds as arguments
```
***** Fortran77 arrays with size arguments
      PROGRAM sld13
      IMPLICIT NONE
      INTEGER   sz,outi,outj
      PARAMETER(sz=4)
      REAL    a(sz,sz),b(sz)
      DATA    a / 1.0 , 2.0 , 3.0 , 4.0,
     &            5.0 , 6.0 , 7.0 , 8.0,
     &            9.0 , 10.0, 11.0, 12.0,
     &            13.0, 14.0, 15.0, 16.0 /
      DATA    b / 100,
     &            200,
     &            300,
     &            400 /
      CALL bradd(a,b,sz)
      DO 100, outi = 1,sz
          DO 90, outj = 1,sz
              b(outj) = a(outi,outj)
   90     CONTINUE
          WRITE(*,*) b
  100 CONTINUE
      END PROGRAM sld13
*****
      SUBROUTINE bradd(a,b,absz)
      INTEGER    absz,i,j
      REAL       a(absz,absz),b(absz)
      DO 10, j = 1,absz
          DO 20, i = 1,absz
             a(i,j) = a(i,j) + b(i)
   20     CONTINUE
   10 CONTINUE
      END SUBROUTINE bradd
```
### 14: Array slicing ':' is not available
Workaround: pass the array to a subroutine as an 'assumed-size' 1D array
```
***** Fortran77 assumed-size array example
      PROGRAM sld14
      IMPLICIT NONE
      INTEGER   sz
      PARAMETER(sz=3)
      DOUBLE PRECISION      a(sz,sz),b
      DATA a / 1.0d0, 2.0d0, 3.0d0,
     &         4.0d0, 5.0d0, 6.0d0,
     &         7.0d0, 8.0d0, 9.0d0 /
      b = 0.1d0
      CALL mulct(a(1,2),b(1),(2*absz-1))
      END PROGRAM sld14
*****
      SUBROUTINE multct(a,b,na)
      INTEGER    na,i
***** a(*) is an assumed-sized array
      DOUBLE PRECISION       a(*),b
      DO 20, i = 1,na
             a(i) = a(i) * b
   20 CONTINUE
      END SUBROUTINE multct
```
