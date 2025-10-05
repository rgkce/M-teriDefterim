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

    // Örnek veri (gerçekte backend'den veya local db'den gelecektir)
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

    // Tarihe göre sıralama (en son işlem en üstte)
    transactions.sort((a, b) => b["date"].compareTo(a["date"]));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              // Üst Bilgi Alanı
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                        ),
                        SizedBox(width: 75),
                        Text(
                          widget.customer["name"],
                          style: AppStyles.headline1.copyWith(
                            color:
                                isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),
                    Text(
                      "Telefon: ${widget.customer["phone"]}",
                      style: AppStyles.bodyText.copyWith(
                        fontSize: 18,
                        color:
                            isDark
                                ? AppColors.darkSurface.withOpacity(0.8)
                                : AppColors.lightSurface.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Kayıt Tarihi: ${widget.customer["date"]}",
                      style: AppStyles.caption.copyWith(
                        fontSize: 18,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
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
                      fontSize: 16,
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 14,
                      ),
                      fillColor:
                          isDark
                              ? AppColors.lightText.withOpacity(0.5)
                              : AppColors.darkText.withOpacity(0.5),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // İşlem Listesi
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final tx = filteredTransactions[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? AppColors.lightText.withOpacity(0.8)
                                : AppColors.darkText.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.darkBackground.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // İşlem Bilgisi
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx["title"],
                                style: AppStyles.bodyText.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isDark
                                          ? AppColors.darkPrimary
                                          : AppColors.lightPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tx["description"],
                                style: AppStyles.caption.copyWith(
                                  fontSize: 15,
                                  color:
                                      isDark
                                          ? AppColors.darkText
                                          : AppColors.lightText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${tx["date"].day}.${tx["date"].month}.${tx["date"].year} - ${tx["date"].hour}:${tx["date"].minute.toString().padLeft(2, '0')}",
                                style: AppStyles.caption.copyWith(
                                  color:
                                      isDark
                                          ? AppColors.darkText
                                          : AppColors.lightText,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          // Fiyat
                          Text(
                            "${tx["price"]} ₺",
                            style: AppStyles.bodyText.copyWith(
                              fontWeight: FontWeight.bold,
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
      // İşlem Ekle Butonu
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            isDark ? AppColors.lightSecondary : AppColors.darkSecondary,
        onPressed: () => Navigator.pushNamed(context, '/add-customer'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
