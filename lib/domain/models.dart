enum NexoSpace { personal, household }

class TaskItem {
  TaskItem(this.title, this.space, {this.completed = false});

  final String title;
  final NexoSpace space;
  bool completed;
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
