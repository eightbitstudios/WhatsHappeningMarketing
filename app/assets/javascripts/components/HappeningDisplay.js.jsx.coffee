@HappeningsDisplay = React.createClass
  getInitialState: ->
    feed: null

  componentWillMount: ->
    @_loadHappenings()

  _loadHappenings: ->
    url = "https://whatshappening.eightbitstudios.com/api/v1/web_app/feeds/#{this.props.happening_key}"

    $.ajax
      type: 'GET'
      dataType: 'json'
      url: url
      success: (response) =>
        @setState feed: response.feed

      error: (response) ->
        console.log response

  render: ->
    if @state.feed != null
      feed = @state.feed
      `(
        <div>
          <h1>{feed.title}</h1>
          <h2>Happenings Count: {feed.happenings_count}</h2>
          <img src={feed.photo_url} width='1000'/>
        </div>
      )`

    else
      `(
        <div>
          <h5>Loading...</h5>
        </div>
      )`