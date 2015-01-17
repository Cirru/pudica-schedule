
define $ \ (require exports module)

  = React $ require :react

  = o React.DOM
  = extend $ require :../utils/extend

  = model   $ require :../model
  = mixins  $ require :../utils/mixins

  = Item      $ require :./item
  = DoneItem  $ require :./done-item

  React.createFactory $ React.createClass $ object
    :displayName :App
    :mixins $ array mixins.listenTo

    :getInitialState $ \ ()
      object
        :schedule (model.get)
        :dragging null

    :componentDidMount $ \ ()
      @listenTo model this._onChange

    :_onChange $ \ ()
      this.setState $ object (:schedule (model.get))

    :clearTask $ \ ()
      model.clear

    :swapItems $ \ (itemId)
      model.swap this.state.dragging itemId

    :dragItem $ \ (itemId)
      this.setState $ object (:dragging itemId)

    :releaseDrag $ \ ()
      this.setState $ object (:dragging null)

    :render $ \ ()
      = isListRich $ > @state.schedule.length 0
      = itemsList @state.schedule
      = itemsList $ itemsList.filter $ \ (item) (not item.done)
      = itemsList $ itemsList.map $ \ (item)
        = dragging $ is @state.dragging item.id
        Item $ object
          :key item.id
          :item item
          :isDragging dragging
          :onDragStart @dragItem
          :onDragEnd @releaseDrag
          :onDragStart @dragItem

      = doneList @state.schedule
      = doneList $ doneList.filter $ \ (item) item.done
      = doneList $ doneList.map $ \ (item)
        DoneItem $ object (:key item.id) (:item item)

      if isListRich
        do $ o.div (object (:id :paper))
          o.div (object (:id :items-all))
            if (> itemsList.length 0)
              o.div (object (:className ":board is-active"))
                o.div (object (:className title)) ":To be done:"
                , itemsList
            if (> doneList.length 0)
              o.div (object (:className ":board is-done"))
                o.div (object (:className :title)) ":Already finished:"
                , doneList
          o.div (object (:id clear))
            o.div (object (:className :trigger) (:onClick @clearTask)) ":⌫"
        do $ o.div (object (:id :paper))
          o.div (object (:id :start-guide)) ":Press Enter to start..."
