import 'package:flutter/material.dart';
import 'package:logic_app/views/utils/ListUtils.dart';
import 'package:logic_app/views/utils/VariableUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        actions: [
          IconButton(
            onPressed: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setBool(UserKey, false);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('LoginPage', (route) => false);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: Tasks.map((task) {
            return Card(
              child: ListTile(
                title: Text(
                  task['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  task['date'],
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                leading: Text(
                  task['number'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(task['routeName']);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
