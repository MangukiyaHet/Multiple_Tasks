import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskOne extends StatefulWidget {
  const TaskOne({Key? key}) : super(key: key);

  @override
  State<TaskOne> createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  TextEditingController _textFieldController = TextEditingController();
  int? enteredNumber;
  int Pressed = 1;
  int? newVal;

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
                      LengthLimitingTextInputFormatter(3), // limit to 3 digits
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Enter a number',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      enteredNumber = int.tryParse(value);
                      newVal = (newVal ?? 0) + enteredNumber!;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Pressed++;
                        _textFieldController.clear();
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
            if (enteredNumber != null)
              Expanded(
                child: ListView.builder(
                  itemCount: newVal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: ListTile(
                        title: Text((index + 1).toString()),
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