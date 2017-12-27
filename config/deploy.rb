# config valid only for current version of Capistrano
lock '3.10.1'

set :application, 'archery'
set :repo_url, 'git@github.com:Sam-Killgallon/archery_tracker.git'
set :user, 'deploy'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :puma_init_active_record, true
