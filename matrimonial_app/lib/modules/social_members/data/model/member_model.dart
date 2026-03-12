// lib/app/data/models/signInModel.dart
class MemberModel {
  final int id;
  final String name;
  final int age;
  final String city;
  final String gotra;
  final String education;
  final String profession;
  final String height;
  final String gender;
  final bool isVerified;
  final bool isNew;
  final String? imageUrl;
  final String? income;
  final String manglik;
  final String complexion;
  final String fatherOccupation;
  final String motherOccupation;
  final String siblings;
  final String familyType;
  final String subCaste;
  final String motherTongue;
  final String about;
  bool isShortlisted;
  bool interestSent;

  MemberModel({
    required this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.gotra,
    required this.education,
    required this.profession,
    required this.height,
    required this.gender,
    this.isVerified = false,
    this.isNew = false,
    this.imageUrl,
    this.income,
    this.manglik = 'No',
    this.complexion = 'Fair',
    this.fatherOccupation = 'Business',
    this.motherOccupation = 'Homemaker',
    this.siblings = '1 Brother',
    this.familyType = 'Nuclear',
    this.subCaste = 'Agrawal',
    this.motherTongue = 'Hindi',
    this.about = '',
    this.isShortlisted = false,
    this.interestSent = false,
  });

  String get initials => name.split(' ').map((w) => w[0]).take(2).join().toUpperCase();
}

class NoticeModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final String type; // 'event' | 'notice' | 'news' | 'wedding'
  final String emoji;
  final bool isImportant;

  NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    required this.emoji,
    this.isImportant = false,
  });
}

class SuccessStoryModel {
  final int id;
  final String groomName;
  final String brideName;
  final String marriageDate;
  final String city;
  final String message;
  final String groomGotra;
  final String brideGotra;

  SuccessStoryModel({
    required this.id,
    required this.groomName,
    required this.brideName,
    required this.marriageDate,
    required this.city,
    required this.message,
    this.groomGotra = 'Agrawal',
    this.brideGotra = 'Agrawal',
  });
}

class SocialMemberModel {
  final int id;
  final String name;
  final String designation;
  final String city;
  final String contribution;
  final String? imageUrl;

  SocialMemberModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.city,
    required this.contribution,
    this.imageUrl,
  });

  String get initials => name.split(' ').map((w) => w[0]).take(2).join().toUpperCase();
}

class GalleryModel {
  final int id;
  final String title;
  final String category;
  final String date;
  final String emoji;
  final String? imageUrl;

  GalleryModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.emoji,
    this.imageUrl,
  });
}

class MessageModel {
  final int id;
  final String name;
  final String initials;
  final String lastMessage;
  final String time;
  final int unread;
  final bool isOnline;

  MessageModel({
    required this.id,
    required this.name,
    required this.initials,
    required this.lastMessage,
    required this.time,
    this.unread = 0,
    this.isOnline = false,
  });
}

// ── SAMPLE DATA ──────────────────────────────────────────────────
class SampleData {
  static List<MemberModel> get members => [
    MemberModel(id: 1, name: 'Priya Agrawal', age: 25, city: 'Jaipur', gotra: 'Garg', education: 'MBA Finance', profession: 'Chartered Accountant', height: "5'4\"", gender: 'female', isVerified: true, isNew: true, income: '₹10 LPA', subCaste: 'Bansal', about: 'Simple, family-oriented girl. Love cooking and traveling.'),
    MemberModel(id: 2, name: 'Sneha Mittal', age: 27, city: 'Mumbai', gotra: 'Singhal', education: 'B.Tech IT', profession: 'Software Engineer', height: "5'5\"", gender: 'female', isVerified: true, income: '₹14 LPA', subCaste: 'Mittal', about: 'Tech professional, love music and reading.'),
    MemberModel(id: 3, name: 'Pooja Bansal', age: 24, city: 'Delhi', gotra: 'Goyal', education: 'MBBS', profession: 'Doctor', height: "5'3\"", gender: 'female', isNew: true, income: '₹12 LPA', subCaste: 'Goyal', about: 'Serving society as a doctor.'),
    MemberModel(id: 4, name: 'Anjali Agrawal', age: 26, city: 'Indore', gotra: 'Mangal', education: 'B.Com + CA', profession: 'CA', height: "5'4\"", gender: 'female', isVerified: true, income: '₹9 LPA', about: 'Looking for a well-settled groom.'),
    MemberModel(id: 5, name: 'Ritu Gupta', age: 23, city: 'Bhopal', gotra: 'Jindal', education: 'M.Sc. Biotech', profession: 'Research Scientist', height: "5'2\"", gender: 'female', income: '₹7 LPA', subCaste: 'Gupta', about: 'Research scientist passionate about science and spirituality.'),
    MemberModel(id: 6, name: 'Kavita Garg', age: 26, city: 'Ujjain', gotra: 'Garg', education: 'M.Com', profession: 'Teacher', height: "5'3\"", gender: 'female', isVerified: true, income: '₹6 LPA', about: 'Simple girl from a respected family.'),
  ];

