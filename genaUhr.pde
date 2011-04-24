/*

genaUhr.pde -- main Arduino sketch
THIS CODE IS UNTESTED AND WRITTEN FROM 'THEORY'
DO NOT USE
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
#include <NewSoftSerial.h>

//TinyGPS to make data manipulation and later expansion easier
#include <TinyGPS.h>
TinyGPS gps;

//declaring le *digital* pins to the units
//GPS module (serial TTL)
#define gpsRx 0
//7-segment LED display (serial TTL)
#define segDisplay 1
//16x2 LCD
#define lcdDisplay 7

//setup software serial ports
NewSoftSerial serial_lcdDisplay(255,4);

void setup() {
  
  //declare pin modes
  pinMode(gpsRx,INPUT);
  pinMode(segDisplay, OUTPUT);
  pinMode(lcdDisplay, OUTPUT);
  
  Serial.begin(9600); //start hardware serial for GPS
  serial_lcdDisplay.begin(9600); //start serial for lcdDisplay
  
  //reset LED display on initial startup
  Serial.print("v");
  
}

//start the long ass loop
void loop() {
  //init tinygps magic
  while (Serial.available())
  {
    int c = Serial.read();
    if (gps.encode(c))
    { //start the real magic
      
      //grab time and date information      
      unsigned long date, time, chars;
      int year;
      byte month, day, hour, minute, second;

      gps.get_datetime(&date, &time);

      //gps.crack_datetime(&hour, &minute, &year, &month, &day, &second); //separating hhmm from ss in order to easily print to LED

      gps.crack_datetime(&year, &month, &day, &hour, &minute, &second);

      //print time to LED
      Serial.print(time);
    } //end magic
  } //end while
} //end loop
