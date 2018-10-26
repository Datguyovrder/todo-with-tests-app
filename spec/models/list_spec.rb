require 'rails_helper'

RSpec.describe List, type: :model do
  describe "#complete_all_tasks" do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "Shopping")
      Task.create(complete: false, list_id: list.id, name: "Milk")
      Task.create(complete: false, list_id: list.id, name: "Eggs")
      
      list.complete_all_tasks!
      
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe "#snooze_all_tasks" do
    it "should increase the deadline of all task by 1 hour" do
      list = List.create(name: "Shopping")
      times = [5.hours.ago, Time.now, 37.minutes.from_now]
      
      times.each do |time|
        Task.create(list_id: list.id, deadline: time)
      end

      list.snooze_all_tasks!

      list.tasks.order(:id).each_with_index do |task, index|
        expect(task.deadline).to eq(times[index] + 1.hour)
      end
    end
  end

  describe "#total_duration" do
    it 'should sum up all the durations of each task' do
      list = List.create(name: "Shopping")
      
      Task.create(list_id: list.id, duration: 12)
      Task.create(list_id: list.id, duration: 21)

      sum = list.total_duration

      expect(sum).to eq(33)
    end
  end

  describe "#incomplete_tasks" do
    it 'should return an array of all incomplete tasks' do
      list = List.create(name: "Shopping")

      task_1 = Task.create(list_id: list.id, complete: false)
      task_2 = Task.create(list_id: list.id, complete: false)
      task_3 = Task.create(list_id: list.id, complete: true)
      task_4 = Task.create(list_id: list.id, complete: true)

      result = list.incomplete_tasks

      expect(result).to match_array([task_1, task_2])
    end
  end

  describe "#favorite_tasks" do
    it 'should return an array of all favorite tasks' do
      list = List.create(name: "Shopping")

      task_1 = Task.create(list_id: list.id, favorite: false)
      task_2 = Task.create(list_id: list.id, favorite: true)

      result = list.favorite_tasks

      expect(result).to match_array([task_2])
    end
  end

end
