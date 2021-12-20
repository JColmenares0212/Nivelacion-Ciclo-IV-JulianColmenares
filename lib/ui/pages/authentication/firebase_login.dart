import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';
import 'firebase_signup.dart';

class FirebaseLogIn extends StatefulWidget {
  @override
  _FirebaseLogInState createState() => _FirebaseLogInState();
}

class _FirebaseLogInState extends State<FirebaseLogIn> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  _login(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      // TODO
      await authenticationController.login(theEmail, thePassword);
      //Aquí llamar al método login del authenticationController con await
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Iniciar Sesion con E-mail",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                key: const ValueKey("loginEmail"),
                keyboardType: TextInputType.emailAddress,
                controller: controllerEmail,
                decoration:
                    const InputDecoration(labelText: "Correo Electronico"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingrese su E-mail";
                  } else if (!value.contains('@')) {
                    return "Ingrese un E-mail valido";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                key: const ValueKey("loginPassword"),
                controller: controllerPassword,
                decoration: const InputDecoration(labelText: "Password"),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingresar Contraseña";
                  } else if (value.length < 6) {
                    return "La contraseña debe contener al menos 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                key: const ValueKey("loginAction"),
                onPressed: () async {
                  // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                  FocusScope.of(context).requestFocus(FocusNode());
                  final form = _formKey.currentState;
                  form!.save();
                  if (_formKey.currentState!.validate()) {
                    await _login(controllerEmail.text, controllerPassword.text);
                  }
                },
                child: const Text("Ingresar"),
              ),
            ]),
          ),
          TextButton(
              onPressed: () {
                // TODO
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FirebaseSignUp())); //Aquí navegar a  FirebaseSignUp
              },
              child: const Text("Crear una cuenta"))
        ],
      ),
    );
  }
}
