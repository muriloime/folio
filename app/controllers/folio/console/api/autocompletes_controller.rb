# frozen_string_literal: true

class Folio::Console::Api::AutocompletesController < Folio::Console::Api::BaseController
  def show
    klass = params.require(:klass).safe_constantize
    q = params.require(:q)

    if klass &&
       klass.respond_to?(:by_query) &&
       klass.new.respond_to?(:to_autocomplete_label)
      ary = klass.by_query(q)
                 .limit(25)
                 .map(&:to_autocomplete_label)
                 .compact
                 .uniq
                 .first(10)

      render json: { data: ary }
    else
      render json: { data: [] }
    end
  end
end
