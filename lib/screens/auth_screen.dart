import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange[100],
                  Colors.orange[300],
                  Colors.orange[500],
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: deviceSize.height * .1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 72,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Alışveriş Uygulaması',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: deviceSize.height * .1,
                ),
                Flexible(flex: 2, child: AuthCard()),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        //Log user in
        await Provider.of<Auth>(context, listen: false)
            .logIn(_authData['email'], _authData['password'])
            .then((value) => Navigator.of(context)
                .popAndPushNamed(ProductOverViewScreen.routeName));
      } else {
        //Sign user up
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
      }
    } catch (error) {
      var message = error.toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _errorColor = TextStyle(
      color: Theme.of(context).errorColor,
      fontSize: 12,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 20.0,
          ),
        ],
        color: Colors.amber[50],
      ),
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 7,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    constraints: BoxConstraints(minHeight: 50, maxHeight: 75),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'E-Mail',
                        errorStyle: _errorColor,
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Hatalı email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    constraints: BoxConstraints(minHeight: 50, maxHeight: 75),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outlined),
                          labelText: 'Şifre',
                          errorStyle: _errorColor,
                          border: InputBorder.none),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Şifreniz en az 6 karakterli olmalıdır!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                  ),
                  //if (_authMode == AuthMode.Signup)
                  AnimatedContainer(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    constraints: BoxConstraints(
                        minHeight: _authMode == AuthMode.Signup ? 50 : 0,
                        maxHeight: _authMode == AuthMode.Signup ? 75 : 0),
                    child: _authMode == AuthMode.Signup
                        ? TextFormField(
                            enabled: _authMode == AuthMode.Signup,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outlined),
                                labelText: 'Şifre Tekrar',
                                errorStyle: _errorColor,
                                border: InputBorder.none),
                            obscureText: true,
                            validator: _authMode == AuthMode.Signup
                                ? (value) {
                                    if (value != _passwordController.text) {
                                      return 'Şifreler uyuşmamaktadır!';
                                    } else {
                                      return "";
                                    }
                                  }
                                : null,
                          )
                        : null,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                child:
                    Text(_authMode == AuthMode.Login ? 'GİRİŞ YAP' : 'ÜYE OL'),
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * .7, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                ),
              ),
            SizedBox(
              height: 15,
            ),
            OutlinedButton(
              child: Text(
                  '${_authMode == AuthMode.Login ? 'ÜYE OL' : 'GİRİŞ YAP'}'),
              onPressed: _switchAuthMode,
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * .7, 40),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}
