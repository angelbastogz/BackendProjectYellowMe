class Api::V1::UrlsController < ApplicationController
include UrlsHelper

  def generate_shorter_url
    url_original = params[:url]
    puts url_original
    path = get_path

    #if the parameter is null render error
    if url_original.nil?
      render json: {status: :unprocessable_entity}
    else
      #Convert parameter to lowercase to avoid repeated data
      url_original = url_original.downcase

      #If the url does not exist, generate a code and save it
      # else return its data
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

  #returns a randomly generated code
  def generate_code
    number = 6

    charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
    Array.new(number) { charset.sample }.join
  end
end
