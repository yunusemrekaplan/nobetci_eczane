import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nobetci_eczane/screens/home_screen.dart';
import 'package:nobetci_eczane/screens/main_screen.dart';
import 'package:nobetci_eczane/services/pharmacy_service.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      routes: {
        '/': (BuildContext context) => const MainScreen(),
        '/home': (BuildContext context) => const HomeScreen(),
      },
      initialRoute: '/',
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
  String name = '';
  String address = '';
  String number = '';
  String district = '/nobetci-istanbul';

  void _incrementCounter() async {
    setState(() {
      PharmacyService.getPharmacyNames(district).then((value) => name = value!.first);
      PharmacyService.getPharmacyAddresses(district).then((value) => address = value!.first);
      PharmacyService.getPharmacyNumbers(district).then((value) => number = value!.first);
    });
    print(name);
    print(address);
    print(number);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              address,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              number,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
