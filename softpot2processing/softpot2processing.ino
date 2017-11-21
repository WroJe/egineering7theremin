const int SOFT_POT_PIN = A0; // Pin connected to softpot wiper

const int GRAPH_LENGTH = 40; // Length of line graph



void setup() 
{
//initialize serial communications at a 9600 baud rate
Serial.begin(9600);
pinMode(SOFT_POT_PIN, INPUT);
}


void loop()
{
// Read in the soft pot's ADC value
  int softPotADC = analogRead(SOFT_POT_PIN);
  // Map the 0-1023 value to 0-40
  int softPotPosition = map(softPotADC, 0, 1023, 0, GRAPH_LENGTH);

  // Print a line graph:
/*  Serial.print("<"); // Starting end
  for (int i=0; i<GRAPH_LENGTH; i++)
  {
    if (i == softPotPosition) Serial.print("|");
    else Serial.print("-");
  }*/
  Serial.println(String(softPotADC));

  delay(50);
}







