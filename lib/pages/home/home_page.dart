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

  void _showAddCustomerPopup(BuildContext context, bool isDark) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final height = mediaQuery.size.height;
        final width = mediaQuery.size.width;

        return Padding(
          padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(width * 0.05),
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
                    width: width * 0.15,
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
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.02),
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
                SizedBox(height: height * 0.015),
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
                SizedBox(height: height * 0.025),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add_alt_1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark
                              ? AppColors.lightSecondary
                              : AppColors.darkSecondary,
                      padding: EdgeInsets.symmetric(vertical: height * 0.018),
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
                        fontSize: width * 0.045,
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

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                children: [
                  // Üst Menü + Başlık
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed:
                            () => _scaffoldKey.currentState?.openDrawer(),
                        icon: Icon(
                          Icons.menu_rounded,
                          color:
                              isDark ? AppColors.lightText : AppColors.darkText,
                          size: width * 0.07,
                        ),
                      ),
                      Text(
                        "Müşterilerim",
                        style: AppStyles.headline1.copyWith(
                          color:
                              isDark ? AppColors.lightText : AppColors.darkText,
                          fontSize: width * 0.065,
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

                  // Arama Kutusu
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.015),
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
                              isDark
                                  ? AppColors.lightSurface
                                  : AppColors.lightText,
                          fontSize: width * 0.045,
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
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                            vertical: height * 0.015,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

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
                                  fontSize: width * 0.04,
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemCount: filteredCustomers.length,
                              itemBuilder: (context, index) {
                                final customer = filteredCustomers[index];
                                return _buildCustomerCard(
                                  context,
                                  customer,
                                  isDark,
                                  width,
                                  height,
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              isDark ? AppColors.lightSecondary : AppColors.darkSecondary,
          onPressed: () => _showAddCustomerPopup(context, isDark),
          child: const Icon(Icons.add, color: Colors.white),
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
                  radius: width * 0.09,
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
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "rumeysa@example.com",
                  style: AppStyles.caption.copyWith(
                    color:
                        isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    fontSize: width * 0.04,
                  ),
                ),
              ],
            ),
          ),

          // Menü seçenekleri
          _drawerTile(Icons.person_add_alt_1, "Yeni Müşteri", () {
            Navigator.pop(context);
            _showAddCustomerPopup(context, isDark);
          }, isDark),
          _drawerTile(Icons.lock, "Şifre Değiştir", () {
            Navigator.pushNamed(context, '/change-password');
          }, isDark),
          const Divider(),
          _drawerTile(Icons.delete_forever, "Hesabı Sil", () {
            Navigator.pushReplacementNamed(context, '/signup');
          }, isDark),
          _drawerTile(Icons.logout_rounded, "Çıkış Yap", () {
            Navigator.pushReplacementNamed(context, '/login');
          }, isDark),
        ],
      ),
    );
  }

  Widget _drawerTile(
    IconData icon,
    String title,
    VoidCallback onTap,
    bool isDark,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDark ? AppColors.lightPrimary : AppColors.darkPrimary,
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

  // 🔹 Responsive Card
  Widget _buildCustomerCard(
    BuildContext context,
    Map<String, dynamic> customer,
    bool isDark,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            '/customer-detail',
            arguments: customer,
          ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.008),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(
          color:
              isDark
                  ? AppColors.darkSurface.withOpacity(0.6)
                  : AppColors.lightSurface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: width * 0.07,
              backgroundColor:
                  isDark
                      ? AppColors.lightAccent.withOpacity(0.7)
                      : AppColors.darkAccent.withOpacity(0.7),
              child: Text(
                customer["name"][0],
                style: TextStyle(
                  fontSize: width * 0.06,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer["name"],
                    style: AppStyles.bodyText.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.004),
                  Text(
                    "${customer["dateAdded"].day}.${customer["dateAdded"].month}.${customer["dateAdded"].year}",
                    style: AppStyles.caption.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontSize: width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: width * 0.045,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ],
        ),
      ),
    );
  }
}
