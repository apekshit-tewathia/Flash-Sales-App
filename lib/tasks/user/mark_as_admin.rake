namespace :user do
  desc "Marking a user as admin"
  task :mark_as_admin => [:environment] do
    puts 'Enter email id'
    user = User.find_by(email: gets.chomp)
    user.update!(role: 'admin')
    puts 'Successfully marked user as admin'
  end
end
