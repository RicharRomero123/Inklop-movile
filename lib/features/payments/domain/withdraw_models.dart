import 'package:flutter/material.dart';

class BankEntity {
  final String id;
  final String name;
  final Color color; // Simulamos el logo con color

  BankEntity({required this.id, required this.name, required this.color});
}

class BankAccountEntity {
  final String id;
  final String alias; // "Interbank Soles"
  final String number; // "1234...5678"
  final BankEntity bank;

  BankAccountEntity({required this.id, required this.alias, required this.number, required this.bank});
}

// --- DATA FAKE PARA SIMULACIÓN ---
final List<BankEntity> fakeBanks = [
  BankEntity(id: '1', name: 'Banco de Crédito del Perú (BCP)', color: const Color(0xFF0033A1)),
  BankEntity(id: '2', name: 'Interbank', color: const Color(0xFF009639)),
  BankEntity(id: '3', name: 'BBVA Continental', color: const Color(0xFF004481)),
  BankEntity(id: '4', name: 'Scotiabank', color: const Color(0xFFEC0000)),
];