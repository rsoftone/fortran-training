program pg17
    implicit none
    integer, parameter :: mml=8
    double precision   :: mat_a(mml,mml)
    character(len=64)  :: dfmt
    write(dfmt, '(a,i0,a)') '(' , mml , 'f7.1)'

    mat_a        = 10
    mat_a(1,1)   = 0
    write(*,dfmt) transpose(mat_a)
end program pg17

