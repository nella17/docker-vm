set history filename ~/.gdb_history
set disassembly-flavor intel
set print asm-demangle on

define peda
  source ~/peda/peda.py
  pset option autosave 'off'
end

define gef
  source ~/.gdbinit-gef.py
end

define pwndbg-init
  source ~/pwndbg/gdbinit.py
end

define ta
  target remote localhost:1234
end

define bmain
  si
  ni
  tb __libc_start_main
  c
  b *($rdi)
  c
end
