#include <fcgi_stdio.h>

int main() {
   while( FCGI_Accept() >= 0 ) {
      printf( "Content-Type: text/plain\n\n" );
      printf( "Hello World!\n" );
   }
  return 0;
}
