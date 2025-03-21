import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:order_management_flutter_app/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/currency_formatter.dart';
import '../model/product_model.dart';

class ProductListInventory extends StatelessWidget {
  final List<ProductModel> products;
  final bool isCompact;
  final Function(ProductModel) onProductSelected;

  const ProductListInventory({
    super.key,
    required this.products,
    required this.isCompact,
    required this.onProductSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    bool isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: isMobile ? colors.background : colors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: _buildDataTable(context, colors),
    );
  }

  Widget _buildDataTable(BuildContext context, ColorScheme colors) {
    return DataTable2(
      columnSpacing: 10,
      horizontalMargin: 10,
      dataRowHeight: 70,
      dividerThickness: 0,
      border: TableBorder(
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      columns: [
        if (!isCompact)
          DataColumn2(
              label: _buildColumnHeader("ID", colors), size: ColumnSize.S),
        DataColumn2(
            label: _buildColumnHeader("Ảnh", colors), size: ColumnSize.S),
        DataColumn2(
            label: _buildColumnHeader("Tên Sản Phẩm", colors),
            size: ColumnSize.M),
        if (!isCompact) ...[
          DataColumn2(
              label: _buildColumnHeader("Ngày tạo", colors),
              size: ColumnSize.S),
          DataColumn2(
              label: _buildColumnHeader("Giá", colors), size: ColumnSize.S),
          DataColumn2(
              label: _buildColumnHeader("Chi tiết", colors),
              size: ColumnSize.S),
        ],
      ],
      rows: products.map((product) {
        return DataRow(
          cells: [
            if (!isCompact) DataCell(Center(child: Text(product.id))),
            DataCell(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrl,
                      width: 80,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/product_default.jpg',
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return _buildShimmerSkeleton();
                      },
                    ),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => onProductSelected(product),
                child: Center(child: Text(product.name)),
              ),
            ),
            if (!isCompact) ...[
              DataCell(Center(
                  child: Text(DateFormat('dd/MM - hh:mm a')
                      .format(product.createdAt)))),
              DataCell(
                  Center(child: Text(CurrencyFormatter.format(product.price)))),
              DataCell(
                Center(
                  child: GestureDetector(
                    onTap: () => onProductSelected(product),
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/more.svg',
                        colorFilter:
                            const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      }).toList(),
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

  Widget _buildColumnHeader(String title, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colors.background,
      ),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
