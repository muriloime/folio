# frozen_string_literal: true

InvisibleCaptcha.setup do |config|
  # config.honeypots           << ['more', 'fake', 'attribute', 'names']
  # config.visual_honeypots    = false
  # config.timestamp_threshold = 2

  # disable timestamp because of page caching
  config.timestamp_enabled = false

  # config.injectable_styles   = false

  # Leave these unset if you want to use I18n (see below)
  # config.sentence_for_humans     = 'If you are a human, ignore this field'
  # config.timestamp_error_message = 'Sorry, that was too quick! Please resubmit.'
end
