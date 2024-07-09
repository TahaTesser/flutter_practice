/// Dog object.
class Dog {
  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  /// Dog id.
  final int id;

  /// Dog name.
  final String name;

  /// Dog age.
  final int age;

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
