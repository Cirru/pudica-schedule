
define $ \ (require exports module)

  object

    :switch $ \ (name registry)
      evaluate (. registry name)

    :if $ \ (cond a b)
      do $ if cond
        do $ a
        do $ if (? b)
          do $ b

    :concat $ \ args
      = list (array)
      for (args index arg)
        if (? arg) (list.push arg)
      list.join ": "
