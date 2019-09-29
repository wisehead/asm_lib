nasm -f macho hello32.asm
ld -macosx_version_min 10.7.0 -o hello32 hello32.o
./hello32

