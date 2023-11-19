import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thiran_task/cubits/case_two/case_two_cubit.dart';
import 'package:thiran_task/cubits/case_two/case_two_state.dart';

class ChallengeTwoView extends StatelessWidget {
  const ChallengeTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Starred Github Repos App'),
      ),
      body: BlocBuilder<RepoCubit, RepoState>(
        builder: (context, state) {
          if (state is RepoLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (state is RepoLoaded) {
            return ListView.builder(
              itemCount: state.repos.length,
              itemBuilder: (context, index) {
                final repo = state.repos[index];
                return ListTile(
                  title: Text(repo.name),
                  subtitle: Text(repo.description),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(repo.ownerAvatarUrl),
                  ),
                  trailing: Text('${repo.stars} stars'),
                );
              },
            );
          } else if (state is RepoError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
