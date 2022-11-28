import '../data/models/branch_object.dart';
import '../data/models/category_object.dart';
import '../data/models/notification_object.dart';
import '../data/models/store_object.dart';
import '../data/models/sub_category_object.dart';

String url = "";

int SUCCESS_CODE = 200;
String DEF_ERROR = 'Error happened, try again later!';
String DEF_ABOUT_US =
    'This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience   This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience  This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience This content is an insignificant content that is only used to improve the user experience  ';

// Todo: May bec changed later
List<String> myIcons = [
  'assets/icons/whatsapp.png',
  'assets/icons/instagram.png',
  'assets/icons/phone.png',
  'assets/icons/placeholder.png',
];

const String defaultPlaceholderImagePath = 'assets/images/placeholder.jpg';

List<CategoryObject> fakeCategories = [
  CategoryObject(
    id: 1,
    name: "Shops",
    image: 'shops.svg',
  ),
  CategoryObject(
    id: 2,
    name: "Education",
    image: 'education.svg',
  ),
  CategoryObject(
    id: 3,
    name: "Government Bodies",
    image: 'government.svg',
  ),
  CategoryObject(
    id: 4,
    name: "Health",
    image: 'health.svg',
  ),
  CategoryObject(
    id: 5,
    name: "Entertainment",
    image: 'entertainment.svg',
  ),
  CategoryObject(
    id: 6,
    name: "Shops",
    image: 'shops.svg',
  ),
  CategoryObject(
    id: 7,
    name: "Education",
    image: 'education.svg',
  ),
  CategoryObject(
    id: 8,
    name: "Government Bodies",
    image: 'government.svg',
  ),
  CategoryObject(
    id: 9,
    name: "Health",
    image: 'health.svg',
  ),
  CategoryObject(
    id: 10,
    name: "Entertainment",
    image: 'entertainment.svg',
  ),
  CategoryObject(
    id: 11,
    name: "Shops",
    image: 'shops.svg',
  ),
  CategoryObject(
    id: 12,
    name: "Education",
    image: 'education.svg',
  ),
  CategoryObject(
    id: 13,
    name: "Government Bodies",
    image: 'government.svg',
  ),
  CategoryObject(
    id: 14,
    name: "Health",
    image: 'health.svg',
  ),
  CategoryObject(
    id: 15,
    name: "Entertainment",
    image: 'entertainment.svg',
  ),
];

List<SubCategoryObject> fakeSubCategory = [
  SubCategoryObject(
    id: 1,
    categoryId: 1,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 2,
    categoryId: 1,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 3,
    categoryId: 2,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 4,
    categoryId: 2,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 5,
    categoryId: 3,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 6,
    categoryId: 3,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 7,
    categoryId: 4,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 8,
    categoryId: 4,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 9,
    categoryId: 5,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 10,
    categoryId: 5,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 11,
    categoryId: 6,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 12,
    categoryId: 6,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 13,
    categoryId: 7,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 14,
    categoryId: 7,
    name: "Education1",
    image: 'education.svg',
  ),
  SubCategoryObject(
    id: 15,
    categoryId: 8,
    name: "Education1",
    image: 'education.svg',
  ),
];

List<StoreObject> fakeStores = [
  StoreObject(
    id: 1,
    name: 'Banota',
    subCategoryId: 1,
    image: 'assets/icons/store1.png',
    branches: [
      BranchObject(
        id: 1,
        name: 'First Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
      BranchObject(
        id: 2,
        name: 'Second Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
    ],
  ),
  StoreObject(
    id: 2,
    name: 'El-saqqr',
    subCategoryId: 1,
    image: 'assets/icons/store2.png',
    branches: [
      BranchObject(
        id: 1,
        name: 'First Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
      BranchObject(
        id: 2,
        name: 'Second Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
      BranchObject(
        id: 3,
        name: 'Third Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
    ],
  ),
  StoreObject(
    id: 3,
    name: 'Banota',
    subCategoryId: 2,
    image: 'assets/icons/store1.png',
    branches: [
      BranchObject(
        id: 1,
        name: 'First Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
      BranchObject(
        id: 2,
        name: 'Second Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
      BranchObject(
        id: 3,
        name: 'Third Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
      BranchObject(
        id: 4,
        name: 'Forth Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
    ],
  ),
  StoreObject(
    id: 4,
    name: 'El-saqqr',
    subCategoryId: 3,
    image: 'assets/icons/store2.png',
    branches: [
      BranchObject(
        id: 1,
        name: 'First Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
      BranchObject(
        id: 2,
        name: 'Second Branch',
        address: 'No. 257 Ramses Street - Azbakia',
        phone: '+973 54844214',
        whatsappLink: '+973 54844214',
        instaLink: '@Alsaqer22',
      ),
    ],
  ),
];

List<NotificationObject> fakeNotifications = [
  NotificationObject(
    id: 1,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 1,
  ),
  NotificationObject(
    id: 2,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 1,
  ),
  NotificationObject(
    id: 3,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 2,
  ),
  NotificationObject(
    id: 4,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 2,
  ),
  NotificationObject(
    id: 5,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 3,
  ),
  NotificationObject(
    id: 6,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 3,
  ),
  NotificationObject(
    id: 7,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 4,
  ),
  NotificationObject(
    id: 8,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 4,
  ),
  NotificationObject(
    id: 9,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 5,
  ),
  NotificationObject(
    id: 10,
    content:
        "This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator",
    createdAt: '2022 August 10',
    isSeen: false,
    image: 'Ellipse 5.png',
    store: 5,
  ),
];

final List<String> fakeBuildingTypes = [
  'buildingType1',
  'buildingType2',
  'buildingType3',
  'buildingType4'
];

final List<String> fakeDistricts = [
  'location1',
  'location2',
  'location3',
  'location4'
];
