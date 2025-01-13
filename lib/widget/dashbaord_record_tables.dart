// // lib/widgets/dashboard_records_table.dart
// import 'package:flutter/material.dart';
// import '../models/child.dart';
// import 'package:provider/provider.dart';
// import '../providers/children_provider.dart';

// class DashboardRecordsTable extends StatelessWidget {
//   const DashboardRecordsTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Important Records',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 16),
//             Consumer<ChildrenProvider>(
//               builder: (context, provider, child) {
//                 final children = provider.children;
//                 if (children.isEmpty) {
//                   return const Text('No records available');
//                 }

//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: const [
//                       DataColumn(label: Text('Child Name')),
//                       DataColumn(label: Text('Age')),
//                       DataColumn(label: Text('Last Growth Check')),
//                       DataColumn(label: Text('Next Vaccine')),
//                       DataColumn(label: Text('Parent Contact')),
//                     ],
//                     rows: children.map((child) {
//                       final age = DateTime.now().difference(child.dateOfBirth);
//                       final ageInMonths = (age.inDays / 30).floor();
                      
//                       final lastGrowth = child.growthRecords.isNotEmpty
//                           ? child.growthRecords.last
//                           : null;
                      
//                       final nextVaccine = child.vaccineRecords
//                           .where((v) => v.administeredDate == null)
//                           .toList()
//                         ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

//                       return DataRow(cells: [
//                         DataCell(Text(child.name)),
//                         DataCell(Text('$ageInMonths months')),
//                         DataCell(Text(lastGrowth != null
//                             ? '${lastGrowth.date.toString().split(' ')[0]}\n'
//                                 'H: ${lastGrowth.height}cm, W: ${lastGrowth.weight}kg'
//                             : 'No records')),
//                         DataCell(Text(nextVaccine.isNotEmpty
//                             ? '${nextVaccine.first.vaccineName}\n'
//                                 'Due: ${nextVaccine.first.dueDate.toString().split(' ')[0]}'
//                             : 'All completed')),
//                         DataCell(Text(child.parent?.phone ?? 'Not registered')),
//                       ]);
//                     }).toList(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }