import 'package:believe_app/pages/storage/storage_folder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../constant/colors.dart';
import '../../model/storage/storage_models.dart';
import '../../utils/app_utils.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  List<StorageData> storagedata = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff007AFF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            appBar(),
            const SizedBox(height: 20),
            searchBar(),
            const SizedBox(height: 20),
            storageSection()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    storagedata = [
      StorageData(folderId: 1, folderName: 'December Data', subFolder: 0, items:  0),
      StorageData(folderId: 1, folderName: 'Important', subFolder: 2, items: 15),
      StorageData(folderId: 1, folderName: 'Family Documents', subFolder: 0,items: 12),
      StorageData(folderId: 1, folderName: 'MR List', subFolder: 0, items: 5),
      StorageData(folderId: 1, folderName: 'New Medicine December January and February', subFolder: 0, items: 30),
      StorageData(folderId: 1, folderName: 'Personal Data', subFolder: 0, items: 8)
    ];
    super.initState();
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color(0xff0171EB)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset('assets/svgs/backWhite.svg',
                    height: 20, width: 20),
              ),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text('Storage',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Recoleta',
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
              child: SizedBox(
                height: 44,
                child: TextField(
                  cursorColor: white,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {

                  },
                  style: editTextStyleWhite(),
                  onChanged: (value) {

                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xff0171EB),
                    contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                        borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xff0171EB))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                        borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xff0171EB))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: Color(0xff0171EB))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: Color(0xff0171EB))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                        borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xff0171EB))),
                    hintText: 'Search...',
                    labelStyle: const TextStyle(
                      color: white,
                      fontSize: 16,
                      fontFamily: otherFont,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Image.asset(
                        'assets/images/ic_search.png',
                        height: 12,
                        width: 12,
                        color: white,
                      ),
                    ),
                    hintStyle: const TextStyle(color: white, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                  ),
                ),
              )),
          const Gap(12),
          GestureDetector(
            onTap: () {
            },
            child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Color(0xff0171EB)),
                height: 42,
                width: 42,
                padding: const EdgeInsets.all(13),
                child: Image.asset('assets/images/ic_add.png', height: 28, width: 28)),
          ),
        ],
      ),
    );
  }

  Widget storageSection(){
    return Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14))),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            itemBuilder: (context, index) {
              String foldername = storagedata[index].folderName!;
              int subfolder = storagedata[index].subFolder!;
              int items = storagedata[index].items!;
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FolderScreen(folderName: foldername)));
              },
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: const Color(0xff7C7E88).withOpacity(0.5))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/folder.svg',height: 45,width: 45),
                        const SizedBox(width: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(foldername, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14))),
                            subfolder == 0 && items == 0 ? const SizedBox() : Row(
                              children: [
                                subfolder != 0 ? Text('$subfolder Folder', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xff7C7E88))) : const SizedBox(),
                                SizedBox(
                                  height: 12,
                                  child: items != 0 && subfolder != 0 ? const VerticalDivider() : const SizedBox(),
                                ),
                                items != 0 ? Text('$items items', style: const TextStyle(fontSize: 12, color: Color(0xff7C7E88))) : const SizedBox()
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Color(0xffCCCCCC),size: 20)
                  ],
                ),
              ),
            );
          }, separatorBuilder: (context, index) => const SizedBox(height: 10), itemCount: storagedata.length),
        ));
  }
}
