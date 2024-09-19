import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xposed_or_not_flutter/pages/home_page.dart';

class EmailEnterPage extends StatefulWidget {
  const EmailEnterPage({super.key});

  @override
  State<EmailEnterPage> createState() => _EmailEnterPageState();
}

class _EmailEnterPageState extends State<EmailEnterPage> {
  // variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // methods
  Future<void> _saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', _emailController.text.trim());

    // Redirect to HomeScreen after saving email
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  Future<void> _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameController.text.trim());
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context)
                  .size
                  .height, // Ensures the column takes the full height of the screen
            ),
            child: IntrinsicHeight(
              // Allows the Spacer() to work correctly
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/splash.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white60,
                              Color.fromARGB(0, 255, 255, 255),
                            ],
                          ),
                        ),
                        height: 70,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("XposedOrNot.",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        const SizedBox(height: 10),
                        const Text('Stay ahead of ',
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        Text('data breaches and exposed passwords.',
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo[300])),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your email',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: const ButtonStyle(
                            shape:
                                WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.indigo),
                            minimumSize: WidgetStatePropertyAll(
                                Size(double.infinity, 70)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveName().then((v) => _saveEmail());
                            }
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Get Started',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_rounded,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
