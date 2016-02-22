@HappeningsDisplay = React.createClass
  getInitialState: ->
    happeningKey: @props.key

  render: ->
    console.log @state
    console.log @props

    `(
      <div>
        Hiya
      </div>
    )`
