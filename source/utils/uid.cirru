
define $ \ (require exports module)

  = count 0

  = exports.make $ \ ()
    = date $ new Date
    = count $ + count 1

    ++: :_id- (date.getTime) :- count

  return exports
