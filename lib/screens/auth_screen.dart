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
      appBar: AppBar(
        title: Text("Alışveriş Uygulaması"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              child: Container(
            color: Colors.white,
            height: deviceSize.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        size: 64,
                      ),
                      Text(
                        'Alışveriş Uygulaması',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
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
    var _borderError = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Theme.of(context).errorColor),
        gapPadding: 5);
    var _border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black54),
        gapPadding: 5);
    var _errorColor =
        TextStyle(color: Theme.of(context).errorColor, fontSize: 10);

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'E-Mail',
                  errorBorder: _borderError,
                  errorStyle: _errorColor,
                  border: _border),
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
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.lock_outlined),
                  labelText: 'Şifre',
                  errorBorder: _borderError,
                  errorStyle: _errorColor,
                  border: _border),
              obscureText: true,
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Şifreniz en az 6 karakterli olmalıdır!';
                }
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            SizedBox(
              height: 15,
            ),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                enabled: _authMode == AuthMode.Signup,
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.lock_outlined),
                    labelText: 'Şifre Tekrar',
                    errorBorder: _borderError,
                    errorStyle: _errorColor,
                    border: _border),
                obscureText: true,
                validator: _authMode == AuthMode.Signup
                    ? (value) {
                        if (value != _passwordController.text) {
                          return 'Şifreler uyuşmamaktadır!';
                        }
                      }
                    : null,
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
