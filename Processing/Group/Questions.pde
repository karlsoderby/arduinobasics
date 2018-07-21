
/* Link to questions */
/* https://docs.google.com/spreadsheets/d/1JWywGLCheNDAA4XvXGtIyOqMhKmG742Lk6la231S1GI/edit?usp=sharing */
public Question[] questions = {
  new Question(
    "Vad är viktigast för dig",
    new String[]{"Att ingen ska behöva gå fattig eller hungrig.", "Att alla kan leva i harmoni med varandra.", "Att framtida generationer kan se vår natur bevarad och oskadad."},
    new int[]{0,0,1},
    new int[]{0,1,0},
    new int[]{1,0,0}
  ),
  new Question(
    "Vilken energikälla skulle du använda?",
    new String[]{"Miljövänlig men lågt energiproducerande källa.", "Högt energiproducerande men icke miljövänligt.", "Lagom miljövänligt och lagom energiproducerande."},
    new int[]{-1, 1, 1},
    new int[]{0, 0, -1},
    new int[]{1, -1, -1}
  ),new Question(
    "Till vilken grad ska rättssystem följa yttrandet ett öga för ett öga, en tand för en tand.",
    new String[]{"Till stor grad, man kommer inte begå brott om man själv kommer uppleva smärtan dem skapar. ", "Definitivt inte, alla är lika inför lagen och har rätt att bli hörda och åtalade inför lagen.", "Delvis, det flesta bör få opartiska rättegångar men vissa förbrytare är för onda för lagen."},
    new int[]{0, 0, 0},
    new int[]{-2,2, 1},
    new int[]{0, 0, 0}
  ),new Question(
    "Hur ska du lösa hungersnöden i världen?",
    new String[]{"Öka tillgång till konstgödsel och andra medel som gör det lättare att odla, fiska och uppfostra kreatur.", "Minska vårt förbruk av odlingsmark, fisk hav, och biodiversitet och söka hållbara lösningar."},
    new int[]{-1, 1},
    new int[]{0, 0},
    new int[]{1, -1}
  ),new Question(
    "Internationella relationer i världen bör utvecklas genom att?",
    new String[]{"Uppmuntra diplomati.", "Uppmuntra länders rätt att själv försörja sig,"},
    new int[]{0, -1},
    new int[]{1, 0},
    new int[]{1, 2}
  ),new Question(
    "Ska din befolkning ha fler bönder, akademiskt utbildade eller industriarbetare?",
    new String[]{"Bönder.", "Akademiskt utbildade.", "Industriarbetare."},
    new int[]{-1, 0, -2},
    new int[]{0, 1, 0},
    new int[]{1, 0, 2}
  ),new Question(
    "Det blir ökad politiska uppror världen över. Hanterar du det genom att?",
    new String[]{"Prioritera stabilitet genom att förtrycka revolutionen.", "Prioritera folkets fria vilja genoma att låta upprorsrörelsen ta kontroll.", "Mellanlanda på en stabil men korrupt regering som ger revolutionens folk delvis politiskt styre."},
    new int[]{0, 0, 0},
    new int[]{-1, 1, 1},
    new int[]{1, -1, -1}
  ),new Question(
    "U-länder industrialiseras allt snabbare vilket ger ekonomisk tillväxt men skadar klimatet. Hur bör industrialisering i u-länder fortsätta?",
    new String[]{"Öka enkel, ekonomisk men miljöskadlig industrialisering.", "Bromsa all industrialisering och gör världen mer miljövänlig.", "Följa en mer miljövänlig men mindre ekonomiskt gynnsam industrialisering."},
    new int[]{-2,2,-1},
    new int[]{0,0,0},
    new int[]{2,-2,1}
  ),new Question(
    "Bör du göra samhället mer jämlikt genom att kvotera mindre representerade grupper i arbetsmarknaden eller ska enbart kompetens styra?",
    new String[]{"Öka kvotering av underrepresenterade folkgrupper.", "Låta merit styra arbetsmarknaden.", "Ha en viss kvotering av underrepresenterade folkgrupper."},
    new int[]{0,0, 0},
    new int[]{2,-2,1},
    new int[]{-1,2,-1}
  ),new Question(
    "Fattiga bönder nära kusten vill att förbudet på att gödsla för mycket ska lyftas även om det kan leda till övergödsling och förstörelse av havens ekosystem. Ska du?",
    new String[]{"Lyfta förbudet.", "Låt förbudet vara.", "Begränsa övergödsling ännu mer."},
    new int[]{-1,0,2},
    new int[]{1,0,-1},
    new int[]{1,0,-1}
  ),new Question(
    "Både arbetslöshet bland vuxna och brist på utbildning bland barn är fortfarande problem, hur löser du det?",
    new String[]{"Ge vuxna mer arbete.", "Ge fler barn mer utbildning.", "Barnarbete", "Skicka vuxna tillbaka till skolan."},
    new int[]{0,0,0,0},
    new int[]{1,0,0,1},
    new int[]{1,-1,1,0}
  ),new Question(
    "Flera privata företag och deras arbetare är upprörda att flera miljövänliga begränsningar kring handel och produktion läggs på dem. Hur bör det lösas?",
    new String[]{"Stoppa begränsningar på privatägda företag.", "Fortsätt med de nuvarande begränsningarna.", "Begränsa företagen ännu mer genom att höja skatten mer."},
    new int[]{-1,0,2},
    new int[]{1,-1,-1},
    new int[]{1,0,-1}
  ),new Question(
    "En politisk och militär stormakt har hotat och kränkt flera grannländers självständighet. Hur vill du bekämpa dessa hot?",
    new String[]{"Bekämpa den militära och ekonomiska stormakten med en förenad offensiv front som innebär att den själv försörjer sig med icke miljövänliga energikällor.", "Välj att inte störa global handel genom att låta stormakten vara.", "Ge stormakten en straffpåföljd genom att strypa handel med den och tvinga deras folk att använda icke miljövänliga försörjningsmedel."},
    new int[]{-1, 0, -1},
    new int[]{-2, -1, -1},
    new int[]{-1, 1, -1}
  )
  
};

