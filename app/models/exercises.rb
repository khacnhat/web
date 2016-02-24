
class Exercises
  include Enumerable

  def initialize(dojo)
    @parent = dojo
    @path = unslashed(dojo.env('exercises', 'root'))
  end

  # queries

  attr_reader :path, :parent

  def each(&block)
    exercises.values.each(&block)
  end

  def [](name)
    exercises[name]
  end

  def write_cache
    cache = {}
    disk[path].each_dir do |sub_dir|
      exercise = make_exercise(sub_dir)
      cache[exercise.name] = { instructions: exercise.instructions }
    end
    disk[path].write_json(cache_filename, cache)
  end

  def cache_filename
    'cache.json'
  end

  private

  include ExternalParentChainer
  include Unslashed

  def exercises
    @exercises ||= read_cache
  end

  def read_cache
    cache = {}
    disk[path].read_json(cache_filename).each do |name, exercise|
      cache[name] = make_exercise(name, exercise['instructions'])
    end
    cache
  end

  def make_exercise(name, instructions = nil)
    Exercise.new(self, name, instructions)
  end

end
