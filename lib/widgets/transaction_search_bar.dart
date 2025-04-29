import 'package:flutter/material.dart';

class TransactionSearchBar extends StatelessWidget {
  const TransactionSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notification press
          },
        ),
        // Search field in the middle
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Transactions...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            ),
            onChanged: (value) {
              // Handle search input
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            // Handle user icon press
          },
        ),
      ],
    );
  }
}