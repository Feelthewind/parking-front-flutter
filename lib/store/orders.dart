import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/order.dart';
import 'package:parking_flutter/services/order.dart';

part 'orders.g.dart';

class OrdersStore = _OrdersStore with _$OrdersStore;

abstract class _OrdersStore with Store {
  final orderService = locator<OrderService>();

  @observable
  ObservableList<OrderEntity> orders = ObservableList<OrderEntity>();

  @observable
  OrderEntity currentOrder;

  @action
  Future<void> getLatestOrder() async {
    try {
      currentOrder = await orderService.getLatestOrder();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
