import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SharedPreferenceExample(),
    );
  }
}

class SharedPreferenceExample extends StatefulWidget {
  const SharedPreferenceExample({super.key});

  @override
  State<SharedPreferenceExample> createState() =>
      _SharedPreferenceExampleState();
}

class _SharedPreferenceExampleState extends State<SharedPreferenceExample> {
  bool isDarkMode = false;
  TextEditingController nameController = TextEditingController();

  Future<void> updatePrefernce() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkMode", isDarkMode);
    prefs.setString("name", nameController.text);
  }

  Future<void> loadPrefernces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool("isDarkMode") ?? false;
      nameController.text = prefs.getString("name") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    loadPrefernces();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SharedPreferences Demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text("Dark Mode"),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  updatePrefernce();
                },
              ),
              const SizedBox(
                height: 200,
              ),
              TextField(
                controller: nameController,
                onChanged: (value) {
                  updatePrefernce();
                },
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Wlecome ${nameController.text}"),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isDarkMode = isDarkMode;
                    });
                    updatePrefernce();
                  },
                  child: const Text("Save Name"))
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", nameController.text);
    prefs.setBool("isDarkMode", true);
    prefs.setInt("age", 26);
    prefs.setDouble("salary", 20320.02);
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString("name") ?? "";
  }

  Future<void> updateUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkMode", false);
  }

  Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("name"); //clear single key data
    prefs.clear(); //clear all sharedpreference data
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nameController,
            ),
            ElevatedButton(
                onPressed: () {
                  saveData();
                },
                child: const Text("Save Name"))
          ],
        ),
      ),
    );
  }
}
