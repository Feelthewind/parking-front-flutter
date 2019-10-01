import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/models/error_response.dart';
import 'package:parking_flutter/models/order.dart';
import 'package:parking_flutter/services/order.dart';
import 'package:parking_flutter/services/parking.dart';

part 'orders.g.dart';

class OrdersStore = _OrdersStore with _$OrdersStore;

abstract class _OrdersStore with Store {
  final orderService = locator<OrderService>();
  final parkingService = locator<ParkingService>();

  @observable
  ObservableList<Order> orders = ObservableList<Order>();

  @observable
  Order currentOrder;

  @observable
  String timeToExtend;

  @observable
  ErrorResponse error;

  @action
  Future<void> getLatestOrder() async {
    try {
      final result = await orderService.getLatestOrder();
      print('result');
      print('getLatestOrder');
      print(result);
      if (result is Order) {
        currentOrder = result;
        timeToExtend = await parkingService.getTimeToExtend(result.parking.id);
        print('timetoextend in order store');
        print(timeToExtend);
      } else if (result is ErrorResponse) {
        error = result;
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
