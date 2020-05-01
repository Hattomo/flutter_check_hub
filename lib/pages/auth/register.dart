import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/auth_service.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';

class Register extends StatefulWidget {
  Register({this.toggleView});
  final Function toggleView;


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();

  //unique key for each form
  final _formKey = GlobalKey<FormState>();
  String error = '';

  //loading flag
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loading
          ? const Text('Loading')
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton.icon(
                        icon: const Icon(Icons.person),
                        label: const Text('Sign In'),
                        color: Colors.pinkAccent[100],
                        onPressed: () => widget.toggleView(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink,
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //print(email);
                          //print(password);
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            await _auth
                                .registerWithEmailAndPassword(email, password);
                          } else {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          }
                        }),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
