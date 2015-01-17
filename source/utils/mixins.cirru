
define $ \ (require exports module)

  -- https://github.com/facebook/react/issues/1694

  = exports.listenTo $ object
    :componentWillMount $ \ ()
      = @listeners (array)

    :listenTo $ \ (store fn)
      store.addChangeListener fn
      @listeners.push $ object
        :remove $ \ ()
          store.removeChangeListener fn

    :componentWillUnmount $ \ ()
      @listeners.forEach $ \ (listener)
        listener.remove

  return exports