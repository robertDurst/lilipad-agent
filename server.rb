# frozen_string_literal: true

require 'sinatra'

configure { set :server, :puma }

if File.exist?('./lilipad_config.json')
  puts 'Config file found'
else
  puts 'Config file not found. Creating one...'
  File.open('./lilipad_config.json', 'w') { |file| file.write('{"enable": false, "log": []}') }
end

get '/' do
  File.read('./lilipad_config.json')
end

get '/enable' do
  config = JSON.parse(File.read('./lilipad_config.json'))
  config['enable'] = true
  File.open('./lilipad_config.json', 'w') { |file| file.write(config.to_json) }
  'Enabled'
end

get '/disable' do
  config = JSON.parse(File.read('./lilipad_config.json'))
  config['enable'] = false
  File.open('./lilipad_config.json', 'w') { |file| file.write(config.to_json) }
  'Disabled'
end

get '/reset_log' do
  config = JSON.parse(File.read('./lilipad_config.json'))
  config['log'] = []
  File.open('./lilipad_config.json', 'w') { |file| file.write(config.to_json) }
  'Log reset'
end

get '/log' do
  filename = params['file']
  lineno = params['lineno']
  msg = params['msg']

  config = JSON.parse(File.read('./lilipad_config.json'))
  config['log'] << { 'file' => filename, 'lineno' => lineno, 'msg' => msg }

  File.open('./lilipad_config.json', 'w') { |file| file.write(config.to_json) }

  "Log added: #{filename}:#{lineno} - #{msg}"
end

# TODO
# * [ ] add a safer read mode in case the config isn't proper json
