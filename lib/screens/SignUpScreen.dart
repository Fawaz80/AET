import 'package:flutter/material.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color.fromRGBO(233, 233, 233, 1)),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            " Create an \n Account",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          width: 380,
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.grey,
              labelText: "Email",
              hintText: "Enter your Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.red, width: 100),
              ),
              // Adds a border around the input field
              prefixIcon:
                  Icon(Icons.mail_outline_outlined, color: Colors.blueAccent),
            ), // Adds an icon inside the field
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          width: 380,
          child: TextField(
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter Your Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.red, width: 100),
              ),
              // Adds a border around the input field
              prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent),
            ), // Adds an icon inside the field
          ),
        ), const SizedBox(
          height: 30,
        ),
        const SizedBox(
          width: 380,
          child: TextField(
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Confirm your Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.red, width: 100),
              ),
              // Adds a border around the input field
              prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent),
            ), // Adds an icon inside the field
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Radio<int>(
              value: 1, // This is the value of this radio button
              groupValue: 1, // This is the selected value in the group
              onChanged: (int? value) {
                // Handle the value change
              },
            ),
            const SizedBox(
                width: 10), // Adds spacing between the button and text
            const Text(
                "I agree to the terms"), // Text next to the toggle button
          ],
        ),
        const SizedBox(
          height: 80,
        ),
        Center(
          child: SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Create an Account"),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text("Have an Account? Login"),
        ),
        const SizedBox(
          height: 10,
        ),
        
      ],
    );
  }
}
