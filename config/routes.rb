require 'redmine'
ActionController::Routing::Routes.draw do |map|
  
	projects = Project.find(:all, :order => 'lft')
	if(defined?(projects.length))
		if(projects.length == 1)
			id=(projects[0]).identifier
			if(Setting.plugin_redmine_single_project['single_landing_page'] == 'repository')
				map.connect '', :controller=> 'repositories', :id=>id, :action=>'show'
			else
				map.connect '', :controller=> 'wiki', :project_id=>id, :action=>'show'
			end
		end
	end
	
end
