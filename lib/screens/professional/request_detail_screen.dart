import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/firestore_provider.dart';
import '../../theme/app_theme.dart';

class RequestDetailScreen extends ConsumerStatefulWidget {
  final String requestId;

  const RequestDetailScreen({super.key, required this.requestId});

  @override
  ConsumerState<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends ConsumerState<RequestDetailScreen> {
  bool _isLoading = false;

  Future<void> _updateStatus(Map<String, dynamic> req, String newStatus, String successMessage) async {
    setState(() => _isLoading = true);
    try {
      final firestore = ref.read(firestoreProvider);
      
      // Update status
      await firestore.collection('requests').doc(widget.requestId).update({
        'status': newStatus,
      });

      // Send notification
      String title = '';
      String body = '';
      String type = 'info';

      final proName = req['professionalName'] ?? 'O profissional';
      
      if (newStatus == 'Aceita') {
        title = 'Solicitação Aceita!';
        body = '$proName aceitou seu serviço.';
        type = 'success';
      } else if (newStatus == 'Recusada') {
        title = 'Solicitação Recusada';
        body = '$proName não pôde aceitar seu serviço no momento.';
        type = 'info';
      } else if (newStatus == 'Concluída') {
        title = 'Serviço Concluído!';
        body = '$proName marcou o serviço como concluído.';
        type = 'success';
      }

      await firestore.collection('notifications').add({
        'userId': req['clientId'],
        'title': title,
        'body': body,
        'type': type,
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMessage), backgroundColor: AppTheme.successColor));
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e'), backgroundColor: AppTheme.errorColor));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.requestId.isEmpty) {
      return const Scaffold(body: Center(child: Text('Pedido inválido')));
    }

    final reqAsync = ref.watch(requestDetailProvider(widget.requestId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Detalhes do Serviço', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: reqAsync.when(
        data: (req) {
          if (req == null) return const Center(child: Text('Pedido não encontrado'));

          DateTime? dt;
          if (req['createdAt'] != null) {
            dt = req['createdAt'].toDate();
          }
          String dateStr = dt != null ? DateFormat('dd MMM, yyyy HH:mm').format(dt) : 'Sem data';

          bool isPending = req['status'] == 'Pendente';
          bool isAccepted = req['status'] == 'Aceita';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informações do Cliente
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: AppTheme.surfaceColor,
                      child: Icon(Icons.person, size: 32, color: AppTheme.iconGrey),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(req['clientName'] ?? 'Cliente', style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                    ),
                    if (isAccepted)
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.primaryColor),
                        onPressed: () {},
                      )
                  ],
                ),
                const SizedBox(height: 32),

                // Informações do Serviço
                Text('O que precisa ser feito?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Text(
                    req['description'] ?? 'Sem descrição',
                    style: const TextStyle(fontSize: 15, color: AppTheme.textSecondary, height: 1.6),
                  ),
                ),
                const SizedBox(height: 32),

                // Detalhes Adicionais
                _buildDetailRow(Icons.calendar_today_rounded, 'Período', req['period'] ?? 'Indefinido'),
                const SizedBox(height: 24),
                _buildDetailRow(Icons.access_time_rounded, 'Solicitado em', dateStr),
                const SizedBox(height: 24),
                _buildDetailRow(Icons.info_outline_rounded, 'Status', req['status'] ?? 'Pendente'),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
      bottomNavigationBar: reqAsync.maybeWhen(
        data: (req) {
          if (req != null && req['status'] == 'Pendente') {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
                    : Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _updateStatus(req, 'Recusada', 'Serviço recusado.'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.errorColor,
                                side: const BorderSide(color: AppTheme.errorColor),
                              ),
                              child: const Text('Recusar'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _updateStatus(req, 'Aceita', 'Serviço aceito!'),
                              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successColor),
                              child: const Text('Aceitar'),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          }
          if (req != null && req['status'] == 'Aceita') {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
                    : ElevatedButton(
                        onPressed: () => _updateStatus(req, 'Concluída', 'Serviço marcado como concluído!'),
                        child: const Text('Marcar como Concluído'),
                      ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}
