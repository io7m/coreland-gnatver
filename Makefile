# auto generated - do not edit

default: all

all:\
UNIT_TESTS/gv_test UNIT_TESTS/gv_test.ali UNIT_TESTS/gv_test.o gnatver.ali \
gnatver.o

# Mkf-test
tests:
	(cd UNIT_TESTS && make)
tests_clean:
	(cd UNIT_TESTS && make clean)

UNIT_TESTS/gv_test:\
ada-bind ada-link UNIT_TESTS/gv_test.ald UNIT_TESTS/gv_test.ali gnatver.ali
	./ada-bind UNIT_TESTS/gv_test.ali
	./ada-link UNIT_TESTS/gv_test UNIT_TESTS/gv_test.ali

UNIT_TESTS/gv_test.ali:\
ada-compile UNIT_TESTS/gv_test.adb gnatver.ali
	./ada-compile UNIT_TESTS/gv_test.adb

UNIT_TESTS/gv_test.o:\
UNIT_TESTS/gv_test.ali

ada-bind:\
conf-adabind conf-systype conf-adatype conf-adabflags conf-adafflist flags-cwd

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist flags-cwd

ada-link:\
conf-adalink conf-adatype conf-systype conf-adaldflags

ada-srcmap:\
conf-adacomp conf-adatype conf-systype

ada-srcmap-all:\
ada-srcmap conf-adacomp conf-adatype conf-systype

cc-compile:\
conf-cc conf-cctype conf-systype

cc-link:\
conf-ld conf-ldtype conf-systype

cc-slib:\
conf-systype

conf-adatype:\
mk-adatype
	./mk-adatype > conf-adatype.tmp && mv conf-adatype.tmp conf-adatype

conf-cctype:\
conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld mk-ldtype
	./mk-ldtype > conf-ldtype.tmp && mv conf-ldtype.tmp conf-ldtype

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

gnatver.ali:\
ada-compile gnatver.adb gnatver.ads
	./ada-compile gnatver.adb

gnatver.o:\
gnatver.ali

mk-adatype:\
conf-adacomp conf-systype

mk-cctype:\
conf-cc conf-systype

mk-ctxt:\
mk-mk-ctxt
	./mk-mk-ctxt

mk-ldtype:\
conf-ld conf-systype conf-cctype

mk-mk-ctxt:\
conf-cc conf-ld

mk-systype:\
conf-cc conf-ld

clean-all: tests_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f UNIT_TESTS/gv_test UNIT_TESTS/gv_test.ali UNIT_TESTS/gv_test.o \
	gnatver.ali gnatver.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
