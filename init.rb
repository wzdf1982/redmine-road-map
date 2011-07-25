require 'redmine'
require 'dispatcher'

require "dispatcher"

Dispatcher.to_prepare do 
  ApplicationHelper.send(:include, Roadmap::ApplicationHelperPatch)
end

require_dependency "roadmap/hook.rb"

Redmine::Plugin.register :redmine_roadmap do
  name 'Redmine Roadmap plugin'
  author 'Dingjun Zhou'
  description 'A plugin for provide a different view for Roadmap'
  version '0.0.1'
end
