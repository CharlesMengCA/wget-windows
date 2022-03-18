#!/bin/bash
clear
echo $0 $@

#
# wget build script for Windows environment
# Author: WebFolder
# https://webfolder.io
# March 15, 2021

# https://ftp.gnu.org/gnu/wget/?C=M;O=D
wgetV="1.21.3"

# https://gmplib.org/
gmpV="6.2.1"

# https://ftp.gnu.org/gnu/nettle/?C=M;O=D
nettleV="3.7.3"

# https://ftp.gnu.org/gnu/libtasn1/?C=M;O=D
libtasn1V="4.18.0"

# https://ftp.gnu.org/gnu/libidn/?C=M;O=D
libidn2V="2.3.0"
# 2.3.1, 2.3.2 couldn't compile

# https://ftp.gnu.org/gnu/libunistring/?C=M;O=D
libunistringV="1.0"

# https://c-ares.org/download/
caresV="1.17.2"
# 1.18.1 couldn't compile

# https://ftp.gnu.org/gnu/libiconv/?C=M;O=D
iconV="1.16"

# https://github.com/rockdaboot/libpsl/releases
pslV="0.21.1"

# https://github.com/PhilipHazel/pcre2/releases
pcre2V="10.39"

# https://www.gnupg.org/ftp/gcrypt/libgpg-error/
gpgErrorV="1.44"

# https://www.gnupg.org/ftp/gcrypt/libassuan/
assuanV="2.5.5"

# https://gnupg.org/ftp/gcrypt/gpgme/
gpgmeV="1.17.1"

# https://github.com/libexpat/libexpat/releases
expatV="2.4.7"

# https://github.com/metalink-dev/libmetalink/releases
metalinkV="0.1.3"

# https://zlib.net/
zlibV="1.2.11"

# https://www.openssl.org/source/
opensslV="1.1.1n"

PATCH_PATH=$PWD

sudo apt-get install -y mingw-w64 python make m4 pkg-config automake gettext wget

cd ~
mkdir wget
export BUILD_ROOT=~/wget

set -x #echo on

cd $BUILD_ROOT

