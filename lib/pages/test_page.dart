import 'dart:async';

import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';

class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  CodeController? _codeController;
  Map<String, TextStyle>? theme = monokaiSublimeTheme;
  Timer? _timer;
  int remainingSeconds = 1;
  final ValueNotifier<String> time = ValueNotifier<String>('00:00');

  @override
  void initState() {
    super.initState();
    final source = "void main() {\n    print(\"Hello, world!\");\n}";
    _codeController = CodeController(text: source);
    _startTimer(900);
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final problemStatement = "1)Write a function that prints 'Hello, world!'";

    return Scaffold(
      appBar: AppBar(
        title: Text("Code Test"),
        backgroundColor: Colors.teal,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.blueGrey,
              elevation: 20,
              icon: Icon(Icons.color_lens_outlined),
              iconEnabledColor: Colors.white,
              items: <String>['Atom', 'Monokai-sublime', 'VS', 'Darcula']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    setState(() {
                      if (value == "Monokai-sublime") {
                        theme = monokaiSublimeTheme;
                      } else if (value == "Atom") {
                        theme = atomOneDarkTheme;
                      } else if (value == "VS") {
                        theme = vsTheme;
                      } else if (value == "Darcula") {
                        theme = darculaTheme;
                      }
                    });
                  },
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                problemStatement,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              child: CodeField(
                controller: _codeController!,
                textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: 20),
              ),
            ),
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: ShapeDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: StadiumBorder(
                        side: BorderSide(width: 2, color: Colors.red))),
                child: ValueListenableBuilder<String>(
                  valueListenable: time,
                  builder: (context, value, child) {
                    return Center(
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: Icon(
          Icons.play_arrow_sharp,
        ),
      ),
    );
  }
}
