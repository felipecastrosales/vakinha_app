// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HomePageStatusMatch on HomePageStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == HomePageStatus.initial) {
      return initial();
    }

    if (v == HomePageStatus.loading) {
      return loading();
    }

    if (v == HomePageStatus.success) {
      return success();
    }

    if (v == HomePageStatus.error) {
      return error();
    }

    throw Exception('HomePageStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == HomePageStatus.initial && initial != null) {
      return initial();
    }

    if (v == HomePageStatus.loading && loading != null) {
      return loading();
    }

    if (v == HomePageStatus.success && success != null) {
      return success();
    }

    if (v == HomePageStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
