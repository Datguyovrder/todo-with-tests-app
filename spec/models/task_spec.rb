require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it 'should switch complete to false if it began as true' do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should switch complete to true if it began as false' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'should switch favorite to false if it began as true' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should switch favorite to true if it began as false' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue' do
    it 'should return false if task has not passed its deadline' do
      task = Task.create(deadline: Time.now + 10.minutes)
      task.overdue?
      expect(task.overdue?).to eq(false)
    end

    it 'should return true if task has passed its deadline' do
      task = Task.create(deadline: 30.minutes.ago)
      task.overdue?
      expect(task.overdue?).to eq(true)
    end
  end

  describe '#increment_priority' do
    it 'should increase priority by 1' do
      task = Task.create(priority: 6)
      task.increment_priority!
      expect(task.priority).to eq(7)
    end
  end
  

  describe '#decrement_priority' do
    it 'should decrease priority by 1' do
      task = Task.create(priority: 4)
      task.decrement_priority!
      expect(task.priority).to eq(3)
    end
  end

  describe '#snooze_hour!' do
    it 'should increase deadline by 1 hour' do
      task = Task.create(deadline: Time.now + 1.hours)
      task.snooze_hour!
      expect(task.deadline).to eq(Time.now + 2.hours)
    end
  end
end
