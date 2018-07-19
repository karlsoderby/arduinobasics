
#include <Servo.h>

Servo myservo;


int sensorPin = A0;
int val;  
int ledPin = 2;  
int ledPin2 = 3;
int ledPin3 = 4;
// select the pin for the LED
int sensorValue = 0;  // variable to store the value coming from the sensor

void setup() {
  
  myservo.attach(9);
  
  pinMode(ledPin, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  pinMode(ledPin3, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  val = analogRead(sensorPin);            // reads the value of the potentiometer (value between 0 and 1023)
  val = map(val, 0, 1023, 40, 90);     // scale it to use it with the servo (value between 0 and 180)

  
  

 
  // sets the servo position according to the scaled value
     
 
  
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
  Serial.println(sensorValue);

  if(sensorValue > 850) {
  myservo.write(93);
  }
  else{
  myservo.write(val);  
  }
  if(sensorValue < 800) {
  digitalWrite(ledPin, HIGH);
  }
  else{
  digitalWrite(ledPin, LOW);
  }
  
  if(sensorValue < 600) {
  digitalWrite(ledPin2, HIGH);

  }
  else{
  digitalWrite(ledPin2, LOW);
  }

   if(sensorValue < 400) {
  digitalWrite(ledPin3, HIGH);
  }
  else{
  digitalWrite(ledPin3, LOW);
  }
  
}
