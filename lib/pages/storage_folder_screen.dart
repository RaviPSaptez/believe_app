import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/colors.dart';
import '../data/model/storage_models.dart';
import '../utils/app_utils.dart';

class FolderScreen extends StatefulWidget {
  final String folderName;
  const FolderScreen({required this.folderName,super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  List<FileType> filetypes = [];
  List<SubFolder> subfolders = [];
  List<FolderFiles> files = [];
  String _selectedFileType = 'All';
  String _selectedPopupMenuItem = 'Time Added';
  final TextEditingController _createFolderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff007AFF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            appBar(),
            const SizedBox(height: 20),
            searchBar(),
            const SizedBox(height: 20),
            itemSection()
          ],
        ),
      ),
    );
  }



  @override
  void initState() {
    subfolders = [
      SubFolder(folderId: 1, folderName: 'New Medicine December', subFolder: 0, items:  3),
      SubFolder(folderId: 2, folderName: 'Personal Data', subFolder: 0, items: 5),
    ];
    filetypes = [
      FileType(id: 1, name: 'All'),
      FileType(id: 2, name: 'Documents'),
      FileType(id: 3, name: 'Photos'),
      FileType(id: 4, name: 'Audio'),
      FileType(id: 5, name: 'Videos'),
      FileType(id: 6, name: 'Others')
    ];
    files = [
      FolderFiles(fileName: 'Hello How are You Thank You.doc', fileId: 1, fileSize: '200KB', date: '19/12/23'),
      FolderFiles(fileName: '2.pdf', fileId: 2, fileSize: '150KB', date: '19/12/24'),
      FolderFiles(fileName: '3.txt', fileId: 3, fileSize: '50KB', date: '19/12/25'),
      FolderFiles(fileName: '4.jpg', fileId: 4, fileSize: '500KB', date: '19/12/26'),
      FolderFiles(fileName: '5.xls', fileId: 5, fileSize: '300KB', date: '19/12/27'),
      FolderFiles(fileName: '6.ppt', fileId: 6, fileSize: '250KB', date: '19/12/28'),
      FolderFiles(fileName: '7.mp3', fileId: 7, fileSize: '4MB', date: '19/12/29'),
      FolderFiles(fileName: '8.mp4', fileId: 8, fileSize: '600MB', date: '19/12/30'),
      FolderFiles(fileName: '9.png', fileId: 9, fileSize: '1MB', date: '20/01/01'),
      FolderFiles(fileName: '10.zip', fileId: 10, fileSize: '2GB', date: '20/01/02'),
      FolderFiles(fileName: '11.pdf', fileId: 11, fileSize: '5MB', date: '20/01/03'),
      FolderFiles(fileName: '12.jpg', fileId: 12, fileSize: '100KB', date: '20/01/04'),
      FolderFiles(fileName: '13.doc', fileId: 13, fileSize: '20KB', date: '20/01/05'),
      FolderFiles(fileName: '14.png', fileId: 14, fileSize: '30KB', date: '20/01/06'),
      FolderFiles(fileName: '15.doc', fileId: 15, fileSize: '40KB', date: '20/01/07')
    ];

    super.initState();
  }

  @override
  void dispose() {
    _createFolderController.dispose();
    super.dispose();
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
           Expanded(
            child: Text(widget.folderName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Recoleta',
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset('assets/svgs/ellipsisMenu.svg',height: 20, width: 20),
          )
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

  Future<dynamic> sheetForAction() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Wrap(
                  children: [
                    Center(
                      child: Container(
                        height: 6,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffD9D9D9), width: 1.5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SvgPicture.asset(
                                            'assets/svgs/close.svg',
                                            width: 20,
                                            height: 20),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 120),
                                          child: Center(
                                              child: Text('Action',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .w900))),
                                        ),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox())
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 22,top: 22),
                            child: Column(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.pop(context);
                                    sheetForCreateNewFolder();
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 20,height: 20,
                                          child: SvgPicture.asset('assets/svgs/folder.svg')),
                                      const SizedBox(width: 20),
                                      const Text('Create Folder',style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 22),
                                GestureDetector(
                                  onTap: () {
                                    sheetForUpload();
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 20,height: 20,
                                          child: SvgPicture.asset('assets/svgs/file.svg')),
                                      const SizedBox(width: 20),
                                      const Text('Upload File',style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              });
        });
      },
    );
  }


  Future<dynamic> sheetForCreateNewFolder() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Wrap(
                    children: [
                      Center(
                        child: Container(
                          height: 6,
                          width: 60,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15))),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffD9D9D9), width: 1.5))),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: SvgPicture.asset(
                                              'assets/svgs/close.svg',
                                              width: 18,
                                              height: 18),
                                        ),
                                      ),
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 30),
                                            child: Center(
                                                child: Text('Create New Folder',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight
                                                            .w900))),
                                          ),
                                        ],
                                      ),
                                       GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Create',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff007AFF))))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 22,top: 22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text('Folder Name',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 25),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        border: Border.all(color: const Color(0xff7E7E7E))),
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextField(
                                            controller: _createFolderController,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(color: Color(0xff666666)),
                                                hintText: 'Untitled Folder'),
                                            style: const TextStyle(color: Color(0xff666666))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        });
      },
    );
  }

  Future<dynamic> sheetForUpload() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Wrap(
                  children: [
                    Center(
                      child: Container(
                        height: 6,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffD9D9D9), width: 1.5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SvgPicture.asset(
                                            'assets/svgs/close.svg',
                                            width: 20,
                                            height: 20),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 120),
                                          child: Center(
                                              child: Text('Upload',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .w900))),
                                        ),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox())
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 22,top: 22),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 20,height: 20,
                                        child: SvgPicture.asset('assets/svgs/pdfFile.svg')),
                                    const SizedBox(width: 20),
                                    const Text('PDF',style: TextStyle(fontSize: 20))
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 20,height: 20,
                                        child: SvgPicture.asset('assets/svgs/file.svg')),
                                    const SizedBox(width: 20),
                                    const Text('Files/Txt/Doc',style: TextStyle(fontSize: 20))
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 20,height: 20,
                                        child: SvgPicture.asset('assets/svgs/imageFile.svg')),
                                    const SizedBox(width: 20),
                                    const Text('Photos',style: TextStyle(fontSize: 20))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              });
        });
      },
    );
  }

  Widget itemSection() {
    return Expanded(
        child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      child: Column(
        children: [
          listOfFileTypes(),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                subFolderSection(),
                itemHeader(),
                itemListSection()
              ],
            ),
          )
        ],
      ),
    ));
  }

  void showCustomDialog() {
    double svgSize = 18.0;
    double paddingForSvg = 20;
    double sizedBoxSize = 18;
    Color mainColor = Colors.black;
    Color selectedColor = const Color(0xff007AFF);
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: 'barrier',
      context: context, pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: const AlignmentDirectional(0.8, -0.2),
        child: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 20, right: 20, left: 30),
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                    const SizedBox(width: 20),
                    Text('Time Added', style: TextStyle(decoration: TextDecoration.none,fontSize: 18, color: _selectedPopupMenuItem == 'Time Added' ? selectedColor : mainColor)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                    const SizedBox(width: 20),
                    Text('Size', style: TextStyle(decoration: TextDecoration.none,fontSize: 18, color: _selectedPopupMenuItem == 'Size' ? selectedColor : mainColor)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                    const SizedBox(width: 20),
                    Text('Filename', style: TextStyle(decoration: TextDecoration.none,fontSize: 18, color: _selectedPopupMenuItem == 'Filename' ? selectedColor : mainColor)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                    const SizedBox(width: 20),
                    Text('Type', style: GoogleFonts.workSans(decoration: TextDecoration.none,fontSize: 18, color: _selectedPopupMenuItem == 'Filename' ? selectedColor : mainColor)),
                  ],
                ),
              )

            ],
          ),
        ),
      );
    },);
  }

  Widget itemHeader(){
    double svgSize = 18.0;
    double paddingForSvg = 20;
    double sizedBoxSize = 18;
    Color mainColor = Colors.black;
    Color selectedColor = const Color(0xff007AFF);
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('15 Items', style: TextStyle(color: Color(0xff666666),fontSize: 16)),
              GestureDetector(
                onTap: () {
                  // showCustomDialog();
                  showMenu(
                    constraints: const BoxConstraints(
                      maxWidth: 200,
                      minWidth: 200
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      context: context,
                      position: const RelativeRect.fromLTRB(100, 240, 20, 100.0),
                      items: <PopupMenuEntry<String>>[
                         PopupMenuItem(
                          onTap: () {
                            setState(() {
                              _selectedPopupMenuItem = 'Time Added';
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _selectedPopupMenuItem == 'Time Added' ? Padding(
                              padding: EdgeInsets.only(right: paddingForSvg, left: paddingForSvg),
                              child: SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                            ) : Padding(
                              padding: EdgeInsets.only(right: sizedBoxSize, left: sizedBoxSize),
                              child: SizedBox(height: sizedBoxSize, width: sizedBoxSize),
                            ),
                            Text('Time Added', style: TextStyle(fontSize: 18, color: _selectedPopupMenuItem == 'Time Added' ? selectedColor : mainColor)),
                          ],
                           ),
                         ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              _selectedPopupMenuItem = 'Size';
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _selectedPopupMenuItem == 'Size' ? Padding(
                                padding: EdgeInsets.only(right: paddingForSvg, left: paddingForSvg),
                                child: SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                              ) : Padding(
                                padding: EdgeInsets.only(right: sizedBoxSize, left: sizedBoxSize),
                                child: SizedBox(height: sizedBoxSize, width: sizedBoxSize),
                              ),
                             Text('Size', style: TextStyle(fontSize: 18, color: _selectedPopupMenuItem == 'Size' ? selectedColor : mainColor)),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              _selectedPopupMenuItem = 'Filename';
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _selectedPopupMenuItem == 'Filename' ? Padding(
                                padding: EdgeInsets.only(right: paddingForSvg, left: paddingForSvg),
                                child: SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                              ) : Padding(
                                padding: EdgeInsets.only(right: sizedBoxSize, left: sizedBoxSize),
                                child: SizedBox(height: sizedBoxSize, width: sizedBoxSize),
                              ),
                              Text('Filename', style: TextStyle(fontSize: 18, color: _selectedPopupMenuItem == 'Filename' ? selectedColor : mainColor)),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              _selectedPopupMenuItem = 'Type';
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _selectedPopupMenuItem == 'Type' ? Padding(
                                padding: EdgeInsets.only(right: paddingForSvg, left: paddingForSvg),
                                child: SvgPicture.asset('assets/svgs/arrowDown.svg',width: svgSize, height: svgSize),
                              ) : Padding(
                                padding: EdgeInsets.only(right: sizedBoxSize, left: sizedBoxSize),
                                child: SizedBox(height: sizedBoxSize, width: sizedBoxSize),
                              ),
                              Text('Type', style: TextStyle(fontSize: 18, color: _selectedPopupMenuItem == 'Type' ? selectedColor : mainColor)),
                            ],
                          ),
                        ),
                      ]
                  );
                },
                child: const Row(
                  children: [
                    Text('Sort By', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.arrow_drop_down, color: Color(0xff7C7E88), size: 25)
                  ],
                ),
              )
            ],
          ),
    );
  }


  Widget itemListSection(){
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 30),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.only(right: 10),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
         String fileName = files[index].fileName!;
         String fileSize = files[index].fileSize!;
         String fileCreationDate = files[index].date!;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //File Icons
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
              color: Color(0xffC2DFFF),
              borderRadius: BorderRadius.all(Radius.circular(16))
            )),
            const SizedBox(width: 20),
            // Column for Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fileName, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  Row(
                    children: [
                      Text(fileSize, style: const TextStyle(color: Color(0xff7C7E88), fontSize: 12)),
                      const SizedBox(
                        height: 10,
                        child: VerticalDivider(),
                      ),
                      Text(fileCreationDate, style: const TextStyle(color: Color(0xff7C7E88), fontSize: 12))
                    ],
                  )
                ],
              ),
            ),
            //Delete Button
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 30),
              child: SvgPicture.asset('assets/svgs/deleteButton.svg', width: 28, height: 28),
            ),
            SvgPicture.asset('assets/svgs/ellipsisMenuBlack.svg', width: 20, height: 20)
          ],
        );
      }, separatorBuilder: (context, index) => const SizedBox(height: 25), itemCount: files.length),
    );
  }

  Widget listOfFileTypes() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: SizedBox(
        height: 45,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 22, right: 20),
            itemBuilder: (context, index) {
              String label = filetypes[index].name!;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFileType = label;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff007AFF)),
                      borderRadius: BorderRadius.circular(12),
                      // color: const Color(0xff5811ce)
                      color: _selectedFileType == label
                          ? const Color(0xff007AFF)
                          : Colors.white),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        // top: 12,
                        // bottom: 12,
                          left: 20,
                          right: 20),
                      child: Text(label,
                          style: TextStyle(
                              color: _selectedFileType == label
                                  ? Colors.white
                                  : const Color(0xff007AFF))),
                    ),
                  ),
                ),
              );
            }, separatorBuilder:  (context, index) => const SizedBox(width: 8), itemCount: filetypes.length),
      ),
    );
  }

 Widget subFolderSection(){
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Container(
      padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: const Color(0xff7C7E88).withOpacity(0.5))
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            String foldername = subfolders[index].folderName!;
            int subfolder = subfolders[index].subFolder!;
            int items = subfolders[index].items!;
            return Row(
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
            );
          }, separatorBuilder: (context, index) => const SizedBox(height: 25), itemCount: subfolders.length),
    ),
  );
 }

}
