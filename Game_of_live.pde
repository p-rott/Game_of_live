// Game of life
// Paul Rotthues
// 29.09.2017

// Object array zur Verwaltung der einzelnen Zellen 
Cell[][] Cells;
// Variablen für Zeilen und Reihen des Spielfeldes
int cols, rows;
// Anzahl der durchlaufenden Generationen
int generations;
// Faktor, um Pixel auf Felder umzurechnen
int scale = 20;
//
boolean gameRun = false;
// Wahrscheinlichkeit von lebenden Zellen bei zufälliger Generation
float chanceAlive = 0.5;
// Pause zwischen jedem Frame, um Veränderungen besser zu beobachten
int gameDelay = 0;

// Setup wird einmal beim Programmstart ausgeführt
void setup()
{
  // Größe des Fensters
  size(1200, 800);
  // Zeilen und Reihen berechnen
  cols = width/scale;
  rows = (height - (60))/scale;
  //
  Cells = new Cell[cols][rows];
  // Hintgrundfarbe Grau
  background(50);
  // Alle Zellen erstellen
  for (int i = 0; i < cols; i++) //x
  {
    for (int j = 0; j < rows; j++) //y
    {
      // Zellen bekommen X- und Y-Position über Konstruktor zugewiesen
      // Multiplikation mit Faktor, um Position an der korrekten Stelle zu setzen
      // randomBool gibt zufällig true oder false aus, um gemischtes Feld zu erstellen
      Cells[i][j] = new Cell(i * scale, j * scale, randomBool());
    }
  }
  generations = 0;
}

// Draw wird immer wieder ausgeführt
void draw()
{
  // Hintergrundfarbe auf Grau setzen
  background(50);
  // Interface anzeigen
  drawInterface();
  // Alle Zellen darstellen und anschließend neu berechnen
  for (int i = 0; i < cols; i++) //x
  {
    for (int j = 0; j < rows; j++) //y
    {
      // Siehe Klasse Cell
      Cells[i][j].drawCell();
      Cells[i][j].sumNeighbors();
      Cells[i][j].calcNext();
    }
  }
  // Boolsche Variable, um weitere Generationen zu stoppen
  // oder mit der Maus Veränderungen vorzunehmen
  if (gameRun)
  {
    // Status aller Zellen gemäß Berechnung anpassen 
    for (int i = 0; i < cols; i++) //x
    {
      for (int j = 0; j < rows; j++) //y
      {
        // siehe Klasse Cell
        Cells[i][j].alive = Cells[i][j].nextAlive;
      }
    }
    // Integer der Generationen erhöhen
    generations ++;
  }
  // Kurze Pause, damit Änderungen verfolgt werden können
  delay(gameDelay);
}

// Funktion, um alle Zellen zu verändern
// 0 = Töten
// 1 = Zufällig
void changeCells(int mode)
{
  for (int i = 0; i < cols; i++) //x
  {
    for (int j = 0; j < rows; j++) //y
    {
      // Zellen bekommen X- und Y-Position über Konstruktor zugewiesen
      // Multiplikation mit Faktor, um Position an der korrekten Stelle zu setzen
      if (mode == 0) Cells[i][j] = new Cell(i * scale, j * scale, false);
      // randomBool gibt zufällig true oder false aus, um gemischtes Feld zu erstellen
      else if (mode == 1) Cells[i][j] = new Cell(i * scale, j * scale, randomBool());
    }
  }
}

// Funktion, mit der das Interface unter dem Spiel erzeugt wird
// Es werden nur Textfelder und Rechtecke erzeugt, bedarf keiner weiteren Dokumentation
void drawInterface()
{
  stroke(200);
  textSize(14);
  fill(0, 0, 200);
  rect(5, 745, 185, 20);
  rect(205, 745, 185, 20);
  rect(5, 765, 185, 20);
  fill(255);
  text("Zellen zufällig erzeugen", 10, 760);
  text("Alle Zellen töten", 10, 780);
  text("Generationen: " + generations, 1000, 775);
  text("Pause pro Frame: " + gameDelay, 1000, 795);
  if (gameRun) text("Pause (Leertaste)", 210, 760);
  else text("Start (Leertaste)", 210, 760);

  text("Größe des Feldes mit 1/2/3 festlegen", 500, 755);
  text("Start/Stopp mit Leertaste", 500, 775);
  text("Pause pro Frame mit Pfeiltaste hoch/runter", 500, 795);
}

// Funktion, um zufällig boolsche Werte zu erzeugen
boolean randomBool() 
{
  return random(1) > chanceAlive;
}

// Tastensteuerung für Pause und Spielverzögerung
void keyPressed()
{
  if (keyCode == UP) gameDelay = gameDelay + 50;
  else if (keyCode == DOWN && gameDelay > 0) gameDelay = gameDelay - 50;
  else if (key == ' ') gameRun = !gameRun;
  else if (key == '1') 
  {
    scale = 10; 
    setup();
  } else if (key == '2') 
  {
    scale = 20; 
    setup();
  } else if (key == '3') 
  {
    scale = 30; 
    setup();
  }
}

// Funktion wird aufgerufen, nachdem Maustaste geklickt und losgelassen wurde
void mouseClicked()
{
  // Nachfolgend Interaktion mit Interface
  // Manuell erledigt, da Processing nativ kein Interface anbietet
  if (mouseX >= 5 && mouseX <= 190 && mouseY >= 745 && mouseY < 765)
  {
    generations = 0;
    changeCells(1);
  }
  if (mouseX >= 205 && mouseX <= 390 && mouseY >= 745 && mouseY < 765)
  {
    gameRun = !gameRun;
  }
  if (mouseX >= 5 && mouseX <= 190 && mouseY >= 765 && mouseY < 785)
  {
    generations = 0;
    changeCells(0);
  }
}

// Funktion wird aufgerufen, nachdem Maustaste geklickt wurde
void mousePressed()
{
  // Zellen per Maus setzen
  if (mouseY < height - 60)
  {
    Cells[mouseX/scale][mouseY/scale].alive = !Cells[mouseX/scale][mouseY/scale].alive;
  }
}