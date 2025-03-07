import 'package:flutter/material.dart';
import 'package:mealci/components/navbar.dart';
import 'package:mealci/components/save_poop_button.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class RegisterPoopPage extends StatefulWidget {
  const RegisterPoopPage({super.key});

  @override
  State<RegisterPoopPage> createState() => _RegisterPoopPageState();
}

class _RegisterPoopPageState extends State<RegisterPoopPage>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  final _formKey = GlobalKey<FormState>();
  String _feeling = '';

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 2,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  void _setFeeling(String feeling) {
    setState(() {
      _feeling = feeling;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Poop Page'),
      ),
      body: Stack(
        children: [
          SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Enregistrement',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Voltaire',
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Comment te sentais tu ?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Voltaire',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Text('😊',
                                            style: TextStyle(fontSize: 30)),
                                        onPressed: () => _setFeeling('happy'),
                                      ),
                                      IconButton(
                                        icon: Text('😢',
                                            style: TextStyle(fontSize: 30)),
                                        onPressed: () => _setFeeling('sad'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: _feeling,
                          decoration: InputDecoration(
                            labelText: 'Feeling',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        SavePoopButton(onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Envoyer les données au back
                            print("it's ok");
                          }
                        })
                      ],
                    ),
                  ))),
        ],
      ),
      bottomNavigationBar: NavBar(
        controller: _motionTabBarController!,
        onTabSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}
