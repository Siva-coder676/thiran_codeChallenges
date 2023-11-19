import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:thiran_task/cubits/case_three/case_three_cubit.dart';
import 'package:thiran_task/cubits/case_three/case_three_state.dart';
import 'package:thiran_task/views/challenge_three/ticket_form_screen.dart';

class ChallengeThreeView extends StatelessWidget {
  final String userId;

  ChallengeThreeView({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('My Tickets'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Tickets Found"),
            );
          } else {
            var tickets = snapshot.data!.docs;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: tickets.length,
              padding: EdgeInsets.all(5),
              itemBuilder: (context, index) {
                var ticket = tickets[index].data() as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Title :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(ticket['title']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Description :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(ticket['description'])
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Location :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(ticket['location'])
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Attachment Details :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(ticket['details']??"-")
                              ],
                            ),
                           
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketFormScreen(userId: userId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
