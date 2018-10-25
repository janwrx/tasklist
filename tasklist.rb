class Task
  attr_accessor :title, :description, :status

  def initialize title, description
    @title = title
    @description = description
    @status = false
  end

  def print_done
    if @status
       "#{@title} task is done"
    else
       "#{@title} is currently underway"
    end
  end

  def toggle_status
    @status = !@status
  end
end


class Task_List
  attr_accessor :list, :time_sensitive, :all_tasks
  def initialize
    @list = []
    @time_sensitive = []
    @all_tasks = []
  end

  def add_task (task)
    if task.class == Due_Date_Task
      @time_sensitive << task
    else
      @list << task
    end
  end

  def get_completed
    completed_arr = []
    @list.each do |task|
      if task.status
        completed_arr << task
      end
    end
    return completed_arr.join(', ')
  end

  def get_incomplete
    incomplete_arr = []
    @list.each do|task|
      if !task.status
        incomplete_arr << task
      end
    end
    return incomplete_arr.join(', ')
  end

  def get_due_today
    due_today = []
    todays_date = "#{Time.new.month}/#{Time.new.day}"
    #loop through timesensitive tasks
    @time_sensitive.each do |task|
      # if due date is same as current date and incomplete
      if (task.due_date == todays_date) && !task.status
        # it's due today, so push into 'due today'
        due_today << task
      end
    end
    return due_today
  end

  def sortby_date
    @time_sensitive.sort_by! {|task| task.due_date}
  end

  def sort_all
    @all_tasks = sortby_date << @list
    @all_tasks.flatten!
  end

end

class Due_Date_Task < Task
  attr_accessor :due_date
  def initialize title, description, due_date
    super(title, description)
    @due_date = due_date
  end

  def print_tasks
       "#{@title} task (#{@description}) is due on #{@due_date}"
  end

end
