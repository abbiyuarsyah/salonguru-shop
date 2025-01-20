abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T> getEntity(T entity);
  Future<T> add(T entity);
  Future<void> deleteAll();
  Future<void> deleteEntity(T entity);
}
