import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskFive extends StatefulWidget {
  const TaskFive({Key? key}) : super(key: key);

  @override
  State<TaskFive> createState() => _TaskFiveState();
}

class _TaskFiveState extends State<TaskFive> {
  TextEditingController _textFieldController = TextEditingController();
  List<int> numbers = [];
  int Pressed = 1;
  int? lastVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task 1",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: _textFieldController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Enter a number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final newVal = int.tryParse(_textFieldController.text);
                        if (newVal != null) {
                          if (Pressed == 1) {
                            for (int i = 1; i <= newVal; i++) {
                              numbers.add(i);
                            }
                            Pressed++;
                          } else {
                            final startVal = lastVal ?? 0;
                            for (int i = startVal + 1; i <= startVal + newVal; i++) {
                              numbers.add(i);
                            }
                          }
                          lastVal = numbers.last;
                          _textFieldController.clear();
                        }
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: numbers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: ListTile(
                      title: Text(
                        "Number is = ${numbers[index]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
