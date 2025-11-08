import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../widgets/barber_card.dart';
import '../../widgets/custom_bottom_nav.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _search = TextEditingController();
  final List<Map<String, dynamic>> _barbers = [
    {
      'name': 'Marcus Johnson',
      'shop': 'Elite Cuts',
      'rating': 4.9,
      'distance': '0.3 km',
      'services': ['Haircut', 'Beard Trim', 'Line-up', 'Styling'],
      'priceRange': '\$25-35',
      'isAvailable': true,
    },
    {
      'name': 'David Williams',
      'shop': 'Fade House',
      'rating': 4.8,
      'distance': '0.7 km',
      'services': ['Fade', 'Beard', 'Mustache'],
      'priceRange': '\$20-30',
      'isAvailable': true,
    },
    {
      'name': 'James Brown',
      'shop': 'Urban Barbershop',
      'rating': 4.7,
      'distance': '1.2 km',
      'services': ['Cut', 'Beard', 'Line-up', 'Hot Towel'],
      'priceRange': '\$30-40',
      'isAvailable': false,
    },
    {
      'name': 'Michael Davis',
      'shop': 'Classic Cuts',
      'rating': 4.6,
      'distance': '0.9 km',
      'services': ['Traditional Cut', 'Beard', 'Shave'],
      'priceRange': '\$25-35',
      'isAvailable': true,
    },
    {
      'name': 'Robert Wilson',
      'shop': 'Modern Barbers',
      'rating': 4.8,
      'distance': '1.5 km',
      'services': ['Fade', 'Design', 'Beard', 'Styling'],
      'priceRange': '\$35-45',
      'isAvailable': true,
    },
    {
      'name': 'Anthony Moore',
      'shop': 'Premium Cuts',
      'rating': 4.9,
      'distance': '2.1 km',
      'services': ['Haircut', 'Beard', 'Facial', 'Massage'],
      'priceRange': '\$40-50',
      'isAvailable': true,
    },
    {
      'name': 'Kevin Taylor',
      'shop': 'Street Style',
      'rating': 4.5,
      'distance': '0.8 km',
      'services': ['Fade', 'Line-up', 'Beard'],
      'priceRange': '\$20-25',
      'isAvailable': false,
    },
    {
      'name': 'Brandon Anderson',
      'shop': 'Gentleman\'s Cut',
      'rating': 4.7,
      'distance': '1.8 km',
      'services': ['Classic Cut', 'Beard', 'Mustache', 'Hot Towel'],
      'priceRange': '\$30-40',
      'isAvailable': true,
    },
  ];

  int _currentIndex = 0;

  void _onNav(int idx) {
    setState(() => _currentIndex = idx);
    switch (idx) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, Routes.appointments);
        break;
      case 2:
        Navigator.pushNamed(context, Routes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover Barbers')),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: 'Search barbers, styles, or shops...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: _search.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        onPressed: () {
                          _search.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _barbers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> b = _barbers[index];
                final String q = _search.text.toLowerCase();
                if (q.isNotEmpty && !(b['name'] as String).toLowerCase().contains(q)) {
                  return const SizedBox.shrink();
                }
                return BarberCard(
                  name: b['name'] as String,
                  shop: b['shop'] as String,
                  rating: b['rating'] as double,
                  distance: b['distance'] as String,
                  services: List<String>.from(b['services'] as List<dynamic>),
                  priceRange: b['priceRange'] as String?,
                  isAvailable: b['isAvailable'] as bool,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Opening ${b['name']} profile...')),
                    );
                  },
                  onFavorite: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${b['name']} added to favorites!')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onNav,
      ),
    );
  }
}



