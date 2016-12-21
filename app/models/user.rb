class User < ApplicationRecord
  validates :title, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      user_hash = row.to_hash
      user = User.where(id: user_hash["id"])

      if user.count == 1
        user.first.update_attributes(user_hash)
      else
        User.create!(user_hash)
      end # end if !user.nil?
    end # end CSV.foreach
  end # end self.import(file)
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv.add_row column_names
      all.each do |foo|
        values = foo.attributes.values
      csv.add_row values
    end
  end
end
end
