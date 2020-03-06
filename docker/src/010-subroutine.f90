program pg10  ! A subroutine contained in a parent program
              ! can access parent variables
    implicit none
    integer :: q1, i141, i42
    i141 = 141
    i42  = 42
    q1   = 1
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
