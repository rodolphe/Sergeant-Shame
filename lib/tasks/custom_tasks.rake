task :check_if_we_good => :environment do
  users = User.all
  users.each do |user|
    puts "##### #{user.id} #####"
    user.tasks.each do |task|
      puts "\t(#{task.id})#{task.name}\t---\t(#{task.count_checkins})#{task.we_good?}"
      # Here if a task wasn't good we would post statuses to them
      task.shame unless task.we_good?
    end
  end
end
