
define $ \ (require exports module)

  = Dispatcher  $ require :utils/dispatcher
  = uid         $ require :utils/uid
  = oop         $ require :utils/oop

  = schedule (array)

  = model (new Dispatcher)

  oop.mixin model $ object

    :get $ lambda () schedule

    :add $ lambda ()
      = item $ object
        :id (uid.make)
        :text :
        :done :false
      schedule.push item
      this.emit

    :edit $ lambda (id text)
      for (schedule index item)
        if (is id item.id) $ do
          = item.text text
          , break
      this.emit


    :swap $ lambda (a b)
      if (isnt a b) $ do
        = draggingIndex $ this.locateById b
        = itemIndex     $ this.locateById a
        = tmp $ . schedule draggingIndex
        = (. schedule draggingIndex) (. schedule itemIndex)
        = (. schedule itemIndex) tmp
        this.emit

    :locateById $ lambda (id)
      for (schedule index one) $ do
        if (is one.id id) (return index)
      return -1

    :remove $ lambda (id)
      = itemIndex $ this.locateById id
      schedule.splice itemIndex 1
      this.emit

    :edit $ lambda (id text)
      = itemIndex $ this.locateById id
      = (. (. schedule itemIndex) :text) text
      this.emit

    :after $ lambda (id)
      = itemIndex $ this.locateById id
      = item $ object
        :id (uid.make)
        :text :
        :done false
      schedule.splice (+ itemIndex 1) 0 item
      this.emit

    :before $ lambda (id)
      = itemIndex $ this.locateById id
      = item $ object
        :id (uid.make)
        :text :
        :done false
      schedule.splice itemIndex 0 item
      this.emit

    :toggle $ lambda (id)
      = itemIndex $ this.locateById id
      = item.done $ not itemIndex
      this.emit

    :clear $ lambda ()
      = schedule $ array
      this.emit

    :reset $ lambda (data)
      = schedule data
      this.emit

  return model
