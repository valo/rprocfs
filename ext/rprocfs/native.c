#include "ruby.h"
#include "time.h"

VALUE RProcFS = Qnil;

void Init_rprocfs();

VALUE method_memory_pagesize(VALUE self);

void Init_rprocfs() {
  RProcFS = rb_define_class("RProcFS", rb_cObject);
  rb_define_const(RProcFS, "CLOCKS_PER_SEC", INT2FIX(CLOCKS_PER_SEC));
}
