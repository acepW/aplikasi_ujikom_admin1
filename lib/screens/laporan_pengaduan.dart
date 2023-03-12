import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';


class LaporanPengaduan extends StatefulWidget {
  const LaporanPengaduan({super.key});

  @override
  State<LaporanPengaduan> createState() => _LaporanPengaduanState();
}

class _LaporanPengaduanState extends State<LaporanPengaduan> {
  late List<Perusahaan> perusahaan;
 List <Perusahaan> selectedRow = [];
 @override
  void initState() {
    // TODO: implement initState
    perusahaan = Perusahaan.getPerusahaan();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Expanded(
            child: DataTable2(
                columnSpacing: 6,
                horizontalMargin: 6,
                dataRowHeight: 30,
                minWidth: 1000,
                columns: [
                  DataColumn2(
                    label: Text(
                      'No',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    fixedWidth: 30
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text('Judul',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ),
                    fixedWidth: 100
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text('Nama',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ),
                    fixedWidth: 100
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text('Status',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ),
                    fixedWidth: 100
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text('Date',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ),
                    fixedWidth: 100
                  ),
                  
                ],
                rows:

                _createRowsManufacture()
                        ),
          ),
        ],
      ),
    );
  }
 List<DataRow> _createRowsManufacture() {
    return perusahaan
        .map((perusahaan) => DataRow(
          
          cells: [
              DataCell(Text(perusahaan.no,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.6,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ))),
                  DataCell(Center(
                    child: Text(perusahaan.perusahaanName,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.6,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                  )),
                  DataCell(Center(
                    child: Text(perusahaan.address,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.6,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                  )),
                  DataCell(Center(
                    child: Text(perusahaan.city,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.6,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                  )),
                  DataCell(Center(
                    child: Text(perusahaan.state,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.6,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                  )),
                 
            ]))
        .toList();
  }
}





class Perusahaan {
    final String no,perusahaanName,address,city,state,phone;

    const Perusahaan({
      required this.no,
      required this.perusahaanName,
      required this.address,
      required this.city,
      required this.state,
      required this.phone
     
    });
    

    static List<Perusahaan> getPerusahaan(){
      return <Perusahaan>[
        Perusahaan(no: "1", perusahaanName: "Perusahaan",address: "Addreas" ,city: "City",state: "State",phone: "Phone"),
        Perusahaan(no: "2", perusahaanName: "Perusahaan",address: "Addreas" ,city: "City",state: "State",phone: "Phone" ),
        Perusahaan(no: "3", perusahaanName: "Perusahaan", address: "Addreas" ,city: "City",state: "State",phone: "Phone" ),
        Perusahaan(no: "4", perusahaanName: "Perusahaan", address: "Addreas" ,city: "City",state: "State",phone: "Phone" ),
        Perusahaan(no: "5", perusahaanName: "Perusahaan",address: "Addreas" ,city: "City",state: "State",phone: "Phone" )
      ];
    }
  }