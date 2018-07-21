import processing.serial.*;
PImage earth; 
PShape globe;

PGraphics canvas;

float nbrOfStars=width/2.5; // Number of stars
float starVal; // Used as star counter
ArrayList<Star> starArr = new ArrayList<Star>(); // Array of stars


String enviroment = "ENV";
String enviromentFull = "Miljö";
String enviromentExp = "Miljö nivå";

String peace = "PCE";
String peaceFull = "Fred";
String peaceExp = "Freds nivå";

String ekonomy = "EKO";
String ekonomyFull = "Ekonomi";
String ekonomyExp = " Ekonomi nivå";

int restartButtonPresses = 2;
String restartText = "Tryck en knapp " +restartButtonPresses +" gånger för att starta om";
String gameNameText = "Spela";
String gameDescText = "I detta spelet gör du hela världen utifrån en följd av frågor du kommer ställas och som kräver att du tar ett av flera beslut du kan välja från. De tre olika mätarna för miljö, fred, och ekonomi kommer påverkas olika och kommer reflektera din ställning och prioriteringar i olika globala politiska frågor. Vad som är viktigt att tänka på är alternativkostnad som innebär att om man väljer att prioritera ett alternativ, väljer man indirekt att ha mindre av dem andra alternativen.";
String oneplayerText = "Spela";
String twoplayerText = "";



IntList currentQuestions = IntList.fromRange(1, 11);
int menu = 0;
int currentQuestion;
int questionCounter = 0;
int maxQuestions = 10;

float MAX_HEALTH = 20;
float p1_enviroment = MAX_HEALTH/2;
float p1_peace = MAX_HEALTH/2;
float p1_ekonomy = MAX_HEALTH/2;


float m1_enviroment = MAX_HEALTH/2;
float m1_peace = MAX_HEALTH/2;
float m1_ekonomy = MAX_HEALTH/2;

long time = 0;
long time1 = 0;

long maxTime = 5*60*1000;
long maxTime1 = 10*1000;

Serial myPort;

void setup() { 
  size(800, 600, P3D); 
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600); 
  //PFont f  = createFont("Arial",16,true);
  //textFont(f,16);        

  //noSmooth();
  surface.setResizable(true);
  background(0); 


  noStroke();
  textureMode(IMAGE);
  /* https://visibleearth.nasa.gov/view.php?id=55167 */
  earth = loadImage("earth_lights_lrg.jpg");


  noFill(); 

  presetup();

  while (starVal<nbrOfStars) {
    createNewStar();
    starVal++;
  }
  m1_enviroment = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
  m1_peace = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
  m1_ekonomy = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
  resetGame();
  time1 = millis();
}

void serialEvent(Serial p) { 
  int value = p.read();
  println(value);
  if(value == 3){
    pressButton(0);
  }else if(value == 2){
    pressButton(1);
  }else if(value == 0){
    pressButton(2);
  }else if(value == 1){
    pressButton(3);
  }
} 


int xUnit = width/6;
int yUnit = height/6;

int old_w = width;
int old_h = height;

void presetup() {
  canvas = createGraphics(width, height, P3D);
  globe = canvas.createShape(SPHERE, earth.width); 
  globe.setStroke(false);
  globe.setTexture(earth);
  ;
}

