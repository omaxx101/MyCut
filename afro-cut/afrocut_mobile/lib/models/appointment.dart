enum AppointmentStatus {
  upcoming,
  completed,
  cancelled,
  noShow,
}

enum AppointmentType {
  haircut,
  beard,
  styling,
  shave,
  facial,
  massage,
}

class Appointment {
  final String id;
  final String barberId;
  final String barberName;
  final String barberShop;
  final String barberAvatar;
  final DateTime dateTime;
  final Duration duration;
  final List<AppointmentType> services;
  final double totalPrice;
  final AppointmentStatus status;
  final String? notes;
  final String? specialRequests;
  final DateTime createdAt;
  final DateTime? completedAt;
  final double? rating;
  final String? review;

  const Appointment({
    required this.id,
    required this.barberId,
    required this.barberName,
    required this.barberShop,
    required this.barberAvatar,
    required this.dateTime,
    required this.duration,
    required this.services,
    required this.totalPrice,
    required this.status,
    this.notes,
    this.specialRequests,
    required this.createdAt,
    this.completedAt,
    this.rating,
    this.review,
  });

  String get formattedDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (appointmentDate == today) {
      return 'Today';
    } else if (appointmentDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (appointmentDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  String get formattedTime {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  String get servicesText {
    return services.map((service) => _getServiceName(service)).join(', ');
  }

  String _getServiceName(AppointmentType type) {
    switch (type) {
      case AppointmentType.haircut:
        return 'Haircut';
      case AppointmentType.beard:
        return 'Beard Trim';
      case AppointmentType.styling:
        return 'Styling';
      case AppointmentType.shave:
        return 'Shave';
      case AppointmentType.facial:
        return 'Facial';
      case AppointmentType.massage:
        return 'Massage';
    }
  }

  bool get isUpcoming {
    return status == AppointmentStatus.upcoming && dateTime.isAfter(DateTime.now());
  }

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return appointmentDate == today;
  }

  Duration get timeUntilAppointment {
    return dateTime.difference(DateTime.now());
  }

  String get timeUntilText {
    final duration = timeUntilAppointment;
    if (duration.isNegative) {
      return 'Past due';
    }
    
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    
    if (days > 0) {
      return '$days day${days == 1 ? '' : 's'} left';
    } else if (hours > 0) {
      return '$hours hour${hours == 1 ? '' : 's'} left';
    } else if (minutes > 0) {
      return '$minutes min${minutes == 1 ? '' : 's'} left';
    } else {
      return 'Starting now';
    }
  }
}
