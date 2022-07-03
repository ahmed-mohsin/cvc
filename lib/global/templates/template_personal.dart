import 'dart:typed_data';
import 'package:fresume_app/global/models/pdf_model.dart';
import 'package:fresume_app/global/templates/temp2.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

Future<Uint8List> generateDocument(context,
    {required PdfModel pdfModel}) async {
  final doc = Document(pageMode: PdfPageMode.outlines);

  var regular = await PdfGoogleFonts.nunitoSansRegular();
  var italic = await PdfGoogleFonts.nunitoSansItalic();
  var bold = await PdfGoogleFonts.nunitoSansBold();
  var boldItalic = await PdfGoogleFonts.nunitoSansBoldItalic();

  doc.addPage(page2(pdfModel,
      regular: regular, italic: italic, bold: bold, boldItalic: boldItalic));

  return await doc.save();
}

Container nameAndJobRole(Personal personal) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(top: 36, bottom: 16, left: 2, right: 2),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(personal.firstName ?? "",
                    style: const TextStyle(fontSize: 18, color: PdfColors.white)),
                SizedBox(width: 5),
                Text(personal.lastName ?? "",
                    style: const TextStyle(fontSize: 18,color: PdfColors.white)),
              ],
            ),
            if (personal.jobTitle != null)
              Text(personal.jobTitle!.toUpperCase(),
                  style: const TextStyle(
                    letterSpacing: 1.2,
                    wordSpacing: 1.3,
                    fontSize: 8,
                    color: PdfColors.white,
                  )),
          ]),
    ),
  );
}

profile(Summary summary, Font bold) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(top: 16, left: 36, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (summary.professionalSummary != null)
            Text("Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: PdfColor.fromHex('006C35'),
                  fontBold: bold,
                  fontSize: 13,
                )),
          SizedBox(height: 8),
          Container(
            child: Expanded(
              child: Text(
                summary.professionalSummary ?? "",
                style: const TextStyle(
                  color: PdfColors.black,
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget sectionTitle(String title, Font bold) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(top: 16, left: 36, right: 24),
      child: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: PdfColor.fromHex('006C35'),
            fontBold: bold,
            fontSize: 13,
          )),
    ),
  ]);
}

Widget skillSectionTitle(String title, Font bold) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 8),
      child: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
            fontBold: bold,
            fontSize: 13,
          )),
    ),
  ]);
}

Widget skillWidget(Skill skill, Font bold) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
    child: Text(
      skill.skillName ?? "",
      style: const TextStyle(
        color: PdfColors.white,
        fontSize: 10,
      ),
    ),
  );
}

Widget linksWidget(Links links, Font bold) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
    child: UrlLink(
        child: Text(
          links.linkName ?? "",
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.white,
            fontSize: 10,
          ),
        ),
        destination: links.linkUrl ?? ""),
  );
}

Widget sectionWidgetFull(Section section, Font bold) {
  String sectionTitle = '';
  String date = '';
  if (section.textOne != null) {
    sectionTitle += section.textOne! + ", ";
  }
  if (section.textTwo != null) {
    sectionTitle += section.textTwo! + ", ";
  }
  if (section.textThree != null) {
    sectionTitle += section.textThree!;
  }

  if (section.startDate != null) {
    date += section.startDate! + " - ";
  }
  if (section.endDate != null) {
    date += section.endDate!;
  }

  return Container(
    padding: const EdgeInsets.only(top: 16, left: 36, right: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Expanded(
          child: Text(sectionTitle,
              style: TextStyle(
                  fontBold: bold, fontWeight: FontWeight.bold, fontSize: 11)),
        )),
        SizedBox(height: 4),
        Text(date.toUpperCase(),
            style: const TextStyle(
              letterSpacing: 1.2,
              wordSpacing: 1.3,
              fontSize: 8,
              color: PdfColors.grey500,
            )),
        SizedBox(height: 8),
        Container(
          child: Expanded(
            child: Text(
              section.description ?? "",
              style: const TextStyle(
                color: PdfColors.black,
                fontSize: 10,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

Widget phoneAndEmail(Personal personal, Font bold) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (personal.email != null || personal.phoneNumber != null)
          Text("Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: PdfColors.white,
                fontBold: bold,
                fontSize: 13,
              )),
        SizedBox(height: 8),
        Text(personal.email ?? "",
            style: const TextStyle(
              color: PdfColors.white,
              fontSize: 10,
            )),
        SizedBox(height: 2),
        Text(
          personal.phoneNumber ?? "",
          style: const TextStyle(
            color: PdfColors.white,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}
