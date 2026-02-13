import 'package:flutter/material.dart';
import '../models/guidance_models.dart';

/// Collapsible widget that displays priority guidance without numeric scores
class PriorityGuidancePanel extends StatefulWidget {
  final PriorityGuidance guidance;

  const PriorityGuidancePanel({
    super.key,
    required this.guidance,
  });

  @override
  State<PriorityGuidancePanel> createState() => _PriorityGuidancePanelState();
}

class _PriorityGuidancePanelState extends State<PriorityGuidancePanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.priority_high,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Priority Guidance',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 12),
                  // Higher Risk Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.orange.shade200,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.orange.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Higher risk when:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade900,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.guidance.higherRiskWhen,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                    color: Colors.orange.shade900,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Lower Risk Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.green.shade200,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_down,
                              color: Colors.green.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Lower risk when:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade900,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.guidance.lowerRiskWhen,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                    color: Colors.green.shade900,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
