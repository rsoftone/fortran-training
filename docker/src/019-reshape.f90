program pg19
    implicit none
    integer :: flatarray(24),matDTQ(2,3,4),matTQD(3,4,2),matQTD(4,3,2)
    character(len=64)  :: dfmt
    write(dfmt, '(a,i0,a)') '(' , ubound(matDTQ,2), 'i5.1)'
    flatarray = [1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, &
                 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    print *, flatarray
    print *, ""
    print *, "---------------"
    matDTQ = reshape(flatarray,shape(matDTQ),order=[1,2,3])
    print *, ""
    print *, "matDTQ(:,:,1)"
    print *, ""
    write(*,dfmt) TRANSPOSE(matDTQ(:,:,1))
    print *, ""
    ! 
    print *, "matDTQ(:,:,2)"
    print *, ""
    write(*,dfmt) TRANSPOSE(matDTQ(:,:,2))
    print *, ""
    ! 
    print *, "matDTQ(:,:,3)"
    print *, ""
    write(*,dfmt) TRANSPOSE(matDTQ(:,:,3))
    print *, ""
    ! 
    print *, "matDTQ(:,:,4)"
    print *, ""
    write(*,dfmt) TRANSPOSE(matDTQ(:,:,4))
    print *, ""
    print *, "---------------"
    !
    matTQD = reshape(matDTQ,shape(matTQD),order=[3,1,2])
    write(dfmt, '(a,i0,a)') '(' , ubound(matTQD,2), 'i5.1)'
    !
    print *,""
    print *, "matTQD(:,:,1)"
    print *,""
    write(*,dfmt) transpose(matTQD(:,:,1))
    print *,""
    !
    print *,""
    print *, "matTQD(:,:,2)"
    print *,""
    write(*,dfmt) transpose(matTQD(:,:,2))
    print *,""
    print *, "---------------"
    !
    matQTD = reshape(matDTQ,shape(matQTD),order=[3,2,1])
    write(dfmt, '(a,i0,a)') '(' , ubound(matQTD,2), 'i5.1)'
    !
    print *,""
    print *, "matQTD(:,:,1)"
    print *,""
    write(*,dfmt) transpose(matQTD(:,:,1))
    print *,""
    !
    print *,""
    print *, "matQTD(:,:,2)"
    print *,""
    write(*,dfmt) transpose(matQTD(:,:,2))
    print *,""
end program pg19

