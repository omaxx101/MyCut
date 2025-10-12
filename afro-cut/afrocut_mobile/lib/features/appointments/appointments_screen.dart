import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import '../../widgets/appointment_card.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../routes.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 1; // Appointments tab

  // Mock appointment data
  final List<Appointment> _appointments = [
    Appointment(
      id: '1',
      barberId: 'barber1',
      barberName: 'Marcus Johnson',
      barberShop: 'Elite Cuts',
      barberAvatar: '',
      dateTime: DateTime.now().add(const Duration(hours: 2)),
      duration: const Duration(minutes: 45),
      services: [AppointmentType.haircut, AppointmentType.beard],
      totalPrice: 35.0,
      status: AppointmentStatus.upcoming,
      notes: 'Regular cut and beard trim',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Appointment(
      id: '2',
      barberId: 'barber2',
      barberName: 'David Williams',
      barberShop: 'Fade House',
      barberAvatar: '',
      dateTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
      duration: const Duration(minutes: 30),
      services: [AppointmentType.haircut],
      totalPrice: 25.0,
      status: AppointmentStatus.upcoming,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Appointment(
      id: '3',
      barberId: 'barber3',
      barberName: 'James Brown',
      barberShop: 'Urban Barbershop',
      barberAvatar: '',
      dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      duration: const Duration(minutes: 60),
      services: [AppointmentType.haircut, AppointmentType.styling, AppointmentType.facial],
      totalPrice: 65.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      completedAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      rating: 4.8,
      review: 'Excellent service! Very professional and clean cut.',
    ),
    Appointment(
      id: '4',
      barberId: 'barber4',
      barberName: 'Michael Davis',
      barberShop: 'Classic Cuts',
      barberAvatar: '',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      duration: const Duration(minutes: 40),
      services: [AppointmentType.haircut, AppointmentType.beard],
      totalPrice: 30.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      completedAt: DateTime.now().subtract(const Duration(days: 5, minutes: 30)),
      rating: 4.5,
    ),
    Appointment(
      id: '5',
      barberId: 'barber5',
      barberName: 'Robert Wilson',
      barberShop: 'Modern Barbers',
      barberAvatar: '',
      dateTime: DateTime.now().subtract(const Duration(days: 10)),
      duration: const Duration(minutes: 35),
      services: [AppointmentType.haircut],
      totalPrice: 28.0,
      status: AppointmentStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onNav(int idx) {
    setState(() => _currentIndex = idx);
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.discover);
        break;
      case 1:
        // Stay on appointments
        break;
      case 2:
        Navigator.pushReplacementNamed(context, Routes.profile);
        break;
    }
  }

  List<Appointment> get upcomingAppointments {
    return _appointments
        .where((appointment) => appointment.status == AppointmentStatus.upcoming)
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  List<Appointment> get pastAppointments {
    return _appointments
        .where((appointment) => 
            appointment.status == AppointmentStatus.completed ||
            appointment.status == AppointmentStatus.cancelled)
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Routes.discover);
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.schedule, size: 18),
                  const SizedBox(width: 8),
                  Text('Upcoming (${upcomingAppointments.length})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history, size: 18),
                  const SizedBox(width: 8),
                  Text('History (${pastAppointments.length})'),
                ],
              ),
            ),
            const Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 18),
                  SizedBox(width: 8),
                  Text('Calendar'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(),
          _buildHistoryTab(),
          _buildCalendarTab(),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onNav,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Routes.discover);
        },
        icon: const Icon(Icons.add),
        label: const Text('Book Now'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildUpcomingTab() {
    if (upcomingAppointments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.schedule,
        title: 'No Upcoming Appointments',
        subtitle: 'Book your next appointment to get started',
        actionText: 'Find Barbers',
        onAction: () => Navigator.pushNamed(context, Routes.discover),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Simulate refresh
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: upcomingAppointments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final appointment = upcomingAppointments[index];
          return AppointmentCard(
            appointment: appointment,
            onTap: () => _showAppointmentDetails(appointment),
            onReschedule: () => _rescheduleAppointment(appointment),
            onCancel: () => _cancelAppointment(appointment),
          );
        },
      ),
    );
  }

  Widget _buildHistoryTab() {
    if (pastAppointments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.history,
        title: 'No Past Appointments',
        subtitle: 'Your appointment history will appear here',
        actionText: 'Book Appointment',
        onAction: () => Navigator.pushNamed(context, Routes.discover),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: pastAppointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final appointment = pastAppointments[index];
        return AppointmentCard(
          appointment: appointment,
          onTap: () => _showAppointmentDetails(appointment),
          onRate: appointment.status == AppointmentStatus.completed && appointment.rating == null
              ? () => _rateAppointment(appointment)
              : null,
        );
      },
    );
  }

  Widget _buildCalendarTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Calendar View',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Coming Soon!',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add),
              label: Text(actionText),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppointmentDetails(Appointment appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AppointmentDetailsSheet(appointment: appointment),
    );
  }

  void _rescheduleAppointment(Appointment appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reschedule ${appointment.barberName} - Coming soon!')),
    );
  }

  void _cancelAppointment(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: Text('Are you sure you want to cancel your appointment with ${appointment.barberName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Appointment'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Appointment cancelled')),
              );
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _rateAppointment(Appointment appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rate ${appointment.barberName} - Coming soon!')),
    );
  }
}

class _AppointmentDetailsSheet extends StatelessWidget {
  final Appointment appointment;

  const _AppointmentDetailsSheet({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointment Details',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  // Add detailed appointment information here
                  Text('Barber: ${appointment.barberName}'),
                  Text('Shop: ${appointment.barberShop}'),
                  Text('Date: ${appointment.formattedDate}'),
                  Text('Time: ${appointment.formattedTime}'),
                  Text('Services: ${appointment.servicesText}'),
                  Text('Duration: ${appointment.duration.inMinutes} minutes'),
                  Text('Price: \$${appointment.totalPrice.toStringAsFixed(2)}'),
                  if (appointment.notes != null) Text('Notes: ${appointment.notes}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



