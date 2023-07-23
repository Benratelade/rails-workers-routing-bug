class RichTextExamplesController < ApplicationController
  def new
    @rich_text_example = RichTextExample.new
  end

  def create 
    @rich_text_example = RichTextExample.new(rich_text_example_params)
    if @rich_text_example.save
      flash[:message] = "Successfully saved!"
      redirect_to(@rich_text_example)
    end
  end

  def show
    @rich_text_example = RichTextExample.find(params[:id])
  end

  private
  def rich_text_example_params
    params.require(:rich_text_example).permit(:content)
  end
end
