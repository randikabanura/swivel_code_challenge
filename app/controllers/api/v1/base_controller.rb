class Api::V1::BaseController < ApplicationController
  include Api::V1::ResponseHandlerConcern
  include Api::V1::ErrorHandlerConcern
end
