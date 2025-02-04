# Encoding: utf-8
#
# Cookbook Name:: elasticsearch
# Recipe:: default
#

include_recipe 'chef-sugar'

# settings for download urls
node.default['elasticsearch']['download_urls'] = if Gem::Version.new(node['elasticsearch']['install']['version']) >= Gem::Version.new('7.0.0')
                                                   node['elasticsearch']['version_7']['download_urls']
                                                 else
                                                   node['elasticsearch']['before_6_version']['download_urls']
                                                 end

# see README.md and test/fixtures/cookbooks for more examples!
elasticsearch_user 'elasticsearch' do
  node['elasticsearch']['user'].each do |key, value|
    # Skip nils, use false if you want to disable something.
    send(key, value) unless value.nil?
  end
end

elasticsearch_install 'elasticsearch' do
  node['elasticsearch']['install'].each do |key, value|
    # Skip nils, use false if you want to disable something.
    send(key, value) unless value.nil?
  end
end

elasticsearch_configure 'elasticsearch' do
  node['elasticsearch']['configure'].each do |key, value|
    # Skip nils, use false if you want to disable something.
    send(key, value) unless value.nil?
  end
end

elasticsearch_service 'elasticsearch' do
  node['elasticsearch']['service'].each do |key, value|
    # Skip nils, use false if you want to disable something.
    send(key, value) unless value.nil?
  end
end

# by default, no plugins
node['elasticsearch']['plugin'].each do |plugin_name, plugin_value|
  elasticsearch_plugin plugin_name do
    plugin_value.each do |key, value|
      # Skip nils, use false if you want to disable something.
      send(key, value) unless value.nil?
    end
  end
end