mkdir build
export INSTALL_PATH=$PWD/build
# -----------------------------------------------------------------------------
# build gmp
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libgmp.a ]; then
	wget https://gmplib.org/download/gmp/gmp-${gmpV}.tar.xz
	tar -xf gmp-${gmpV}.tar.xz 
	cd gmp-${gmpV}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[gmp] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[gmp] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[gmp] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build nettle
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libnettle.a ]; then
	wget https://ftp.gnu.org/gnu/nettle/nettle-${nettleV}.tar.gz
	tar -xf nettle-${nettleV}.tar.gz
	cd nettle-${nettleV}
	CFLAGS="-I$INSTALL_PATH/include" \
	LDFLAGS="-L$INSTALL_PATH/lib" \
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--disable-documentation \
	--prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[nettle] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[nettle] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[nettle] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build tasn
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libtasn1.a ]; then
	wget https://ftp.gnu.org/gnu/libtasn1/libtasn1-${libtasn1V}.tar.gz
	tar -xf libtasn1-${libtasn1V}.tar.gz
	cd libtasn1-${libtasn1V}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--disable-doc \
	--prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[tasn] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[tasn] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[tasn] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build idn2
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libidn2.a ]; then
	wget https://ftp.gnu.org/gnu/libidn/libidn2-${libidn2V}.tar.gz
	tar -xf libidn2-${libidn2V}.tar.gz
	cd libidn2-${libidn2V}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--disable-doc \
	--prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[idn2] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[idn2] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[idn2] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build unistring
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libunistring.a ]; then
	wget https://ftp.gnu.org/gnu/libunistring/libunistring-${libunistringV}.tar.gz
	tar -xf libunistring-${libunistringV}.tar.gz
	cd libunistring-${libunistringV}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[unistring] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[unistring] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[unistring] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build cares
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libcares.a ]; then
	wget https://c-ares.haxx.se/download/c-ares-${caresV}.tar.gz
	tar -xf c-ares-${caresV}.tar.gz
	cd c-ares-${caresV}
	CPPFLAGS="-DCARES_STATICLIB=1" \
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static \
	--disable-tests \
	--disable-debug
	(($? != 0)) && { printf '%s\n' "[cares] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[cares] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[cares] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build iconv
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libiconv.a ]; then
	wget https://ftp.gnu.org/gnu/libiconv/libiconv-${iconV}.tar.gz
	tar -xf libiconv-${iconV}.tar.gz
	cd libiconv-${iconV}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static
	(($? != 0)) && { printf '%s\n' "[iconv] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[iconv] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[iconv] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build psl
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libpsl.a ]; then
	wget https://github.com/rockdaboot/libpsl/releases/download/${pslV}/libpsl-${pslV}.tar.gz
	tar -xf libpsl-${pslV}.tar.gz
	cd libpsl-${pslV}
	CFLAGS="-I$INSTALL_PATH/include" \
	LIBS="-L$INSTALL_PATH/lib -lunistring -lidn2" \
	LIBIDN2_CFLAGS="-I$INSTALL_PATH/include" \
	LIBIDN2_LIBS="-L$INSTALL_PATH/lib -lunistring -lidn2" \
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static \
	--disable-gtk-doc \
	--enable-builtin=libidn2 \
	--enable-runtime=libidn2 \
	--with-libiconv-prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[psl] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[psl] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[psl] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build pcre2
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libpcre2-8.a ]; then
	wget https://github.com/PhilipHazel/pcre2/releases/download/pcre2-${pcre2V}/pcre2-${pcre2V}.tar.gz
	#wget https://ftp.pcre.org/pub/pcre/pcre2-${pcre2V}.tar.gz
	tar -xf pcre2-${pcre2V}.tar.gz
	cd pcre2-${pcre2V}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static
	(($? != 0)) && { printf '%s\n' "[pcre2] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[pcre2] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[pcre2] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build gpg-error
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libgpg-error.a ]; then
	wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${gpgErrorV}.tar.gz
	tar -xf libgpg-error-${gpgErrorV}.tar.gz
	cd libgpg-error-${gpgErrorV}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static \
	--disable-doc
	(($? != 0)) && { printf '%s\n' "[gpg-error] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[gpg-error] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[gpg-error] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build assuan
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libassuan.a ]; then
	wget https://gnupg.org/ftp/gcrypt/libassuan/libassuan-${assuanV}.tar.bz2
	tar -xf libassuan-${assuanV}.tar.bz2
	cd libassuan-${assuanV}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static \
	--disable-doc \
	--with-libgpg-error-prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[assuan] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[assuan] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[assuan] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build gpgme
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libgpgme.a ]; then
	wget https://gnupg.org/ftp/gcrypt/gpgme/gpgme-${gpgmeV}.tar.bz2
	tar -xf gpgme-${gpgmeV}.tar.bz2 
	cd gpgme-${gpgmeV}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static \
	--with-libgpg-error-prefix=$INSTALL_PATH \
	--disable-gpg-test \
	--disable-g13-test \
	--disable-gpgsm-test \
	--disable-gpgconf-test \
	--disable-glibtest \
	--with-libassuan-prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[gpgme] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[gpgme] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[gpgme] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build expat
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libexpat.a ]; then
	wget https://github.com/libexpat/libexpat/releases/download/R_${expatV//\./_}/expat-${expatV}.tar.gz
	tar -xf expat-${expatV}.tar.gz
	cd expat-${expatV}
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static \
	--without-docbook \
	--without-tests \
	--with-libgpg-error-prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[expat] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[expat] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[expat] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build metalink
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libmetalink.a ]; then
	wget https://github.com/metalink-dev/libmetalink/releases/download/release-${metalinkV}/libmetalink-${metalinkV}.tar.gz
	tar -xf libmetalink-${metalinkV}.tar.gz
	cd libmetalink-${metalinkV}
	EXPAT_CFLAGS="-I$INSTALL_PATH/include" \
	EXPAT_LIBS="-L$INSTALL_PATH/lib -lexpat" \
	./configure \
	--host=x86_64-w64-mingw32 \
	--disable-shared \
	--prefix=$INSTALL_PATH \
	--enable-static \
	--with-libgpg-error-prefix=$INSTALL_PATH \
	--with-libexpat
	(($? != 0)) && { printf '%s\n' "[metalink] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[metalink] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[metalink] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build zlib
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libz.a ]; then
	wget https://zlib.net/zlib-${zlibV}.tar.gz
	tar -xf zlib-${zlibV}.tar.gz
	cd zlib-${zlibV}
	CC=x86_64-w64-mingw32-gcc ./configure --64 --static --prefix=$INSTALL_PATH
	(($? != 0)) && { printf '%s\n' "[zlib] configure failed"; exit 1; }
	make
	(($? != 0)) && { printf '%s\n' "[zlib] make failed"; exit 1; }
	make install
	(($? != 0)) && { printf '%s\n' "[zlib] make install"; exit 1; }
	cd $BUILD_ROOT
