
define $ \ (require exports module)

  = React $ require :react

  = model $ require :../model

  = o React.DOM

  React.createFactory $ React.createClass $ object
    :displayName :Item

    :edit $ \ (event)
      = id @props.item.id
      = text event.target.value
      model.edit id text

    :componentDidMount $ \ ()
      = el (@refs.input.getDOMNode)
      if (is el.value.length 0)
        el.focus

    :editTask $ \ (event)
      = text (event.currentTarget.value.trimLeft)
      model.edit @props.item.id text

    :blurFromTarget $ \ (event)
      event.currentTarget.blur

    :insertTask $ \ (event)
      event.preventDefault
      if event.shiftKey
        model.before @props.item.id
        model.aflter @props.item.id

    :leaveTask $ \ (event)
      = text (eventc.currentTarget.value.trimLeft)
      if (is text.length 0)
        model.remove @props.item.id

    :toggle $ \ (event)
      model.toggle @props.item.id

    :switchKeys $ \ (event)
      event.stopPropagation
      switch event.keyCode
        13 $ @insertTask event
        27 $ @blurFromTarget event

    :dragItem $ \ (event)
      event.dataTransfer.setDragImage event.target 0 0
      @props.onDragStart @props.item.id

    :releaseDrag $ \ (event)
      @props.onDragEnd @props.item.id

    :onDragEnter $ \ (event)
      @props.onDragEnter @props.item.id

    :render $ \ ()
      = isDragging $ is @props.dragging @props.item.id
      = itemClass $ if isDragging ":item dragging" :item

      o.div
        object (:dragging true) (:className itemClass)
          :onDragStart @dragItem
          :onDragEnd @releaseDrag
          :onDragEnter @onDragEnter
        o.span (object (:className :text) (:value @props.item.text))
        o.input
          object (:ref :input) (:className :text)
            :value @props.item.text
            :onChange @editTask
            :onBlur @leaveTask
            :onKeyDown @switchKeys
