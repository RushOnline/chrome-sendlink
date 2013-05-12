$ ->
  DEBUG = true

  debug =  ->
    console.debug arguments if DEBUG
    return

  debug 'SendLink Loaded OK'
  debug 'SendLink jQuery: ', $().jquery

  selectors = [
    'a[href$=\\.avi]'
    'a[href$=\\.mp3]'
    'a[href$=\\.mkv]'
    'a[href$=\\.mpeg]'
    'a[href$=\\.mpg]'
    ]

  hook_links = ->
    for selector in selectors
      $(selector).each ->
        if  $(this).prev('.x-sendlink').length == 0
          $(this).before '<button data-href="' + this.href + '" href="#" class="x-sendlink">Play</a>&nbsp;'
    $('.x-sendlink').on 'click', ->
      request =
          type: "POST"
          url: 'http://localhost:8001/'
          crossDomain: true
          data:
              command: 'playlist.add'
              item: encodeURI $(this).data('href')
          success: (response) =>
              if response.success == true
                  $(this).addClass 'x-sendlink-done'
                  $(this).attr('disabled', true)
              else
                  alert 'Seems like SMPlayer not running: ' + response.message
                  console.debug 'strange response: ', response
              return
          error: (response) ->
              console.debug response
              alert 'Use SMPlayer with local proxy: https://github.com/RushOnline/smploxy'
              return

      debug request
      $.ajax request
      false
    return

  $(document).on 'DOMNodeInserted', (e) ->
    element = e.target
    return if $(element).hasClass 'x-sendlink'
    hook_links()
    return

  hook_links()


  return
