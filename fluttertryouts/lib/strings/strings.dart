// String file where strings can be stored

//Lists
List<String> medicijnNamenGlobal = [];
List<String> medicijnInfoGlobal = [];
List<String> medicijnAndereMedsGlobal = [];
List<String> medicijnBijwerkingenGlobal = [];
List<String> medicijnGebruikGlobal = [];
List<String> medicijnInnameTijdGlobal = [];
List<String> medicijnVergetenGlobal = [];
List<String> medicijnStoppenGlobal = [];
List<String> medicijnReceptGlobal = [];

List<String> opgeslagenBerichtenLijst = [];

// Strings get medicine Name by chosing
String medicineChoice = "";
String savedMedication2 = "";

// String getdata
String? selectedMedicationInfo;
String? selectedMedicationAndere;
String? selectedMedicationBijwerkingen;
String? selectedMedicationGebruik;
String? selectedMedicationInnameTijd;
String? selectedMedicationVergeten;
String? selectedMedicationStoppen;
String? selectedMedicationRecept;
String saveTheMessageToSendToDatabase = '';

// Function to check if there is a savedMedicin available
void processDataChoice(String? choice) {
  if (choice != null) {
    // Use if choice is known out of the savedMedicine
    selectedMedicationInfo = medicationInfoMap[choice];
    selectedMedicationAndere = medicationAndereMedMap[choice];
    selectedMedicationBijwerkingen = medicationBijwerkingenMap[choice];
    selectedMedicationGebruik = medicationGebruikMap[choice];
    selectedMedicationInnameTijd = medicationInnameTijdMap[choice];
    selectedMedicationVergeten = medicationVergetenMap[choice];
    selectedMedicationStoppen = medicationStoppenMap[choice];
    selectedMedicationRecept = medicationReceptMap[choice];
  } else {
    // Use the medicine choice field and connect with your medicine
    selectedMedicationInfo = medicationInfoMap[medicineChoice];
    selectedMedicationAndere = medicationAndereMedMap[medicineChoice];
    selectedMedicationBijwerkingen = medicationBijwerkingenMap[medicineChoice];
    selectedMedicationGebruik = medicationGebruikMap[medicineChoice];
    selectedMedicationInnameTijd = medicationInnameTijdMap[medicineChoice];
    selectedMedicationVergeten = medicationVergetenMap[medicineChoice];
    selectedMedicationStoppen = medicationStoppenMap[medicineChoice];
    selectedMedicationRecept = medicationReceptMap[medicineChoice];
  }
}

// Mappen
Map<String, String> medicationInfoMap = {};
Map<String, String> medicationAndereMedMap = {};
Map<String, String> medicationBijwerkingenMap = {};
Map<String, String> medicationGebruikMap = {};
Map<String, String> medicationInnameTijdMap = {};
Map<String, String> medicationVergetenMap = {};
Map<String, String> medicationStoppenMap = {};
Map<String, String> medicationReceptMap = {};