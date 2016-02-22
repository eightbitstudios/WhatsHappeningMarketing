@HappeningsDisplay = React.createClass
  getInitialState: ->
    happenings: null

  componentWillMount: ->
    @_loadHappenings()

  _loadHappenings: ->
    # url = "https://whatshappening.eightbitstudios.com/api/v1/web_app/feeds/#{this.props.happening_key}"
    url = "http://localhost:3001/api/v1/web_app/feeds/#{this.props.happening_key}"

    $.ajax
      type: 'GET'
      dataType: 'json'
      url: url
      success: (response) =>
        @setState happenings: response.feed.happenings

      error: (response) ->
        console.log response

  render: ->
    `(
      <div>
        Hiya
      </div>
    )`
