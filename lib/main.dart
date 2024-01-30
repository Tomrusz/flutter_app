import 'package:flutter/material.dart';

void main() {
  runApp(const CostShareApp());
}

class CostShareApp extends StatelessWidget {
  const CostShareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cost Share',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const CostShareHomePage(),
    );
  }
}

class CostShareHomePage extends StatefulWidget {
  const CostShareHomePage({Key? key}) : super(key: key);

  @override
  State<CostShareHomePage> createState() => _CostShareHomePageState();
}

class _CostShareHomePageState extends State<CostShareHomePage> {
  final TextEditingController _billController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _tipController = TextEditingController();

  int numberOfPeople = 1;
  double tipPercentage = 0.0;

  double tipAmount = 0.0;
  double totalAmount = 0.0;
  double totalAmountPerPerson = 0.0;

  void updateTipPercentage(double percentage) {
    setState(() {
      tipPercentage = percentage;
    });
  }

  void updateNumberOfPeople(int number) {
    setState(() {
      numberOfPeople = number;
    });
  }

  void showCustomTipDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: const Text('Input custom amount of tip'),
            actions: [
              TextField(
                keyboardType: TextInputType.number,
                controller: _tipController,
              ),
              ElevatedButton(
                onPressed: () => updateTipPercentage(double.parse(_tipController.text)/100),
                child: const Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomPeopleNumberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: const Text('Input custom amount of people'),
            actions: [
              TextField(
                keyboardType: TextInputType.number,
                controller: _peopleController,
              ),
              ElevatedButton(
                onPressed: () => updateNumberOfPeople(int.parse(_peopleController.text)),
                child: const Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _calculateTotalAmount() {
    tipAmount = double.parse(_billController.text)*tipPercentage;
    totalAmount = double.parse(_billController.text)+tipAmount;
    totalAmountPerPerson = totalAmount/numberOfPeople;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            actions: [
              Text(
                  "Total amount: $totalAmount"
              ),
              Text(
                  "Tip amount: $tipAmount"
              ),
              Text(
                  "Amount per person: $totalAmountPerPerson"
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cost Share'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Input Bill Amount:"),
            TextField(
              keyboardType: TextInputType.number,
              controller: _billController,
            ),
            const SizedBox(height: 20),
            Text("Select Number of people:"),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => updateNumberOfPeople(1),
                  child: const Text("1"),
                ),
                ElevatedButton(
                  onPressed: () => updateNumberOfPeople(2),
                  child: const Text("2"),
                ),
                ElevatedButton(
                  onPressed: () => updateNumberOfPeople(3),
                  child: const Text("3"),
                ),
                ElevatedButton(
                  onPressed: () => updateNumberOfPeople(4),
                  child: const Text("4"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => showCustomPeopleNumberDialog(),
              child: const Text("Custom"),
            ),
            const SizedBox(height: 20),
            Text("Selected number of people: $numberOfPeople"),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => updateTipPercentage(0.10),
                  child: const Text("10%"),
                ),
                ElevatedButton(
                  onPressed: () => updateTipPercentage(0.15),
                  child: const Text("15%"),
                ),
                ElevatedButton(
                  onPressed: () => updateTipPercentage(0.20),
                  child: const Text("20%"),
                ),
                ElevatedButton(
                  onPressed: () => updateTipPercentage(0.30),
                  child: const Text("30%"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => showCustomTipDialog(),
              child: const Text("Custom"),
            ),
            Text("Selected tip percentage: ${(tipPercentage * 100).toStringAsFixed(0)}%"),
            ElevatedButton(

              onPressed: () => _calculateTotalAmount(),
              child: const Text("Count up the bill"),
            ),
          ],
        ),
      ),
    );
  }
}