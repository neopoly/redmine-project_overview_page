module ProjectOverviewPage
  # Registers this gems a Redmine plugin and applies the needed patches
  class RedminePlugin
    include ProjectOverviewPage::Infos

    DEFAULT_SETTINGS = {
      "overview" => "WikiStart",
      "sidebar"  => "OverviewSidebar"
    }.freeze

    SETTING_PARTIAL = "settings/project_overview_page_settings"

    def initialize
      register!
      boot!
    end

    private

    def register!
      Redmine::Plugin.register :project_overview_page do
        name NAME
        author AUTHORS.keys.join(", ")
        description DESCRIPTION
        version VERSION
        url URL
        author_url URL
        directory Engine.root

        settings default: DEFAULT_SETTINGS, partial:  SETTING_PARTIAL
      end
    end

    def boot!
      require "project_overview_page/hooks"
    end
  end
end