void draw() { 
  clear();
  if (old_w != width || old_h != height) {
    presetup();
    starVal = 0;
    nbrOfStars = width/2.5;
    starArr = new ArrayList<Star>(); 
    while (starVal<nbrOfStars) {
      createNewStar();
      starVal++;
    }
  }



  old_w = width;
  old_h = height;
  background(0, 0, 0);

  xUnit = width/6;
  yUnit = height/6;


  globe.rotateY(0.002f);


  canvas.beginDraw();
  canvas.clear();
  canvas.pushMatrix();
  canvas.translate(width/2, height/2, -earth.width*2.6);
  canvas.shape(globe);

  canvas.popMatrix();
  canvas.endDraw();
  /*   END EARTH   */

  createStars();

  image(canvas, 0, 0);

  if (menu == 0) {
    drawText(gameNameText);
    drawText2(gameDescText);

    drawHealth(m1_enviroment, m1_peace, m1_ekonomy);
    if (millis()-time1 > maxTime1) {
      m1_enviroment = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
      m1_peace = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
      m1_ekonomy = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
      time1 = millis();
    }
    drawAnswers2(oneplayerText);
    //drawAnswers("", "", oneplayerText, twoplayerText);
  } else if (menu == 1) {
    
    if(questionCounter == 0){
      drawQuestionCounter("Test fråga");
    }else{
       drawQuestionCounter(questionCounter + "/" + maxQuestions);
    }
    drawQuestion(questions[currentQuestion].question);
    drawHealth(p1_enviroment, p1_peace, p1_ekonomy);
    drawAnswers(questions[currentQuestion].answers);

    fill(9, 173, 6);
    float timeValue = 360-(360*((millis()-time) * 1.0 / maxTime));
    //println(timeValue, millis()-time);
    float value = map(timeValue, 0, 360, -90, 270);
    arc((xUnit*6)-xUnit/6, yUnit/3, xUnit/6, xUnit/6, radians(-90), radians(value), PIE);
    noFill();
    stroke(255, 255, 255);
    ellipse((xUnit*6)-xUnit/6, yUnit/3, xUnit/6, xUnit/6);
    noStroke();
    if (millis()-time > maxTime) {
      resetGame();
    }
  } else if (menu == 2) {
    int ending_env = endings_enviroment.length-1-round(map(p1_enviroment, 0f, MAX_HEALTH, 0f, float(endings_enviroment.length-1)));
    int ending_pce = endings_peace.length-1-round(map(p1_peace, 0f, MAX_HEALTH, 0f, float(endings_peace.length-1)));
    int ending_eko = endings_ekonomy.length-1-round(map(p1_ekonomy, 0f, MAX_HEALTH, 0f, float(endings_ekonomy.length-1)));
    
    
    drawTexts3(endings_enviroment[ending_env], endings_peace[ending_pce], endings_ekonomy[ending_eko]);
    drawHealth(p1_enviroment, p1_peace, p1_ekonomy);
  }
  
}

void resetGame() {
  currentQuestions = IntList.fromRange(1, questions.length);
  currentQuestions.shuffle(this);
  currentQuestions.resize(maxQuestions);
  currentQuestions.append(0);
  currentQuestion = currentQuestions.get(currentQuestions.size()-1);
   
  
  menu = 0;
  questionCounter = 0;

  p1_enviroment = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
  p1_peace = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
  p1_ekonomy = int(random(MAX_HEALTH/2-2, MAX_HEALTH/2+2));
  time = millis();
  time1 = millis();
}
int buttonCount = 0;
void pressButton(int button) {

  if (menu == 0) {

    if (button == 0) {
      resetGame();
      menu = 1;
    }
  } else if (menu == 1) {
    time = millis();
    Question now = questions[currentQuestion];
    if (button > now.answers.length-1) {
      println("TO HIGH");
      return;
    }

    p1_enviroment += now.enviroment[button];
    p1_peace += now.peace[button];
    p1_ekonomy += now.ekonomy[button];
    checkHealth();

    questionCounter++;
    println("Q + "+ questionCounter);
    if (questionCounter > maxQuestions) {
      menu = 2;
      return;
    }
    currentQuestions.remove(currentQuestions.size()-1);
    currentQuestion = currentQuestions.get(currentQuestions.size()-1);
  }else if(menu == 2){
    buttonCount++;
    if(buttonCount >= restartButtonPresses){
      resetGame();
      buttonCount = 0;
    }
  }
}

void checkHealth() {

  if (p1_enviroment > MAX_HEALTH) {
    p1_enviroment = MAX_HEALTH;
  }
  if (p1_peace > MAX_HEALTH) {
    p1_peace = MAX_HEALTH;
  }
  if (p1_ekonomy > MAX_HEALTH) {
    p1_ekonomy = MAX_HEALTH;
  }

  if (p1_enviroment < 0) {
    p1_enviroment = 0;
  }
  if (p1_peace < 0) {
    p1_peace = 0;
  }
  if (p1_ekonomy < 0) {
    p1_ekonomy = 0;
  }
}

