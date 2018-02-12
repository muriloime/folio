import React from 'react'
import styled from 'styled-components'
import LazyLoad from 'react-lazyload'

const Wrap = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;

  i {
    margin-bottom: 10px;
    font-size: 30px;
  }
`

function ThumbOrInfo ({ file, singleSelect }) {
  if (file.thumb) {
    return (
      <LazyLoad height={150} once overflow={singleSelect}>
        <img src={file.thumb} alt={file.file_name} />
      </LazyLoad>
    )
  }

  return (
    <Wrap>
      <i className='fa fa-file-o' />

      <strong>{file.file_name}</strong>
    </Wrap>
  )
}

export default ThumbOrInfo