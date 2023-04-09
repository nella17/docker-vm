set history filename ~/.gdb_history
set disassembly-flavor intel
set print asm-demangle on
set output-radix 16

define gef
  source /opt/gdbinit-gef.py
end

define pwndbg-init
  source /opt/pwndbg/gdbinit.py
end

define splitmind
  source /opt/splitmind/gdbinit.py
  python
import splitmind
(splitmind.Mind()
  .tell_splitter(show_titles=True)
  .tell_splitter(set_title="Main")
  .right(display="backtrace", size="25%")
  .above(of="main", display="disasm", size="80%", banner="top")
  .show("code", on="disasm", banner="none")
  .right(cmd='tty; tail -f /dev/null', size="65%", clearing=False)
  .tell_splitter(set_title='Input / Output')
  .above(display="stack", size="75%")
  .above(display="legend", size="25")
  .show("regs", on="legend")
  .below(of="backtrace", cmd="python", size="30%")
).build(nobanner=True)
  end
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

