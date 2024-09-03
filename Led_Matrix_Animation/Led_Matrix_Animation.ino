
int col[5] = { A0, A1, A2, A3, A4 };
int row[5] = { 9, 10, 11, 12, 13 };
int x[5][5] = { { 1, 1, 1, 1, 1 },
                { 1, 0, 0, 0, 1 },
                { 1, 0, 0, 0, 1 },
                { 1, 0, 0, 0, 1 },
                { 1, 1, 1, 1, 1 }};

int sx[5][5] = { { 0, 0, 0, 0, 0 },
                 { 0, 1, 1, 1, 0 },
                 { 0, 1, 0, 1, 0 },
                 { 0, 1, 1, 1, 0 },
                 { 0, 0, 0, 0, 0 } };
void setup() {
  // put your setup code here, to run once:
  for (int pins = 0; pins <= 4; pins++) {
    pinMode(col[pins], OUTPUT);
    pinMode(row[pins], OUTPUT);
  }
  for (int pins = 0; pins <= 4; pins++) {
    digitalWrite(col[pins], 0);
    digitalWrite(row[pins], 1);
  }
}

void loop() {
  for (int i = 1; i <= 125; i++) {
    for (int floor = 0; floor <= 4; floor++) {
      digitalWrite(row[floor], LOW);
      for (int room = 0; room <= 4; room++) {
        digitalWrite(col[room], x[floor][room]);
      }
      delay(2);
      digitalWrite(row[floor], HIGH);
      for (int room = 0; room <= 4; room++) {
        digitalWrite(col[room], LOW);
      }
    }
  }
  for (int i = 1; i <= 25; i++) {
    for (int floor = 0; floor <= 4; floor++) {
      for (int floor = 0; floor <= 4; floor++) {
        digitalWrite(row[floor], LOW);
        for (int room = 0; room <= 4; room++) {
          digitalWrite(col[room], sx[floor][room]);
        }
        delay(2);
        digitalWrite(row[floor], HIGH);
        for (int room = 0; room <= 4; room++) {
          digitalWrite(col[room], LOW);
        }
      }
    }
  }
  digitalWrite(A2,1);
  digitalWrite(11,0);
  delay(1125);
}