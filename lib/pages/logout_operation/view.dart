import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';
import '../../common/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LogoutOperatPage extends GetView<LogoutOperationController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 44 + ScreenUtil().statusBarHeight,
            child: _buildNavbar(),
          ),
          SizedBox(
            height: 52.h,
            child: _buildHeader(),
          ),
          Expanded(
            child: GetBuilder<LogoutOperationController>(
                id: 'list',
                init: controller,
                builder: (ctr) => _buildList(context, ctr)),
          ),
          // Expanded(child: _buildList(context)),

          SizedBox(
            height: 140,
            child: _buildBottomUI(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar() {
    return GetBuilder<LogoutOperationController>(
      id: "title",
      builder: (ctr) => navBarWidget(
        leftBtnTap: () {
          Get.back();
        },
        title: "注销账户",
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 0.5,
          ))),
      alignment: Alignment.centerLeft,
      height: 52.h,
      padding: EdgeInsets.only(left: 17, right: 30),
      child: Text(
        "账号注销需满足以下条件：",
        style: TextStyle(
          color: Color(0xFF333333),
          decoration: TextDecoration.none,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildList(
      BuildContext context, LogoutOperationController controller) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: RefreshIndicator(
        child: StaggeredGridView.countBuilder(
          controller: controller.scrollController,
          crossAxisCount: 1,
          itemBuilder: (_, int index) => _buildItem(index),
          staggeredTileBuilder: (_) => StaggeredTile.extent(1, 61),
          itemCount: controller.state.logoutList.length,
        ),
        onRefresh: controller.refresh,
      ),
    );
  }

  // Widget _buildSliverList() {
  //   return SliverList(
  //       delegate: SliverChildBuilderDelegate(
  //           (_, int index) => Container(
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     border: Border(
  //                         bottom: BorderSide(
  //                       color: Color(0xFFF2F2F2),
  //                       width: 0.5,
  //                     ))),
  //                 height: 61,
  //                 padding: EdgeInsets.only(right: 30),
  //                 margin: EdgeInsets.only(left: 17),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       controller.state.logoutList[index].reasonDesc ?? "",
  //                       style: TextStyle(
  //                         color: Color(0xFF333333),
  //                         fontSize: 14.sp,
  //                         decoration: TextDecoration.none,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     controller.state.logoutList[index].checkResult ?? false
  //                         ? Icon(
  //                             Icons.check_circle,
  //                             size: 16.sp,
  //                             color: Colors.blue,
  //                           )
  //                         : Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(
  //                                 controller
  //                                         .state.logoutList[index].opNameDesc ??
  //                                     "",
  //                                 style: TextStyle(
  //                                   color: Color(0xFFA1A1A1),
  //                                   fontSize: 13.sp,
  //                                   decoration: TextDecoration.none,
  //                                   fontWeight: FontWeight.w400,
  //                                 ),
  //                               ),
  //                               Icon(
  //                                 Icons.arrow_right,
  //                                 size: 14.sp,
  //                                 color: Color(0xFFA1A1A1),
  //                               )
  //                             ],
  //                           )
  //                   ],
  //                 ),
  //               ),
  //           childCount: controller.state.logoutList.length));
  // }

  Widget _buildItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 0.5,
          ))),
      height: 61,
      padding: EdgeInsets.only(right: 30),
      margin: EdgeInsets.only(left: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            controller.state.logoutList[index].reasonDesc ?? "",
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 14.sp,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
            ),
          ),
          controller.state.logoutList[index].checkResult ?? false
              ? Icon(
                  Icons.check_circle,
                  size: 16.sp,
                  color: Colors.blue,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.state.logoutList[index].opNameDesc ?? "",
                      style: TextStyle(
                        color: Color(0xFFA1A1A1),
                        fontSize: 13.sp,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      size: 14.sp,
                      color: Color(0xFFA1A1A1),
                    )
                  ],
                )
        ],
      ),
    );
  }

  Widget _buildBottomUI() {
    return Container(
      height: 140,
      margin: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          btnFlatButtonWidget(
            width: 345,
            onPressed: () {
              controller.logout();
            },
            title: "注销",
            fontSize: 15.sp,
          ),
          Container(
              margin: EdgeInsets.only(top: 22),
              child: RichText(
                text: TextSpan(
                    text: "如存在疑问，请拨打客服",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "0532-83089999",
                        style: TextStyle(
                            color: Color(0xFF4F7DFF),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
