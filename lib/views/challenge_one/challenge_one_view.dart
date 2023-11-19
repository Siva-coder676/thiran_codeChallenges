import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:thiran_task/cubits/case_one/case_one_cubit.dart';
import 'package:thiran_task/widgets/thiran_button.dart';

class ChallengeOneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EmailCubit emailCubit = BlocProvider.of<EmailCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Error Report App'),
      ),
      body: Center(
          child: ThiranButton(
        onTap: () {
          emailCubit.sendDailyErrorEmail();
        },
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.60,
        title: "Send Daily Error Email",
        fontSize: 14,
      )),
    );
  }
}
