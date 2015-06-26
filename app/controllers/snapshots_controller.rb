class SnapshotsController < ApplicationController

  def show
    link = Link.find(params[:id])
    if link.mhtml
      # render file: link.mhtml, content_type: "multipart/related"
      render file: link.mhtml, content_type: "application/x-mimearchive"
    else
      render text: "Not found"
    end
  end
  
end
