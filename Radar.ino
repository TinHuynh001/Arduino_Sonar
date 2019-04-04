//Servo motor working.


#include <Servo.h>

const int delaySensor = 28; 

//left sensor
const int trigPin1 = 9;
const int echoPin1 = 8;
//right sensor
const int trigPin2 = 11;
const int echoPin2 = 10;
//servo
const int servoPin = 12;

long duration;
int distance;

Servo myServo;

void setup() {
  //SERVO
  myServo.attach(servoPin);
  //myServo.write(90);
  
  pinMode(trigPin1, OUTPUT);
  pinMode(echoPin1, INPUT);
  pinMode(trigPin2, OUTPUT);
  pinMode(echoPin2, INPUT);
  Serial.begin(9600);
  
  delay(10000);

}

void loop() {
  // put your main code here, to run repeatedly:

  for (int i =160; i>= 20; i--)
  {
    myServo.write(i);
    delay(30);
    Serial.print(i); // Sends the current degree into the Serial Port
  Serial.print(","); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
  
    calculateDistance(trigPin1, echoPin1);
  //Serial.println("Sensor 1: ");
  //Serial.print(" ");
  Serial.print(distance);
  
  Serial.print("-");

  calculateDistance(trigPin2, echoPin2);
  //Serial.println("Sensor 2: ");
  //Serial.print(duration);
  //Serial.print(" ");
  Serial.print(distance);
  
  Serial.print("."); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
  delay(14);
  }

  //spin back
  for(int i = 20; i <= 160; i++)
  {
    myServo.write(i);
    delay(30);
    
  Serial.print(i); 
  Serial.print(",");

  calculateDistance(trigPin1, echoPin1);
  Serial.print(distance);
  
  Serial.print("-");

  calculateDistance(trigPin2, echoPin2);
  Serial.print(distance);
  
  Serial.print(".");

  delay(14);
  }


  
}


int calculateDistance(int trigPin, int echoPin)
{   
  duration =0;
  distance =0;
  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  
  duration = pulseIn(echoPin, HIGH); // Reads the echoPin, returns the sound wave travel time in microseconds
  delay(delaySensor);
  distance= (duration/2)*0.0343;
  return distance;
}