void drawAnswers(String ... answers) {
  textAlign(CENTER, CENTER);
  if (answers.length > 4) {
    return;
  }
  color color4 = color(49, 165, 36, 180);
  color color3 = color(221, 109, 17, 180);
  color color2 = color(29, 122, 165, 180);
  color color1 = color(255, 238, 7, 180);
  

  int count = 0;

  int w = (42-int(map(answers[0].length(), 0, width/6, 8, 42)));
  textSize(w);

  if (answers[0] != "") {
    fill(color1);
    rect(xUnit, yUnit*3.7, xUnit*1.9, yUnit/1.1);
  }

  fill(255);
  text(answers[0], xUnit, yUnit*3.7, xUnit*1.9, yUnit/1.1);

  count++;
  if (count >= answers.length) {
    return;
  }
  w = (42-int(map(answers[1].length(), 0, width/6, 8, 42)));
  textSize(w);

  if (answers[1] != "") {
    fill(color2);
    rect(xUnit*3.1, yUnit*3.7, xUnit*1.9, yUnit/1.1);
  }
  fill(255);
  text(answers[1], xUnit*3.1, yUnit*3.7, xUnit*1.9, yUnit/1.1);

  count++;
  if (count >= answers.length) {
    return;
  }
  w = (42-int(map(answers[2].length(), 0, width/6, 8, 42)));
  textSize(w);

  if (answers[2] != "") {
    fill(color3);
    rect(xUnit, yUnit*4.7, xUnit*1.9, yUnit/1.1);
  }
  fill(255);
  text(answers[2], xUnit, yUnit*4.7, xUnit*1.9, yUnit/1.1);

  count++;
  if (count >= answers.length) {
    return;
  }
  w = (42-int(map(answers[3].length(), 0, width/6, 8, 42)));
  textSize(w);
  if (answers[3] != "") {
    fill(color4);
    rect(xUnit*3.1, yUnit*4.7, xUnit*1.9, yUnit/1.1);
  }
  fill(255);
  text(answers[3], xUnit*3.1, yUnit*4.7, xUnit*1.9, yUnit/1.1);
}

void drawAnswers2(String answer) {
  textAlign(CENTER, CENTER);

  color color1 = color(123, 129, 140, 180);
  ;
  if (menu == 0) {
    color1 = color(123, 166, 237, 180);
  }

  int w = (50-int(map(answer.length(), 0, width/6+answer.length(), 8, 50)));
  textSize(w);
  if (answer != "") {
    fill(color1);
    rect(xUnit*3-xUnit/2, yUnit*4.7, xUnit*1, yUnit/1.4);
  }
  fill(255);
  text(answer, xUnit*3-xUnit/2, yUnit*4.7, xUnit*1, yUnit/1.4);
}

