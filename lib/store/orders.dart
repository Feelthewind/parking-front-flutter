import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/order.dart';
import 'package:parking_flutter/services/order.dart';
import 'package:parking_flutter/services/parking.dart';

part 'orders.g.dart';

class OrdersStore = _OrdersStore with _$OrdersStore;

abstract class _OrdersStore with Store {
  final orderService = locator<OrderService>();
  final parkingService = locator<ParkingService>();

  @observable
  ObservableList<OrderEntity> orders = ObservableList<OrderEntity>();

  @observable
  OrderEntity currentOrder;

  @observable
  String timeToExtend;

  @action
  Future<void> getLatestOrder() async {
    try {
      currentOrder = await orderService.getLatestOrder();
      print('currentOrder');
      print('getLatestOrder');
      print(currentOrder);
      if (currentOrder != null) {
        timeToExtend =
            await parkingService.getTimeToExtend(currentOrder.parking.id);
        print('timetoextend in order store');
        print(timeToExtend);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @action
  Future<void> cancelOrder() async {
    try {
      await orderService.cancelOrder(currentOrder.id);
      currentOrder = null;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @action
  Future<void> extendOrderTime(int timeToExtend) async {
    try {
      currentOrder =
          await orderService.extendOrderTime(currentOrder.id, timeToExtend);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
