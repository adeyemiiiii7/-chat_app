import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  File? _selectedImage;
  var _isAuthenticationg = false;
  void _submit() async {
    final isValid = _formkey.currentState!.validate();

    // if (isValid) {
    //   _formkey.currentState!.save();
    //   print(_enteredEmail);
    //   print(_enteredPassword);
    // }
    if (!isValid || !_isLogin && _selectedImage == null) {
      //show an error message
      return;
    }
    _formkey.currentState!.save();
    // if(!_isLogin && _selectedImage == null) {
  
    

    try {
      setState(() {
        _isAuthenticationg = true;
      });
      if (_isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        // print(userCredential);
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        // print(userCredential);
       final storageReference =  FirebaseStorage.instance.
       ref().
       child('user_images').
       child('${userCredential.user!.uid}.jpg');
        //child is path
         await storageReference.putFile(_selectedImage!);

         //to get the picture stored in firebase
         //use await it's a future
         final imageUrl = await storageReference.getDownloadURL();
        //  print(imageUrl);
      // this would then create a new document in the firebase firestorage
      await FirebaseFirestore.instance
      .collection('users').
      doc('userCredential.user!.uid')
      .set({'username' : _enteredUsername,
      'email': _enteredEmail,
      'imageUrl': imageUrl
          });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Authentication Failed.')),
      );
      setState(() {
        _isAuthenticationg = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                width: 200,
                child: Image.asset('assets/images/logo.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    //declare the formkey in your form widget to hold all inputed values
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin) UserImagePicker(onPickImage: (pickedImage) {_selectedImage = pickedImage;
                          },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please a enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          if(!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Username',prefixIcon: Icon(Icons.person),),
                            enableSuggestions: false,
                            validator: (value) {
                              if(value == null|| value.isEmpty || value.trim().length< 4){
                                return'please enter at least 4 characters.';
                              }
                              return null;
                            },
                            onSaved: (value){
                              _enteredUsername = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().length < 6 ||
                                  !value.contains(RegExp(r'\d'))) {
                                return 'Password must be at least 6 characters long and contain a number.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                    
                          const SizedBox(height: 24),
                          if(_isAuthenticationg)
                          const CircularProgressIndicator(),
                          if(!_isAuthenticationg)
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(
                              _isLogin ? 'Login' : 'Signup',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? 'Create an account'
                                  : 'I already have an account',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
