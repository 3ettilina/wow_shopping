import 'package:flutter/material.dart';

@immutable
sealed class AppState<T> {}

class InitialState extends AppState {}

class LoadingState extends AppState {}

class DataState<T> extends AppState<T> {
  DataState({required this.data});

  final T data;
}

class FailureState extends AppState {
  FailureState({required this.errorMessage});

  final String errorMessage;
}
