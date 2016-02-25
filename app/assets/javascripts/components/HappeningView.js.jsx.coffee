@HappeningView = React.createClass
  getInitialState: ->
    view: 'Start'
    happeningCode: null

    showError: false

  render: ->
    selectedView = @_loadView()

    `(
      <div>
        {selectedView}
      </div>
    )`

  _loadView: ->
    switch @state.view
      when 'Start'
        @_enterCode()
      when 'View'
        `<HappeningsDisplay happeningKey={this.state.happeningCode} reset={this._reset} />`

  _enterCode: ->
    errorDisplay = @_errorDisplay()

    `(
      <div className='enter-code'>
        <div className="navbar navbar-collapse">
          <ul className="nav navbar-nav">
            <li>
              <a className="glyphicon glyphicon-menu-left ghome" href="/"></a>
            </li>
          </ul>
          <ul className="nav navbar-nav pull-right">
            <li>
              <a href="http://eightbitstudios.com">Download</a>
            </li>
          </ul>
        </div>
        <div className="row">
          <form>
            <div className="form-group">
              <h1>Enter Happening Code</h1>
              <input type="text"
                maxLength="4"
                ref="happeningCode"
                className="form-control"
                onChange={this._formUpdate}
                />
              <p>Codes are located at the top of the stream in the app</p>
            </div>
            {errorDisplay}
            <button type="submit" className="btn btn-default" onClick={this._loadHappenings}>Join</button>
            <p className="ohno">Don't have a code? View one of ours: <strong>ce61</strong></p>
          </form>
        </div>
      </div>
    )`

  _errorDisplay: ->
    if @state.showError == true
      `(
        <p>
          Please enter in a 4-digit Happening Code.
        </p>
      )`

  _reset: (e) ->
    e.preventDefault()

    @setState view: 'Start'

  _formUpdate: ->
    @setState
      happeningCode: ReactDOM.findDOMNode(this.refs.happeningCode).value

  _loadHappenings: (e) ->
    e.preventDefault()
    @setState showError: false

    if @state.happeningCode && @state.happeningCode?.length == 4
      @setState view: 'View'
    else
      @setState showError: true

