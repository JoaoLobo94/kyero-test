
class ReportsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @logs = "Nightly routine for reporting to the line manager...\n"
    Report.new.send_to_line_manager unless simulate?
    puts @logs
  end

  private

  def simulate?
    Rails.env.development?
  end
end
