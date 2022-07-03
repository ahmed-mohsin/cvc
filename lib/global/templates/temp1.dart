import 'package:fresume_app/global/templates/template_personal.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/pdf_model.dart';

MultiPage page(PdfModel pdfModel,
    {required Font regular, required Font italic, required Font bold, required Font boldItalic}) {
  return MultiPage(
      pageTheme: PageTheme(
        margin: const EdgeInsets.all(0),
        buildBackground: (Context context) => Row(children: [
          Expanded(
            flex: 2,
            child: Container(color: PdfColors.white),
          ),
          Expanded(
              child: Container(
                color: PdfColor.fromHex('165d31'),
              ))
        ]),
        theme: ThemeData.withFont(base: regular, italic: italic, bold: bold, boldItalic: boldItalic),
      ),
      build: (context) {
        return [
          Partitions(children: [
            Partition(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameAndJobRole(pdfModel.resumePersonal!),
                  profile(pdfModel.resumeSummary!, bold),
                  if (pdfModel.employment != null && pdfModel.employment!.isNotEmpty)
                    sectionTitle('Employment History', bold),
                  if (pdfModel.employment != null && pdfModel.employment!.isNotEmpty)
                    for (var data in pdfModel.employment!) Column(children: [sectionWidgetFull(data, bold)]),
                  if (pdfModel.education != null && pdfModel.education!.isNotEmpty) sectionTitle('Education', bold),
                  if (pdfModel.education != null && pdfModel.education!.isNotEmpty)
                    for (var data in pdfModel.education!) Column(children: [sectionWidgetFull(data, bold)]),
                  if (pdfModel.activities != null && pdfModel.activities!.isNotEmpty)
                    sectionTitle('Extra-curricular activities', bold),
                  if (pdfModel.activities != null && pdfModel.activities!.isNotEmpty)
                    for (var data in pdfModel.activities!) Column(children: [sectionWidgetFull(data, bold)]),
                ],
              ),
            ),
            Partition(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  phoneAndEmail(pdfModel.resumePersonal!, bold),
                  if (pdfModel.links != null && pdfModel.links!.isNotEmpty) skillSectionTitle('Links', bold),
                  if (pdfModel.links != null && pdfModel.links!.isNotEmpty)
                    for (var data in pdfModel.links!) Column(children: [linksWidget(data, bold)]),
                  if (pdfModel.skills != null && pdfModel.skills!.isNotEmpty) skillSectionTitle('Skills', bold),
                  if (pdfModel.skills != null && pdfModel.skills!.isNotEmpty)
                    for (var data in pdfModel.skills!) Column(children: [skillWidget(data, bold)]),
                  if (pdfModel.languages != null && pdfModel.languages!.isNotEmpty) skillSectionTitle('Languages', bold),
                  if (pdfModel.languages != null && pdfModel.languages!.isNotEmpty)
                    for (var data in pdfModel.languages!) Column(children: [skillWidget(data, bold)]),
                ])),
          ]),
        ];
      });
}
