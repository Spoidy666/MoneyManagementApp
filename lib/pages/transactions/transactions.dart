import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available balance",
                    ),
                    Text(
                      "\$10000",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            
            Expanded(
              child: Container(
                child: ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (ctx, index) {
                      return const Card(
                        elevation: 20,
                        child: ListTile(
                            trailing: Text('15-02-2025'),
                            title: Text('Amount spend'),
                            subtitle: Text('Travel')),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
