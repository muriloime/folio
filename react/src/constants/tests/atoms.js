export const SINGLE_LOCALE_ATOMS = { atoms: { atoms: [{ id: 1, type: 'Folio::Atom::Text', position: 1, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }, { id: 2, type: 'Folio::Atom::Text', position: 2, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }, { id: 3, type: 'Folio::Atom::Text', position: 3, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }] }, destroyedIds: { atoms: [] }, namespace: 'page', structures: { 'Folio::Atom::Title': { attachments: [], structure: { title: { label: 'Název', validators: [{ class: 'ActiveRecord::Validations::PresenceValidator', options: {} }], type: 'string' } }, title: 'Titulek' }, 'Folio::Atom::Text': { attachments: [], structure: { content: { label: 'Obsah', validators: [{ class: 'ActiveRecord::Validations::PresenceValidator', options: {} }], type: 'richtext' } }, title: 'Text' }, 'Dummy::Atom::Gallery': { attachments: [{ type: 'image_placements', label: 'Images', plural: true, file_type: 'Folio::Image' }], structure: { title: { label: 'Název', validators: [], type: 'string' } }, title: 'Gallery' }, 'Dummy::Atom::DaVinci': { attachments: [{ type: 'cover_placement', label: 'Obrázek', plural: false, file_type: 'Folio::Image' }, { type: 'image_placements', label: 'Images', plural: true, file_type: 'Folio::Image' }], structure: { string: { label: 'String', validators: [], type: 'string' }, text: { label: 'Text', validators: [], type: 'text' }, richtext: { label: 'Richtext', validators: [], type: 'richtext' }, code: { label: 'Code', validators: [], type: 'code' }, integer: { label: 'Integer', validators: [], type: 'integer' }, float: { label: 'Float', validators: [], type: 'float' }, color: { label: 'Color', validators: [], type: 'color' }, date: { label: 'Date', validators: [], type: 'date' }, datetime: { label: 'Datetime', validators: [], type: 'datetime' } }, title: 'Da vinci' } } }

export const MULTI_LOCALE_ATOMS = { atoms: { cs_atoms: [{ id: 1, type: 'Folio::Atom::Text', position: 1, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }, { id: 2, type: 'Folio::Atom::Text', position: 2, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }, { id: 3, type: 'Folio::Atom::Text', position: 3, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }], en_atoms: [{ id: 1, type: 'Folio::Atom::Text', position: 1, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }, { id: 2, type: 'Folio::Atom::Text', position: 2, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }, { id: 3, type: 'Folio::Atom::Text', position: 3, placement_type: 'Folio::Page', placement_id: 1, data: { content: 'lorem ipsum' } }] }, destroyedIds: { cs_atoms: [], en_atoms: [] }, namespace: 'page', structures: { 'Folio::Atom::Title': { attachments: [], structure: { title: { label: 'Název', validators: [{ class: 'ActiveRecord::Validations::PresenceValidator', options: {} }], type: 'string' } }, title: 'Titulek' }, 'Folio::Atom::Text': { attachments: [], structure: { content: { label: 'Obsah', validators: [{ class: 'ActiveRecord::Validations::PresenceValidator', options: {} }], type: 'richtext' } }, title: 'Text' }, 'Dummy::Atom::Gallery': { attachments: [{ type: 'image_placements', label: 'Images', plural: true, file_type: 'Folio::Image' }], structure: { title: { label: 'Název', validators: [], type: 'string' } }, title: 'Gallery' }, 'Dummy::Atom::DaVinci': { attachments: [{ type: 'cover_placement', label: 'Obrázek', plural: false, file_type: 'Folio::Image' }, { type: 'image_placements', label: 'Images', plural: true, file_type: 'Folio::Image' }], structure: { string: { label: 'String', validators: [], type: 'string' }, text: { label: 'Text', validators: [], type: 'text' }, richtext: { label: 'Richtext', validators: [], type: 'richtext' }, code: { label: 'Code', validators: [], type: 'code' }, integer: { label: 'Integer', validators: [], type: 'integer' }, float: { label: 'Float', validators: [], type: 'float' }, color: { label: 'Color', validators: [], type: 'color' }, date: { label: 'Date', validators: [], type: 'date' }, datetime: { label: 'Datetime', validators: [], type: 'datetime' } }, title: 'Da vinci' } } }
