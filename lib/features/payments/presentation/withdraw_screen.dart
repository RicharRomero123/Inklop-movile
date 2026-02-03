import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../payments/domain/withdraw_models.dart';
import 'withdraw_success_screen.dart'; // Importaremos la siguiente pantalla

class WithdrawScreen extends StatefulWidget {
  final double currentBalance;
  const WithdrawScreen({super.key, required this.currentBalance});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();

  // Estado del Formulario
  BankEntity? _selectedBank;
  BankAccountEntity? _selectedAccount;
  List<BankAccountEntity> _myAccounts = []; // Lista local (simula API)

  double _amount = 0.0;
  final double _commission = 4.25; // Comisión fija Stripe según diseño

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      setState(() {
        _amount = double.tryParse(_amountController.text) ?? 0.0;
      });
    });
  }

  // Calcular Total a Recibir
  double get _totalToReceive => (_amount - _commission) > 0 ? (_amount - _commission) : 0.0;
  bool get _isFormValid => _amount >= 50 && _amount <= widget.currentBalance && _selectedAccount != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        leading: IconButton(
          icon: const CircleAvatar(backgroundColor: Colors.white10, child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Retirar Fondos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. INPUT MONTO
            const Text('Monto a Retirar', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: const Color(0xFF2C2C2C), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: '0.00',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        border: InputBorder.none,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    ),
                  ),
                  const Text('PEN', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Monto mínimo: s/50.00', style: TextStyle(color: Colors.grey, fontSize: 10)),

            const SizedBox(height: 24),

            // 2. SELECTOR BANCO
            const Text('Entidad Financiera', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            _buildSelector(
              text: _selectedBank?.name ?? 'Selecciona un Banco',
              isSelected: _selectedBank != null,
              onTap: _showBankSelector,
            ),

            const SizedBox(height: 24),

            // 3. SELECTOR CUENTA
            const Text('Cuenta Bancaria', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            _buildSelector(
              text: _selectedAccount?.alias ?? 'Selecciona una cuenta',
              isSelected: _selectedAccount != null,
              // Solo permite seleccionar cuenta si ya hay banco seleccionado (Lógica opcional)
              isDisabled: _selectedBank == null,
              onTap: _showAccountSelector,
            ),

            const SizedBox(height: 40),

            // 4. RESUMEN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Comisión de Stripe', style: TextStyle(color: Colors.grey)),
                Text('- S/$_commission', style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total a Recibir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text('S/${_totalToReceive.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),

            const SizedBox(height: 40),

            // 5. BOTÓN RETIRAR
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _isFormValid ? _processWithdraw : null,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: _isFormValid
                    ? Text('Retirar S/${_totalToReceive.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                    : const Text('Retirar S/0.00', style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---
  Widget _buildSelector({required String text, required bool isSelected, required VoidCallback onTap, bool isDisabled = false}) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.white.withOpacity(0.05) : const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.grey.shade400)),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  // --- LOGICA DE MODALES ---

  void _showBankSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 500,
          child: Column(
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              const Text('¿En que banco deseas recibir tu dinero?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: fakeBanks.length,
                  itemBuilder: (context, index) {
                    final bank = fakeBanks[index];
                    return ListTile(
                      leading: Container(width: 30, height: 30, decoration: BoxDecoration(color: bank.color, borderRadius: BorderRadius.circular(6))),
                      title: Text(bank.name, style: const TextStyle(color: Colors.white)),
                      trailing: const Text('PEN', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      onTap: () {
                        setState(() {
                          _selectedBank = bank;
                          _selectedAccount = null; // Reset cuenta al cambiar banco
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAccountSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        // Filtramos cuentas que sean del banco seleccionado (para esta demo)
        final accounts = _myAccounts.where((acc) => acc.bank.id == _selectedBank!.id).toList();

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              const Text('Selecciona tu cuenta bancaria', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              if (accounts.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('No hay cuentas bancarias\nAgrega al menos una para continuar', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                )
              else
                ...accounts.map((acc) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: acc.bank.color, borderRadius: BorderRadius.circular(8))),
                  title: Text(acc.alias, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(acc.bank.name, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: (){}), // TODO: Eliminar lógica
                  onTap: () {
                    setState(() => _selectedAccount = acc);
                    Navigator.pop(context);
                  },
                )),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // Cerrar selector
                    _showAddAccountForm(); // Abrir formulario
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('+ Agregar una cuenta', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showAddAccountForm() {
    // Controladores locales del modal
    final aliasCtrl = TextEditingController();
    final numberCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Para que suba con el teclado
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 24, right: 24, top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24 // Padding teclado
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              const Center(child: Text('Nueva cuenta bancaria', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
              const SizedBox(height: 24),

              _buildInputLabel('Apodo'),
              _buildDarkInput(aliasCtrl, 'Ej: Interbank Soles'),
              const SizedBox(height: 16),

              _buildInputLabel('Número de cuenta Bancaria'),
              _buildDarkInput(numberCtrl, 'CCI o Número de cuenta'),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    // 1. Simular creación de cuenta
                    if (aliasCtrl.text.isNotEmpty && _selectedBank != null) {
                      final newAccount = BankAccountEntity(
                        id: DateTime.now().toString(),
                        alias: aliasCtrl.text,
                        number: numberCtrl.text,
                        bank: _selectedBank!,
                      );
                      setState(() {
                        _myAccounts.add(newAccount);
                        _selectedAccount = newAccount; // Auto seleccionar
                      });
                      Navigator.pop(context); // Cerrar modal
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Añadir cuenta', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)));

  Widget _buildDarkInput(TextEditingController ctrl, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: const Color(0xFF2C2C2C), borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade600), border: InputBorder.none),
      ),
    );
  }

  void _processWithdraw() {
    // Simular carga y navegación a éxito
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => WithdrawSuccessScreen(amount: _totalToReceive))
    );
  }
}