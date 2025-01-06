import 'package:flutter/material.dart';
import 'package:warung_ajib/models/models.dart';
import 'package:warung_ajib/repositories/repositories.dart';
import 'package:warung_ajib/services/services.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _auth = AuthService();
  final _productRepository = ProductRepository();
  late Map<Product, int> productQuantityMap = {};
  int totalHarga = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final List<Product>? data = await _productRepository.getAllProduct();
    setState(() {
      productQuantityMap = {for (var product in data!) product: 0};
    });
  }

  void _tambahKeTotal(Product product) {
    setState(() {
      totalHarga += product.price;
      productQuantityMap[product] = (productQuantityMap[product] ?? 0) + 1;
    });
  }

  void _resetTransaction() {
    setState(() {
      totalHarga = 0;
      productQuantityMap = {
        for (var product in productQuantityMap.keys) product: 0
      };
    });
  }

  void _showMenu(String choice) {
    switch (choice) {
      case 'Update User & Password':
        Navigator.pushNamed(context, '/user-update');
        break;
      case 'Call Center Penjual':
        Navigator.pushNamed(context, '/call-center');
        break;
      case 'SMS ke Penjual':
        Navigator.pushNamed(context, '/sms');
        break;
      case 'Maps Lokasi Agen':
        Navigator.pushNamed(context, '/maps');
        break;
      case 'Pembayaran':
        Navigator.pushNamed(
          context,
          '/payment',
          arguments: {
            'totalTransaction': totalHarga,
            'productQuantityMap': productQuantityMap,
            'onPaymentComplete': _resetTransaction,
          },
        );
        break;
      case 'Logout':
        _auth.logout();
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warung Ajib'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _showMenu,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Update User & Password',
                  child: Text('Update User & Password'),
                ),
                const PopupMenuItem<String>(
                  value: 'Call Center Penjual',
                  child: Text('Call Center Penjual'),
                ),
                const PopupMenuItem<String>(
                  value: 'SMS ke Penjual',
                  child: Text('SMS ke Penjual'),
                ),
                const PopupMenuItem<String>(
                  value: 'Maps Lokasi Agen',
                  child: Text('Maps Lokasi Agen'),
                ),
                const PopupMenuItem<String>(
                  value: 'Pembayaran',
                  child: Text('Pembayaran'),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: productQuantityMap.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: productQuantityMap.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = productQuantityMap.keys.elementAt(index);
                      return _buildProductCard(context, product);
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _showMenu('Pembayaran');
        },
        child: BottomAppBar(
          color: Colors.blue.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Total: Rp. $totalHarga",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        _tambahKeTotal(product);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                'assets/images/${product.image}',
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    Text(
                      "Rp. ${product.price}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
