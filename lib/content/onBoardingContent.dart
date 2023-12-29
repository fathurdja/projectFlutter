class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Sport Habits',
      image: 'assets/images/content1.jpg',
      discription:
          "Membangun rutinitas olahraga yang konsisten dapat meningkatkan gaya hidup sehat dan meningkatkan kesejahteraan secara keseluruhan Aktivitas fisik secara teratur tidak hanya meningkatkan kebugaran fisik, tetapi juga berkontribusi pada kejernihan mental dan mengurangi stres"),
  UnbordingContent(
      title: 'Health LifeStyle',
      image: 'assets/images/content2.jpg',
      discription:
          "Menerapkan gaya hidup sehat melibatkan keputusan untuk menjaga keseimbangan antara pola makan nutrisi dan aktivitas fisik. Memilih makanan bergizi dan menjaga tidur yang cukup menjadi langkah-langkah penting dalam menciptakan fondasi kesehatan yang kokoh."),
  UnbordingContent(
      title: 'Make Your Community',
      image: 'assets/images/content3.jpg',
      discription:
          "mengajak setiap individu untuk aktif terlibat dalam kegiatan olahraga. Dengan mendukung dan mendorong partisipasi dalam berbagai jenis olahraga, kita dapat menciptakan lingkungan yang sehat dan aktif. "),
];