void drawQuestion(String question) {

  int w = (64-int(map(question.length(), 0, width/5+question.length(), 8, 64)));
  textSize(w);

  textAlign(CENTER, CENTER);
  int standarH = yUnit/2;

  strokeText(question, xUnit, standarH, xUnit*4, yUnit*3);
  /*// Text box //
   noFill();
   stroke(255);
   rect(xUnit, standarH, xUnit*4, yUnit*3);
   noStroke();
  /* END text box */
}
void drawQuestionCounter(String question) {

  int w = (64-int(map(question.length(), 0, width/3+question.length(), 32, 64)));
  textSize(w);



  strokeText(question, xUnit, yUnit/6, xUnit*4, (yUnit/3)*2);
  /*// Text box //
   noFill();
   stroke(255, 0, 0);
   rect(xUnit, yUnit/6, xUnit*4, (yUnit/3)*2);
   noStroke();
  /* END text box */
}
void drawText(String question) {

  int w = (90-int(map(question.length(), 0, width/5+question.length(), 8, 90)));

  textSize(w);

  textAlign(CENTER, CENTER);
  int standarH = yUnit/3;

  strokeText(question, xUnit, standarH, xUnit*4, int(yUnit*1.2));
  /* //Text box 
   noFill();
   stroke(255);
   rect(xUnit, standarH, xUnit*4, int(yUnit*1.2));
   noStroke();
  /* END text box */
}
void drawTexts3(String question1, String question2, String question3) {

  textAlign(CENTER, CENTER);
  int standarH = yUnit/3;
  
  int w = (50-int(map(enviromentFull.length(), 0, xUnit*4+question1.length(), 8, 50)));
  textSize(w);
  strokeText(enviromentFull, int(xUnit*1.6), standarH/2, xUnit*4, standarH);
  
  
  textAlign(CENTER, TOP);
  w = (40-int(map(question1.length(), 0, xUnit*4+question1.length(), 8, 40)));
  textSize(w);
  strokeText(question1, int(xUnit*1.6), standarH+standarH/2, xUnit*4, int(yUnit*1.5)-standarH/2);
   textAlign(CENTER, CENTER);
 
   w = (50-int(map(peaceFull.length(), 0, xUnit*4+question1.length(), 8, 50)));
  textSize(w);
  strokeText(peaceFull, int(xUnit*1.6), (standarH + int(yUnit*1.5)+4), xUnit*4, standarH);
 
  textAlign(CENTER, TOP);
  w = (40-int(map(question2.length(), 0, xUnit*4+question1.length(), 8, 40)));
  textSize(w);
  strokeText(question2, int(xUnit*1.6), (standarH + int(yUnit*1.5)+4)+standarH, xUnit*4, int(yUnit*1.5)-standarH/2);
  
  textAlign(CENTER, CENTER);
   w = (50-int(map(ekonomyFull.length(), 0, xUnit*4+question1.length(), 8, 50)));
  textSize(w);
  strokeText(ekonomyFull, int(xUnit*1.6), (standarH + int(yUnit*1.5)*2+4)+(standarH/2)+4, xUnit*4, standarH);
  
  textAlign(CENTER, TOP);
   w = (40-int(map(question3.length(), 0, xUnit*4+question1.length(), 8, 40)));
  textSize(w);
  strokeText(question3, int(xUnit*1.6), ((standarH + int(yUnit*1.5)*2+4)+(standarH/2)+4)+standarH, xUnit*4, int(yUnit*1.8));
 
  textAlign(CENTER, TOP);
  
   w = (32-int(map(restartText.length(), 0, xUnit*4+question1.length(), 8, 32)));
  textSize(w);
  strokeText(restartText, int(xUnit*1.6), ((standarH + int(yUnit*1.5)*2+4)+(standarH/2)+4)+standarH+int(yUnit*1.8), xUnit*4, standarH);
  textAlign(CENTER, CENTER);
  
  
  /*//Text box 
   noFill();
   stroke(255);
   rect(xUnit*1.6, standarH/2, xUnit*4, standarH);
   rect(xUnit*1.6, standarH+standarH/2, xUnit*4, int(yUnit*1.5)-standarH/2);
   
   stroke(255,0,0);
   
   rect(xUnit*1.6, (standarH + int(yUnit*1.5)+4), xUnit*4, standarH);
   rect(xUnit*1.6, (standarH + int(yUnit*1.5)+4)+standarH, xUnit*4, int(yUnit*1.5)-standarH/2);
   
   
   stroke(0,255,0);
   
   rect(xUnit*1.6, (standarH + int(yUnit*1.5)*2+4)+(standarH/2)+4, xUnit*4, standarH);
   rect(xUnit*1.6, ((standarH + int(yUnit*1.5)*2+4)+(standarH/2)+4)+standarH, xUnit*4, int(yUnit*1.8));
   stroke(0,180, 180);
   
   
   rect(xUnit*1.6, ((standarH + int(yUnit*1.5)*2+4)+(standarH/2)+4)+standarH+int(yUnit*1.8), xUnit*4, standarH);
   noStroke();
  /* END text box */
  textAlign(CENTER, CENTER);
}

void drawText2(String question) {

  int w = (82-int(map(question.length(), 0, width/5+question.length(), 16, 80)));

  textSize(w);

  textAlign(CENTER, TOP);
  int standarH = yUnit/3;

  strokeText(question, xUnit, standarH+int(yUnit*1.2), xUnit*4, int(yUnit*2.5));
  /*//Text box 
   noFill();
   stroke(255);
   rect(xUnit, standarH+int(yUnit*1.5), xUnit*4, int(yUnit*2.5));
   noStroke();
  /* END text box */
  textAlign(CENTER, CENTER);
}


void strokeText(String message, int x, int y, int x2, int y2) 
{ 
  fill(242, 241, 210);
  text(message, x-1, y, x2, y2); 
  text(message, x, y-1, x2, y2); 
  text(message, x+1, y, x2, y2); 
  text(message, x, y+1, x2, y2); 
  fill(255, 255, 255);
  text(message, x, y, x2, y2);
} 

