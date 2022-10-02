import 'package:flutter/material.dart';
import 'package:fotografos/providers/providers.dart';
import 'package:fotografos/services/services.dart';
import 'package:fotografos/themes/app_themems.dart';
import 'package:fotografos/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
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
                      Text('Crear Cuenta',
                          style: Theme.of(context).textTheme.headline4),
                      const SizedBox(height: 30),
                      ChangeNotifierProvider(
                        create: (_) => RegisterFormProvider(),
                        child: _RegisterForm(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              FadeInUp(
                child: TextButton(
                  child: const Text(
                    "Ya tengo una cuenta",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.green.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
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

class _RegisterForm extends StatefulWidget {
  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final Color mainColor = AppTheme.primary;

  final Color labelColor = Colors.grey;
  final textController = TextEditingController();

  bool _passwordVisible = true;
  bool _passwordCheckVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _passwordCheckVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    final now = DateTime.now();
    final accepted = DateTime(now.year - 18, now.month, now.day - 1);

    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          //* Name Field
          TextFormField(
            enabled: registerForm.isLoading ? false : true,
            autocorrect: false,
            keyboardType: TextInputType.name,
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
              hintText: "Lionel Messi",
              labelText: "Nombre Completo",
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Icon(
                Icons.person_outline,
                color: mainColor,
              ),
            ),
            onChanged: (value) => registerForm.name = value,
            validator: (value) {
              return value != null && value.isNotEmpty
                  ? null
                  : 'Debe Ingresar Nombre y Apellido';
            },
          ),
          const SizedBox(height: 30),

          //* CI Field
          TextFormField(
            enabled: registerForm.isLoading ? false : true,
            autocorrect: false,
            keyboardType: TextInputType.number,
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
              hintText: "12345678",
              labelText: "Carnet de Identidad",
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Icon(
                Icons.credit_card_outlined,
                color: mainColor,
              ),
            ),
            onChanged: (value) => registerForm.ci = value,
            validator: (value) {
              return value != null && value.isNotEmpty
                  ? null
                  : 'Debe Ingresar CI';
            },
          ),
          const SizedBox(height: 30),

          //* Password Input
          TextFormField(
            enabled: registerForm.isLoading ? false : true,
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
            onChanged: (value) => registerForm.password = value,
            validator: (value) {
              return value == registerForm.checkPassword
                  ? null
                  : 'Contraseñas no son iguales';
            },
          ),
          const SizedBox(height: 30),

          //* Check Password Input
          TextFormField(
            enabled: registerForm.isLoading ? false : true,
            autocorrect: false,
            obscureText: _passwordCheckVisible,
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
              labelText: "Verificar Contraseña",
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Icon(
                Icons.verified_user_outlined,
                color: mainColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordCheckVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: labelColor,
                ),
                onPressed: () {
                  setState(() {
                    _passwordCheckVisible = !_passwordCheckVisible;
                  });
                },
              ),
            ),
            onChanged: (value) => registerForm.checkPassword = value,
            validator: (value) {
              return value == registerForm.password
                  ? null
                  : 'Contraseñas no son iguales';
            },
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
                registerForm.isLoading ? 'Verificando...' : 'Enviar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;
                    final String? errorMessage = await authService.register(
                      name: registerForm.name,
                      email: registerForm.email,
                      password: registerForm.password,
                    );

                    // if (errorMessage == null) {
                    //   final petBloc = BlocProvider.of<PetBloc>(context);
                    //   petBloc.add(const OnLoadMyPetsEvent());
                    //   Navigator.pushReplacementNamed(context, 'wall');
                    // } else {
                    //   NotificationsService.showSnackbarDanger(errorMessage);
                    //   registerForm.isLoading = false;
                    // }
                  },
          ),
        ],
      ),
    );
  }
}
