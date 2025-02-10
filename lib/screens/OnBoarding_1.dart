import 'package:flutter/material.dart';
import 'package:auto_expense_tracker/screens/OnBoarding_2.dart';
class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/onboarding1.png'),
            SizedBox(
              height: 30,
            ),
            Text(
              'Track Your Spending',
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
                'Easily manage and monitor all your expenses in one place',
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
                    color: const Color.fromARGB(250, 208, 208, 208),
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
                    color: const Color.fromARGB(250, 208, 208, 208),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
            ),
            SizedBox(
              width: 310,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Onboarding2()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(250, 18, 100, 211)),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: const Color.fromARGB(250, 247, 248, 250),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}