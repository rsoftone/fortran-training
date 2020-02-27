program pg
    implicit none   ! always use implicit none, unless you know why 
                    ! you don't want to...
    ! 
    ! Section: Specification
    !
    integer                       :: mml,i,retinfo  ! scalars
    double precision, allocatable :: a(:,:) ! a is a "deferred shape" array
    double precision, allocatable :: ata(:,:),meye(:,:)
    integer         , allocatable :: ipiv(:)
    character(len=512)            :: dfmt   ! string
    !
    ! Section: Execution
    !
    Mml = 12
    Retinfo = 0
    !
    ! Format for I/O
    ! 
    write(dfmt, '(a,i0,a)') '(' , mml , 'f7.2)'  ! a => character , i0 => minimum digits required for integer 
    !
    ! Allocate memory
    !
    allocate( a(mml,mml)    &
        &   , ata(mml,mml)  &
        &   , meye(mml,mml) &
        &   , ipiv(mml)     &
        &   )
    !
    ! Assign all elements of meye to 0
    !
    meye = 0.0d0
    !
    ! Assign all elements on the diagonal of meye to 1.0
    !
    do i = 1,mml
        mEye(i,i) = 1.0d0
    end do
    !
    ! Output the matrix: meye
    ! 
    write(*,*) 'Identity matrix meye:'
    write(*,*)
    write(*,dfmt) TRANSPOSE(meye)
    !
    ! Deallocate memory
    !
    deallocate( a, ata, meye, ipiv)    
end program pg
