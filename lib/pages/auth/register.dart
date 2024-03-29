import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/auth_service.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';

@immutable
class Register extends StatefulWidget {
  const Register({this.toggleView});
  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();

  //unique key for each form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';

  //loading flag
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CupertinoActivityIndicator())
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.person),
                        label: const Text('Sign In'),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.pinkAccent[100],
                            primary: Colors.white),
                        onPressed: () => widget.toggleView(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (String val) =>
                          val.isEmpty ? 'Enter an email' : null,
                      onChanged: (String val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (String val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      obscureText: true,
                      onChanged: (String val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.pink),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //print(email);
                          //print(password);
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            final dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result != null) {
                              //User user = User(uid: result.uid);
                              databaseServiceUser.createuserData(result.uid);
                            }
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
