//Basic radar display completed
//Beam demo completed
//Serial input read and parsed correctly
// !!! Do NOT run this with Serial Monitor running, will cause Port busy error.

import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

final int WIDTH = 1024;
final int HEIGHT = 768;
final int PORT_NO = 9600;
final String PORT = "COM4";

final float MAX_DISTANCE = 80;
final float SENSOR_SPACING = 7;
final float ANGLE_SENSOR1 = 12;
final float ANGLE_SENSOR2 = 10;
float CM_TO_PIX;

Serial myPort;
String angle = "";
String distance1 = "";
String distance2 = "";
String input ="";

int iAngle;
int iDistance1;
int iDistance2;

//Ints to store index numbers of separators in our serial data stream.
//The format is [degree],[sensor1Dist]-[sensor2Dist]
//So index1 would be for the "," and index2 for the "-"
int index1;
int index2;

void settings()
{
  size(WIDTH, HEIGHT);
}


void setup()
{
  CM_TO_PIX =  (500 / MAX_DISTANCE);
  System.out.println(CM_TO_PIX);
  //background(0);
  //noStroke();

  myPort = new Serial(this, PORT, PORT_NO);
  myPort.bufferUntil('.');
}

void draw()
{
  System.out.println("Parse:");
  System.out.println("Degree: " + iAngle);
  System.out.println("Sensor 1: " + iDistance1);
  System.out.println("Sensor 2: " + iDistance2);
  
    
  noStroke();
  fill(0,2.5);
  rect(0,0, WIDTH, HEIGHT);
  
  translate(WIDTH/2,HEIGHT-100);
    
  drawRadar();
  drawBeam();
}

//background
void drawRadar()
{
  pushMatrix();
  
  noFill();
  stroke(98, 245, 31);
  
  
  arc(0, 0, 1000, 1000, PI, TWO_PI);
  line(-WIDTH/2,0, WIDTH/2,0);
  
  translate(-50, -510);
  textSize(25);
  fill(98, 245, 31);
  text(MAX_DISTANCE + "cm",0,0);
  
  
  popMatrix();
}

//draw the sensor distance results as a line/beam
void drawBeam()
{
  pushMatrix();
  
  strokeWeight(2);
  stroke(98,245,31);
  
  rotate(radians(iAngle-180));
  //line(0, 0, 75*CM_TO_PIX,0);
  
  pushMatrix();
  line(0, 0, 0, -SENSOR_SPACING*CM_TO_PIX/2);
  translate(0, -SENSOR_SPACING*CM_TO_PIX/2);
  rotate(radians(ANGLE_SENSOR1));
  line(0, 0, iDistance1* CM_TO_PIX,0);
  popMatrix();
  
  pushMatrix();
  line(0, 0, 0, SENSOR_SPACING*CM_TO_PIX/2);
  translate(0, SENSOR_SPACING*CM_TO_PIX/2);
  rotate(radians(-ANGLE_SENSOR2));
  line(0, 0, iDistance2* CM_TO_PIX,0);
  popMatrix();
  
  
  popMatrix();
}


void serialEvent(Serial myPort)
{
  //the sensor output is written in the format [degree],[sensor1Dist]-[sensor2Dist]
  //first we read the input until we hit the end '.'
 input = myPort.readStringUntil('.');
 input = input.substring(0, input.length()-1); //trim the '.'
 
 //except for these separators we explicit put into the data input
 //the data contains only numbers, so we dont have to worry about duplicates
 index1 = input.indexOf(',');
 index2 = input.indexOf('-');
 
 //now we can use substring to "cut" the data for the angle and distances
 angle = input.substring(0, index1);
 distance1 = input.substring(index1 +1, index2);
 distance2 = input.substring(index2 +1, input.length());
 
 iAngle = int (angle);
 iDistance1 = int (distance1);
 iDistance2 = int (distance2);
 if(iDistance1 > MAX_DISTANCE)
 {
   iDistance1 = (int) MAX_DISTANCE;
 }
 if(iDistance2 > MAX_DISTANCE)
 {
   iDistance2 = (int) MAX_DISTANCE;
 }
}
