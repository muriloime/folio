import React from 'react'
import { connect } from 'react-redux'

import { makeFilesStatusSelector, makeFilesForListSelector, makeFilesPaginationSelector, changeFilesPage } from 'ducks/files'
import { displayAsThumbsSelector } from 'ducks/display'
import LazyLoadCheckingComponent from 'utils/LazyLoadCheckingComponent'

import FileFilter from 'containers/FileFilter'
import Uploader from 'containers/Uploader'
import UploadTagger from 'containers/UploadTagger'
import FileList from 'components/FileList'
import Loader from 'components/Loader'
import Card from 'components/Card'

class IndexMode extends LazyLoadCheckingComponent {
  render () {
    if (!this.props.filesStatus.loaded) return <Loader />
    const fileTypeIsImage = this.props.filesKey === 'images'

    return (
      <Uploader filesKey={this.props.filesKey}>
        <Card
          filters={<FileFilter filesKey={this.props.filesKey} fileTypeIsImage={fileTypeIsImage} />}
        >
          <UploadTagger filesKey={this.props.filesKey} />

          {this.props.filesStatus.loading ? <Loader standalone /> : (
            <FileList
              files={this.props.filesForList}
              fileTypeIsImage={fileTypeIsImage}
              displayAsThumbs={this.props.displayAsThumbs}
              pagination={this.props.filesPagination}
              changeFilesPage={(page) => this.props.dispatch(changeFilesPage(this.props.filesKey, page))}
              link
              dropzoneTrigger
            />
          )}
        </Card>
      </Uploader>
    )
  }
}

const mapStateToProps = (state, props) => ({
  filesStatus: makeFilesStatusSelector(props.filesKey)(state),
  filesForList: makeFilesForListSelector(props.filesKey)(state),
  displayAsThumbs: displayAsThumbsSelector(state),
  filesPagination: makeFilesPaginationSelector(props.filesKey)(state)
})

function mapDispatchToProps (dispatch) {
  return { dispatch }
}

export default connect(mapStateToProps, mapDispatchToProps)(IndexMode)