fi
# -----------------------------------------------------------------------------
# build openssl
# -----------------------------------------------------------------------------
if [ ! -f $INSTALL_PATH/lib/libssl.a ]; then
	wget https://www.openssl.org/source/openssl-${opensslV}.tar.gz
	tar -xf openssl-${opensslV}.tar.gz
	cd openssl-${opensslV}
	./Configure \
		--static \
		-static \
		--prefix=$INSTALL_PATH \
		--cross-compile-prefix=x86_64-w64-mingw32- \
		mingw64 \
		no-shared \
		enable-asm \
		no-tests \
		--with-zlib-include=$INSTALL_PATH \
		--with-zlib-lib=$INSTALL_PATH/lib/libz.a
	make
	make install_sw
	cd $BUILD_ROOT
fi
cp /usr/x86_64-w64-mingw32/lib/libbcrypt.a $INSTALL_PATH/lib/

wget https://ftp.gnu.org/gnu/wget/wget-${wgetV}.tar.gz
tar -xf wget-${wgetV}.tar.gz
cd wget-${wgetV}

#patch src/wget.h < $PATCH_PATH/wget-1.21-2gb-win.patch
patch src/openssl.c < $PATCH_PATH/openssl-windows-cert-store.patch
pwd
#patch -p1 < $PATCH_PATH/taskbar-progress.patch

# -----------------------------------------------------------------------------
# build wget (openssl)
# -----------------------------------------------------------------------------

make clean
patch src/openssl.c < $PATCH_PATH/windows-openssl.diff

CFLAGS="-I$INSTALL_PATH/include -DCARES_STATICLIB=1 -DPCRE2_STATIC=1 -DNDEBUG -O3 -march=x86-64 -mtune=generic" \
 LDFLAGS="-L$INSTALL_PATH/lib -static -static-libgcc -s" \
 OPENSSL_CFLAGS=$CFLAGS \
 OPENSSL_LIBS="-L$INSTALL_PATH/lib -lcrypto -lssl" \
 LIBPSL_CFLAGS=$CFLAGS \
 LIBPSL_LIBS="-L$INSTALL_PATH/lib -lpsl" \
 CARES_CFLAGS=$CFLAGS \
 CARES_LIBS="-L$INSTALL_PATH/lib -lcares" \
 PCRE2_CFLAGS=$CFLAGS \
 PCRE2_LIBS="-L$INSTALL_PATH/lib -lpcre2-8"  \
 METALINK_CFLAGS="-I$INSTALL_PATH/include" \
 METALINK_LIBS="-L$INSTALL_PATH/lib -lmetalink -lexpat" \
 LIBS="-L$INSTALL_PATH/lib -lidn2 -lpsl -lcares -lunistring -liconv -lpcre2-8 -lmetalink -lexpat -lgpgme -lassuan -lgpg-error -lcrypto -lssl -lz -lcrypt32" \
 ./configure \
 --host=x86_64-w64-mingw32 \
 --prefix=$INSTALL_PATH \
 --disable-debug \
 --disable-valgrind-tests \
 --enable-iri \
 --enable-pcre2 \
 --with-ssl=openssl \
 --with-included-libunistring \
 --with-libidn \
 --with-cares \
 --with-libpsl \
 --with-metalink \
 --with-openssl \
 --with-gpgme-prefix=$INSTALL_PATH
(($? != 0)) && { printf '%s\n' "[wget openssl] configure failed"; exit 1; }
make
(($? != 0)) && { printf '%s\n' "[wget openssl] make failed"; exit 1; }
make install
(($? != 0)) && { printf '%s\n' "[wget openssl] make install"; exit 1; }
mkdir $INSTALL_PATH/wget-openssl
cp $INSTALL_PATH/bin/wget.exe $INSTALL_PATH/wget-openssl
x86_64-w64-mingw32-strip $INSTALL_PATH/wget-openssl/wget.exe
