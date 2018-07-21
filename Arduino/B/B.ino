
int bcount = 4;
int buttons[] = {2, 3, 5, 6};

int counters[] = {0, 0, 0, 0};
boolean states[] = {0, 0, 0, 0};

void setup() {

  Serial.begin(9600);
  while (!Serial);
  for (int i = 0; i < bcount; i++) {
    pinMode(buttons[i], INPUT_PULLUP);
  }
}

void loop() {
  updateButtonStates();
  
  
  if (checkButtonPressed(0)) {
    delay(1000);
  }
  if (checkButtonPressed(1)) {
    delay(1000);
  }
  if (checkButtonPressed(2)) {
    delay(1000);
  }
  if (checkButtonPressed(3)) {
    delay(1000);
  }


}

void updateButtonStates() {
  for (int i = 0; i < bcount; i++) {
    if (digitalRead(buttons[i]) == HIGH && !states[i]) {
      counters[i]++;
      states[i] = !states[i];
    } else if (digitalRead(buttons[i]) == LOW && states[i]) {
      counters[i]++;
      states[i] = !states[i];
    }
  }
}

boolean checkButtonPressed(int button) {
  if (counters[button] % 2 == 0 && counters[button] > 0) {
    Serial.write(button);
      counters[button] = 0;
      return true;
    }
    return false;

  }
