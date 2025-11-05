import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class Hospital {
  final String name;
  final String address;
  final String distance;
  final String imageUrl;
  final List<Doctor> doctors;

  Hospital({
    required this.name,
    required this.address,
    required this.distance,
    required this.imageUrl,
    required this.doctors,
  });
}

class Doctor {
  final String name;
  final String specialty;
  final String timing;

  Doctor({
    required this.name,
    required this.specialty,
    required this.timing,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Hospital> hospitals = List.generate(30, (index) {
    return Hospital(
      name: 'Hospital ${index + 1}',
      address: '${index + 1}23 Health St, Wellness City',
      distance: '${(index + 1) * 0.5} km',
      imageUrl: 'https://picsum.photos/seed/${index + 1}/200/300',
      doctors: [
        Doctor(name: 'Dr. Smith ${index + 1}', specialty: 'Cardiologist', timing: '9 AM - 5 PM'),
        Doctor(name: 'Dr. Jones ${index + 1}', specialty: 'Neurologist', timing: '10 AM - 6 PM'),
      ],
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Nearest Hospitals'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  hospital.imageUrl,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.local_hospital, color: Colors.red, size: 50),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospital.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Address: ${hospital.address}'),
                      const SizedBox(height: 8.0),
                      Text('Distance: ${hospital.distance}'),
                      const SizedBox(height: 12.0),
                      const Text(
                        'Doctors:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      ...hospital.doctors.map((doctor) => Text('- ${doctor.name} (${doctor.specialty}), ${doctor.timing}')).toList(),
                      const SizedBox(height: 12.0),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement appointment booking
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Booking appointment for ${hospital.name}'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text('Book Appointment'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
