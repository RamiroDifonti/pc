.data

matrix: .space 120
a: .float 1.5

.text

main:

li $v0,2
lwc1 $f12, a
syscall


li $v0,10

syscall