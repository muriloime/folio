import React, { Fragment } from 'react'

import FilePlacementSortableList from './FilePlacementSortableList'
import filePlacementInputName from './utils/filePlacementInputName'

const FilePlacementList = (props) => (
  <Fragment>
    <FilePlacementSortableList
      axis='xy'
      distance={5}
      move={props.onSortEnd}
      {...props}
    />

    {!props.nested && props.filePlacements.deleted.map((filePlacement) => (
      <div key={filePlacement.id}>
        <input
          type='hidden'
          name={filePlacementInputName('id', filePlacement, props.filePlacements.attachmentable, props.filePlacements.placementType)}
          value={filePlacement.id}
        />
        <input
          type='hidden'
          name={filePlacementInputName('_destroy', filePlacement, props.filePlacements.attachmentable, props.filePlacements.placementType)}
          value='1'
        />
      </div>
    ))}
  </Fragment>
)

export default FilePlacementList
