import 'dart:async';

import 'package:redux/redux.dart';

typedef Dispatch<St> = void Function(CompactAction<St> action);

abstract class CompactAction<St> {
  /// The redux store
  late Store<St> _store;
  late RequestStatus _requestStatus;

  /// Setter for the action store
  void setStore(Store<St> store) => _store = store;

  void setRequestStatus(RequestStatus status) => _requestStatus = status;

  Store<St> get store => _store;

  St get state => _store.state;

  Dispatch<St> get dispatch => _store.dispatch;

  /// Status of a request.
  ///
  /// `isLoading`: Indicates if a request is loading
  ///
  /// `data`: The response from the request
  ///
  /// `error`: The error if it occurs
  RequestStatus get request => _requestStatus;

  /// The action reducer
  St reduce();

  /// Creates an asynchronous action
  FutureOr<dynamic> makeRequest() {}

  /// Runs before `reduce()`.
  void before() {}

  /// Runs after `reduce()`.
  void after() {}
}

class RequestStatus {
  final bool loading;
  final dynamic data;
  final dynamic error;

  bool get hasError => error != null;

  RequestStatus({this.loading = false, this.data, this.error});
}

abstract class BaseModel<T> {
  final Store<T> store;

  BaseModel(this.store);

  BaseModel<T> fromStore();

  T get state => store.state;

  Dispatch get dispatch => store.dispatch;
}
