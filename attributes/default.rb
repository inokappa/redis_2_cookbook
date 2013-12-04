# working directory
default['redis']['work_dir'] = '/usr/local/src/redis/'

# current redis version
default['redis']['current_redis_version'] = '2.6.13'

# Source code URL
default['redis']['source_ver_num'] = '2.8.2'
default['redis']['source_url_path'] = 'http://download.redis.io/releases/'
default['redis']['source_file_name'] = "redis-#{default['redis']['source_ver_num']}.tar.gz"

# redis-server install path
default['redis']['server_install_path'] = '/usr/local/bin/redis-server'

# redis.conf path
default['redis']['server_conf_path'] = '/usr/local/etc/redis.conf'

# redis.conf setting
default['redis']['server_daemonize'] = 'yes'

# redis-server data directory 
default['redis']['server_data_path'] = '/usr/local/redis'

# redis user
default['redis']['user'] = 'redis-user'

# redis server log dir
default['redis']['server_log_path'] = '/var/log/redis'
