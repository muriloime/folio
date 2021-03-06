import React from 'react'

import TagsInput from 'components/TagsInput'

export default ({ modal, onTagsChange, closeModal, saveModal, tags }) => (
  <div className='modal-content'>
    <div className='modal-header'>
      <strong className='modal-title'>{modal.file.attributes.file_name}</strong>
      <button type='button' className='close' onClick={closeModal}>×</button>
    </div>

    <div className='modal-body'>
      <div className='form-group string optional file_tag_list'>
        <label className='control-label string optional'>
          {window.FolioConsole.translations.tagsLabel}
        </label>

        <TagsInput
          value={modal.newTags || modal.file.attributes.tags}
          options={tags}
          onTagsChange={onTagsChange}
          submit={saveModal}
        />

        <small className='form-text'>
          {window.FolioConsole.translations.tagsHint}
        </small>
      </div>
    </div>

    <div className='modal-footer'>
      <button type='button' className='btn btn-secondary' onClick={closeModal}>
        {window.FolioConsole.translations.cancel}
      </button>

      <button type='button' className='btn btn-primary' onClick={saveModal}>
        {window.FolioConsole.translations.save}
      </button>
    </div>
  </div>
)
