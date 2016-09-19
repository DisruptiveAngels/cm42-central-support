module Central
  module Support
    module ProjectConcern
      module Associations
        extend ActiveSupport::Concern

        included do
          has_many :ownerships
          has_many :teams, through: :ownerships

          has_many :memberships, dependent: :destroy
          has_many :users, -> { uniq }, through: :memberships

          has_many :stories, dependent: :destroy do
            def with_dependencies
              includes(:notes, :tasks, :document_files)
            end

            include Central::Support::ProjectConcern::CSV::Import
          end

          accepts_nested_attributes_for :users, reject_if: :all_blank
        end
      end
    end
  end
end
