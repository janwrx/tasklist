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

    @task3 = Due_Date_Task.new("pay bills", "give money to Verizon", "10/25")
    @task4 = Due_Date_Task.new("pay bills", "give money to Janice", "07/28")
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

  it "can add items with due dates to my task_list" do
    expect(@task_list.time_sensitive).to be_a Array
  end

  # Story: As a developer with a TaskList, I can list all the not completed items that are due today.

  it "can list all the incomplete tasks that are due today" do
    expect(@task_list.get_due_today). to be_an Array
  end

  it "successfully pushes incomplete task due today into due_today array" do
    @task_list.add_task(@task3)
    expect(@task_list.time_sensitive.length).to be 1
    expect(@task_list.get_due_today.length).to be 1
  end

  # Story: As a developer with a TaskList, I can list all the incomplete items in order of due date.

  # be >= 10 # also applicable for >, <=, < be_within(0.01).of(28.35) # floating point

  it "can list all incomplete items in order of due date" do
    @task_list.add_task(@task3)
    @task_list.add_task(@task4)
    @task_list.sortby_date
    expect(@task_list.time_sensitive[0].due_date).to be < (@task_list.time_sensitive[1].due_date)
  end
  # Story: As a developer with a TaskList with and without due dates, I can list all the not completed items in order of due date, and then the items without due dates.

  it "can list incomplete items with dates by date and then dateless tasks" do
    @task_list.add_task(@task3)
    @task_list.add_task(@task4)
    @task_list.add_task(@task1)
    @task_list.add_task(@task2)
    @task_list.sort_all
    expect(@task_list.all_tasks.last). to be_an_instance_of Task
    expect(@task_list.all_tasks.first). to be_an_instance_of Due_Date_Task
  end 

end


describe Due_Date_Task do
  before do
    @duedatetask = Due_Date_Task.new("go to bank", "go to bank", "November 2nd, 2018")
  end
# Story: As a developer, I can create a DueDateTask, which is-a Task that has-a due date.
# Hint: Use the built-in Ruby Date class
it "can create a new due date task" do
  expect{Due_Date_Task.new("shit", "fuck", "date")}.to_not raise_error

end
# Story: As a developer, I can print an item with a due date with labels and values.
# Hint: When implementing to_s, use super to call to_s on the super class.
it "can print tasks with due dates, labels, and values" do
  expect(@duedatetask.print_tasks).to be_a String
end

end
