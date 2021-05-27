import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/auth_service.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';

@immutable
class SignIn extends StatefulWidget {
  const SignIn({this.toggleView});
  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();
  //unique key for form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';

  //loading flag
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    //print("singin");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CupertinoActivityIndicator())
          : Container(
              height: MediaQuery.of(context).size.height,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          icon: const Icon(Icons.person),
                          label: const Text('Register'),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.pink[300],
                              primary: Colors.white
                              //onSurface: Colors.white
                              ),
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
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                        ),
                        validator: (String val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (String val) {
                          setState(() => password = val);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.pink),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            //print(email);
                            //print(password);
                            //if validate each form
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              await _auth.signInWithEmailAndPassword(
                                  email, password);
                            } else {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }),
                      const SizedBox(height: 12.0),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
