module ex12module
    implicit none
    save
    private
    public :: modsub1, seti141, geti42
    integer :: i42, i141
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
    q1   = 1
    print *, "q1: ", q1
    call seti141(11)
    call modsub1(q1)
    print *, "q1: ", q1
    q1 = geti42()
    print *, "q1: ", q1
end program pg12

