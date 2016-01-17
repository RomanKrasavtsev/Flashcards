require "spec_helper"
require "carrierwave/test/matchers"

describe "image" do
  include CarrierWave::Test::Matchers

  before(:each) do
    @user = create(:user)
    @card = create(:card, :expired, user_id: @user.id)

    @uploader = ImageUploader.new(@card, :image)

    File.open("#{Rails.root}/spec/fixtures/image.jpg") do |f|
      @uploader.store!(f)
    end
  end

  after do
    @uploader.remove!
  end

  it "should be no larger than 360 by 360 pixels" do
    @uploader.should be_no_larger_than(360, 360)
  end
end