void drawHealth(float health1, float health2, float health3) {

  noStroke();

  float drawHeight = (health1 / MAX_HEALTH) * (yUnit*4.7);
  float drawHeight2 = (health2 / MAX_HEALTH) * (yUnit*4.7);
  float drawHeight3 = (health3  / MAX_HEALTH) * (yUnit*4.7);

  strokeCap(ROUND);


  textAlign(BOTTOM, BOTTOM);


  fill(78, 211, 33);
  rect(xUnit/5, yUnit+((yUnit*4.7)-drawHeight), xUnit/6, drawHeight);
  noFill();

  stroke(78, 211, 33);
  rect(xUnit/5, yUnit, xUnit/6, yUnit*4.7);
  noStroke();



  int textSize = 1;
  textSize(textSize);
  float w = textWidth(enviroment);
  while (w < (xUnit/6)) {
    textSize(textSize++);
    w = textWidth(enviroment);
    //println(w, textSize);
  }

  //if (menu == 0) {
    stroke(78, 211, 33);
    line(xUnit/5+(xUnit/6/2), yUnit-textAscent()-2, xUnit/5 + xUnit/6, yUnit / 4);
    text(enviromentExp, xUnit/5 + xUnit/6, yUnit / 4);
    noStroke();
 // }

  textAlign(BOTTOM, BOTTOM);
  text(enviroment, xUnit/5, yUnit);

  fill(41, 113, 196);
  rect(xUnit/5+(xUnit/6)+4, yUnit+((yUnit*4.7)-drawHeight2), xUnit/6, drawHeight2);
  noFill();

  stroke(41, 113, 196);
  rect(xUnit/5+(xUnit/6)+4, yUnit, xUnit/6, yUnit*4.7);
  noStroke();
  /*
  textSize = 1;
   textSize(textSize);
   w = textWidth(peace);
   while (w < (xUnit/6)) {
   textSize(textSize++);
   w = textWidth(peace);
   println(w, textSize);
   }*/

  //if (menu == 0) {
    stroke(41, 113, 196);
    line(xUnit/5+(xUnit/6)+4+(xUnit/6/2), yUnit-textAscent()-2, xUnit/5+(xUnit/6)+4 + xUnit/6, (yUnit / 4)*2);
    text(peaceExp, xUnit/5 + (xUnit/6)+4 + xUnit/6, (yUnit / 4)*2);
    noStroke();
  //}

  textAlign(BOTTOM, BOTTOM);
  text(peace, xUnit/5+(xUnit/6)+4, yUnit);


  fill(239, 23, 41);
  rect(xUnit/5+((xUnit/6+4)*2), yUnit+((yUnit*4.7)-drawHeight3), xUnit/6, drawHeight3);
  noFill();

  stroke(239, 23, 41);
  rect(xUnit/5+((xUnit/6+4)*2), yUnit, xUnit/6, yUnit*4.7);
  noStroke();
  /*
  textSize = 1;
   textSize(textSize);
   w = textWidth(wealth);
   while (w < (xUnit/6)) {
   textSize(textSize++);
   w = textWidth(wealth);
   println(w, textSize);
   }*/

  //if (menu == 0) {
    stroke(239, 23, 41);
    line(xUnit/5+((xUnit/6+4)*2)+(xUnit/6/2), yUnit-textAscent()-2, xUnit/5+((xUnit/6+4)*2) + xUnit/6, (yUnit / 4)*3);
    text(ekonomyExp, xUnit/5 + +((xUnit/6+4)*2) + xUnit/6, (yUnit / 4)*3);
    noStroke();
  //}

  textAlign(BOTTOM, BOTTOM);
  text(ekonomy, xUnit/5+((xUnit/6+4)*2), yUnit);


  noStroke();
}

void mousePressed() {
  p1_enviroment -= 1;
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      currentQuestion = int(random(0, float(questions.length)));
    } else if (keyCode == LEFT) {
      menu --;
    } else if (keyCode == RIGHT) {
      menu ++;
    }
  }
  if (key == '1') {
    println("1");
    pressButton(0);
  } else if (key == '2') {
    println("2");
    pressButton(1);
  } else if (key == '3') {
    println("3");
    pressButton(2);
  } else if (key == '4') {
    println("4");
    pressButton(3);
  }
  if (key == 'r') {
    resetGame();
  }
}

void createNewStar() {
  //We add a new star to the star array
  starArr.add(new Star(random(0, width), random(0, height), random(1, 4)));
}

void createStars() {

  translate(0, 0);

  // We create a for loop that loops through all stars
  for (int i=0; i<starArr.size(); i++) {
    //We create a local instance of the star object
    Star star = starArr.get(i);
    star.move(random(1, 5));
    star.display();
  }
}