class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    Comment.where(asahi: "現地調査中", updated_at: ..14.days.ago)
           .or(Comment.where(cocacola: "現地調査中", updated_at: ..14.days.ago))
           .or(Comment.where(itoen: "現地調査中", updated_at: ..14.days.ago))
           .or(Comment.where(dydo: "現地調査中", updated_at: ..14.days.ago))
           .or(Comment.where(yamakyu: "現地調査中", updated_at: ..14.days.ago))
           .or(Comment.where(neos: "現地調査中", updated_at: ..14.days.ago))
           .each do |comment|
      ReminderMailer.send_reminder(comment.estimate.client).deliver_later
    end
  end
end
  