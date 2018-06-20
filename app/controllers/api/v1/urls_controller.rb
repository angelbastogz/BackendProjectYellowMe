class Api::V1::UrlsController < ApplicationController

  def generate_shorter_url
    url_original = params[:url]
    puts url_original
    path = "http://localhost:3000/api/v1/"

    url = Url.new
    url.original = url_original
    url.generated_code = generate_code

    if url.save
      render json: {status: :ok, generated_url: path+url.generated_code}
    else
      render json: {status: :unprocessable_entity}
    end

  end

  private
  def generate_code
    number = 6

    charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
    Array.new(number) { charset.sample }.join
  end
end
