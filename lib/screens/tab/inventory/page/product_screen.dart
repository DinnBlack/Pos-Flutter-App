import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management_flutter_app/core/utils/responsive.dart';
import 'package:order_management_flutter_app/features/product/views/product_inventory_filter.dart';
import 'package:order_management_flutter_app/features/product/views/product_list_inventory.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../../features/product/model/product_model.dart';
import '../../../../features/product/views/product_create_button.dart';
import '../../../../features/product/views/product_inventory_detail.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _allProducts = [];
  ProductModel? _selectedProduct;
  String? selectedCategoryId;
  String selectedSortOption = 'Mặc định';

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetchStarted());
  }

  void _filterProductsByCategory(String? categoryId) {
    setState(() {
      selectedCategoryId = categoryId;

      if (categoryId == null || categoryId.isEmpty) {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts = _allProducts.where((product) {
          return product.categoryId == categoryId;
        }).toList();
        _onSearchChanged(_searchController.text);
      }
      _sortProducts(selectedSortOption);
    });
  }

  void _sortProducts(String option) {
    setState(() {
      selectedSortOption = option;
      switch (option) {
        case 'Giá tăng dần':
          _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Giá giảm dần':
          _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'Tên A-Z':
          _filteredProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'Tên Z-A':
          _filteredProducts.sort((a, b) => b.name.compareTo(a.name));
          break;
        default:
          _filteredProducts.sort((a, b) {
            int idA = int.tryParse(a.id) ?? 0;
            int idB = int.tryParse(b.id) ?? 0;
            _filterProductsByCategory(selectedCategoryId);
            return idA.compareTo(idB);
          });
          break;
      }
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = selectedCategoryId == null
            ? List.from(_allProducts)
            : _allProducts.where((product) {
                return product.categoryId == selectedCategoryId;
              }).toList();
      } else {
        _filteredProducts = _allProducts.where((product) {
          return (selectedCategoryId == null ||
                  product.categoryId == selectedCategoryId) &&
              product.toString().toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
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
      child: Column(
        children: [
          if (!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Expanded(
                      child: SearchField(
                        hintText: 'Tìm kiếm món ăn của bạn',
                        controller: _searchController,
                        onSearchChanged: _onSearchChanged,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ProductInventoryFilter(
                    onCategorySelected: _filterProductsByCategory,
                    onSortOptionSelected: _sortProducts,
                  ),
                  const Spacer(),
                  const ProductCreateButton(),
                ],
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: _selectedProduct == null ? 1 : 2,
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
                  if (_selectedProduct != null) ...[
                    const SizedBox(
                      width: 10,
                    ),
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
                  ]
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
