import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management_flutter_app/features/product/views/product_list_inventory.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../../features/product/model/product_model.dart';
import '../../../../features/product/views/product_inventory_detail.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _allProducts = [];
  ProductModel? _selectedProduct;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetchStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductFetchSuccess) {
          setState(() {
            _allProducts = state.products;
            _filteredProducts = List.from(_allProducts);
          });
        }
      },
      child: Row(
        children: [
          Expanded(
            flex: _selectedProduct == null ? 1 : 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: ProductListInventory(
                products: _filteredProducts,
                isCompact: _selectedProduct != null,
                onProductSelected: (product) {
                  setState(() {
                    _selectedProduct = product;
                  });
                },
              ),
            ),
          ),
          if (_selectedProduct != null)
            Expanded(
              flex: 3,
              child: ProductInventoryDetail(
                product: _selectedProduct!,
                onClose: () {
                  setState(() {
                    _selectedProduct = null;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
