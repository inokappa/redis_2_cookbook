# 作業用ディレクトリ
default['redis']['work_dir'] = '/usr/local/src/redis/'

# ソースコードの URL
default['redis']['source_ver_num'] = '2.6.13'
default['redis']['source_url_path'] = 'http://redis.googlecode.com/files/'
default['redis']['source_file_name'] = "redis-#{default['redis']['source_ver_num']}.tar.gz"

# redis-server のインストールパス
default['redis']['server_install_path'] = '/usr/local/bin/redis-server'
