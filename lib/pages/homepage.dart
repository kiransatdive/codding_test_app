import 'package:coding_app_design/pages/test_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Personal Details")),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more email validation logic here if needed
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // You can add more password validation logic here if needed
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CheckboxListTile(
                    title: Text("I agree to the Terms and Conditions"),
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _agreeToTerms) {
                        // Form is valid and terms are agreed, navigate to the next page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TestPage()),
                        );
                      } else {
                        // Show an error message if terms are not agreed
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Please agree to the Terms and Conditions'),
                        ));
                      }
                    },
                    child: Text('Start Test'),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
