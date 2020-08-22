program main
implicit none
    logical equal
    CHARACTER(1)::choice
    integer, parameter ::  rows = 3, columns = 3,gen=5
    double precision,parameter::some=0.619
    integer,DIMENSION(rows*columns)::now, final
    integer :: i
    call sleep(1)
    call GET_COMMAND_ARGUMENT(1,choice)
    if (choice .EQ. 'a') then
        do i=1,rows*columns
            if (rand()<some) then 
                now(i) = 1
            else 
                now(i)=0
            endif
        end do
    else
        now=(/0,0,0,1,1,1,0,0,0/)
    endif
    call life(now,rows,columns,gen)

    !if (choice .NE. 'a') then
    !   final = (/0,0,0,0,0,0,0,0,0/)
    !    equal = size(now) == size(final)
    !    if (equal) then
    !        do i=1,size(now)
    !            equal = equal .and. now(i) == final(i) 
    !            print *, equal, now(i)
    !            if ( .not. equal )exit
    !        enddo
    !    endif
    !    if(equal) then
    !        print *, "All good!!"
    !    endif
    !endif
end program main


subroutine life (now,rows,cols,gen)
implicit none     
    
    integer,INTENT(IN) :: rows,cols
    integer, INTENT(INOUT) :: gen
    integer,INTENT(INOUT) :: now(rows*cols)
    integer :: i, j 
    integer::d(1:SIZE(now,1))
    d=now
    write(*,*) "recursive ", gen
    do i = 1, rows*cols
        if (modulo(i-1,rows)==0) then
            write(*,*)
        endif
        if(d(i) .eq. 0) then
            write(*,"(1x, A)",advance="no") " "
        else
            write(*,"(1x, A)",advance="no") "o"
        endif
    end do
    write(*,*)
    
    call live(now,rows,cols,gen)
end subroutine life


RECURSIVE subroutine live (a,r,c,gen)    
implicit none   
    integer,INTENT(IN):: r,c
    integer, INTENT(INOUT) ::a(r*c)
    integer, INTENT(INOUT) :: gen
    integer:: i,nei,m
    integer::b(1:SIZE(a,1))
    write (*,"(A)") gen
     do i = 1,c*r
        nei=0
        b(i)=0
        if((i-1) .GE. 1) then
            nei= nei+ a(i-1)
        endif
        if((i+1) .LE. (r*c)) then
            nei= nei+a(i+1)
        endif
        if((i-r) .GE. 1) then
            nei= nei+a(i-r)
        endif
        if((i+r) .LE. (r*c)) then
            nei= nei+a(i+r)
        endif
        if((i-r-1) .GE. 1) then
            nei= nei+a(i-r-1)
        endif
        if((i-r+1) .GE. 1) then
            nei= nei+a(i-r+1)
        endif
        if((i+r-1) .LE. (r*c)) then
            nei= nei+a(i+r-1)
        endif
        if((i+r+1) .LE. (r*c)) then
            nei= nei+a(i+r+1)
        endif
        if(a(i)==0) then
            if(nei==3) then
                b(i)=1
            endif
        else
            if(.NOT. (nei .LT. 2) .AND. .NOT. (nei .GT. 3)) then
                b(i)=a(i)
            endif
        endif
    end do
    m = (gen-1)
    write(*,*) "recursive ", m
    do i = 1, r*c
        if (modulo(i-1,r)==0) then
            write(*,*)
        endif
        if(b(i) .eq. 0) then
            write(*,"(1x, A)",advance="no") " "
        else
            write(*,"(1x, A)",advance="no") "o"
        endif
    end do
    write(*,*)
    if(m .NE. 0) then
        call live(b,r,c,m)
    endif
end subroutine live 