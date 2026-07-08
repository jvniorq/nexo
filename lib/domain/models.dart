enum NexoSpace { personal, household }

enum TaskPriority { low, medium, high }

class SubtaskItem {
  SubtaskItem(this.title, {this.completed = false});

  final String title;
  bool completed;
}

class TaskItem {
  TaskItem(
    this.title,
    this.space, {
    this.priority = TaskPriority.medium,
    this.dueDate,
    this.subtasks = const [],
    this.completed = false,
  });

  final String title;
  final NexoSpace space;
  final TaskPriority priority;
  final DateTime? dueDate;
  final List<SubtaskItem> subtasks;
  bool completed;

  int get completedSubtasks =>
      subtasks.where((subtask) => subtask.completed).length;

  double get progress {
    if (subtasks.isEmpty) return completed ? 1 : 0;
    return completedSubtasks / subtasks.length;
  }

  bool isOverdueAt(DateTime now) =>
      !completed && dueDate != null && dueDate!.isBefore(now);
}

class ShoppingEntry {
  ShoppingEntry(this.name, this.quantity, {this.completed = false});

  final String name;
  final String quantity;
  bool completed;
}

class NoteEntry {
  NoteEntry(this.title, this.content, this.space);

  final String title;
  final String content;
  final NexoSpace space;
}
