class Cms::DashboardController < Cms::BaseController
      
  def index
    @unpublished_pages = Page.unpublished.all(:order => "updated_at desc")
    @unpublished_pages = @unpublished_pages.select { |page| current_user.able_to_publish?(page) }
    @incomplete_tasks = current_user.tasks.incomplete.all(
      :include => :page, 
      :order => "tasks.due_date desc, pages.name")
    @recently_updated_pages = Page.by_update_time(:limit => 10)
  end
end
