import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:thiran_task/views/challenge_one/challenge_one_view.dart';
import 'package:thiran_task/views/challenge_three/challenge_three_view.dart';
import 'package:thiran_task/views/challenge_two/challenge_two_view.dart';
import 'package:thiran_task/widgets/thiran_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Thiran Code Challenges",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            ThiranButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChallengeOneView()));
              },
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.33,
              title: "Challenge one",
              fontSize: 14,
            ),
            SizedBox(
              height: 20,
            ),
            ThiranButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChallengeTwoView()));
              },
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.33,
              title: "Challenge Two",
              fontSize: 14,
            ),
            SizedBox(
              height: 20,
            ),
            ThiranButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChallengeThreeView(
                              userId: "85",
                            )));
              },
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.33,
              title: "Challenge Three",
              fontSize: 14,
            )
          ],
        ),
      ),
    );
  }
}
