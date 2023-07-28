module IndexConcern
  extend ActiveSupport::Concern

  included do
    searchkick unless ENV['OPEN_SEARCH'].present?
  end
end
