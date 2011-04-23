//SoftwareSerial library used for 7-segement and LCD display
#include <SoftwareSerial.h>

//might use TinyGPS, still up for grabs
/*#include "tinygps/TinyGPS.h"
TinyGPS gps;
*/

//declaring le *digital* pins to the units
//GPS module
int gpsRx = 0
//7-segment LED display
int segDisplay = 4
//16x2 LCD
int lcdDisplay = 7

//setup software serial ports
SoftwareSerial serial_segDisplay = SoftwareSerial(,4);
SoftwareSerial serial_lcdDisplay = SoftwareSerial(,7);

void setup() {
  
  //declare pin modes
  pinMode(gpsRx,INPUT);
  pinMode(segDisplay, OUTPUT);
  pinMode(lcdDisplay, OUTPUT);
  
  Serial.begin(9600); //start hardware serial for GPS
 
  

