@HappeningsDisplay = React.createClass
  getInitialState: ->
    feed: null
    notFound: false

    showCaptions: true
    showUserInfo: true
    showHapInfo: true

    showSettings: false

  componentWillMount: ->
    @_loadHappenings()

  _initSlideshow: ->
    if $('#source').length > 0
#      $('#source').hide()
      $('.image-container .image-main').slideshowify()
      # working on making some cool shiz happen here
#      $('#source').bind('afterFadeIn'), $(e, img){ console.log('nyes') })

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

      `(
        <div id="targetDiv">
          <button type="submit" className="btn btn-default" onClick={this.props.reset}>Reset</button>

          <div>
            <a onClick={this._toggleSettings}>Settings</a>
            {settingsDisplay}
          </div>

          <h1>{feed.title}</h1>

          {happeningInfo}

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
          <div className='domain'>haps.tv</div>
          <div className='key'>{feed.join_key}</div>
        </div>
      )`
    else
      ``

  _imageDisplay: ->
    feed = @state.feed

    for happening, index in feed.happenings
      userDisplay = @_userDisplay(happening)
      captionDisplay = @_captionDisplay(happening)

      `(
        <div className='image-container' key={index}>
          {userDisplay}
          <img className='image-main' src={happening.photo_url} />
          {captionDisplay}
        </div>
      )`

  _userDisplay: (happening) ->
    if @state.showUserInfo == true
      `(
        <div className='user'>
          <img className='img-circle pull-left' src={happening.user_image} width='80' />
          <h2>{happening.user_name}</h2>
        </div>
      )`
    else
      ``

  _captionDisplay: (happening) ->
    if @state.showCaptions == true
      `(
        <div className='caption'>
          <h3>{happening.caption}</h3>
        </div>
      )`
    else
      ``
