import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'top_selling_event.dart';
part 'top_selling_state.dart';

class TopSellingBloc extends Bloc<TopSellingEvent, TopSellingState> {
  TopSellingBloc({required ProductsRepo productsRepo})
      : _productsRepo = productsRepo,
        super(const TopSellingInitial()) {
    on<TopSellingFetchRequested>(_onTopSellingFetchRequested);
  }

  final ProductsRepo _productsRepo;

  Future<void> _onTopSellingFetchRequested(
    TopSellingFetchRequested event,
    Emitter<TopSellingState> emit,
  ) async {
    try {
      emit(TopSellingLoading());
      final products = await _productsRepo.fetchTopSelling();
      emit(TopSellingData(products));
    } catch (_) {
      emit(const TopSellingFailure("Something went wrong while fetching products"));
    }
  }
}
