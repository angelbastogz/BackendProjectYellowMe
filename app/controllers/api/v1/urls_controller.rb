class Api::V1::UrlsController < ApplicationController

  def generate_shorter_url
    url_original = params[:url]
    puts url_original
    path = "http://localhost:3000/api/v1/"

    #if the parameter is null render error
    if url_original.nil?
      render json: {status: :unprocessable_entity}
    else
      #Convert parameter to lowercase to avoid repeated data
      url_original = url_original.downcase

      if !Url.exists?(original: url_original)
        url = Url.new
        url.original = url_original
        url.generated_code = generate_code

        if url.save
          render json: {status: :ok, generated_url: path+url.generated_code}
        else
          render json: {status: :unprocessable_entity}
        end
      else
        url = Url.find_by(original: url_original)
        render json: {status: :ok, generated_url: path+url.generated_code}
      end
    end
  end

  private
  def generate_code
    number = 6

    charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
    Array.new(number) { charset.sample }.join
  end
end
