wgetV="1.21.3"
cp version.c.new ~/wget/wget-${wgetV}/src/version.c
cd ~/wget/wget-${wgetV}/src
rm version.o
rm main.o
#rm wget.exe

x86_64-w64-mingw32-gcc -DSYSTEM_WGETRC=\"D:/Tools/.wgetrc\" -DHAVE_CONFIG_H -I. -I../lib -DHAVE_LIBSSL -I../../build/include -DCARES_STATICLIB=1 -DPCRE2_STATIC=1 -DNDEBUG -O3 -march=x86-64 -mtune=generic -MT main.o -MD -MP -MF $depbase.Tpo -c -o main.o main.c

x86_64-w64-mingw32-gcc -DHAVE_CONFIG_H -I. -I../lib -DHAVE_LIBSSL -I../../build/include -DCARES_STATICLIB=1 -DPCRE2_STATIC=1 -DNDEBUG -O3 -march=x86-64 -mtune=generic -MT version.o -MD -MP -MF $depbase.Tpo -c -o version.o version.c

x86_64-w64-mingw32-gcc -O2 -march=x86-64 -mtune=generic -static -static-libgcc -s -o wget.exe connect.o convert.o cookies.o ftp.o css_.o css-url.o ftp-basic.o ftp-ls.o hash.o host.o hsts.o html-parse.o html-url.o http.o init.o log.o main.o netrc.o progress.o ptimer.o recur.o res.o retr.o spider.o url.o warc.o utils.o exits.o build_info.o iri.o metalink.o version.o ftp-opie.o mswindows.o openssl.o http-ntlm.o ../lib/libgnu.a -pthread -lidn2 -lpsl -lcares -lssl -lpcre2-8 -lmetalink -lexpat -lgpgme -lassuan -lgpg-error -lcrypto -lz -lcrypt32 -lunistring -liconv -lws2_32 -L../../build/lib 
#x86_64-w64-mingw32-gcc -O3 -march=x86-64 -mtune=generic -static -static-libgcc -s -o wget.exe connect.o convert.o cookies.o ftp.o css_.o css-url.o ftp-basic.o ftp-ls.o hash.o host.o hsts.o html-parse.o html-url.o http.o init.o log.o main.o netrc.o progress.o ptimer.o recur.o res.o retr.o spider.o url.o warc.o utils.o exits.o build_info.o iri.o metalink.o version.o ftp-opie.o mswindows.o openssl.o http-ntlm.o ../lib/libgnu.a -pthread -lidn2 -lpsl -lcares -lssl -lpcre2-8 -lmetalink -lexpat -lgpgme -lassuan -lgpg-error -lcrypto -lz -lcrypt32 -lunistring -liconv -lws2_32 -L../../build/lib 