require 'enumerize'
require 'transitions'
require 'active_record/transitions'
class Story < ActiveRecord::Base
  belongs_to :project
  belongs_to :requested_by, class_name: 'User'
  belongs_to :owned_by, class_name: 'User'

  has_many :users, through: :project

  # This attribute is used to store the user who is acting on a story, for
  # example delivering or modifying it.  Usually set by the controller.
  attr_accessor :acting_user, :base_uri
  attr_accessor :iteration_number, :iteration_start_date # helper fields for IterationService
  attr_accessor :iteration_service

  STORY_TYPES = %i[feature chore bug release].freeze
  ESTIMABLE_TYPES = %w[feature release]

  extend Enumerize
  enumerize :story_type, in: STORY_TYPES, predicates: true, scope: true

  # Scopes for the different columns in the UI
  scope :done, -> { where(state: :accepted) }
  scope :in_progress, -> { where(state: [:started, :finished, :delivered]) }
  scope :backlog, -> { where(state: :unstarted) }
  scope :chilly_bin, -> { where(state: :unscheduled) }

  validate :bug_chore_estimation

  include ActiveRecord::Transitions
  state_machine do
    state :unscheduled
    state :unstarted
    state :started
    state :finished
    state :delivered
    state :accepted
    state :rejected

    event :start do
      transitions to: :started, from: [:unstarted, :unscheduled]
    end

    event :finish do
      transitions to: :finished, from: :started
    end

    event :deliver do
      transitions to: :delivered, from: :finished
    end

    event :accept do
      transitions to: :accepted, from: :delivered
    end

    event :reject do
      transitions to: :rejected, from: :delivered
    end

    event :restart do
      transitions to: :started, from: :rejected
    end
  end

  def to_s
    title
  end

  # Returns true or false based on whether the story has been estimated.
  def estimated?
    !estimate.nil?
  end
  alias :estimated :estimated?

  # Returns the CSS id of the column this story belongs in
  def column
    case state
    when 'unscheduled'
      '#chilly_bin'
    when 'unstarted'
      '#backlog'
    when 'accepted'
      if iteration_service
        if iteration_service.current_iteration_number == iteration_service.iteration_number_for_date(accepted_at)
          return '#in_progress'
        end
      end
      '#done'
    else
      '#in_progress'
    end
  end

  private

    def bug_chore_estimation
      if !ESTIMABLE_TYPES.include?(story_type) && estimated?
        errors.add(:estimate, :cant_estimate)
      end
    end
end
