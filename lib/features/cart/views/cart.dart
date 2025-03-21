import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/confirmation_dialog.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../core/widgets/dash_divider.dart';
import '../../order/bloc/order_bloc.dart';
import '../bloc/cart_bloc.dart';
import 'widgets/cart_item.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(CartFetchProductsStarted());
  }

  List<String> tables = [
    "Bàn 01",
    "Bàn 02",
    "Bàn 03",
    "Bàn 04",
    "Bàn 05",
    "Bàn 06"
  ];
  String selectedTable = "Bàn 05";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.secondary,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartFetchProductsInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CartFetchProductsFailure) {
                  return Center(
                      child: Text("Lỗi: ${state.error}",
                          style: const TextStyle(color: Colors.red)));
                }

                if (state is CartFetchProductsSuccess) {
                  final cartItems = state.cartItems;
                  if (cartItems.isEmpty) {
                    return const Center(
                        child: Text("Giỏ hàng trống",
                            style:
                                TextStyle(fontSize: 16, color: Colors.grey)));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => const DashDivider(),
                    itemBuilder: (context, index) =>
                        CartItem(cartItem: cartItems[index]),
                  );
                }

                return const Center(child: Text("Giỏ hàng trống"));
              },
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/order.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                ),
              ),
              const Text(
                "Thông tin bàn",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => ConfirmationDialog(
                      title: "Xác nhận",
                      content:
                          "Bạn có chắc chắn muốn xóa tất cả sản phẩm trong giỏ hàng?",
                      onConfirm: () {
                        context.read<CartBloc>().add(CartClearStarted());
                        CustomToast.showToast(context, "Giỏ hàng đã được xóa!",
                            type: ContentType.success);
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/delete.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    value: selectedTable,
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      elevation: 0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: colors.background,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTable = newValue!;
                      });
                    },
                    items: tables.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        double totalPrice = 0;
        if (state is CartFetchProductsSuccess) {
          totalPrice = state.cartItems.fold(
              0, (sum, item) => sum + (item.product.price * item.quantity));
        }
        if (totalPrice == 0) {
          return const SizedBox.shrink();
        } else {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tổng tiền:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        CurrencyFormatter.format(totalPrice),
                        style: TextStyle(fontSize: 16, color: colors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Ghi chú',
                      fillColor: colors.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ), // Padding bên trong TextField
                    ),
                  ),
                ),
                BlocListener<OrderBloc, OrderState>(
                  listener: (context, state) {
                    if (state is OrderCreateSuccess) {
                      // Hiển thị Toast khi tạo đơn hàng thành công
                      CustomToast.showToast(context, "Gọi món thành công!",
                          type: ContentType.success);
                      context.read<CartBloc>().add(CartClearStarted());
                    } else if (state is OrderCreateFailure) {
                      // Hiển thị Toast khi có lỗi xảy ra
                      CustomToast.showToast(context, "Gọi món thất bại!",
                          type: ContentType.failure);
                    }
                  },
                  child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state is OrderCreateInProgress
                              ? null
                              : () {
                                  context
                                      .read<OrderBloc>()
                                      .add(OrderCreateStarted());
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: state is OrderCreateInProgress
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  "Gọi món",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
