import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter and Python Demo App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greetings = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              greetings,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Container(
                color: Colors.amber,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextButton(
                  child: const Text(
                    "Press this",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    var uri = Uri.parse("http://ruvo99.pythonanywhere.com/");

                    var response = await http.get(uri);

                    if (response.statusCode == 200) {
                      final decoded =
                          json.decode(response.body) as Map<String, dynamic>;
                      setState(() {
                        greetings = decoded['greetings'];
                      });
                    } else {
                      throw Exception("Failed to load data");
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
