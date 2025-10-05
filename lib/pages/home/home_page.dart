import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_colors.dart';
import 'package:musteridefterim/constants/app_styles.dart';
import 'package:musteridefterim/navigation/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> customers = [
    {
      "name": "Ayşe Yılmaz",
      "dateAdded": DateTime(2025, 9, 30),
      "phone": "0532 123 45 67",
    },
    {
      "name": "Mehmet Demir",
      "dateAdded": DateTime(2025, 10, 1),
      "phone": "0543 987 65 43",
    },
    {
      "name": "Zeynep Kaya",
      "dateAdded": DateTime(2025, 10, 3),
      "phone": "0505 222 33 44",
    },
  ];

  List<Map<String, dynamic>> filteredCustomers = [];
  String _sortOption = "Eklenme Sırası";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCustomers = List.from(customers);
  }

  void _sortCustomers() {
    setState(() {
      if (_sortOption == "A-Z") {
        filteredCustomers.sort((a, b) => a["name"].compareTo(b["name"]));
      } else if (_sortOption == "Zaman") {
        filteredCustomers.sort(
          (a, b) => b["dateAdded"].compareTo(a["dateAdded"]),
        );
      } else {
        filteredCustomers = List.from(customers);
      }
    });
  }

  void _filterCustomers(String query) {
    setState(() {
      filteredCustomers =
          customers
              .where(
                (customer) => customer["name"].toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList();
      _sortCustomers(); // mevcut sıralamayı koru
    });
  }

  // Yeni Müşteri Ekleme Popup
  void _showAddCustomerPopup(BuildContext context, bool isDark) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:
                  isDark
                      ? AppColors.darkSurface.withOpacity(0.95)
                      : AppColors.lightSurface.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkSurface.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  "Yeni Müşteri Ekle",
                  style: AppStyles.headline1.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Müşteri Adı",
                    filled: true,
                    fillColor:
                        isDark
                            ? AppColors.darkText.withOpacity(0.05)
                            : AppColors.lightText.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Telefon Numarası",
                    filled: true,
                    fillColor:
                        isDark
                            ? AppColors.darkText.withOpacity(0.05)
                            : AppColors.lightText.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add_alt_1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark
                              ? AppColors.lightSecondary
                              : AppColors.darkSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty) {
                        setState(() {
                          customers.add({
                            "name": nameController.text,
                            "phone": phoneController.text,
                            "dateAdded": DateTime.now(),
                          });
                          _filterCustomers(_searchController.text);
                        });
                        Navigator.pop(context);
                      }
                    },
                    label: Text(
                      "Ekle",
                      style: AppStyles.caption.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                // Başlık + Menü
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Müşterilerim",
                        style: AppStyles.headline1.copyWith(
                          color:
                              isDark ? AppColors.lightText : AppColors.darkText,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() {
                            _sortOption = value;
                            _sortCustomers();
                          });
                        },
                        color:
                            isDark ? AppColors.lightText : AppColors.darkText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        icon: Icon(
                          Icons.sort_rounded,
                          color:
                              isDark ? AppColors.lightText : AppColors.darkText,
                        ),
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: "Eklenme Sırası",
                                child: Text("Eklenme Sırası"),
                              ),
                              const PopupMenuItem(
                                value: "A-Z",
                                child: Text("A-Z"),
                              ),
                              const PopupMenuItem(
                                value: "Zaman",
                                child: Text("Zamana Göre"),
                              ),
                            ],
                      ),
                    ],
                  ),
                ),

                // Arama Alanı
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
                      onChanged: _filterCustomers,
                      style: TextStyle(
                        color:
                            isDark
                                ? AppColors.lightSurface
                                : AppColors.lightText,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: "Müşteri ara...",
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
                      ),
                    ),
                  ),
                ),

                // Liste
                Expanded(
                  child:
                      filteredCustomers.isEmpty
                          ? Center(
                            child: Text(
                              "Müşteri bulunamadı",
                              style: AppStyles.caption.copyWith(
                                color:
                                    isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                fontSize: 16,
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            itemCount: filteredCustomers.length,
                            itemBuilder: (context, index) {
                              final customer = filteredCustomers[index];
                              return _buildCustomerCard(
                                context,
                                customer,
                                isDark,
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
        ),

        // ➕ Popup ile Müşteri Ekleme
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              isDark ? AppColors.lightSecondary : AppColors.darkSecondary,
          onPressed: () => _showAddCustomerPopup(context, isDark),
          child: const Icon(Icons.add, color: Colors.white),
        ),

        bottomNavigationBar: const NavBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildCustomerCard(
    BuildContext context,
    Map<String, dynamic> customer,
    bool isDark,
  ) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            '/customer-detail',
            arguments: customer,
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color:
              isDark
                  ? AppColors.darkSurface.withOpacity(0.7)
                  : AppColors.lightSurface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color:
                isDark
                    ? AppColors.lightTextSecondary
                    : AppColors.darkTextSecondary,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      isDark
                          ? AppColors.lightAccent.withOpacity(0.7)
                          : AppColors.darkAccent.withOpacity(0.7),
                  child: Text(
                    customer["name"][0],
                    style: TextStyle(
                      fontSize: 20,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer["name"],
                      style: AppStyles.bodyText.copyWith(
                        color:
                            isDark ? AppColors.darkText : AppColors.lightText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${customer["dateAdded"].day}.${customer["dateAdded"].month}.${customer["dateAdded"].year}",
                      style: AppStyles.caption.copyWith(
                        color:
                            isDark ? AppColors.darkText : AppColors.lightText,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ],
        ),
      ),
    );
  }
}
