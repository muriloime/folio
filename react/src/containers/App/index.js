import React, { Component } from 'react'
import { connect } from 'react-redux'
import { forceCheck } from 'react-lazyload'

import { getFiles } from 'ducks/files'

import SingleSelect from 'containers/SingleSelect'
import MultiSelect from 'containers/MultiSelect'

import AppWrap from './AppWrap'

class App extends Component {
  componentWillMount () {
    this.props.dispatch(getFiles())
    window.addEventListener('checkLazyload', forceCheck)
  }

  renderMode () {
    const { mode } = this.props.app

    if (mode === 'multi-select') {
      return <MultiSelect />
    }

    if (mode === 'single-select') {
      return <SingleSelect />
    }

    return (
      <div className='alert alert-danger'>
        Unknown mode: {mode}
      </div>
    )
  }

  render () {
    return <AppWrap>{this.renderMode()}</AppWrap>
  }
}

const mapStateToProps = (state) => ({
  app: state.get('app').toJS()
})

function mapDispatchToProps (dispatch) {
  return { dispatch }
}

export default connect(mapStateToProps, mapDispatchToProps)(App)
