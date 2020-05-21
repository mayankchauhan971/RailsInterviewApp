class AddResumeToMeeting < ActiveRecord::Migration[6.0]
  def self.up
    add_column :meetings, :resume, :binary, :limit => 10.megabyte
  end
  def self.down
    remove_column :meetings, :resume
  end
end
