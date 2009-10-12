#include <ruby.h>
#include <unistd.h>

VALUE RProcFS = Qnil;

void Init_native();

void Init_native() {
  RProcFS = rb_define_class("RProcFS", rb_cObject);
  rb_define_const(RProcFS, "CLOCKS_PER_SEC", INT2FIX(sysconf(_SC_CLK_TCK)));
  rb_define_const(RProcFS, "MEMORY_PAGESIZE", INT2FIX(getpagesize()));
}
