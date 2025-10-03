Rat
A minimal Linux x86-64 "cat clone" in pure assembly.
Reads a file and writes it to stdout, with an error message on failure.

Install:
```sh
gcc -nostdlib -no-pie rat.s -o rat
```
./rat <filename>

or

```sh
as --64 -o rat.o rat.s
ld -o rat rat.o
```
./rat <filename>

