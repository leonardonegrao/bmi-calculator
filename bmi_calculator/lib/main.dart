import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _infoText = 'Insert your information';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    _weightController.text = '';
    _heightController.text = '';

    setState(() {
      _infoText = 'Insert your information';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;

    double bmi = weight / (height * height);
    String formattedBmi = bmi.toStringAsPrecision(4);

    setState(() {
      if (bmi < 18.6) {
        _infoText = 'BMI: $formattedBmi. Your weight is below the ideal';
      } else if (bmi >= 18.6 && bmi <= 24.9) {
        _infoText = 'BMI: $formattedBmi. Your weight is ideal';
      } else if (bmi >= 24.9 && bmi <= 29.9) {
        _infoText = 'BMI: $formattedBmi. Your weight is slightly above ideal';
      } else if (bmi >= 29.9 && bmi <= 34.9) {
        _infoText = 'BMI: $formattedBmi. Your weight is considered Obese I';
      } else if (bmi >= 34.9 && bmi <= 39.9) {
        _infoText = 'BMI: $formattedBmi. Your weight is considered Obese II';
      } else if (bmi >= 40.0) {
        _infoText = 'BMI: $formattedBmi. Your weight is considered Obese III';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _resetFields(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Your weight (KG)',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please, inform your weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Your height (cm)',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please, inform your height';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Container(
                  height: 56.0,
                  child: RaisedButton(
                    onPressed: () => _calculate(),
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
