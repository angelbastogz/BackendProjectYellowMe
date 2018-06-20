Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    namespace :api, defaults: { format: "json" } do
      namespace :v1 do
        post 'generate', to: 'urls#generate_shorter_url'
        post 'generate_many_urls', to: 'urls#generate_many_shorter_urls'

        get '*generated_code', to: 'urls#redirect_url'
      end
    end
  end
end
