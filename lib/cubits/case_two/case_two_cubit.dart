import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:thiran_task/cubits/case_two/case_two_state.dart';
import 'package:thiran_task/models/repository.dart';

class RepoCubit extends Cubit<RepoState> {
  RepoCubit() : super(RepoLoading());

  Future<void> fetchRepos() async {
    try {
      final repos = await _fetchRepos();
      emit(RepoLoaded(repos));
    } catch (e) {
      emit(RepoError("Failed to fetch repositories"));
    }
  }

  Future<List<Repository>> _fetchRepos() async {
    final response = await http.get(Uri.parse(
        'https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => Repository.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
