# app/controllers/welcome_controller.rb
require "google/cloud/pubsub"

class WelcomeController < ApplicationController
  def index
    publish_message('Pub/Sub message from Welcome application running on Rails on Ruby')
  end

  private

  def publish_message(message)
    pubsub = Google::Cloud::Pubsub.new
    topic = pubsub.topic('projects/tanfaiz-cwx-internal/topics/rails-test') # Replace with your actual topic name
    topic.publish(message)
  end
end

