import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
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
