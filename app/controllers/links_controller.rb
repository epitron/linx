class LinksController < ApplicationController

  def index
    page_size = 20

    if params[:tag] and @tag = Tag.find_by(name: params[:tag])
      @links = @tag.links
    else
      @links = current_user.links
    end

    if @query = params[:search]
      @links = @links.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?", *["%#{@query.downcase}%"]*2)
    end

    @links = @links.limit(page_size).offset(current_page * page_size).includes(:tags)
  end

  helper_method def current_page(delta=0)
    if page_num = params[:page]
      n = page_num.to_i
    else
      n = 0
    end

    [n + delta, 0].max
  end
end
