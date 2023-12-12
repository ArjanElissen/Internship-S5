// I create a homepage which I can use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertryouts/api_connection/send_data.dart';
// import 'package:fluttertryouts/components/menu.dart';
import 'package:fluttertryouts/components/popup.dart';
import 'package:fluttertryouts/components/receivedbubble.dart';
// import 'package:fluttertryouts/components/settimepopup.dart';
// import 'package:fluttertryouts/components/settimepopup.dart';
import 'package:fluttertryouts/components/setuppushnotes.dart';
import 'package:fluttertryouts/components/textbubble.dart';
import 'package:fluttertryouts/standaardtext.dart/berichten.dart';
import 'package:fluttertryouts/strings/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_connection/api_getdata.dart';

// Create a class
class Message {
  // make a string
  final String text;
  // create a bool for true or false
  final bool isSentByUser;
  // Control if the message is sent by the user and the text from the textfield
  Message(this.text, this.isSentByUser);
}

// Create a widget without a state
class HomePage extends StatelessWidget {
  // Constructor with key to call the statelesswidget
  const HomePage({super.key});

  @override
  //Create a UI for the app and navigate to HomePageNav.
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageNav(),
    );
  }
}

// Create a new widget with a state
class HomePageNav extends StatefulWidget {
  const HomePageNav({Key? key}) : super(key: key);

  @override
  // Create a new state for the HomePageNav so the content of the page can change
  State<HomePageNav> createState() => HomePageNavState();
}

// Create a widget for the _HomePageNavState who is responsible for the HomePageNav
class HomePageNavState extends State<HomePageNav> {
  // Create a TextEditingController for the Textfield
  final TextEditingController _messageController = TextEditingController();
  // Create an empty list for Message
  final List<Message> _messages = [];
  // Create a ScrollController to scroll automatically down
  final ScrollController _scrollController = ScrollController();
  // Create an empty list for the medicijnnaam
  List<String> medicijnNamen = [];
  String medicineSaved = savedMedication2;

