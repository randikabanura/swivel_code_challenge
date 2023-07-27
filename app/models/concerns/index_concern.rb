module IndexConcern
  extend ActiveSupport::Concern

  included do
    searchkick
  end
end
