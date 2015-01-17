
define $ \ (require exports module)

  = React $ require :react

  = model $ require :../model

  = o React.DOM

  React.createFactory $ React.createClass $ object

    :displayName :DoneItem

    :onClick $ \ (event item)
      model.toggle @props.item.id

    :render $ \ ()
      o.div (object (:className ":item is-done"))
        o.span (object (:className :toggler) (:onClick @onClick)) ":↺"
        o.div (object (:className :text) (:type :text)) @props.item.text
