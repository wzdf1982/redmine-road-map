module Roadmap
    class ViewHooks < Redmine::Hook::ViewListener
        render_on(:view_projects_roadmap_version_bottom,:partial => "hooks/show")
    end
end