String[] endings_enviroment = {
  "Jorden har följt en hållbar utveckling i alla miljöfrågor. Naturresurser används ansvarsfullt och förorening i hav och luft drabbar jorden allt mindre.",
  "Det råder miljöproblem i denna värld som klimatförändring och mer, allt skapat av människor men planeten är fortfarande beboelig nog för att många ska tveka miljöfrågors vikt.",
  "Världen lider av stora ekologiska problem som har allvarligt drabbat mänskligheten och olika ekosystem i form av torka, översvämning och förorening i hav och luft."
};
String[] endings_peace = {
  "Din värld har i stort sätt inga beväpnade konflikter. Världens länder och folkgrupper lever i fred och förståelse mellan varandra.",
  "Krig och andra former av väpnad konflikt består fortfarande men inte i en så pass allvarlig grad att diplomati fortfarande triumferar.",
  "Krig drabbar jorden allvarligt. Ännu fler i världen dör, skadas och tvingas fly deras hem varje dag då förståelse och diplomati mellan länder och folkgrupper inte existerar."
};
String[] endings_ekonomy = {
  "Din värld upplever hög ekonomisk framgång. Problem som fattigdom, hunger och arbetslöshet besvärar världens väldigt lite befolkning.",
  "Ekonomisk framgång är relativt hög vilket innebär att problem som fattigdom och hunger fortfarande består men till en mindre allvarlig grad.",
  "Ekonomin har försummats vilket har lett till globala finansiella kriser, fattigdom och svält."
};

// MILJÖ, FRED, EKONOMI

class Question{
  
  public String question = "";
  public String[] answers;
  
  public int enviroment[]; //global enviroment health levels
  public int peace[]; // Global peace levels
  public int ekonomy[]; //Human development index, ekonomy
  
  public Question(String question, String[] answers, int enviroment[], int peace[], int ekonomy[]){
    this.question = question;
    this.answers = answers;
    this.enviroment = enviroment;
    this.peace = peace;
    this.ekonomy = ekonomy;
  }
  
  
}