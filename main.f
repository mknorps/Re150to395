      program inputRe395

c	program for prepering initial velocity field for fluid
c	at Re=395 for LES


      integer n,m,o,m2,o2, psteps
      real*8 time
      parameter (n=32,m=64,o=32,m2=m/2,o2=o/2)

      real*8 u(0:n,0:m2-1, -o2+1:o2-1,4,2)
      real*8 p(0:n,0:m2-1, -o2+1:o2-1,2)

      integer nn,mn,on !new number of mesh points
      parameter (nn=64, mn=128, on=64)
      real*8 un(0:nn,0:mn/2-1, -on/2+1:on/2-1,4,2)
      real*8 pn(0:nn,0:mn/2-1, -on/2+1:on/2-1,2)

      integer j,k,l,comp

      un = 0.0d0
      pn = 0.0d0

      open(unit=3,file='velocityfield_2600_LES_Re150', 
     &            form='unformatted') 
      read(3)psteps
      read(3)time
      read(3)u
      read(3)p
      close(3)

       write(*,*) psteps, time	

      do j=0,nn
         do k=0,m2-1
            do l=-o2+1,o2-1
               do comp=1,4
               un(j,k,l,comp,1) = u(j/2,k,l,comp,1)
               un(j,k,l,comp,2) = u(j/2,k,l,comp,2)
               enddo
               pn(j,k,l,1)      = p(j/2,k,l,1)
               pn(j,k,l,2)      = p(j/2,k,l,2)
	     enddo
	 enddo
      enddo


      open(unit=35,file='velocityfield_LES_Re395',form='unformatted') 
      write(35)psteps
      write(35)time
      write(35)un
      write(35)pn
      close(35)


      end
