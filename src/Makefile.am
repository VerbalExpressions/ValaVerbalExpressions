## Process this file with automake to produce Makefile.in

## Created by Anjuta

AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(pkgdatadir)"\" \
	$(libverbex_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

lib_LTLIBRARIES = libverbex.la

vapidir = $(datadir)/vala/vapi
dist_vapi_DATA = libverbex-0.1.vapi libverbex-0.1.deps

libverbex_la_SOURCES = libverbex.vala

libverbex_la_LDFLAGS = 
	
libverbex_la_VALAFLAGS =  \
	--library libverbex-0.1 --vapi libverbex-0.1.vapi -H libverbex.h

libverbex_la_LIBADD = $(libverbex_LIBS)


if PLATFORM_WIN32
libverbex_la_LDFLAGS += -no-undefined
endif

if NATIVE_WIN32
libverbex_la_LDFLAGS += -export-dynamic
endif

libverbexincludedir = $(includedir)/libverbex-0.1
libverbexinclude_HEADERS = \
	libverbex.h

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = libverbex-0.1.pc

EXTRA_DIST = \
	libverbex-0.1.pc.in
