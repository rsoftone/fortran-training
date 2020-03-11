program pg20
    implicit none
    ! Section: Specification
    integer :: mml,i,j,retinfo
    double precision, allocatable :: a(:,:)
    double precision, allocatable :: ata(:,:), meye(:,:)
    integer, allocatable :: ipiv(:)
    character(len=512) :: dfmt
    ! Section: Execution
    mml = 5
    retinfo = 0
    ! Format for I/O
    write(dfmt, '(a,i0,a)') '(',mml,'f7.2)'
    !
    allocate(a(mml,mml), ata(mml,mml), meye(mml,mml), ipiv(mml))
    ! 'meye' is an Identity matrix
    meye = 0.0
    do i = 1,mml
        meye(i,i) = 1.0
    end do
    ! 'a' is now assigned values
    do i = 1,mml
        do j = 1,mml
            a(i,j) = 10*i + j
        end do
    end do
    write(*,*) 'Input:'
    write(*,dfmt) transpose(a)
    !
    call dgetrf(mml,mml,a,mml,ipiv,retinfo)
    ! call getrf(a,ipiv,retinfo)
    !
    if (retinfo /= 0) then
        write(*,*) 'The matrix is singular: dgetrf returned ', retinfo
    else
        write(*,*) 'LU Result:'
        write(*,dfmt) transpose(a)
        write(*,*)
        write(*,*) 'Pivots:'
        write(*,*) ipiv
        write(*,*)
        write(*,*) 'Identity:'
        write(*,dfmt) transpose(meye)
        call dtrmm('L','U','N','N',mml,mml,1.0d0,a,mml,meye,mml)
        call dtrmm('L','L','N','U',mml,mml,1.0d0,a,mml,meye,mml)
        write(*,*)
        write(*,*) 'After trmm:'
        write(*,dfmt) transpose(meye)
        do i = mml,1,-1
            call s_rowexch(ipiv(i),i,meye)
        end do
        write(*,*)
        write(*,*) 'After reversing pivots:'
        write(*,dfmt) transpose(meye)
    end if
    deallocate(a, ata, meye, ipiv)
    contains
        subroutine s_rowexch(row_a,row_b,m)
            implicit none
            integer, intent(in) :: row_a, row_b
            double precision, intent(inout) :: m(:,:)
            double precision, allocatable :: tmprow(:)
            allocate(tmprow(size(m,2)))
            !
            tmprow = m(row_b,:)
            m(row_b,:) = m(row_a,:)
            m(row_a,:) = tmprow
            !
            deallocate(tmprow)
        end subroutine s_rowexch
end program pg20
