import 'package:flutter/material.dart';
class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/onboarding3.png'),
          SizedBox(
            height: 30,
          ),
          Text(
            'Start Your Journey!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            child: Text(
              'Track your spending and stay on budget',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(250, 143, 144, 146),
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(250, 18, 100, 211),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 60,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(250, 18, 100, 211),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 60,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(250, 18, 100, 211),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 130,
          ),
          SizedBox(
            width: 310,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Onboarding3()), // Here is where you go to sign up
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(250, 18, 100, 211)),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: const Color.fromARGB(250, 247, 248, 250),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 310,
            height: 50,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Onboarding3()), // Here is where you go to sign in
                  );
                },
                style: ButtonStyle(
                  side: WidgetStateProperty.all<BorderSide>(BorderSide(
                      color: const Color.fromARGB(250, 18, 100, 211))),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: const Color.fromARGB(250, 18, 100, 211),
                  ),
                )),
          ),
        ],
      )),
    );
  }
}