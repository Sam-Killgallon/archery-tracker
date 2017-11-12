Rake::Task['puma:start'].clear_actions
Rake::Task['puma:stop'].clear_actions
Rake::Task['puma:restart'].clear_actions
Rake::Task['puma:status'].clear_actions

namespace :puma do
  desc 'Start puma'
  task :start do
    on roles(:web) do
      execute "sudo systemctl start archery.service"
    end
  end

  desc 'Stop puma'
  task :stop do
    on roles(:web) do
      execute "sudo systemctl stop archery.service"
    end
  end

  desc 'Restart puma'
  task :restart do
    on roles(:web) do
      execute "sudo systemctl restart archery.service"
    end
  end

  desc 'Status puma'
  task :status do
    on roles(:web) do
      execute "sudo systemctl status archery.service"
    end
  end
end