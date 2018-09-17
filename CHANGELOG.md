# Change Log
All notable changes to this project will be documented in this file.

## 2018-09-14
### Removed
- removed `Thumbnails` concern from `Document`

## 2018-09-13
### Changed
- forms utilize the `form_footer` helper

## 2018-09-10
### Removed
- removed `Site.current` and make it use `Folio::Singleton`
- removed `Site` relations from `Node` and `Visit`
- removed `Site.scheme` and `Site.url`

## 2018-09-03
### Changed
- added `required: true` to `belongs_to :placement` of `Folio::Atom::Base` 