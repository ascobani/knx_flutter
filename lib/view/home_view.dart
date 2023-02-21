import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

List<String> _messages = [];

//TODO: Add a button to the home view
class _HomeViewState extends State<HomeView> {
  Future<void> _onPressed() async {
    try {
      const platform = MethodChannel('camilero.icibot.knx');
      final response = await platform.invokeMethod('start');
      setState(() {
        _messages.add(response.toString());
      });
    } catch (e) {
      setState(
        () {
          _messages.add(e.toString());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _onPressed,
              child: const Text('Start'),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(_messages[index]);
                },
                itemCount: _messages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
