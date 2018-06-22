class Api::V1::UrlsController < ApplicationController
  include UrlsHelper, EventMachine

  def index
    urls = Url.all.select("id, original, generated_url", "generated_code", "id")
    render json: {status: :ok, urls: urls}
  end

  #POST api/v1/generate
  def generate_shorter_url
    url_original = params[:url]
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

        if url.save
          render json: {status: :ok, generated_url: url.generated_url}
        else
          render json: {status: :unprocessable_entity}
        end
      else
        url = Url.find_by(original: url_original)
        render json: {status: :ok, generated_url: url.generated_url}
      end
    end
  end

  #POST api/v1/generate_many_urls
  def generate_many_shorter_urls
    urls_original = params[:urls]
    urls_original = JSON.parse(urls_original.to_json)

    path = get_path + get_path_of_method_generate_shorter_url

    EventMachine.run {
      #get urls of five to five for create synchronized post
      urls_original.each_slice(5) do |firstElement, secondElement, thirdElement, fourthElement, fifthElement|

        elements = [firstElement, secondElement, thirdElement, fourthElement, fifthElement]
        elements = convert_to_lowercase_elements elements

        elements_unique = elements.uniq

        elements_unique.each do |element|
          if !element.nil?
            http = EventMachine::HttpRequest.new(path).post :body => {'url'=>element['url']}

            http.errback {
              EventMachine.stop
            }

            http.callback {
              p http.response_header.status
              p http.response_header
              p http.response
              EventMachine.stop
            }
          end
        end
      end
    }
    render json: {status: :ok}
  end

  #get /*generated_code
  def redirect_url
    code = params[:generated_code]

    #if generated_code exists then redirect to url
    # else return unprocessable_entity
    if Url.exists?(generated_code: code)
      url = Url.find_by(generated_code: code)
      redirect_to url.original
    else
      render json: {status: :unprocessable_entity}
    end
  end

  private
  def convert_to_lowercase_elements elements

    elements.each do |element|
      if !element.nil?
        element['url'] = element['url'].downcase
      end
    end

    return elements
  end

end
