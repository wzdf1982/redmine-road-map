require_dependency "application_helper"

module Roadmap
  module ApplicationHelperPatch
	def self.included(base)
	  base.class_eval do

		def issue_list(issues, &block)
			ancestors = []
			issues.each do |issue|
			  while (ancestors.any? && !issue.is_descendant_of?(ancestors.last))
				ancestors.pop
			  end
			  yield issue, ancestors.size
			  ancestors << issue unless issue.leaf?
			end
		end
		
		def link_to_roadmap_issue(issue, options={})
			title = nil
			subject = nil
			if options[:subject] == false
			  title = truncate(issue.subject, :length => 60)
			else
			  subject = issue.subject
			  if options[:truncate]
				subject = truncate(subject, :length => options[:truncate])
			  end
			end
			s = link_to "#{issue.tracker} ##{issue.id}", {:controller => "issues", :action => "show", :id => issue}, 
														 :class => issue.css_classes,
														 :title => title
			#s << ": #{h subject}" if subject
			s = "#{h issue.project} - " + s if options[:project]
			s
		end
		
		def render_descendants_tree(root_issue, all_selected_issues)
			s = ""
			issue_list(root_issue.self_and_descendants.sort_by(&:lft)) do |child, level|
			   if all_selected_issues.include?(child)
			     s << content_tag('tr',
				     content_tag('td', check_box_tag("ids[]", child.id, false, :id => nil), :class => 'checkbox') +
					 content_tag('td', link_to_roadmap_issue(child), :class => 'subject') +
					 content_tag('td', h(child.priority)) +
					 content_tag('td', h(child.subject), :align => "left"),
					 :class => "issue issue-#{child.id} hascontextmenu #{level > 0 ? "idnt idnt-#{level}" : nil}")
				end
			end
			s
		end #end def

	  end #end fo eval
   end #end self include
  end # end of ApplicationHelperPatch
end #end of model roadmap
