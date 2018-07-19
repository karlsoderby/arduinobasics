int photoPin = A0;
int ledPin = 2;
int photoValue = 0;

void setup() {
  
  pinMode(ledPin, OUTPUT);

}

void loop() {

photoValue = analogRead(photoPin);
Serial.println(photoValue);

if(photoValue > 700) {
digitalWrite(ledPin, HIGH);
delay(3000);
digitalWrite(ledPin, LOW);  
}


}
