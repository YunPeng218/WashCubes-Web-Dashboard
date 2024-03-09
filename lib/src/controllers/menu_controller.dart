import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/routing/routes.dart';

class MenuController extends GetxController{
  static MenuController instance = Get.find(); //Easy Access to Menu Controller Values
  var activeItem = DashboardPageRoute.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName){
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if(!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName){
    switch (itemName) {
      case DashboardPageRoute:
        return _customIcon(Icons.auto_graph_rounded, itemName);
      case OrdersPageRoute:
        return _customIcon(Icons.card_travel_rounded, itemName);
      case ServicesPageRoute:
        return _customIcon(Icons.room_service_outlined, itemName);
      case LockersPageRoute:
        return _customIcon(Icons.check_box_outline_blank_rounded, itemName);
      case UsersPageRoute:
        return _customIcon(Icons.person_outline_rounded, itemName);
      case RidersPageRoute:
        return _customIcon(Icons.delivery_dining_outlined, itemName);
      case OperatorsPageRoute:
        return _customIcon(Icons.people_outline_rounded, itemName);
      case FeedbackPageRoute:
        return _customIcon(Icons.chat_outlined, itemName);
      case LogOutPageRoute:
        return _customIcon(Icons.logout_rounded, itemName);
      default:
        return _customIcon(Icons.exit_to_app_rounded, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName){
    if(isActive(itemName)) return Icon(icon, size: 22, color: AppColors.cWhiteColor,);

    return Icon(icon, color: isHovering(itemName) ? AppColors.cWhiteColor : AppColors.cBarColor);
  }
}