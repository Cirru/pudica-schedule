
define $ \ (require exports module)

  class Dispacher
    :constructor $ \ ()
      = @_queue (array)

    :addChangeListener $ \ (cb)
      if (not (in @_queue cb))
        do $ @_queue.push cb

    :emit $ \ ()
      for (@_queue index cb) (cb)

    :removeChangeListener $ \ (f)
      for (@_queue index cb)
        if (is cb f)
          do
            @_queue.splice index 1
            , break
