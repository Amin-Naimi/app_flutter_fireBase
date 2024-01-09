import 'package:dsi32_flutter_project/features/auth/presentation/widgets/auth_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:validators/validators.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/user_manager/user_manager_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[800]!,
                Colors.blue[600]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AmoTech",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Discover a world of exclusive deals",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
/***************************************************************************************************************************/
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The name is required';
                            }
                            return null;
                          },
                          controller: _nameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFe7edeb),
                            hintText: "Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
/***************************************************************************************************************************/

                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'le email est obligatoire';
                            }
                            if (!isEmail(value)) {
                              return "email incorrect";
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFe7edeb),
                            hintText: "E-Mail",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
/***************************************************************************************************************************/

                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Le mot de passe est obligatoire';
                            } else if (value.length < 6) {
                              return 'Le mot de passe doit contenir au moins 6 caractères';
                            }
                            return null;
                          },
                          controller: _pwdController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFe7edeb),
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
/***************************************************************************************************************************/

                        BlocBuilder<UserManagerBloc, UserManagerState>(
                          builder: (context, state) {
                            if (state is RegisteringUserState) {
                              return const CircularProgressIndicator(
                                color: Color.fromARGB(255, 74, 72, 203),
                              );
                            } else {
                              return AuthButton(
                                text: "Sign Up",
                                onPressed: () {
                                  if (state is! RegisteringUserState) {
                                    validateAndRegisterUser();
                                  }
                                },
                                color: Colors.green,
                              );
                            }
                          },
                        ),

/****************************************************************************************/
                        const SizedBox(
                          height: 20.0,
                        ),
/****************************************************************************************/
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed('login');
                          },
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateAndRegisterUser() {
    if (_formKey.currentState!.validate()) {
      final user = UserEntity(
          name: _nameController.text,
          email: _emailController.text,
          password: _pwdController.text);

      BlocProvider.of<UserManagerBloc>(context).add(RegisterEvent(user: user));
    }
  }
}
