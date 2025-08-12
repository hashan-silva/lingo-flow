import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TtsProvider(),
      child: const MyApp(),
    ),
  );
}

class TtsProvider extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lingo Flow',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lingo Flow')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final text = _controller.text;
                if (text.isNotEmpty) {
                  context.read<TtsProvider>().speak(text);
                }
              },
              child: const Text('Speak'),
            ),
          ],
        ),
      ),
    );
  }
}
