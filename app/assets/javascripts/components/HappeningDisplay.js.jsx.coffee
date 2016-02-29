@HappeningsDisplay = React.createClass
  getInitialState: ->
    feed: null
    displayMessage: false
    messageToDisplay: null

    showCaptions: true
    showUserInfo: true
    showHapInfo: true

    showSettings: false

    currentHappening: null

    fullScreen: false

  componentWillMount: ->
    @_loadHappenings()

  _initSlideshow: ->
    if $('#source').length > 0
      $('.image-container .image-main').slideshowify()
      $('body').bind 'afterFadeIn', (e, img) =>
        sourceString = img['src']
        @_showInfo(sourceString)

      $('body').bind 'beforeFadeOut', =>
        @setState currentHappening: null

      $('body').bind 'lastImageLoaded', =>
        console.log "Need to stop, re-trigger slideshow here"
        # $("[id^=slideshowify]").remove()
        # $('.image-container .image-main').slideshowify()

  _loadHappenings: ->
    @setState
      displayMessage: false
      messageToDisplay: null

    url = "https://whatshappening.eightbitstudios.com/api/v1/web_app/feeds/#{this.props.happeningKey}"

    $.ajax
      type: 'GET'
      dataType: 'json'
      url: url
      success: (response) =>
        if response.feed.happenings.length > 0
          @setState feed: response.feed

          @_initSlideshow()

        else
          @setState
            displayMessage: true
            messageToDisplay: "Hang tight, nothing's happening yet."

      error: (response) =>
        @setState
          displayMessage: true
          messageToDisplay: "Could not find that Happening. Please try again."

  render: ->
    if @state.feed != null
      feed = @state.feed
      settingsDisplay = @_settingsDisplay()
      happeningInfo = @_happeningInfo()
      imageDisplay = @_imageDisplay()

      userDisplay = @_userDisplay()
      captionDisplay = @_captionDisplay()

      toggleFullScreenButton = @_toggleFullScreenButton()

      `(
        <div id="targetDiv">
          <div className="vignette-top"></div>
          <div className="vignette-bottom"></div>

          <div className="join-settings">
            <div className="settings pull-right">
              {toggleFullScreenButton}
              <a className="glyphicon glyphicon-option-horizontal" aria-hidden="true" onClick={this._toggleSettings}></a>
              {settingsDisplay}
            </div>
            {happeningInfo}
          </div>


          {userDisplay}
          {captionDisplay}

          <div id="source">
            {imageDisplay}
          </div>
        </div>
      )`

    else if @state.displayMessage == true
      `(
        <div>
          <h3>{this.state.messageToDisplay}</h3>
          <button type="submit" className="btn btn-default" onClick={this.props.reset}>Reset</button>
        </div>
      )`

    else
      `(
        <div className="loading">
          <img src="loader.gif" />
        </div>
      )`

  _reset: ->
    window.location = "/view"

  _toggleFullScreenButton: ->
    if @state.fullScreen == false
      `<a className="glyphicon glyphicon-fullscreen" aria-hidden="true" onClick={this._launchFullScreen}></a>`
    else
      `<a className="glyphicon glyphicon-resize-small" aria-hidden="true" onClick={this._exitFullScreen}></a>`

  _launchFullScreen: ->
    @setState fullScreen: true
    launchIntoFullscreen document.documentElement

  _exitFullScreen: ->
    @setState fullScreen: false
    exitFullscreen document.documentElement

  _toggleSettings: ->
    @setState showSettings: !@state.showSettings

  _settingsDisplay: ->
    if @state.showSettings == true
      captionText = this._settingButtonText(this.state.showCaptions, "Captions")
      userInfoText = this._settingButtonText(this.state.showUserInfo, "User")
      joinCodeText = this._settingButtonText(this.state.showHapInfo, "Code")

      `(
        <div>
          <ul>
            <li>
              <a onClick={this._toggleSetting.bind(this, "showCaptions")}>{captionText}</a>
            </li>
            <li>
              <a onClick={this._toggleSetting.bind(this, "showUserInfo")}>{userInfoText}</a>
            </li>
            <li>
              <a onClick={this._toggleSetting.bind(this, "showHapInfo")}>{joinCodeText}</a>
            </li>
            <li>
              <a className="glyphicon glyphicon-log-out" aria-hidden="true" onClick={this._reset}>Leave</a>
            </li>
          </ul>
        </div>
      )`
    else
      ``

  _settingButtonText: (state, text) ->
    if state == true
      "Hide #{text}"
    else
      "Show #{text}"

  _toggleSetting: (setting, event) ->
    switch setting
      when 'showCaptions'
        @setState showCaptions: !@state.showCaptions
      when 'showUserInfo'
        @setState showUserInfo: !@state.showUserInfo
      when 'showHapInfo'
        @setState showHapInfo: !@state.showHapInfo

  _happeningInfo: ->
    feed = @state.feed

    if @state.showHapInfo == true
      `(
        <div className='join-key'>
          <div className='key'><span className='join-label'>Join:</span>{feed.join_key}</div>
          <div className='domain'>{feed.title} on haps.tv</div>
        </div>
      )`
    else
      ``

  _imageDisplay: ->
    feed = @state.feed

    for happening, index in feed.happenings
      `(
        <div className='image-container' key={index}>
          <img className='image-main' src={happening.photo_url} />
        </div>
      )`

  _showInfo: (src) ->
    happening = @_happeningFromSource(src)

    @setState currentHappening: happening

  _happeningFromSource: (src) ->
    for happening in @state.feed.happenings when happening.photo_url == src
      return happening

  _userDisplay: ->
    if @state.showUserInfo == true && @state.currentHappening != null
      happening = @state.currentHappening

      `(
        <div className='user'>
          <img className='img-circle pull-left' src={happening.user_image} width='80' />
          <h2>{happening.user_name}</h2>
        </div>
      )`

  _captionDisplay: ->
    if @state.showCaptions == true && @state.currentHappening != null
      happening = @state.currentHappening

      `(
        <div className='caption'>
          <h3>{happening.caption}</h3>
        </div>
      )`
