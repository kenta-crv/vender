class ImagesController < ApplicationController

 def create
    @company = Company.find(params[:company_id])
    @company.images.create(image_params)
    redirect_to company_path(@company)
  end

  def destroy
    @company = Company.find(params[:company_id])
    @image = @company.images.find(params[:id])
    @image.destroy
    redirect_to company_path(@company)
  end

  def update
      @company = Company.find(params[:company_id])
      @image = @company.images.find(params[:id])
     if @image.update(image_params)
       redirect_to company_path(@company)
     else
        render 'edit'
     end
  end

  def download
      @image = Image.find(params[:id].to_i)
      filepath = @image.picture.current_path
      stat = File::stat(filepath)
      send_file(filepath, :filename => @image.picture.url.gsub(/.*\//,''), :length => stat.size)
  end

  def view
    @image = Image.find(params[:id].to_i)
    filepath = @image.picture.current_path
    stat = File::stat(filepath)
    send_file(filepath, :filename => @image.picture.url.gsub(/.*\//,''), :length => stat.size, :disposition => 'inline')
  end

  private
    def image_params
      params.require(:image).permit(
        :picture, #その他
        :title
      )
    end
end
