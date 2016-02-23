@HappeningsDisplay = React.createClass
  getInitialState: ->
    feed: null
    notFound: false

  componentWillMount: ->
    @_loadHappenings()

  # componentDidUpdate: ->
  #   if $('#source').length > 0
  #     $('#source img').slideshowify({ parentEl:'#targetDiv' })

  _loadHappenings: ->
    url = "https://whatshappening.eightbitstudios.com/api/v1/web_app/feeds/#{this.props.happeningKey}"

    $.ajax
      type: 'GET'
      dataType: 'json'
      url: url
      success: (response) =>
        @setState feed: response.feed

      error: (response) =>
        @setState notFound: true

  render: ->
    if @state.feed != null
      feed = @state.feed
      imageDisplay = @_imageDisplay()

      `(
        <div>
          <h1>{feed.title}</h1>
          <div id="targetDiv"></div>

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

  _imageDisplay: ->
    feed = @state.feed

    for happening, index in feed.happenings
      `(
        <div className='image-container' key={index}>
          <h2>{happening.user_name}</h2>
          <img src={happening.user_image} width='50' />
          <img src={happening.photo_url} />
          <h3>{happening.caption}</h3>
        </div>
      )`

