import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';

class HeroBalanceCard extends StatefulWidget {
  const HeroBalanceCard({
    super.key,
    required this.data,
  });

  final DashboardSummaryData data;

  @override
  State<HeroBalanceCard> createState() => _HeroBalanceCardState();
}

class _HeroBalanceCardState extends State<HeroBalanceCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _countController;
  late Animation<double> _amountAnimation;

  @override
  void initState() {
    super.initState();
    _countController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _amountAnimation = Tween<double>(
      begin: 0,
      end: widget.data.totalLent,
    ).animate(
      CurvedAnimation(
        parent: _countController,
        curve: Curves.easeOutCubic,
      ),
    );
    _countController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _countController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant HeroBalanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.totalLent != widget.data.totalLent) {
      _amountAnimation = Tween<double>(
        begin: oldWidget.data.totalLent,
        end: widget.data.totalLent,
      ).animate(
        CurvedAnimation(
          parent: _countController,
          curve: Curves.easeOutCubic,
        ),
      );
      if (MediaQuery.disableAnimationsOf(context)) {
        _countController.value = 1.0;
      } else {
        _countController
          ..reset()
          ..forward();
      }
    }
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 180),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.heroGradientStart,
              colors.heroGradientEnd,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: colors.heroGradientStart.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -42,
              right: -32,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.10),
                ),
              ),
            ),
            Positioned(
              bottom: -54,
              left: -28,
              child: Container(
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          l10n.totalLentLabel,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (widget.data.monthlyGrowthPercent != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          key: const ValueKey('hero_trend_chip'),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.data.monthlyGrowthPercent! >= 0
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.data.monthlyGrowthPercent! > 0 ? '+' : ''}${widget.data.monthlyGrowthPercent!}%',
                                style: textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                  AnimatedBuilder(
                    animation: _countController,
                    builder: (context, _) {
                      final value = reduceMotion
                          ? widget.data.totalLent
                          : _amountAnimation.value;
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          IndianCurrencyFormatter.format(value),
                          maxLines: 1,
                          style: textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.availableToCollect,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.80),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                      ),
                    ),
                    child: Wrap(
                      spacing: 14,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _MiniStatItem(
                          label: l10n.activeLoansLabel,
                          value: '${widget.data.activeLoansCount}',
                        ),
                        _MiniStatDivider(),
                        _MiniStatItem(
                          label: l10n.customersLabel,
                          value: '${widget.data.customersCount}',
                        ),
                        _MiniStatDivider(),
                        _MiniStatItem(
                          label: l10n.emisDueThisMonthLabel,
                          value: '${widget.data.emisDueThisMonth}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStatItem extends StatelessWidget {
  const _MiniStatItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.80),
          ),
        ),
      ],
    );
  }
}

class _MiniStatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 26,
      color: Colors.white.withValues(alpha: 0.25),
    );
  }
}