  static List<NoticeModel> get notices => [
    NoticeModel(id: 1, title: 'Agrawal Samaj Annual Milap 2025', description: 'आप सभी को आमंत्रित किया जाता है कि दिनांक 15 जनवरी 2025 को अग्रवाल समाज का वार्षिक मिलाप कार्यक्रम आयोजित किया जाएगा। स्थान: टाउन हॉल, उज्जैन। समय: प्रातः 10 बजे।', date: '15 Jan 2025', type: 'event', emoji: '🎊', isImportant: true),
    NoticeModel(id: 2, title: 'New Member Registration Open', description: 'Agraseva.com पर नए सदस्यों का पंजीकरण अब खुला है। इस माह पंजीकरण पर 50% छूट मिलेगी। आज ही जुड़ें और अपना सही जीवनसाथी खोजें।', date: '01 Jan 2025', type: 'notice', emoji: '📝', isImportant: true),
    NoticeModel(id: 3, title: 'Vivah Milan Samaroh 2025', description: 'अग्रसेवा द्वारा आयोजित विवाह मिलन समारोह 20 फरवरी 2025 को होगा। इसमें 200+ योग्य वर-वधू परिवार भाग लेंगे। निःशुल्क पंजीकरण।', date: '20 Feb 2025', type: 'wedding', emoji: '💒', isImportant: false),
    NoticeModel(id: 4, title: 'Community Health Camp', description: 'Free health checkup camp organized by Agrawal Samaj on 5th Feb 2025 at Samaj Bhawan, Ujjain. Blood test, BP check, sugar test - all free.', date: '05 Feb 2025', type: 'news', emoji: '🏥', isImportant: false),
    NoticeModel(id: 5, title: 'Premium Membership Offer', description: 'इस माह Premium सदस्यता लेने पर 3 माह के मूल्य में 6 माह की सदस्यता मिलेगी। असीमित संपर्क और प्रोफ़ाइल देखें।', date: '10 Jan 2025', type: 'notice', emoji: '⭐', isImportant: false),
    NoticeModel(id: 6, title: 'Navratri Garba Event 2024', description: 'Agrawal Samaj Annual Navratri Garba celebration was a grand success with 1000+ attendees. Thank you all for your participation!', date: '15 Oct 2024', type: 'event', emoji: '🪔', isImportant: false),
  ];

