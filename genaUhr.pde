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
#define lcdDisplay 4

//setup software serial port. 255 is a dummy port. only transmitting on 4
NewSoftSerial slcdDisplay(255,4);

void setup() {
  
  //declare pin modes
  pinMode(gpsRx,INPUT);
  pinMode(segDisplay, OUTPUT);
  pinMode(lcdDisplay, OUTPUT);
  
  Serial.begin(9600); //start hardware serial for GPS
  slcdDisplay.begin(9600); //start serial for lcdDisplay
  
  //reset LED display on initial startup
  Serial.print("v");
  
  //line 2 of the LCD. notes regarding this below
  slcdDisplay.print(0xfe, BYTE); slcdDisplay.print(0xc0, BYTE);
  slcdDisplay.print("UTC/GPS");
  slcdDisplay.print(0xfe, BYTE); slcdDisplay.print(0xc8, BYTE);
  slcdDisplay.print("genaUhr b1");
 
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
      unsigned long date, time;
      unsigned short sentences, failed_checksum;
      int year;
      byte month, day, hour, minute, second;

      //gps.get_datetime(&date, &time); //probably not necessary
      gps.crack_datetime(&year, &month, &day, &hour, &minute, &second);

      //print time to LED (hh:mm)
      Serial.print(int(hour)); Serial.print(0x77, BYTE); Serial.print(0x10, BYTE); Serial.print(int(minute));
      
      /*LED display <cursor position, display>
      
      <0-1, second, ss> <4-5, satellites in view> <9-19, date, YYYY-MM-DD>
      <64-70, UTC/GPS (print out)> <73~, genaUhr b1>
      
      send special character 254 then cursor position + 128
      
      LINE 2 is at void setup() in order to save resources as the second line is completely static
      */
      
      //line 1
      slcdDisplay.print(int(second));
      slcdDisplay.print(0xfe, BYTE); slcdDisplay.print(0x84, BYTE);
      slcdDisplay.print(gps.satellites());
      slcdDisplay.print(0xfe, BYTE); slcdDisplay.print(0x89, BYTE);
      slcdDisplay.print(year);
      slcdDisplay.print("-");
      slcdDisplay.print(int(month));
      slcdDisplay.print("-");
      slcdDisplay.print(int(day));
      
    } //end magic
  } //end while
} //end loop
