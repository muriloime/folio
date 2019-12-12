import styled from 'styled-components'

export default styled.div`
  position: relative;
  flex: 1 1 auto;
  display: flex;
  flex-direction: column;
  height: 100%;

  .folio-loader {
    top: -15px;
    left: -15px;
    width: calc(100% + 30px);
    height: calc(100% + 30px);
    z-index: 2;
  }

  .folio-console-nested-model-controls {
    flex: 0 0 35px;
    margin-left: 1rem;
  }
`
