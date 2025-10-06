import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_colors.dart';
import 'package:musteridefterim/constants/app_styles.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      _sortCustomers();
    });
  }

  void _showAddOrEditCustomerPopup(
    BuildContext context,
    bool isDark, {
    Map<String, dynamic>? customer,
  }) {
    final TextEditingController nameController = TextEditingController(
      text: customer?["name"] ?? "",
    );
    final TextEditingController phoneController = TextEditingController(
      text: customer?["phone"] ?? "",
    );

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
                  customer == null ? "Yeni Müşteri Ekle" : "Müşteri Güncelle",
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
                    icon: Icon(
                      customer == null ? Icons.person_add_alt_1 : Icons.edit,
                    ),
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
                          if (customer == null) {
                            customers.add({
                              "name": nameController.text,
                              "phone": phoneController.text,
                              "dateAdded": DateTime.now(),
                            });
                          } else {
                            customer["name"] = nameController.text;
                            customer["phone"] = phoneController.text;
                          }
                          _filterCustomers(_searchController.text);
                        });
                        Navigator.pop(context);
                      }
                    },
                    label: Text(
                      customer == null ? "Ekle" : "Güncelle",
                      style: AppStyles.caption.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteCustomer(Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.lightText : AppColors.darkText,
          title: Text(
            "Müşteri Sil",
            style: AppStyles.headline2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontSize: 22,
            ),
          ),
          content: Text(
            "${customer["name"]} adlı müşteriyi silmek istediğinize emin misiniz?",
            style: AppStyles.caption.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Hayır",
                style: AppStyles.caption.copyWith(
                  color: AppColors.darkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  customers.remove(customer);
                  _filterCustomers(_searchController.text);
                });
                Navigator.pop(context);
              },
              child: Text(
                "Evet",
                style: AppStyles.caption.copyWith(
                  color: AppColors.darkSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    VoidCallback onConfirm,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: isDark ? AppColors.lightText : AppColors.darkText,
            title: Text(
              title,
              style: AppStyles.headline2.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontSize: 22,
              ),
            ),
            content: Text(
              "Bu işlemi yapmak istediğinize emin misiniz?",
              style: AppStyles.headline2.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Hayır",
                  style: AppStyles.caption.copyWith(
                    color: isDark ? AppColors.darkAccent : AppColors.darkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                child: Text(
                  "Evet",
                  style: AppStyles.caption.copyWith(
                    color:
                        isDark
                            ? AppColors.darkSecondary
                            : AppColors.darkSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: _buildDrawer(isDark, width, height),
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
              // Üst kısım
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      icon: Icon(
                        Icons.menu_rounded,
                        color:
                            isDark ? AppColors.lightText : AppColors.darkText,
                        size: 28,
                      ),
                    ),
                    Text(
                      "Müşterilerim",
                      style: AppStyles.headline1.copyWith(
                        color:
                            isDark ? AppColors.lightText : AppColors.darkText,
                        fontSize: width < 350 ? 20 : 24,
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
                      color: isDark ? AppColors.lightText : AppColors.darkText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      icon: Icon(
                        Icons.sort_rounded,
                        color:
                            isDark ? AppColors.lightText : AppColors.darkText,
                      ),
                      itemBuilder:
                          (context) => const [
                            PopupMenuItem(
                              value: "Eklenme Sırası",
                              child: Text("Eklenme Sırası"),
                            ),
                            PopupMenuItem(value: "A-Z", child: Text("A-Z")),
                            PopupMenuItem(
                              value: "Zaman",
                              child: Text("Zamana Göre"),
                            ),
                          ],
                    ),
                  ],
                ),
              ),

              // Arama kutusu
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
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterCustomers,
                    style: TextStyle(
                      color:
                          isDark ? AppColors.lightSurface : AppColors.lightText,
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
                            return _buildCustomerCard(customer, isDark);
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
        onPressed: () => _showAddOrEditCustomerPopup(context, isDark),
        child: const Icon(Icons.add, color: AppColors.lightSurface),
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer, bool isDark) {
    return Card(
      color:
          isDark
              ? AppColors.darkSurface.withOpacity(0.7)
              : AppColors.lightSurface.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              isDark
                  ? AppColors.lightAccent.withOpacity(0.8)
                  : AppColors.darkAccent.withOpacity(0.8),
          child: Text(
            customer["name"][0],
            style: TextStyle(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          customer["name"],
          style: AppStyles.bodyText.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        subtitle: Text(
          customer["phone"],
          style: AppStyles.caption.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? Colors.white : Colors.black54,
          ),
          onSelected: (value) {
            if (value == "edit") {
              _showAddOrEditCustomerPopup(context, isDark, customer: customer);
            } else if (value == "delete") {
              _deleteCustomer(customer);
            }
          },
          itemBuilder:
              (context) => const [
                PopupMenuItem(value: "edit", child: Text("Güncelle")),
                PopupMenuItem(value: "delete", child: Text("Sil")),
              ],
        ),
        onTap:
            () => Navigator.pushNamed(
              context,
              '/customer-detail',
              arguments: customer,
            ),
      ),
    );
  }

  // 🔹 Responsive Drawer
  Widget _buildDrawer(bool isDark, double width, double height) {
    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    isDark
                        ? [AppColors.darkPrimary, AppColors.darkAccent]
                        : [AppColors.lightPrimary, AppColors.lightAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.person,
                    color:
                        isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    size: width * 0.12,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Text(
                  "Rümeysa Gökçe",
                  style: AppStyles.headline1.copyWith(
                    color:
                        isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "rumeysa@example.com",
                  style: AppStyles.caption.copyWith(
                    color:
                        isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          // Menü seçenekleri
          _drawerTile(
            Icons.person_add_alt_1,
            "Yeni Müşteri",
            () {
              Navigator.pop(context);
              _showAddOrEditCustomerPopup(context, isDark);
            },
            isDark,
            iconColor:
                isDark ? AppColors.lightSecondary : AppColors.darkSecondary,
          ),
          _drawerTile(
            Icons.lock,
            "Şifre Değiştir",
            () {
              Navigator.pushNamed(context, '/change-password');
            },
            isDark,
            iconColor: isDark ? AppColors.lightPrimary : AppColors.darkPrimary,
          ),
          const Divider(),
          _drawerTile(
            Icons.delete_forever,
            "Hesabı Sil",
            () => _showConfirmationDialog(context, "Hesabı Sil", () {
              Navigator.pushReplacementNamed(context, '/signup');
            }),
            isDark,
            iconColor: isDark ? AppColors.lightAccent : AppColors.darkAccent,
          ),
          _drawerTile(
            Icons.logout_rounded,
            "Çıkış Yap",
            () => _showConfirmationDialog(context, "Çıkış Yap", () {
              Navigator.pushReplacementNamed(context, '/login');
            }),
            isDark,
            iconColor: isDark ? AppColors.lightSurface : AppColors.darkSurface,
          ),
        ],
      ),
    );
  }

  Widget _drawerTile(
    IconData icon,
    String title,
    VoidCallback onTap,
    bool isDark, {
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color:
            iconColor ?? // 🔹 Renk belirlenmişse onu kullan
            (isDark ? AppColors.lightPrimary : AppColors.darkPrimary),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDark ? AppColors.darkText : AppColors.lightText,
        ),
      ),
      onTap: onTap,
    );
  }
}
