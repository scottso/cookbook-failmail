#
# Cookbook Name:: failmail
# Recipe:: default
#
# Copyright 2012, Scott Lampert
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
chef_gem "pony" do
  action :install
end

require 'rubygems'
require 'pony'

include_recipe "chef_handler"

cookbook_file(::File.join(node['chef_handler']['handler_path'], "failmail.rb")).run_action(:create)

chef_handler "Chef::Handler::SilverLining::FailMail" do
  source   ::File.join node['chef_handler']['handler_path'], "failmail.rb"
  supports :report => true
  arguments [node['failmail']['from_address'], node['failmail']['to_address'], node['failmail']['cc_address']]
  action :enable
end

