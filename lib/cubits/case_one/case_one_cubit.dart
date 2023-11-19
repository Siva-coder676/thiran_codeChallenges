import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thiran_task/cubits/case_one/case_one_state.dart';
import 'package:bloc/bloc.dart';
import 'package:thiran_task/models/transaction_data.dart';

import 'package:thiran_task/services/email_service.dart';

import '../../services/database_service.dart';

class EmailCubit extends Cubit<EmailState> {
  final dbHelper = DatabaseHelper();
  final EmailComponent _emailComponent = EmailComponent();

  EmailCubit() : super(EmailInitialState());

  void sendDailyErrorEmail() async {
    try {
      emit(EmailLoadingState());

      await dbHelper.initializeDatabase();

      await dbHelper.insertTransaction(TransactionData(
        transId: 1,
        transDesc: 'UpdateTask',
        transStatus: 'Success',
        transDateTime: '12-05-2022 10:00',
      ));
      await dbHelper.insertTransaction(TransactionData(
        transId: 2,
        transDesc: 'UpdateStatus',
        transStatus: 'Pending',
        transDateTime: '12-05-2022 11:00',
      ));
      await dbHelper.insertTransaction(TransactionData(
        transId: 3,
        transDesc: 'UpdatePerson',
        transStatus: 'Error',
        transDateTime: '12-05-2022 11:02',
      ));
      List<TransactionData> errorTransactions =
          await dbHelper.getErrorTransactions();
      if (errorTransactions.isNotEmpty) {
        Logger().d(errorTransactions.length.toString());
        _emailComponent.sendEmail('sivaprajee@gmail.com', errorTransactions);
        emit(EmailSuccessState());
      } else {
        emit(EmailSuccessState());
      }
    } catch (e) {
      Logger().e(e.toString());
      emit(EmailErrorState());
    }
  }
}
