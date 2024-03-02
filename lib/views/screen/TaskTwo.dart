import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskTwo extends StatefulWidget {
  const TaskTwo({Key? key}) : super(key: key);

  @override
  State<TaskTwo> createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  TextEditingController _textFieldController = TextEditingController();
  List<int> numbersToShow = [];
  List<int> allNumbers = List.generate(100, (index) => index + 1);
  bool showOdd = false;
  bool showEven = false;

  void updateNumbersToShow(int enteredNumber) {
    if (enteredNumber != null && enteredNumber <= 100) {
      numbersToShow = allNumbers.sublist(0, enteredNumber);
    } else {
      numbersToShow = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task 2",
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
                  flex: 3,
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
                    onChanged: (value) {
                      setState(() {
                        int? entered = int.tryParse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: numbersToShow.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: ListTile(
                      title: Text(numbersToShow[index].toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            onPressed: () {
              setState(() {
                showOdd = true;
                showEven = false;
                updateNumbersToShow(int.parse(_textFieldController.text));
                numbersToShow = numbersToShow.where((num) => num % 2 != 0).toList();
              });
            },
            child: const Text("Odd"),
          ),
          const SizedBox(width: 20,),
          FloatingActionButton(
            mini: true,
            onPressed: () {
              setState(() {
                showOdd = false;
                showEven = true;
                updateNumbersToShow(int.parse(_textFieldController.text));
                numbersToShow = numbersToShow.where((num) => num % 2 == 0).toList();
              });
            },
            child: const Text("Even"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
