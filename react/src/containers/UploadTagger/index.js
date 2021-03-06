import React from 'react'
import { connect } from 'react-redux'

import { makeTagsSelector } from 'ducks/filters'
import {
  setUploadTags,
  makeUploadsSelector
} from 'ducks/uploads'

import TagsInput from 'components/TagsInput'
import Wrap from './styled/Wrap'

class UploadTagger extends React.PureComponent {
  state = { tags: [] }

  constructor (props) {
    super(props)
    this.state.tags = props.uploads.uploadTags
  }

  onTagsChange = (tags) => {
    this.setState({ tags })
  }

  setUploadTags = () => {
    this.props.dispatch(setUploadTags(this.props.filesKey, this.state.tags))
  }

  render () {
    if (!this.props.uploads.showTagger) return null

    return (
      <Wrap className='alert alert-primary'>
        <label>{window.FolioConsole.translations.newUploadTags}:</label>

        <TagsInput
          value={this.state.tags}
          options={this.props.tags}
          onTagsChange={this.onTagsChange}
          closeMenuOnSelect={false}
        />

        <button
          className='btn btn-success fa fa-check'
          type='button'
          onClick={this.setUploadTags}
        />
      </Wrap>
    )
  }
}

const mapStateToProps = (state, props) => ({
  uploads: makeUploadsSelector(props.filesKey)(state),
  tags: makeTagsSelector(props.filesKey)(state)
})

function mapDispatchToProps (dispatch) {
  return { dispatch }
}

export default connect(mapStateToProps, mapDispatchToProps)(UploadTagger)
