@HappeningsDisplay = React.createClass
  getInitialState: ->
    feed: null
    notFound: false

    showCaptions: true
    showUserInfo: true
    showHapInfo: true

    showSettings: false

    currentHappening: null

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

  _loadHappenings: ->
    url = "https://whatshappening.eightbitstudios.com/api/v1/web_app/feeds/#{this.props.happeningKey}"

    $.ajax
      type: 'GET'
      dataType: 'json'
      url: url
      success: (response) =>
        @setState feed: response.feed

        @_initSlideshow()

      error: (response) =>
        @setState notFound: true

  render: ->
    if @state.feed != null
      feed = @state.feed
      settingsDisplay = @_settingsDisplay()
      happeningInfo = @_happeningInfo()
      imageDisplay = @_imageDisplay()

      userDisplay = @_userDisplay()
      captionDisplay = @_captionDisplay()

      `(
        <div id="targetDiv">
          <div className="vignette-top"></div>
          <div className="vignette-bottom"></div>

          <div className="join-settings">
            {happeningInfo}
            <div className="settings">
              <a className="glyphicon glyphicon-flash" aria-hidden="true" onClick={this._toggleSettings}>Settings</a>
              {settingsDisplay} 
              <a className="glyphicon glyphicon-log-out" aria-hidden="true" onClick={this._reset}></a>
            </div>
          </div>

          
          {userDisplay}
          {captionDisplay}

          <div id="source">
            {imageDisplay}
          </div>
        </div>
      )`

    else if @state.notFound == true
      `(
        <div>
          <h3>Could not find that Happening. Please try again.</h3>
          <button type="submit" className="btn btn-default" onClick={this.props.reset}>Reset</button>
        </div>
      )`

    else
      `(
        <div>
          <h5>Loading...</h5>
        </div>
      )`

  _reset: ->
    window.location = "/view"

  _toggleSettings: ->
    @setState showSettings: !@state.showSettings

  _settingsDisplay: ->
    if @state.showSettings == true
      `(
        <div>
          <ul>
            <li>
              <a onClick={this._toggleSetting.bind(this, "showCaptions")}>Show Captions</a>
            </li>
            <li>
              <a onClick={this._toggleSetting.bind(this, "showUserInfo")}>Show User Info</a>
            </li>
            <li>
              <a onClick={this._toggleSetting.bind(this, "showHapInfo")}>Show Happening Join Code</a>
            </li>
          </ul>
        </div>
      )`
    else
      ``

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
          <div className='key'><span>Join:</span> {feed.join_key}</div>
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
