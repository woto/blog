class TagsController < ApplicationController
  auto_complete_for :tag, :name
end
