import React, { Component } from 'react'
import { connect } from 'react-redux'
import { forceCheck } from 'react-lazyload'

import { getFiles, thumbnailGenerated, makeFilesLoadedSelector } from 'ducks/files'
import { openModal } from 'ducks/modal'

import SingleSelect from 'containers/SingleSelect'
import MultiSelect from 'containers/MultiSelect'
import IndexMode from 'containers/IndexMode'
import ModalSingleSelect from 'containers/ModalSelect/ModalSingleSelect'
import ModalMultiSelect from 'containers/ModalSelect/ModalMultiSelect'
import Modal, { ModalContext } from 'containers/Modal'
import Atoms from 'containers/Atoms'

import AppWrap from './styled/AppWrap'

class App extends Component {
  componentWillMount () {
    if (this.shouldAutoLoadFiles()) {
      this.loadFiles(this.props.app.filesKey)
    }
    this.listenOnActionCable()
    window.addEventListener('checkLazyload', forceCheck)
  }

  loadFiles = (filesKey) => {
    if (!this.props.filesLoaded) {
      this.props.dispatch(getFiles(filesKey))
    }
  }

  openModal = (file) => {
    this.props.dispatch(openModal(file))
  }

  listenOnActionCable () {
    if (!window.FolioCable) return
    this.cableSubscription = window.FolioCable.cable.subscriptions.create('FolioThumbnailsChannel', {
      received: (data) => {
        if (!data) return
        if (!data.temporary_url || !data.url) return
        this.props.dispatch(thumbnailGenerated('images', data.temporary_url, data.url))
      }
    })
  }

  shouldAutoLoadFiles () {
    return this.props.app.mode !== 'modal-single-select' && this.props.app.mode !== 'modal-multi-select' && this.props.app.mode !== 'atoms'
  }

  renderMode () {
    const { mode, fileType, filesKey } = this.props.app

    if (mode === 'multi-select') {
      return <MultiSelect filesKey={filesKey} />
    }

    if (mode === 'single-select') {
      return <SingleSelect filesKey={filesKey} />
    }

    if (mode === 'index') {
      return <IndexMode filesKey={filesKey} />
    }

    if (mode === 'modal-single-select') {
      return (
        <ModalSingleSelect
          fileType={fileType}
          filesKey={filesKey}
          loadFiles={this.loadFiles}
        />
      )
    }

    if (mode === 'modal-multi-select') {
      return (
        <ModalMultiSelect
          fileType={fileType}
          filesKey={filesKey}
          loadFiles={this.loadFiles}
        />
      )
    }

    if (mode === 'atoms') {
      return (
        <Atoms />
      )
    }

    return (
      <div className='alert alert-danger'>
        Unknown mode: {mode}
      </div>
    )
  }

  render () {
    return (
      <AppWrap className='folio-react-app'>
        <ModalContext.Provider value={this.openModal}>
          {this.renderMode()}
        </ModalContext.Provider>

        <Modal filesKey={this.props.app.filesKey} />
      </AppWrap>
    )
  }
}

const mapStateToProps = (state, props) => ({
  app: state.app,
  filesLoaded: makeFilesLoadedSelector(props.filesKey)(state)
})

function mapDispatchToProps (dispatch) {
  return { dispatch }
}

export default connect(mapStateToProps, mapDispatchToProps)(App)
