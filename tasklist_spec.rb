require 'rspec'
require_relative 'tasklist'

describe Task do
  before do
    @task = Task.new("get money", "make economical success")
  end

  # Story: As a developer, I can create a Task.
  it "can create a task" do
    expect{Task.new("task", "task")}.to_not raise_error
  end
  # Story: As a developer, I can give a Task a title and retrieve it.
  it "can give a task a title and retrieve it" do
    expect(@task.title).to be_a String
  end
  # Story: As a developer, I can give a Task a description and retrieve it.
  it "can give a task a description and retrieve it" do
    expect(@task.description).to be_a String
  end
  # Story: As a developer, I can mark a Task done.
  it "can mark a task done" do
    expect(@task.status).to be_a FalseClass
  end
  # Story: As a developer, when I print a Task that is done, its status is shown.
  it "can print a task and see the current status" do
    expect(@task.print_done). to be_a String
  end

end

describe Task_List do
  before do
    @task_list = Task_List.new
    @task1 = Task.new("get money", "get money")
    @task2 = Task.new("study", "read books")
  end

  it "can create a task_list" do
    expect{Task_List}.to_not raise_error
  end
  # Story: As a developer, I can add all of my Tasks to a TaskList.
  # Hint: A TaskList has-many Tasks
  #
  it "can add all tasks to task_list" do
    expect(@task_list.list). to be_an Array
    expect(@task_list.list.length). to be 0
  end
  # Story: As a developer with a TaskList, I can get the completed items.
  #

  it "can retrieve completed tasks" do
    @task1.toggle_status
    @task_list.add_task(@task1)
    @task_list.add_task(@task2)
    expect(@task_list.get_completed). to be_a String
  end
  # Story: As a developer with a TaskList, I can get the incomplete items.
  it "can retrieve incomplete tasks" do
    @task1.toggle_status
    @task_list.add_task(@task1)
    @task_list.add_task(@task2)
    expect(@task_list.get_incomplete). to be_a String
  end

end