  // Create a async function _saveMessage whithout a specific result yet. In the future this function will give me a result
Future<void> _saveMessage() async {
  // Create a String to get text from the textfield
  String messageText = _messageController.text;
  opgeslagenBerichtenLijst.add(messageText);
  if (opgeslagenBerichtenLijst.length >= 3) {
    saveUserMessage(messageText); // Functie om berichten naar de database te schrijven
}
  // Check if the message is not empty
  if (messageText.trim().isNotEmpty) { // Check for non-empty and non-whitespace text
    // Create new object which tells you if the message was sent by the user
    Message message = Message(messageText, true);
    // Change the state of the page
    setState(() {
      // Add the user's message to the Message message
      _messages.add(message);
      // Call a reaction of the send message and call the function getResponse and save the text of the user in messageText
      String response = MessageResponses.getResponse(messageText);
      // Add the message to the list Message
      _messages.add(Message(response, false));
    });
    // Clear the textfield
    _messageController.clear();
    // Call the Save the chat history function to save the chat locally
    await _saveChatHistory();

    // saveUserMessage();

    // messageText = saveTheMessageToSendToDatabase;
    saveTheMessageToSendToDatabase = messageText; 

    // When the list is full scroll down to the last posted message
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}


  //Create a async function _saveChatHistory whithout a specific result yet. In the future this function will give me a result.
  Future<void> _saveChatHistory() async {
  // Create a sharedPreferences to save data and call data
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Create a new list chatHistory, which has a map and strings in it. It will save the text which is send by the user. It checks who send the message (which should be the user).
  List<Map<String, dynamic>> chatHistory = _messages.map((message) {
    return {
      'text': message.text,
      'isSentByUser': message.isSentByUser,
    };
    // convert to a list
  }).toList();

  // Convert the List<Map> to JSON and save it as a string
  String chatHistoryJson = jsonEncode(chatHistory);
  await prefs.setString('chat_history', chatHistoryJson);
}

  Future<void> _loadChatHistory() async {
  // Save the chat and save it in a json format, this way I can see the differnce between a user message and a code message.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? chatHistoryJson = prefs.getString('chat_history');

  // Check if json isnt null
  if (chatHistoryJson != null) {
    //Convert list to dynamic objects to recover the messages
    List<dynamic> chatHistoryList = jsonDecode(chatHistoryJson);
    setState(() {
      // makes sure that we don't get double messegas
      _messages.clear();
      // Check every item with a for loop
      for (var item in chatHistoryList) {
        // Create new messages and add it to the Message list
        _messages.add(Message(item['text'], item['isSentByUser']));
      }
    });
  }
}
  // Loading the chat history
@override
void initState() {
  super.initState();
  _loadChatHistory();
  // Retrieving medicijnNamen with the fetch fucntion
  fetchData().then((_) {
    setState(() {
      medicijnNamen = medicijnNamenGlobal;
    });
  });

  // Als het "Chat" tabblad is geselecteerd, scroll automatisch naar beneden
  if (_selectedIndex == 1) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

  // Make a selectedIndex for tabs. It has a starting value of 0
  int _selectedIndex = 0;
  //Set textstyle with a variable
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

// Create a function to switch between tabs and to make a welcomemessage
void _onItemTapped(int index) {
  // Adjust internal state of the widget
  setState(() {
    // set index to the selectedindex to make sure you can switch between tabs.
    _selectedIndex = index;
    // when the index is 1 I check if the fields are empty so a welcomemessage can be provided.
    if (index == 1) {
      // Check if there are no existing messages before adding the welcome message
      if (_messages.isEmpty) {
         // Display the standard welcome message immediately
        String standardWelcomeMessage = MessageResponses.getWelcomeMessageStandard();
        Message standardWelcomeMessageObj = Message(standardWelcomeMessage, false);

        // Add the standard welcome message to the message list
        setState(() {
          _messages.add(standardWelcomeMessageObj);
        });

        // Add a delay of 2 seconds before displaying the welcome message
        Future.delayed(const Duration(milliseconds: 10), () {
          // Pick up the welcom message from the other file
          // String welcomeMessage = MessageResponses.getWelcomeMessage();
          // Making a new message object which contains the welcomemessage and false. False will say the message is not send by the user.
          // Message welcomeMessageObj = Message(welcomeMessage, false);
          // Show popup
          Future.delayed(const Duration(seconds: 2), () {
            // Show Popup from the popup file
            Popup.showPopup(context, medicijnNamen,showwelcomeMessage);
          });
          //Create a new state
          setState(() {
          //Add the message to the message list and it will be displayed on your screen
            // _messages.add(welcomeMessageObj);
          });
        });
      }
    }
  });
}

// Show the welcome message function
void showwelcomeMessage() {
  String showTheWelcomeMessage = '';

  Future<void> waitForWelcomeMessage() async {
    // Wait until the welcome message is non-empty
    while (showTheWelcomeMessage.isEmpty) {
      // Wait 100 ms to control again
      await Future.delayed(const Duration(milliseconds: 100));
      // Get the welcome message
      showTheWelcomeMessage = MessageResponses.getWelcomeMessage();
    }
    // Create a new welcome message
    Message newWelcomeObj = Message(showTheWelcomeMessage, false);
    // Update the state and add to the message list
    setState(() {
      _messages.add(newWelcomeObj);
    });
  }
  // Call the function waiting for the message
  waitForWelcomeMessage();
}

  // Create the content to display
  List<Widget> _widgetOptions() {
    // Create a List with the name chatwidgets
    List<Widget> chatWidgets = [
      // Below you find the structure of the content of the pages
      // Set up text on the page
      Text(
        medicineSaved.isNotEmpty
            ? 'Welkom op de homepage\n\nUw laatst gezochte medicijn was:\n$medicineSaved\n U heeft nog $totalMessages berichten verstuurd'
            : 'Welkom op de homepage\n\nU heeft nog geen medicijn geselecteerd\n U heeft nog $totalMessages berichten verstuurd',
        style: optionStyle,
        textAlign: TextAlign.center,
      ),
      
      // This is the chatpage. The structure of the app.
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // Build a list where all the messages can be displayed
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                // Here the sides will be set. The chat messages will be on the left and the user messages will be on the right
                itemBuilder: (context, index) {
                  return _messages[index].isSentByUser
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: ChatBubble(message: _messages[index].text),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: ReceivedMessageBubble(
                              message: _messages[index].text),
                        );
                },
              ),
            ),

            // This will be the set up for the textfield. It will place it where it should be. It will also a send button
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                   IconButton(
                    onPressed: (){
                      Popup.showPopup(context, medicijnNamen, showwelcomeMessage);
                    }, 
                    icon: const Icon(Icons.medication_outlined)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      controller: _messageController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Typ uw bericht...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: (){
                      _saveMessage();
                      },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
    // gives the list back and will show it on the display screen
    return chatWidgets;
  }

  // This is the setup for the page. So there will be a appbar with a menu in it.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  // Makes a bar in the top of the screen with the name
  appBar: AppBar(
    // changes the background color
    backgroundColor: Colors.black,
    // Title in the appbar
    title: const Text(
      'Chat',
      style: TextStyle(color: Color(0xFFFF8F00)),
    ),
    // Menu item
    actions: [
      // Icon button for the three dots
    IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
       pushNotesmenu(context); 
      },
      ),
    ],
  ),

      // This is the navigation menu on the bottom on the bottom of screen
      body: Center(
        child: _widgetOptions().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        iconSize: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
