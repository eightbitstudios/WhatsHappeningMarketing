@HappeningView = React.createClass
  getInitialState: ->
    view: 'Start'
    happeningCode: null

  render: ->
    selectedView = @_loadView()

    `(
      <div className='container'>
        <div className="row">
          <div className="col-md-12">
            {selectedView}
          </div>
        </div>
      </div>
    )`

  _loadView: ->
    switch @state.view
      when 'Start'
        @_enterCode()
      when 'View'
        `<HappeningsDisplay happeningKey={this.state.happeningCode} reset={this._reset} />`

  _enterCode: ->
    `(
      <div>
        <form>
          <div className="form-group">
            <label>Enter Happening Code</label>
            <input type="text"
              ref="happeningCode"
              className="form-control"
              onChange={this._formUpdate}
              />
          </div>
          <button type="submit" className="btn btn-default" onClick={this._loadHappenings}>Submit</button>
        </form>
      </div>
    )`

  _reset: (e) ->
    e.preventDefault()

    @setState view: 'Start'

  _formUpdate: ->
    @setState
      happeningCode: ReactDOM.findDOMNode(this.refs.happeningCode).value

  _loadHappenings: (e) ->
    e.preventDefault()

    if @state.happeningCode.length == 4
      @setState view: 'View'

