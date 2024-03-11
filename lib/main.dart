import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teklifimgelsin_feature/blocs/loan_bloc.dart';
import 'package:teklifimgelsin_feature/screens/search_form_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoanBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loan Offers',
        theme: ThemeData(),
        home: const SearchFormPage(),
      ),
    );
  }
}
