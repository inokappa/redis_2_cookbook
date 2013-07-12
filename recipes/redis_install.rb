# Debian 系と redhat 系の分岐が必要だけど...
#package "tcl8.5" do
#  action :install
#end

# 作業用ディレクトリの作成
directory node['redis']['work_dir'] do
  action :create
  not_if "ls -d #{node['redis']['work_dir']}"
end

# 最新のソースコードを取得
remote_file node['redis']['work_dir'] + node['redis']['source_file_name'] do
  source node['redis']['source_url_path'] + node['redis']['source_file_name']
  not_if "ls #{node['redis']['server_install_path']}"
end

# ソースコードのアーカイブを展開して make && make test && make install
bash "install_redis_program" do
  user "root"
  cwd node['redis']['work_dir']
  code <<-EOH
    tar -zxf #{node['redis']['source_file_name']}
    cd #{::File.basename(node['redis']['source_file_name'], '.tar.gz')}
    make
    make install
  EOH
  not_if {File.exists?(#{node['redis']['server_install_path']})}
end

# サービスを起動する
#bash "start_redis_server" do
#  user "root"
#  cwd "/usr/local/bin"
#  code <<-EOH
#    #{node['redis']['server_install_path']} &
#  EOH
#  not_if "ps aux | grep \[r\]edis-server"
#end

# redis 用ユーザーを作成する
user node['redis']['user'] do
  comment "redis system"
  system true
  shell "/bin/false"
  not_if "id #{node['redis']['user']}"
end

# update-rc.d を実行する
execute "update_rc_d" do
  command "update-rc.d redis-server defaults"
  action :nothing
end

# 起動スクリプトを設置する
template "/etc/init.d/redis-server" do
  source "redis-server.erb"
  owner "root"
  group "root"
  mode 00755
  valiables(
    :redis_server_path => node['redis']['server_install_path']
    :redis_conf_path => node['redis']['server_conf_path']
    :redis_user => node['redis']['user']  
  )
  notifies :run, 'execute[update_rc_d]', :immediately
  not_if {File.exists?("/etc/init.d/redis-server")}
end

# redis-server の起動
service "redis-server" do
  supports :start => true, :restart => true, :stop => true
  subscribes :restart, "template[/etc/init.d/redis-server]", :immediately
  only_if "id #{node['redis']['user']}"
end
