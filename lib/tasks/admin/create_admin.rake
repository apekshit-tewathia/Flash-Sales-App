namespace :admin do
  desc "Creating an admin"
  task :create => [:environment] do
    admin = {}
    puts "Enter email"
    admin[:email] = gets.chomp
    puts "Enter name"
    admin[:name] = gets.chomp
    puts "Enter password"
    admin[:password] = gets.chomp
    puts "Confirm password"
    admin[:password_confirmation] = gets.chomp
    admin[:role] = 'admin'
    admin[:verified_at] = Time.current

    admin_user = User.new(admin)      
    puts "Something went wrong could not create admin" unless admin_user.save
  end
end
