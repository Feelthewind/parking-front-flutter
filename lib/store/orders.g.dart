// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrdersStore on _OrdersStore, Store {
  final _$ordersAtom = Atom(name: '_OrdersStore.orders');

  @override
  ObservableList<Order> get orders {
    _$ordersAtom.context.enforceReadPolicy(_$ordersAtom);
    _$ordersAtom.reportObserved();
    return super.orders;
  }

  @override
  set orders(ObservableList<Order> value) {
    _$ordersAtom.context.conditionallyRunInAction(() {
      super.orders = value;
      _$ordersAtom.reportChanged();
    }, _$ordersAtom, name: '${_$ordersAtom.name}_set');
  }

  final _$currentOrderAtom = Atom(name: '_OrdersStore.currentOrder');

  @override
  Order get currentOrder {
    _$currentOrderAtom.context.enforceReadPolicy(_$currentOrderAtom);
    _$currentOrderAtom.reportObserved();
    return super.currentOrder;
  }

  @override
  set currentOrder(Order value) {
    _$currentOrderAtom.context.conditionallyRunInAction(() {
      super.currentOrder = value;
      _$currentOrderAtom.reportChanged();
    }, _$currentOrderAtom, name: '${_$currentOrderAtom.name}_set');
  }

  final _$timeToExtendAtom = Atom(name: '_OrdersStore.timeToExtend');

  @override
  String get timeToExtend {
    _$timeToExtendAtom.context.enforceReadPolicy(_$timeToExtendAtom);
    _$timeToExtendAtom.reportObserved();
    return super.timeToExtend;
  }

  @override
  set timeToExtend(String value) {
    _$timeToExtendAtom.context.conditionallyRunInAction(() {
      super.timeToExtend = value;
      _$timeToExtendAtom.reportChanged();
    }, _$timeToExtendAtom, name: '${_$timeToExtendAtom.name}_set');
  }

  final _$getLatestOrderAsyncAction = AsyncAction('getLatestOrder');

  @override
  Future<void> getLatestOrder() {
    return _$getLatestOrderAsyncAction.run(() => super.getLatestOrder());
  }

  final _$cancelOrderAsyncAction = AsyncAction('cancelOrder');

  @override
  Future<void> cancelOrder() {
    return _$cancelOrderAsyncAction.run(() => super.cancelOrder());
  }

  final _$extendOrderTimeAsyncAction = AsyncAction('extendOrderTime');

  @override
  Future<void> extendOrderTime(int timeToExtend) {
    return _$extendOrderTimeAsyncAction
        .run(() => super.extendOrderTime(timeToExtend));
  }
}
