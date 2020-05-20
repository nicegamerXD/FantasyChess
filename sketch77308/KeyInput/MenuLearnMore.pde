
// Functions for learn more about the game is found here.
void textLearnMoreOnScreen() {
  background(Flag);
  String a = textLearnMore();
  a = a.replaceAll("#", "\n");
  a += "\n";
  a += "                          - Tryk på musseknappen for at gå tilbage til hovedmenuen";
  textLeading(50);
  text(a, 9, 10);
}

void printLearnMore() {
  String a = textLearnMore();
  String[] list = split(a, '#');
  for (int i=0; i<list.length; i++) {
    println(list[i]);
  }
}

String textLearnMore() {
  // the sign # = line break
  textAlign(CORNER);
  textSize(20);
  String a=""; 
  a+="#"+"Hvordan spiller man spillet?";
  a+="#"+"#";
  a+="#"+"Dette spil har en 2 taster der kan bruges. ";
  a+="#"+"R = Genstart Spil.";
  a+="#"+"H = Fasttravel til Hovedmenuen.";
  a+="#"+"";
  a+="#"+"Kampen Om Kronerne.";
  a+="#"+"    Disse 2 kongeriger der nu kæmper om magten,";
  a+="#"+"    skal prøve at stjæle fjenens krone,";
  a+="#"+"    for at få den fulde magt over begge kongeriger.";
  a+="#"+"    Formålet med spillet er at få fat i modstanderens krone.";
  return (a);
}
