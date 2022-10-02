import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fotografos/providers/providers.dart';
import 'package:fotografos/themes/app_themems.dart';
import 'package:fotografos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              FadeInLeft(
                child: CardContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text('Login',
                          style: Theme.of(context).textTheme.headline4),
                      const SizedBox(height: 30),
                      ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: _LoginForm(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              FadeInUp(
                child: TextButton(
                  child: const Text(
                    "Crear una nueva Cuenta",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.green.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'register'),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final Color mainColor = AppTheme.primary;

  final Color labelColor = Colors.grey;

  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          //Email Input
          TextFormField(
            enabled: loginForm.isLoading ? false : true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: mainColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              ),
              hintText: "ejemplo123@gmail.com",
              labelText: "Email",
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Icon(
                Icons.alternate_email_rounded,
                color: mainColor,
              ),
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no tiene formato de correo';
            },
          ),
          const SizedBox(height: 30),

          //Password Input
          TextFormField(
            enabled: loginForm.isLoading ? false : true,
            autocorrect: false,
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: mainColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              ),
              labelText: "Contraseña",
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: mainColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: labelColor,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            onChanged: (value) => loginForm.password = value,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: labelColor,
            color: mainColor,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 70,
                vertical: 15,
              ),
              child: Text(
                loginForm.isLoading ? 'Verificando...' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    //final authService =
                      //Provider.of<AuthService>(context, listen: false);
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;
//                    final String? errorMessage = await authService.login(
  //                    email: loginForm.email,
    //                  password: loginForm.password,
      //              );

        //            if (errorMessage == null) {
                      //final petBloc = BlocProvider.of<PetBloc>(context);
                      //petBloc.add(const OnLoadMyPetsEvent());
              //        Navigator.pushReplacementNamed(context, 'wall');
          //          } else {
                      //NotificationsService.showSnackbarDanger(errorMessage);
            //          loginForm.isLoading = false;
                //    }
                  },
          ),
        ],
      ),
    );
  }
}
