import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Import slidable package
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../bloc/cart_bloc.dart';
import '../../model/cart_item_model.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Slidable(
      key: Key(cartItem.product.id),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<CartBloc>().add(
                CartRemoveProductStarted(
                  productId: cartItem.product.id,
                ),
              );
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Xóa',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cartItem.product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/product_default.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildShimmerSkeleton();
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    CurrencyFormatter.format(cartItem.product.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildActionButton(Icons.remove, () {
                          if (cartItem.quantity > 1) {
                            context.read<CartBloc>().add(
                              CartUpdateProductQuantityStarted(
                                productId: cartItem.product.id,
                                newQuantity: cartItem.quantity - 1,
                              ),
                            );
                          } else {
                            context.read<CartBloc>().add(
                              CartRemoveProductStarted(
                                  productId: cartItem.product.id),
                            );
                          }
                        }),
                        const SizedBox(width: 5),
                        Text("${cartItem.quantity}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        _buildActionButton(Icons.add, () {
                          context.read<CartBloc>().add(
                            CartUpdateProductQuantityStarted(
                              productId: cartItem.product.id,
                              newQuantity: cartItem.quantity + 1,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
