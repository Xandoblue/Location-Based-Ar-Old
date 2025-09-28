require 'json'

class Task
  attr_accessor :id, :title, :done

  def initialize(id, title)
    @id = id
    @title = title
    @done = false
  end

  def complete!
    @done = true
  end
end

class TaskMasterToDo
  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def add_task(title)
    @tasks << Task.new(@tasks.size+1, title)
  end

  def complete_task(id)
    t = @tasks.find { |task| task.id == id }
    t.complete! if t
  end

  def remove_task(id)
    @tasks.reject! { |task| task.id == id }
  end

  def list_tasks
    @tasks.each do |task|
      puts "#{task.id}. #{task.title} [#{task.done ? 'Done' : 'Todo'}]"
    end
  end

  def export_json
    JSON.pretty_generate(@tasks.map { |t| { id: t.id, title: t.title, done: t.done } })
  end
end

todo = TaskMasterToDo.new
todo.add_task("Learn Ruby")
todo.add_task("Build ToDo App")
todo.complete_task(1)
todo.list_tasks
puts "Exported JSON:"
puts todo.export_json