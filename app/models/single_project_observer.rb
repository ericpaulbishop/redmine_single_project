class SingleProjectObserver < ActiveRecord::Observer
	observe :project
	
	def after_create(object)
		update_routes_and_menus object
	end

	def after_destroy(object)
		update_routes_and_menus object
	end

	protected
	def update_routes_and_menus(object)
		# only update if num projects = 1 (may have just deleted a project, now single again)
		# or 2 (may have just added a project, no longer single)
		# otherwise, nothing changes
		if object.is_a?(Project)
			all_projects = Project.find(:all)
			if all_projects.length == 1 || all_projects.length == 2
				ActionController::Routing::Routes.reload!
				Redmine::MenuManager.map :top_menu do |menu|
					menu.delete :projects rescue nil
					if all_projects.length > 1
						menu.push  :projects, { :controller => 'projects', :action => 'index', :after =>:my_page }, :caption => :label_project_plural
					end
				end
			end
		end
	end
end

