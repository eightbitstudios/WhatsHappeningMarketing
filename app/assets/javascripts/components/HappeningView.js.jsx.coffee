@HappeningView = React.createClass
  getInitialState: ->
    view: 'Start'

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
        `<HappeningStart />`
      when 'View'
        `<HappeningsDisplay />`