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
  not_if "ls #{node['redis']['server_install_path']}"
end

# サービスを起動する
bash "start_redis_server" do
  user "root"
  cwd "/usr/local/bin"
  code <<-EOH
    #{node['redis']['server_install_path']} &
  EOH
  not_if "ps aux | grep \[r\]edis-server"
end
