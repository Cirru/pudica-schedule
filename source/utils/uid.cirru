
define $ \ (require exports module)

  = date $ . (new Date) :getTime
  = count 0

  = exports.make $ \ ()
    = count $ + count 1

    ++: :_id- date :- count

  return exports
