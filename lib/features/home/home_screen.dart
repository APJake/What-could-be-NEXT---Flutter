import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:what_could_be_next/controller/animal_controller.dart';
import 'package:what_could_be_next/model/animal_guess.dart';
import 'package:what_could_be_next/model/animal_item.dart';
import 'package:what_could_be_next/ui/components.dart';
import 'package:what_could_be_next/ui/route/app_routes.dart';
import 'package:what_could_be_next/utils/nav_extensions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalState = ref.watch(animalControllerProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade900,
              Colors.blue.shade900,
              Colors.pink.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 16),
                      _buildGuessesSection(context, animalState),
                      const SizedBox(height: 24),
                      _buildItemsListHeader(context, ref, animalState),
                      const SizedBox(height: 12),
                      _buildItemsList(context, animalState, (int index) {
                        ref
                            .read(animalControllerProvider.notifier)
                            .deleteAt(index);
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: _buildAddButton(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: const [
              Icon(Icons.pets, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'Animal Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuessesSection(
    BuildContext context,
    AnimalControllerState animalState,
  ) {
    final guessResult = animalState.guessResult;

    if (guessResult == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GlassContainer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Add items to see predictions',
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.show_chart, color: Colors.white70, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Next Predictions',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (guessResult.guesses.isEmpty)
                Center(
                  child: Text(
                    'No predictions available',
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                )
              else
                ...guessResult.guesses.map((guess) => _buildGuessItem(guess)),
              if (guessResult.optionalGuesses.isNotEmpty) ...[
                const SizedBox(height: 12),
                Divider(color: Colors.white.withOpacity(0.2)),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Icon(Icons.more_horiz, color: Colors.white70, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Optional',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...guessResult.optionalGuesses.map(
                  (guess) => _buildGuessItem(guess, isOptional: true),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuessItem(AnimalGuess guess, {bool isOptional = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withOpacity(isOptional ? 0.2 : 0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                guess.animalType.asLetter(),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guess.animalType.asFullName(),
                  style: TextStyle(
                    color: isOptional ? Colors.white60 : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: guess.percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:
                              isOptional
                                  ? [
                                    Colors.white.withOpacity(0.3),
                                    Colors.white.withOpacity(0.2),
                                  ]
                                  : [
                                    Colors.blue.shade400,
                                    Colors.purple.shade400,
                                  ],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${guess.percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              color: isOptional ? Colors.white60 : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsListHeader(
    BuildContext context,
    WidgetRef ref,
    AnimalControllerState animalState,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.list, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                'Recent Items (${animalState.items.length})',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          if (animalState.items.isNotEmpty)
            GestureDetector(
              onTap: () => _showClearDialog(context, ref),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    color: Colors.red.shade200,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemsList(
    BuildContext context,
    AnimalControllerState animalState,
    Function(int index) onDelete,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:
          animalState.items.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: animalState.items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = animalState.items[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          //key: ValueKey(index),
                          onPressed: (context) {
                            onDelete(index);
                          },
                          borderRadius: BorderRadius.circular(12),
                          backgroundColor: Colors.red.withAlpha(60),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: _buildItemCard(context, item),
                  );
                },
              ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.inbox_outlined, color: Colors.white30, size: 64),
          SizedBox(height: 16),
          Text(
            'No items yet',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap + to add your first item',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, AnimalItem item) {
    final colorWidget =
        item.color != null
            ? Container(
              width: 8,
              decoration: BoxDecoration(
                color: item.color!.asColor(),
                borderRadius: BorderRadius.circular(4),
              ),
            )
            : const SizedBox.shrink();

    return GlassContainer(
      borderRadius: 12,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            colorWidget,
            if (item.color != null) const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  if (item.animal != null)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            item.color != null
                                ? item.color!.asColor().withOpacity(0.2)
                                : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          item.animal!.type.asLetter(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.animal?.type.asFullName() ?? "Unknown"} ${item.animal!.variant}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (item.animal?.variant != null)
                          Text(
                            item.animal!.description ?? "",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
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

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigate(AppRoute.create);
      },
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.purple.shade400],
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  void _showClearDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Clear All Items?',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'This will remove all items from your list.',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(animalControllerProvider.notifier).clear();
                  Navigator.pop(context);
                },
                child: Text(
                  'Clear',
                  style: TextStyle(color: Colors.red.shade300),
                ),
              ),
            ],
          ),
    );
  }
}
