import 'package:flutter/material.dart';
import 'package:task_1/Assignment_3/Profile.dart';

class PopularPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
              print('Profile icon pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Popular Places',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildPlaceCard(
                    name: 'Niladri Reservoir',
                    location: 'Tekergat, Sunamgni',
                    rating: '4.7',
                    price: '\$459/Person',
                    image: 'assets/niladri_reservoir.png',
                  ),
                  SizedBox(width: 16),
                  _buildPlaceCard(
                    name: 'Casa Las Tirtugas',
                    location: 'Av Damero, Mexico',
                    rating: '4.8',
                    price: '\$894/Person',
                    image: 'assets/casa_las_tirtugas.png',
                  ),
                  SizedBox(width: 16),
                  _buildPlaceCard(
                    name: 'Aonang Villa Resort',
                    location: 'Bastola, Islampur',
                    rating: '4.3',
                    price: '\$761/Person',
                    image: 'assets/aonang_villa_resort.png',
                  ),
                  SizedBox(width: 16),
                  _buildPlaceCard(
                    name: 'Rangauti Resort',
                    location: 'Sylhet, Airport Road',
                    rating: '4.5',
                    price: '\$857/Person',
                    image: 'assets/rangauti_resort.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'More Places',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildPlaceCard(
                    name: 'Sunset Beach Resort',
                    location: 'Maldives',
                    rating: '4.9',
                    price: '\$1200/Person',
                    image: 'assets/rangauti_resort.png',
                  ),
                  SizedBox(width: 16),
                  _buildPlaceCard(
                    name: 'Mountain View Lodge',
                    location: 'Switzerland',
                    rating: '4.6',
                    price: '\$950/Person',
                    image: 'assets/aonang_villa_resort.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard({
    required String name,
    required String location,
    required String rating,
    required String price,
    required String image,
  }) {
    return Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.favorite_border, size: 20),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        rating,
                        style: TextStyle(fontSize: 14),
                      ),
                      Spacer(),
                      Text(
                        price,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}