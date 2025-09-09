import 'package:flutter/material.dart';

class ParentDashboard extends StatefulWidget {
  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  int selectedChild = 0;

  // Sample data - replace with your API calls
  final List<Map<String, dynamic>> children = [
    {
      'id': 'CHD001',
      'name': 'Emma Johnson',
      'age': '2 years 4 months',
      'photo': '👧',
      'completedVaccines': 12,
      'upcomingVaccines': 2,
      'missedVaccines': 0,
    },
    {
      'id': 'CHD002',
      'name': 'Liam Johnson',
      'age': '6 months',
      'photo': '👶',
      'completedVaccines': 6,
      'upcomingVaccines': 1,
      'missedVaccines': 1,
    },
  ];

  final List<Map<String, dynamic>> vaccineTimeline = [
    {
      'name': 'Hepatitis B',
      'status': 'completed',
      'date': '2023-01-15',
      'dueAge': 'Birth'
    },
    {
      'name': 'DTaP',
      'status': 'completed',
      'date': '2023-03-15',
      'dueAge': '2 months'
    },
    {
      'name': 'IPV (Polio)',
      'status': 'completed',
      'date': '2023-03-15',
      'dueAge': '2 months'
    },
    {
      'name': 'MMR',
      'status': 'upcoming',
      'date': '2024-01-15',
      'dueAge': '12 months'
    },
    {
      'name': 'Varicella',
      'status': 'upcoming',
      'date': '2024-01-15',
      'dueAge': '12 months'
    },
    {
      'name': 'Hib',
      'status': 'missed',
      'date': '2023-09-15',
      'dueAge': '6 months'
    },
  ];

  final Map<String, dynamic> nextVaccine = {
    'name': 'MMR (Measles, Mumps, Rubella)',
    'dueDate': 'January 15, 2024',
    'clinic': 'City Health Center',
    'time': '10:30 AM',
  };

  Color getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'upcoming':
        return Colors.blue;
      case 'missed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'upcoming':
        return Icons.schedule;
      case 'missed':
        return Icons.warning;
      default:
        return Icons.schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.security, color: Colors.blue[600], size: 28),
                        SizedBox(width: 8),
                        Text(
                          'VaxTracker',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Keep your family protected',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Child Profile Card
              Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Child Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        if (children.length > 1)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<int>(
                              value: selectedChild,
                              underline: SizedBox(),
                              isExpanded: true, // ✅ Prevent overflow
                              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                              items: children.asMap().entries.map((entry) {
                                return DropdownMenuItem<int>(
                                  value: entry.key,
                                  child: Text(entry.value['name']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedChild = value!;
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.purple[100]!, Colors.pink[100]!],
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Text(
                              children[selectedChild]['photo'],
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                children[selectedChild]['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                children[selectedChild]['age'],
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                'ID: ${children[selectedChild]['id']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Vaccine Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard(
                          icon: Icons.check_circle,
                          color: Colors.green,
                          count: children[selectedChild]['completedVaccines'],
                          label: 'Completed',
                        ),
                        _buildStatCard(
                          icon: Icons.schedule,
                          color: Colors.blue,
                          count: children[selectedChild]['upcomingVaccines'],
                          label: 'Upcoming',
                        ),
                        _buildStatCard(
                          icon: Icons.warning,
                          color: Colors.red,
                          count: children[selectedChild]['missedVaccines'],
                          label: 'Missed',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Next Vaccine Reminder
              Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications, color: Colors.orange[600], size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Next Vaccine Due',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange[50]!, Colors.red[50]!],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border(
                          left: BorderSide(color: Colors.orange[400]!, width: 4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nextVaccine['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                              SizedBox(width: 8),
                              Text(
                                '${nextVaccine['dueDate']} at ${nextVaccine['time']}',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.local_hospital, size: 16, color: Colors.grey[600]),
                              SizedBox(width: 8),
                              Text(
                                nextVaccine['clinic'],
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle push notification
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Push notification sent!')),
                                );
                              },
                              icon: Icon(Icons.notifications_active),
                              label: Text('Send Push Notification'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[500],
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              'SMS notifications coming soon!',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Vaccine Timeline
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timeline, color: Colors.blue[500], size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Vaccine Timeline',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    ...vaccineTimeline.map((vaccine) => _buildTimelineItem(vaccine)),
                    
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          // Handle view complete history
                        },
                        child: Text(
                          'View Complete Vaccination History',
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Footer
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Last updated: Today at 2:30 PM',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color color,
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> vaccine) {
    final color = getStatusColor(vaccine['status']);
    final icon = getStatusIcon(vaccine['status']);
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vaccine['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  'Due at ${vaccine['dueAge']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                vaccine['date'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
              Text(
                vaccine['status'].toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
