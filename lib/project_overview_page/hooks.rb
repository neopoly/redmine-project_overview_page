module ProjectOverviewPage
  class Hooks < Redmine::Hook::ViewListener
    include ::AttachmentsHelper

    def view_projects_show_top(context)
      page = find_wiki_page(context, overview_id)

      return unless page
      %(<div class="wiki">#{render_content_for_page(context, page)}</div>)
    end

    def view_projects_show_sidebar_top(context)
      page = find_wiki_page(context, sidebar_id)
      return unless page
      %(<div class="wiki">#{render_content_for_page(context, page)}</div>)
    end

    def view_projects_contextual(ctx)
      edit_page_link(ctx, overview_id) +
        edit_page_link(ctx, sidebar_id, "project_overview_page_sidebar_label")
    end

    private

    def overview_id
      settings["overview"]
    end

    def sidebar_id
      settings["sidebar"]
    end

    def settings
      Setting.plugin_project_overview_page
    end

    def render_content_for_page(context, page)
      # this rendering must be done through the current view content
      # otherwise textile macros and etc. won't be available
      context[:controller].view_context.textilizable(
        page.content,
        :text,
        attachments: page.attachments,
        project: context[:project]
      )
    end

    def edit_page_link(context, id, label = nil)
      if find_wiki_page(context, id)
        page_link(context, id, :edit, label)
      else
        page_link(context, id, :add, label)
      end
    end

    def page_link(context, id, action, label)
      link_to(
        l(label || "button_#{action}"),
        edit_link_path(context, id),
        class: "icon icon-#{action}",
        accesskey: accesskey(action.to_sym)
      )
    end

    def find_wiki_page(context, title)
      (project = context[:project]) &&
        project.wiki &&
        project.wiki.find_page(title)
    end

    def edit_link_path(context, id)
      edit_project_wiki_page_path(project_id: context[:project].id, id: id)
    end
  end
end
