// =============================================== //
// Nolan Delligatta                                //
// CPSC 240-03                                     //
// ndelligatta@csu.fullerton.edu                   //
// Force Calculator                                //
// =============================================== //
#include <stdio.h>
double force();
int main(int argc, char** argv) {
  double result_code = -99.99;
  printf("This is Final exam by Nolan Delligatta\n");
  result_code = force();
  printf("The main program recieved %.2lf and will just keep it.\n", result_code);
  printf("Have a nice day\n");
  return 0;
}