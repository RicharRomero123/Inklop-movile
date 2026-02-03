import 'package:flutter/material.dart';

// 1. WIDGET DE ESTADÍSTICA (Arriba: 12 Campañas)
class ProfileStatItem extends StatelessWidget {
  final String value;
  final String label;

  const ProfileStatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

// 2. BOTÓN DE CUENTA SOCIAL (TikTok, Instagram, +)
class SocialAccountButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isAdd;
  final VoidCallback onTap;

  const SocialAccountButton({
    super.key,
    this.icon,
    required this.label,
    this.isAdd = false,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: isAdd ? Colors.grey.shade300 : Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
                isAdd ? Icons.add : icon,
                color: isAdd ? Colors.white : Colors.white,
                size: 30
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// 3. ITEM DE CONFIGURACIÓN (Fila con flecha)
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing; // Para Switch o Flecha

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle!, style: const TextStyle(fontSize: 12, color: Colors.grey)) : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}

// 4. TARJETA DE SOPORTE
class SupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String detail;

  const SupportCard({super.key, required this.icon, required this.title, required this.subtitle, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              Text(detail, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}