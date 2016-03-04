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
        <a className="glyphicon glyphicon-menu-left ghome" href="/"></a>
        <div className="row">
          <form>
            <div className="form-group">
              <h1>Enter Happening Code</h1>
              <input type="text"
                maxLength="4"
                autoFocus="true"
                ref="happeningCode"
                className="form-control"
                onChange={this._formUpdate}
                />
              <p><span>Codes are located at the top of&nbsp;</span><span>the stream in the app</span></p>
            </div>
            {errorDisplay}
            <button type="submit" className="btn btn-default" onClick={this._loadHappenings}>Join</button>
            <p className="ohno">Don't have a code? View one of ours:&nbsp;<strong><a onClick={this._loadDefaultHappening}>8b1t</a></strong></p>
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

  _loadDefaultHappening: ->
    @setState happeningCode: "8b1t"
    @setState view: 'View'

  _loadHappenings: (e) ->
    e.preventDefault()
    @setState showError: false

    if @state.happeningCode && @state.happeningCode?.length == 4
      @setState view: 'View'
    else
      @setState showError: true

