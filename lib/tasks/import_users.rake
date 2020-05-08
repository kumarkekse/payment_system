require 'csv'

namespace :db do
  desc 'Import users'
  task import_users: :environment do
    begin
      file = File.open('users.csv')
      CSV.foreach(file, :headers => true) do |row|
        opts = row.to_hash
        role = opts.delete('role') || 'merchant'
        opts['status'] = 'inactive' unless %w(active inactive).include?(opts['status'])

        u = User.find_or_initialize_by(opts.except('password')) do |user|
          user.password = opts['password']
        end
        u.add_role(role)

        if u.save
          puts "\n#{role} user created with\nName: #{u.name}"
        else
          puts "\n#{role} user with Name: #{u.name} has errors:\n#{u.errors.full_messages.join(",\n")}"
        end
      end
    rescue StandardError => e
      puts "An error occurred while processing file: #{e.message}"
    end
  end
end
