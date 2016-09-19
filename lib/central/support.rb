require "central/support/version"
require "central/support/iteration_service"
require "central/support/iteration"
require "central/support/mattermost"

# Ccompatibility mode for drop-in replacement into Central
# TODO: must remove this after the migration from Central is complete
IterationService = Central::Support::IterationService
Iteration = Central::Support::Iteration
Mattermost = Central::Support::Mattermost
