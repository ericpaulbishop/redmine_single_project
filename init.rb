# Single project redmine plguin
require 'redmine'

RAILS_DEFAULT_LOGGER.info 'Starting Single Project plugin for RedMine'

Redmine::Plugin.register :single_project_plugin do
	name 'Single Project plugin'
	author 'Eric Bishop'
	description 'Hides multi-project display when only when project is present'
	version '1.0.0'
	settings :default => {
    			'single_landing_page' => 'wiki' 
    			}
end
