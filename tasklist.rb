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
  attr_accessor :list
  def initialize
    @list = []
  end

  def add_task (task)
    @list << task
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

end
