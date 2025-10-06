import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_colors.dart';
import 'package:musteridefterim/constants/app_styles.dart';

class CustomerDetailPage extends StatefulWidget {
  final Map<String, dynamic> customer;

  const CustomerDetailPage({super.key, required this.customer});

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    transactions = [
      {
        "title": "Saç Kesimi",
        "description": "Kısa model, düzeltme yapıldı",
        "date": DateTime(2025, 10, 4, 15, 30),
        "price": 250,
      },
      {
        "title": "Saç Boyama",
        "description": "Karamel tonlarında",
        "date": DateTime(2025, 10, 3, 17, 10),
        "price": 400,
      },
      {
        "title": "Fön",
        "description": "Düz fön",
        "date": DateTime(2025, 10, 1, 13, 00),
        "price": 150,
      },
    ];

    transactions.sort((a, b) => b["date"].compareTo(a["date"]));
  }

  void _showAddTransactionDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          backgroundColor:
              isDark ? AppColors.darkBackground : AppColors.lightBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Yeni İşlem Ekle",
            style: AppStyles.headline2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildResponsiveTextField(
                  controller: titleController,
                  label: "İşlem Adı",
                  isDark: isDark,
                  width: screenWidth,
                ),
                SizedBox(height: screenWidth * 0.03),
                _buildResponsiveTextField(
                  controller: descController,
                  label: "İşlem Detayı",
                  isDark: isDark,
                  width: screenWidth,
                ),
                SizedBox(height: screenWidth * 0.03),
                _buildResponsiveTextField(
                  controller: priceController,
                  label: "Ücret (₺)",
                  isDark: isDark,
                  width: screenWidth,
                  keyboard: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "İptal",
                style: AppStyles.caption.copyWith(
                  color: isDark ? AppColors.lightAccent : AppColors.darkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? AppColors.lightSecondary : AppColors.darkSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  setState(() {
                    transactions.insert(0, {
                      "title": titleController.text,
                      "description": descController.text,
                      "date": DateTime.now(),
                      "price": double.tryParse(priceController.text) ?? 0,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Ekle",
                style: AppStyles.caption.copyWith(
                  color: AppColors.lightSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResponsiveTextField({
    required TextEditingController controller,
    required String label,
    required bool isDark,
    required double width,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      style: TextStyle(
        color: isDark ? AppColors.darkText : AppColors.lightText,
        fontSize: width * 0.04,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color:
              isDark
                  ? AppColors.darkText.withOpacity(0.7)
                  : AppColors.lightText.withOpacity(0.7),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<Map<String, dynamic>> filteredTransactions =
        transactions
            .where(
              (t) =>
                  t["title"].toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
                  t["description"].toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
            )
            .toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                isDark
                    ? [AppColors.darkPrimary, AppColors.darkAccent]
                    : [AppColors.lightPrimary, AppColors.lightAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color:
                                isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                            size: screenWidth * 0.07,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                        ),
                        SizedBox(width: screenWidth * 0.15),
                        Expanded(
                          child: Text(
                            widget.customer["name"],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppStyles.headline1.copyWith(
                              color:
                                  isDark
                                      ? AppColors.darkSurface
                                      : AppColors.lightSurface,
                              fontSize: screenWidth * 0.065,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Telefon: ${widget.customer["phone"]}",
                      style: AppStyles.bodyText.copyWith(
                        fontSize: screenWidth * 0.045,
                        color:
                            isDark
                                ? AppColors.darkSurface.withOpacity(0.8)
                                : AppColors.lightSurface.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      "Kayıt Tarihi: ${widget.customer["dateAdded"]}",
                      style: AppStyles.caption.copyWith(
                        fontSize: screenWidth * 0.04,
                        color:
                            isDark
                                ? AppColors.darkSurface.withOpacity(0.7)
                                : AppColors.lightSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              // 🔍 Arama Alanı
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors.lightText.withOpacity(0.5)
                            : AppColors.darkText.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.darkSurface),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: TextStyle(
                      color:
                          isDark ? AppColors.lightSurface : AppColors.lightText,
                      fontSize: screenWidth * 0.04,
                    ),
                    decoration: InputDecoration(
                      hintText: "İşlem ara...",
                      hintStyle: TextStyle(
                        color:
                            isDark
                                ? AppColors.lightSurface
                                : AppColors.lightText,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color:
                            isDark
                                ? AppColors.lightSurface
                                : AppColors.lightText,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              // 💳 İşlem Listesi
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  itemCount: filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final tx = filteredTransactions[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.012),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? AppColors.lightText.withOpacity(0.8)
                                : AppColors.darkText.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx["title"],
                                  style: AppStyles.bodyText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.045,
                                    color:
                                        isDark
                                            ? AppColors.darkPrimary
                                            : AppColors.lightPrimary,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  tx["description"],
                                  style: AppStyles.caption.copyWith(
                                    fontSize: screenWidth * 0.04,
                                    color:
                                        isDark
                                            ? AppColors.darkText
                                            : AppColors.lightText,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  "${tx["date"].day}.${tx["date"].month}.${tx["date"].year} - ${tx["date"].hour}:${tx["date"].minute.toString().padLeft(2, '0')}",
                                  style: AppStyles.caption.copyWith(
                                    fontSize: screenWidth * 0.035,
                                    color:
                                        isDark
                                            ? AppColors.darkText
                                            : AppColors.lightText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${tx["price"]} ₺",
                            style: AppStyles.bodyText.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                              color:
                                  isDark
                                      ? AppColors.darkPrimary
                                      : AppColors.lightPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor:
            isDark ? AppColors.lightSecondary : AppColors.darkSecondary,
        onPressed: _showAddTransactionDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
