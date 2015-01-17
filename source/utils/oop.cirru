
define $ \ (require exports module)

  = exports.mixin $ \ (obj proto)
    of (proto key value)
      = (. obj key) value
    return obj

  return exports
