# frozen_string_literal: true

require 'folio/engine'

# TODO: rm the require

require 'dotenv-rails'
require 'friendly_id'
require 'ancestry'
require 'devise'
require 'cancancan'
require 'responders'
require 'active_model_serializers'
require 'sitemap_generator'
require 'acts-as-taggable-on'
require 'pg_search'

require 'cells'
require 'cells-rails'
require 'cells-slim'
require 'slim'
require 'sass-rails'
require 'simple_form'
require 'cocoon'
require 'pagy'
require 'font-awesome-rails'
require 'jquery-rails'
require 'dropzonejs-rails'
require 'countries'
require 'breadcrumbs_on_rails'
require 'rails-assets-selectize'
require 'ahoy_matey'
require 'invisible_captcha'
require 'rails-i18n'
require 'state_machines'
require 'state_machines-activerecord'
require 'recaptcha'

module Folio
  LANGUAGES = {
    cs: 'CZ',
    de: 'DE',
    pl: 'PL',
    es: 'ES',
    en: 'GB',
    en_US: 'US'
  }

  EMAIL_REGEXP = /[^@]+@[^@]+/
  OG_IMAGE_DIMENSIONS = '1200x630#'
end
