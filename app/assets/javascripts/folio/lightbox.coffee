#= require photoswipe/dist/photoswipe
#= require photoswipe/dist/photoswipe-ui-default

class window.FolioLightbox
  constructor: (selector, additionalSelector = false, data = null) ->
    @selector = selector
    if additionalSelector
      @full_selector = "#{selector}, #{additionalSelector}"
    else
      @full_selector = selector
    @eventIdentifier = "folioLightbox"
    @bind(data)

  pswp: ->
    @$pswp ||= $('.pswp')
    @$pswp

  bind: (data) ->
    @unbind()
    $(document).on "click.#{@eventIdentifier}", @full_selector, (e) =>
      e.preventDefault()
      $img = $(e.target)

      options =
        index: $img.index(@full_selector)
        bgOpacity: 0.7
        showHideOpacity: true
        history: false
        errorMsg: @pswp().data('error-msg')

      @photoSwipe = new PhotoSwipe(@pswp()[0], PhotoSwipeUI_Default, data || @items(), options)
      @photoSwipe.init()

  items: ->
    $(@selector).map(@item.bind(this)).toArray()

  item: (index, el) ->
    if el.tagName.toLowerCase() is 'img'
      $el = $(el)
    else
      $el = $(el).find('img')

    item =
      src: $el.data('lightbox-src')
      w: parseInt($el.data('lightbox-width'))
      h: parseInt($el.data('lightbox-height'))
    item.title = $el.data('lightbox-title') or $el.next('figcaption').text()
    item

  unbind: ->
    $(document).off "click.#{@eventIdentifier}", @full_selector

  destroy: ->
    try
      @photoSwipe.close()
      @photoSwipe.destroy()
    catch e
    @photoSwipe = null
    @unbind()
    @$pswp = null

window.makeFolioLightbox = (selector, opts = {}) ->
  window.folioLightboxInstances ?= []

  init = ->
    $items = $(selector)
    return if $items.length is 0
    if opts.individual
      $items.each ->
        subSelector = ".#{@className.replace(/\s+/g, '.')}"
        if opts.itemSelector
          subSelector = "#{subSelector} #{opts.itemSelector}"

        window.folioLightboxInstances.push(new window.FolioLightbox(subSelector))
    else if opts.fromData
      $items.each ->
        window.folioLightboxInstances.push(
          new window.FolioLightbox(selector,
                                   false,
                                   $(this).data('lightbox-image-data'))
        )
    else
      window.folioLightboxInstances.push(new window.FolioLightbox(selector))

  if Turbolinks?
    $(document).on 'turbolinks:load', init

    $(document).on 'turbolinks:before-cache turbolinks:before-render', ->
      return unless window.folioLightboxInstances.length > 0

      window.folioLightboxInstances.forEach (instance) ->
        instance.destroy()

      window.folioLightboxInstances = []
  else
    $ init
