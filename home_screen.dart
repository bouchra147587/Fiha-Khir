import 'package:flutter/material.dart';

const Color mainGreen = Color(0xFF0B5F3C);

class HomePage extends StatelessWidget {
  final List<Category> categories = [
    Category('Plants', 'Gardening & Green Spaces', Icons.spa, Color(0xFFE6FFED)),
    Category('Paints', 'Walls & Graffiti Cleanup', Icons.brush, Color(0xFFFDEEFF)),
    Category('Infrastructure', 'Roads & Lights', Icons.construction, Color(0xFFFFF3E6)),
    Category('Cleaning', 'Waste & Sanitation', Icons.delete, Color(0xFFE6F9FF)),
  ];

  final List<Problem> problems = [
    Problem(
      'Broken Street Light',
      'Street light has been out for two weeks making the area unsafe at night.',
      'Elm Street Corner',
      'In Progress', // yellow
      'assets/Images/BrokenStreetLight.png',
    ),
    Problem(
      'Garbage Accumulation',
      'Uncollected waste piling up for over a week, creating health hazards.',
      'Park Avenue',
      'Pending', // orange
      'assets/Images/GarbageAccumulation.jpg',
    ),
    Problem(
      'Playground Equipment Broken',
      'Swing set in the public park is broken and dangerous for children.',
      'Community Park',
      'Pending', // orange
      'assets/Images/PlaygroundEquipementBroken.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeBanner(),
              SizedBox(height: 24),
              Text('What needs help today?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.8),
                itemBuilder: (context, index) => CategoryCard(category: categories[index]),
              ),
              SizedBox(height: 24),
              Text('Community Impact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImpactCard('Solved', 1, Colors.green, Icons.check_circle),
                  ImpactCard('Active', 2, Colors.orange, Icons.access_time),
                  ImpactCard('Pending', 2, Colors.red, Icons.error),
                  ImpactCard('Total', 5, Colors.green[800]!, Icons.trending_up),
                ],
              ),
              SizedBox(height: 24),
              Text('Latest Problems', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 12),
              Column(children: problems.map((problem) => ProblemCard(problem: problem)).toList()),
              SizedBox(height: 24),
              Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _QuickActionButton(icon: Icons.report_problem, label: 'Report Issue', onTap: () {}),
                  _QuickActionButton(icon: Icons.group, label: 'View Org', onTap: () {}),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: mainGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Welcome Back! ', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text('👋', style: TextStyle(fontSize: 24)),
          ]),
          SizedBox(height: 8),
          Text("Let's make our community better together", style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Color(0xFFFFFDE6), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('"Every problem solved is a step towards a better community"',
                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green[900])),
                SizedBox(height: 8),
                Text('Join us in making a difference today!', style: TextStyle(color: Colors.grey[800])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- Widgets -------------------

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: category.bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: Offset(0, 2))]),
      child: Row(children: [
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: Icon(category.icon, color: Colors.black)),
        SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(category.title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(category.subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          ]),
        )
      ]),
    );
  }
}

class ProblemCard extends StatelessWidget {
  final Problem problem;
  const ProblemCard({required this.problem});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (problem.status == 'In Progress') {
      statusColor = const Color.fromARGB(255, 247, 196, 66)!;
    } else if (problem.status == 'Pending') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.green;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: Offset(0, 2))]),
      child: Row(children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: AssetImage(problem.image), fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(problem.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            SizedBox(height: 4),
            Text(problem.description, style: TextStyle(fontSize: 12, color: Colors.grey[800]), maxLines: 3, overflow: TextOverflow.ellipsis),
            SizedBox(height: 6),
            Row(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(8)),
                child: Text(problem.status, style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
              SizedBox(width: 8),
              Text(problem.location, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
            ])
          ]),
        )
      ]),
    );
  }
}

class ImpactCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;

  const ImpactCard(this.label, this.value, this.color, this.icon);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text('$value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ]),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: mainGreen,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.green.shade200, blurRadius: 4, offset: Offset(0, 2))]),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, color: Colors.white, size: 32),
            SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ]),
        ),
      ),
    );
  }
}

// ------------------- Models -------------------

class Category {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color bgColor;

  Category(this.title, this.subtitle, this.icon, this.bgColor);
}

class Problem {
  final String title;
  final String description;
  final String location;
  final String status;
  final String image;

  Problem(this.title, this.description, this.location, this.status, this.image);
}
