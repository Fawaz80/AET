import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_expense_tracker/screens/HomeScreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String errorMessage = '';

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Login failed. ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Added to prevent overflow on small screens
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 100),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Icon(Icons.mail_outline_outlined),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Your Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Don't have an account? Create one."),
            ],
          ),
        ),
      ),
    );
  }
}
// this code need to be modified to store data in firebase
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:auto_expense_tracker/screens/HomeScreen.dart';

// class Loginscreen extends StatefulWidget {
//   const Loginscreen({super.key});

//   @override
//   State<Loginscreen> createState() => _LoginscreenState();
// }

// class _LoginscreenState extends State<Loginscreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String errorMessage = '';
//   bool _isLoading = false;

//   Future<void> _createDummyData(String userId) async {
//     try {
//       // Check if user already has data
//       final doc = await _firestore.collection('users').doc(userId).get();
//       if (doc.exists) return;

//       // Create dummy data
//       final dummyUser = {
//         'user_id': userId,
//         'personal_info': {
//           'name': 'Ahmed Al Otaibi',
//           'dob': '1988-03-22',
//           'email': _emailController.text.trim(),
//         },
//         'preferences': {
//           'theme': 'light',
//           'language': 'ar',
//           'currency': 'SAR',
//           'notifications_enabled': true,
//         },
//         'bank_accounts': _generateBankAccounts(),
//         'created_at': FieldValue.serverTimestamp(),
//       };

//       await _firestore.collection('users').doc(userId).set(dummyUser);
//     } catch (e) {
//       print('Error creating dummy data: $e');
//       rethrow;
//     }
//   }

//   List<Map<String, dynamic>> _generateBankAccounts() {
//     final now = DateTime.now();
//     return [
//       {
//         'account_id': 'BA${now.millisecondsSinceEpoch}1',
//         'bank_name': 'ALRAJHI',
//         'account_number': 'SA0380000000608010167519',
//         'account_type': 'Checking',
//         'balance': 25000.50,
//         'transactions': _generateTransactions(30, 25000.50),
//       },
//       {
//         'account_id': 'BA${now.millisecondsSinceEpoch}2',
//         'bank_name': 'ALINMA',
//         'account_number': 'SA0310000000608010167519',
//         'account_type': 'Savings',
//         'balance': 18000.00,
//         'transactions': _generateTransactions(15, 18000.00),
//       },
//     ];
//   }

//   List<Map<String, dynamic>> _generateTransactions(int count, double initialBalance) {
//     final transactions = <Map<String, dynamic>>[];
//     final categories = ['Food', 'Groceries', 'Transport', 'Utilities', 'Shopping'];
//     final merchants = ['Carrefour', 'AlBaik', 'STC', 'Amazon', 'Panda', 'Uber'];
//     final locations = ['Riyadh', 'Jeddah', 'Dammam', 'Online'];
    
//     double balance = initialBalance;
//     final now = DateTime.now();

//     for (int i = 0; i < count; i++) {
//       final daysAgo = count - i;
//       final amount = (100 + (i * 50)) % 1000;
//       final isDeposit = i % 5 == 0;
//       final transactionAmount = isDeposit ? amount : -amount;
//       balance += transactionAmount;

//       transactions.add({
//         'transaction_id': 'T${now.millisecondsSinceEpoch}$i',
//         'amount': transactionAmount.abs(),
//         'type': isDeposit ? 'deposit' : 'expense',
//         'date': Timestamp.fromDate(now.subtract(Duration(days: daysAgo))),
//         'category': categories[i % categories.length],
//         'merchant': merchants[i % merchants.length],
//         'location': locations[i % locations.length],
//         'balance_after': balance,
//       });
//     }

//     return transactions;
//   }

//   Future<void> _login() async {
//     setState(() {
//       _isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();

//       if (email.isEmpty || password.isEmpty) {
//         throw 'Please enter both email and password';
//       }

//       final userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       await _createDummyData(userCredential.user!.uid);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Login successful!')),
//       );
      
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = _parseFirebaseError(e);
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   String _parseFirebaseError(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'user-not-found':
//         return 'No user found with this email';
//       case 'wrong-password':
//         return 'Incorrect password';
//       case 'invalid-email':
//         return 'Invalid email address';
//       case 'user-disabled':
//         return 'This account has been disabled';
//       case 'too-many-requests':
//         return 'Too many attempts. Try again later';
//       default:
//         return 'Login failed. Please try again';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Login",
//                   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 100),
//               TextField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   hintText: "Enter your Email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   prefixIcon: Icon(Icons.mail_outline_outlined),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: "Password",
//                   hintText: "Enter Your Password",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   prefixIcon: Icon(Icons.lock_outline),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               if (errorMessage.isNotEmpty)
//                 Text(
//                   errorMessage,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 width: 300,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _login,
//                   child: _isLoading
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Colors.white,
//                           ),
//                         )
//                       : const Text("Login"),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text("Don't have an account? Create one."),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }