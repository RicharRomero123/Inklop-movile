class CampaignModel {
  final String brandName;
  final String title;
  final String pricePerK;
  final double paidAmount;
  final double totalBudget;
  final String type;
  final String category;
  final bool isPopular;
  final int colorCode;

  // --- NUEVOS CAMPOS ---
  final String description;
  final String deadline;      // Ej: 27 Nov 2025
  final String maxPay;        // Ej: S/300.00
  final String reward;        // Ej: S/3.00
  final List<String> requirements; // Lista de pautas
  final List<String> socialLinks;  // Para la tab Recursos

  // --- CAMPO DE FOTO AGREGADO ---
  final String photoUrl;      // URL de la imagen de fondo o producto

  CampaignModel({
    required this.brandName,
    required this.title,
    required this.pricePerK,
    required this.paidAmount,
    required this.totalBudget,
    required this.type,
    required this.category,
    this.isPopular = false,
    required this.colorCode,
    required this.description,
    required this.deadline,
    required this.maxPay,
    required this.reward,
    required this.requirements,
    required this.socialLinks,
    // Requerido en el constructor
    required this.photoUrl,
  });
}

// --- DATA FAKE ACTUALIZADA ---
final List<CampaignModel> fakeCampaigns = [
  CampaignModel(
    brandName: 'Interbank',
    title: 'Interbank Challenge',
    pricePerK: 'S/3.00 / 1k',
    paidAmount: 200.00,
    totalBudget: 5000.00,
    type: 'Recomendación',
    category: 'Entretenimiento',
    isPopular: true,
    colorCode: 0xFFD32F2F,
    description: 'Esta campaña tiene como fin dar a conocer la nueva colección navideña a los creadores emergentes. Monetiza tu creatividad con Topitop.',
    deadline: '27 Nov 2025',
    maxPay: 'S/300.00',
    reward: 'S/3.00',
    requirements: [
      'La duración del video debe ser mínimo 30 segundos',
      'Los videos deben ser originales y creativos',
      'Incentivar las descargas de la aplicación',
      'Usar el hashtag #NavidadTopitop'
    ],
    socialLinks: ['@topitop_pe', 'www.topitop.pe'],
    // FOTO: Puedes usar una URL de internet o 'assets/images/tu_imagen.png'
    photoUrl: 'https://res.cloudinary.com/dod56svuf/image/upload/v1770504195/unnamed_xi9zbd.webp',
  ),

  CampaignModel(
    brandName: 'Kick',
    title: 'Clippers Kick',
    pricePerK: 'S/4.00 / 1k',
    paidAmount: 1000.00,
    totalBudget: 1000.00,
    type: 'Clipping',
    category: 'Entretenimiento',
    isPopular: true,
    colorCode: 0xFF00E676,
    description: 'Buscamos los mejores clips de la plataforma Kick. Sube tus mejores momentos y gana dinero por visualizaciones.',
    deadline: '15 Dic 2025',
    maxPay: 'S/500.00',
    reward: 'S/4.00',
    requirements: [
      'Clips de alta calidad (1080p)',
      'Sin marcas de agua de otras apps',
      'Contenido divertido o "fails"',
    ],
    socialLinks: ['@kick_latam'],
    photoUrl: 'https://res.cloudinary.com/dod56svuf/image/upload/v1770474342/kick_laopvf.png',
  ),

  CampaignModel(
    brandName: 'Rokys',
    title: 'Promo Rokys',
    pricePerK: 'S/5.50 / 1k',
    paidAmount: 300.00,
    totalBudget: 700.00,
    type: 'Recomendación',
    category: 'Lifestyle',
    isPopular: true,
    colorCode: 0xFFFFC107,
    description: 'Promociona nuestro nuevo combo familiar de fin de semana. Muestra el producto y tu reacción al probarlo.',
    deadline: '30 Nov 2025',
    maxPay: 'S/400.00',
    reward: 'S/5.50',
    requirements: [
      'Enfoque en el producto (Pollo + Papas)',
      'Mencionar el precio de la oferta',
      'Video en formato vertical',
    ],
    socialLinks: ['@rokys_pe'],
    photoUrl: 'https://res.cloudinary.com/dod56svuf/image/upload/v1770474333/rocky_cypr6s.jpg',
  ),
];