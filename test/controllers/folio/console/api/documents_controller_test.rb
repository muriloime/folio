# frozen_string_literal: true

require 'test_helper'

class Folio::Console::Api::DocumentsControllerTest < Folio::Console::BaseControllerTest
  test 'index' do
    get url_for([:console, :api, Folio::Document])
    assert_response :success
  end

  test 'create' do
    assert_equal(0, Folio::Document.count)
    post url_for([:console, :api, Folio::Document]), params: {
      file: {
        attributes: {
          file: fixture_file_upload('test/fixtures/folio/test.gif'),
          type: 'Folio::Document',
        }
      }
    }
    assert_response :success
    assert_equal(1, Folio::Document.count)
  end

  test 'update' do
    document = create(:folio_document)
    put url_for([:console, :api, document]), params: {
      file: {
        attributes: {
          tags: ['foo'],
        }
      }
    }
    assert_response(:success)
    json = JSON.parse(response.body)
    assert_equal(['foo'], json['data']['attributes']['tags'])
  end

  test 'tag' do
    documents = create_list(:folio_document, 2)
    assert_equal([], documents.first.tag_list)
    assert_equal([], documents.second.tag_list)

    post url_for([:tag, :console, :api, Folio::Document]), params: {
      file_ids: documents.pluck(:id),
      tags: ['a', 'b'],
    }

    assert_equal(['a', 'b'], documents.first.reload.tag_list.sort)
    assert_equal(['a', 'b'], documents.second.reload.tag_list.sort)
  end
end