  static List<SuccessStoryModel> get successStories => [
    SuccessStoryModel(id: 1, groomName: 'Rohit Agrawal', brideName: 'Priyanka Bansal', marriageDate: 'February 2024', city: 'Indore', message: 'We found each other on Agraseva and it was love at first sight. Thank you Agraseva for making our dream come true!', groomGotra: 'Singhal', brideGotra: 'Bansal'),
    SuccessStoryModel(id: 2, groomName: 'Vivek Mittal', brideName: 'Deepika Garg', marriageDate: 'November 2023', city: 'Jaipur', message: 'Agraseva is a blessing for our community. Within 3 months of registration we found the perfect match. Highly recommended!', groomGotra: 'Mittal', brideGotra: 'Garg'),
    SuccessStoryModel(id: 3, groomName: 'Amit Goyal', brideName: 'Ritu Singhal', marriageDate: 'March 2023', city: 'Delhi', message: 'Our families were connected through Agraseva. Today we are happily married with the blessings of our elders.', groomGotra: 'Goyal', brideGotra: 'Singhal'),
    SuccessStoryModel(id: 4, groomName: 'Sanjay Bansal', brideName: 'Neha Agrawal', marriageDate: 'December 2023', city: 'Mumbai', message: 'It was a perfect match made through Agraseva. Our families are very happy and we are blessed!', groomGotra: 'Bansal', brideGotra: 'Agrawal'),
  ];

  static List<SocialMemberModel> get socialMembers => [
    SocialMemberModel(id: 1, name: 'Govind Mittal', designation: 'Founder & Owner, Agraseva', city: 'Ujjain, MP', contribution: 'Founded Agraseva to serve Agrawal Samaj through trusted matrimonial platform. Dedicated to community welfare.'),
    SocialMemberModel(id: 2, name: 'Ramesh Agrawal', designation: 'President, Agrawal Samaj', city: 'Indore, MP', contribution: 'Leading the community for 15+ years with social welfare activities and events.'),
    SocialMemberModel(id: 3, name: 'Suresh Bansal', designation: 'Social Activist', city: 'Jaipur, RJ', contribution: 'Organized 200+ community marriages and social events. Dedicated social worker.'),
    SocialMemberModel(id: 4, name: 'Dr. Anita Garg', designation: 'Social Worker & Doctor', city: 'Delhi', contribution: 'Free medical camps for underprivileged Agrawal families across MP and Rajasthan.'),
    SocialMemberModel(id: 5, name: 'Mahesh Singhal', designation: 'Treasurer, Samaj Trust', city: 'Ujjain, MP', contribution: 'Managing community funds, scholarship programs and educational support.'),
  ];

  static List<GalleryModel> get gallery => [
    GalleryModel(id: 1, title: 'Agrawal Samaj Annual Event 2024', category: 'Events', date: 'Dec 2024', emoji: '🎊'),
    GalleryModel(id: 2, title: 'Community Wedding Ceremony', category: 'Weddings', date: 'Nov 2024', emoji: '💒'),
    GalleryModel(id: 3, title: 'Navratri Celebration', category: 'Community', date: 'Oct 2024', emoji: '🪔'),
    GalleryModel(id: 4, title: 'Third Event Highlights', category: 'Events', date: 'Oct 2024', emoji: '🌟'),
    GalleryModel(id: 5, title: 'Diwali Pooja Gathering', category: 'Community', date: 'Nov 2024', emoji: '🎆'),
    GalleryModel(id: 6, title: 'Blood Donation Camp', category: 'Activities', date: 'Sep 2024', emoji: '🩸'),
    GalleryModel(id: 7, title: 'High Profile Event 2023', category: 'Events', date: 'Jan 2023', emoji: '🏆'),
    GalleryModel(id: 8, title: 'Happy Couple Rohit & Priya', category: 'Weddings', date: 'Feb 2024', emoji: '💑'),
  ];

  static List<MessageModel> get messages => [
    MessageModel(id: 1, name: 'Priya Agrawal', initials: 'PA', lastMessage: 'Namaste! I saw your profile and liked it very much 🙏', time: '2m', unread: 2, isOnline: true),
    MessageModel(id: 2, name: 'Sneha Mittal', initials: 'SM', lastMessage: 'Thank you for showing interest 🙏', time: '1h', unread: 0, isOnline: false),
    MessageModel(id: 3, name: 'Pooja Bansal', initials: 'PB', lastMessage: 'Can we connect on a call?', time: '2h', unread: 1, isOnline: true),
    MessageModel(id: 4, name: 'Anjali Agrawal', initials: 'AA', lastMessage: 'Hello! My family would like to meet...', time: '1d', unread: 0, isOnline: false),
  ];
}

