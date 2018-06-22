class Url < ApplicationRecord
  include UrlsHelper
  validates :original, :generated_code, presence: true

  before_validation :generate_unique_code

  def generate_unique_code
    begin
      generated_code = generate_code
    end while Url.exists?(generated_code: generated_code)

    self.generated_code = generated_code
    self.generated_url = get_path+generated_code
  end

  #returns a randomly generated code
  def generate_code
    number = 6

    charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
    Array.new(number) { charset.sample }.join
  end
end
