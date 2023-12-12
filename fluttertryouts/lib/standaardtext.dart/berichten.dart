// In this file you see the messages which are responded back on the questions
import 'package:fluttertryouts/strings/strings.dart';
class MessageCategory {
  final String categoryName;
  final List<String> keywords;
  final String response;

  MessageCategory(this.categoryName, this.keywords, this.response);
}


class MessageResponses {
  static List<MessageCategory> categories = [
    MessageCategory('andere_medicatie', ['wisselwerking', 'andere','andere medicijnen'], selectedMedicationAndere!),
    MessageCategory('info', ['doet', 'informatie', 'categorie', 'voorschrijven', 'voorschrift', 'info', 'schrijven', 'wat doet het','wat doet', "wat is het", 'wat is'], selectedMedicationInfo!),
    MessageCategory('inname_tijd', ['hoge bloedruk', 'hoelang', 'hoe lang', 'hartfalen', 'nierziekten'], selectedMedicationInnameTijd!),
    MessageCategory('bijwerkingen', ['bijwerkingen', 'bijwerking', 'last van'], selectedMedicationBijwerkingen!),
    MessageCategory('gebruik', ['hoe vaak', 'innemen', 'hoevaak', 'tijd', 'gebruik', 'gebruiken'], selectedMedicationGebruik!),
    MessageCategory('vergeten', ['vergeten', 'overgeslagen'], selectedMedicationVergeten!),
    MessageCategory('stoppen', ['stoppen', 'ophouden', 'stopzetten'], selectedMedicationStoppen!),
    MessageCategory('recept', ['recept', 'voorschrift', 'doktersvoorschrift'], selectedMedicationRecept!),
    MessageCategory('bedankt', ['bedankt', 'dankjewel', 'dankuwel'], "Graag gedaan! Als u meer vragen heeft hoor ik het graag!"),
  ];
  

  static String getResponse(String message) {
    String response = 'Sorry, ik begrijp het niet.';

    // Iterate through categories and check if any keywords match
    for (var category in categories) {
      for (var keyword in category.keywords) {
        if (message.toLowerCase().contains(keyword)) {
          response = category.response;
          break;
        }
      }
    }
    return response;
  }
  
    // Gives you a confirmation on which medicine you choose
    static String getWelcomeMessage() {
    String chosenMedicine = medicineChoice; 
    return 'Wat wilt u weten over $chosenMedicine?';
  }
  // Gives a welcome message
  static String getWelcomeMessageStandard() {
  var now = DateTime.now();
  var greeting = _getGreeting(now.hour);
  return '$greeting Welkom in de chat!';
}

  // Gives messages based on time
  static String _getGreeting(int hour) {
    if (hour >= 6 && hour < 12) {
      return 'Goedemorgen!';
    } else if (hour >= 12 && hour < 18) {
      return 'Goedemiddag!';
    } else {
      return 'Goede avond!';
    }
  }
}
