class ContentModel {
  final String title;
  final String thumbnailPath;
  final String platformIcon;
  final String caption;
  final String views;
  final String likes;
  final String comments;
  final String shares;
  final String earnings;
  final String status;

  ContentModel({
    required this.title,
    required this.thumbnailPath,
    required this.platformIcon,
    required this.caption,
    required this.views,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.earnings,
    required this.status,
  });
}

// --- DATA FAKE ---
final List<ContentModel> fakeContents = [
  ContentModel(
    title: 'Navidad con Topitop',
    thumbnailPath: 'assets/images/video_thumb_1.jpg',
    platformIcon: 'tiktok',
    caption: 'Con Inklop, podrás monetizar tu contenido. Descarga la app de una vez! #Inklop #fyp #viralvideo',
    views: '6.1 K',
    likes: '846 k',
    comments: '120',
    shares: '3.8 k',
    earnings: 'S/21.00',
    status: 'Aceptado',
  ),
  ContentModel(
    title: 'Promo Rokys',
    thumbnailPath: 'assets/images/video_thumb_2.jpg',
    platformIcon: 'tiktok',
    caption: 'Probando el nuevo combo de Rokys, está buenazo 🍗🔥 #Rokys #Pollo',
    views: '12.5 K',
    likes: '1.2 k',
    comments: '45',
    shares: '500',
    earnings: 'S/45.50',
    status: 'Pendiente',
  ),
];