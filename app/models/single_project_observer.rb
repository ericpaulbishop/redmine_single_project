class SingleProjectObserver < ActiveRecord::Observer
	observe :project
	
	def after_create(object)
		if object.is_a?(Project)
			all_projects = Project.find(:all)
			if(all_projects.length > 1)
				ActionController::Routing::Routes.draw do |map|
					map.home '', :controller => 'welcome'
				end
				Redmine::MenuManager.map :top_menu do |menu|
					menu.push :projects, { :controller => 'projects', :action => 'index', :after =>:my_page }, :caption => :label_project_plural
				end
			end
		end
	end
end

