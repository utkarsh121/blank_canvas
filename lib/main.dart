import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'geolocate.dart'; // Import the file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void generateRandomWord() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      key: _scaffoldKey, // Add GlobalKey here
      appBar: AppBar(
        title: Text('My Test App'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: Text('Menu Item 1'),
              onTap: () {
                showCurrentLocation(context); // show current location
              },
            ),
            ListTile(
              title: Text('Menu Item 2'),
              onTap: () {
                // Add functionality for drawer menu items
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('A random idea:'),
            Text(appState.current.asLowerCase),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.generateRandomWord();
              },
              child: Text('Generate Random Word'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final generatedWord = appState.current.asLowerCase;
                final googleUri =
                    Uri.parse('https://www.google.com/search?q=$generatedWord');
                if (await canLaunchUrl(googleUri)) {
                  // Use canLaunchUrl
                  await launchUrl(googleUri);
                } else {
                  print('Could not launch $googleUri');
                }
              },
              child: Text('Google this word'),
            ),
          ],
        ),
      ),
    );
  }
}
