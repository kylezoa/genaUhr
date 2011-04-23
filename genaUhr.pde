/*

genaUhr.pde -- main Arduino sketch
                        _   _ _          
  __ _  ___ _ __   __ _| | | | |__  _ __ 
 / _` |/ _ \ '_ \ / _` | | | | '_ \| '__|
| (_| |  __/ | | | (_| | |_| | | | | |   
 \__, |\___|_| |_|\__,_|\___/|_| |_|_|   
 |___/ 

arduino GPS clock with a 7-segment and LCD display
license, copyright and more information can be found in the README

*/

//NewSoftwareSerial library used for LCD display
#include "lib/NewSoftwareSerial.h"

//might use TinyGPS, still up for grabs
/*#include "tinygps/TinyGPS.h"
TinyGPS gps;
*/

//declaring le *digital* pins to the units
//GPS module (serial TTL)
int gpsRx = 0
//7-segment LED display (serial TTL)
int segDisplay = 1
//16x2 LCD
int lcdDisplay = 7

//setup software serial ports
NewSoftwareSerial serial_lcdDisplay = SoftwareSerial(,4);

void setup() {
  
  //declare pin modes
  pinMode(gpsRx,INPUT);
  pinMode(segDisplay, OUTPUT);
  pinMode(lcdDisplay, OUTPUT);
  
  Serial.begin(9600); //start hardware serial for GPS
  serial_lcdDisplay.begin(9600); //start serial for lcdDisplay
  
}
