// Klasse Cell, in der alle Funktionen, Attribute und der Konstruktor enthalten sind
class Cell
{
  // Variablen für Position im Feld und lebende Nachbarn
  int posX, posY, aliveN;
  // Variable, ob Zelle lebt
  boolean alive;
  // Variable, ob Zelle nächste Generation lebt
  boolean nextAlive;

  // Konstruktor, um Zelle zu ertellen und Position sowie Status direkt zu übergeben
  Cell(int x, int y, boolean status)
  {
    posX = x;
    posY = y;
    alive = status;
  }

  // Funktion, um die Summer der lebenden 8 Nachbarn zu ermitteln
  void sumNeighbors()
  {
    // Von Koordinaten zu Position im Feld umwandeln
    int X = posX / scale;
    int Y = posY / scale;
    // Offset-Variablen erstellen, um das Feld von links nach rechts
    // und von oben nach unten zu verbinden
    int offsetU = 0;
    int offsetD = 0;
    int offsetL = 0;
    int offsetR = 0;
    // Überprüfung, ob Offset-Werte gesetzt werden müssen, d.h. ob Zelle am Rand des Feldes liegt
    if ((X - 1) < 0) offsetU = cols;
    if ((Y - 1) < 0) offsetL = rows;
    if ((X + 1) >= cols) offsetD = cols * (-1);
    if ((Y + 1) >= rows) offsetR = rows * (-1);
    // Zählen der lebenden Zellen
    // Zellen werden anhand der Position der aktuellen Zelle +/- 1 gewählt
    // Offset nötig, wenn die aktuelle Zelle sich am Rand befindet
    if (Cells[X - 1 + offsetU][Y - 1 + offsetL].alive) aliveN ++;
    if (Cells[X              ][Y - 1 + offsetL].alive) aliveN ++;
    if (Cells[X + 1 + offsetD][Y - 1 + offsetL].alive) aliveN ++;
    if (Cells[X - 1 + offsetU][Y              ].alive) aliveN ++;
    if (Cells[X + 1 + offsetD][Y              ].alive) aliveN ++;
    if (Cells[X - 1 + offsetU][Y + 1 + offsetR].alive) aliveN ++;
    if (Cells[X              ][Y + 1 + offsetR].alive) aliveN ++;
    if (Cells[X + 1 + offsetD][Y + 1 + offsetR].alive) aliveN ++;
  }

  // Nächsten Status der Zelle anhand der Regeln bestimmen
  void calcNext()
  {
    // Regeln vom Game of Life
    // 3 lebende Nachbarn = Wiedergeburt der toten Zelle
    // <2 lebende Nachbarn = Tod der Zelle
    // 2|3 lebende Nachbarn = Zelle bleibt am Leben
    // >3 lebende Nachbarn = Tod der Zelle

    if (alive && (aliveN < 2 || aliveN > 3)) nextAlive = false;
    else if (!alive && aliveN == 3) nextAlive = true;
    else nextAlive = alive;
    // Zähler zurücksetzen
    aliveN = 0;
  }

  //Zelle darstellen
  void drawCell()
  {
    // RGB-Werte für lebendige (grün) und tote (rot) Zellen setzen
    if (alive) fill(0, 200, 0);
    else fill(200, 0, 0);
    // Quadrat mit abgerundeten Ecken zeichnen
    stroke(0);
    rect(posX, posY, scale, scale, 5);
    // Position der Zelle anzeigen, nützlich für Debugging
    // fill(0, 0, 200);
    // textSize(7);
    // text(posX/10 + ":" + posY/10, posX + 1, posY + 10);
  }
}