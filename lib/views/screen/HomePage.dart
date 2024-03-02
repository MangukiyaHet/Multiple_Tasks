import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HomePage",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text(
                  "Task 1",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: const Text(
                  "02/03/2024",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                leading: const Text(
                  "1",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('Task1');
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text(
                  "Task 2",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: const Text(
                  "02/03/2024",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                leading: const Text(
                  "2",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('Task2');
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
