import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _num1 = 0;
  int _num2 = 0;
  int _sum = 0;

  Future<void> _calcSum() async {
    const channel = MethodChannel('cod3r.com.br/nativo');

    try {
      final sum = await channel.invokeMethod('calcSum', {
        "num1": _num1,
        "num2": _num2,
      });

      setState(() {
        _sum = sum;
      });
    } on PlatformException catch (e) {
      setState(() {
        _sum = 0;
      });
    }

    setState(() {
      _sum = _num1 + _num2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nativo'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Soma...$_sum',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _num1 = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _num2 = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextButton(onPressed: _calcSum, child: Text('Somar'))
            ],
          ),
        ),
      ),
    );
  }
}
