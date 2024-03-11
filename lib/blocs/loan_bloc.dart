import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teklifimgelsin_feature/models/loan_offer.dart';
import 'package:teklifimgelsin_feature/models/loan_request.dart';
import 'package:teklifimgelsin_feature/repositories/loan_repository.dart';

abstract class LoanEvent {}

class FetchLoanOffers extends LoanEvent {
  final LoanRequest request;

  FetchLoanOffers(this.request);
}

abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanLoading extends LoanState {}

class LoanLoaded extends LoanState {
  final LoanRequest request;
  final List<LoanOffer> offers;

  LoanLoaded(this.request, this.offers);
}

class LoanError extends LoanState {
  final String message;

  LoanError(this.message);
}

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  final LoanRepository _loanRepository = LoanRepository();

  LoanBloc() : super(LoanInitial()) {
    on<FetchLoanOffers>(_onFetchLoanOffers);
  }

  Future<void> _onFetchLoanOffers(
    FetchLoanOffers event,
    Emitter<LoanState> emit,
  ) async {
    emit(LoanLoading());
    try {
      final offers = await _loanRepository.fetchLoanOffers(event.request);
      emit(LoanLoaded(event.request, offers));
    } catch (e) {
      emit(LoanError('Failed to fetch loan offers'));
    }
  }
}
