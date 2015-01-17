
define $ \ (require exports module)

  = React $ require :react

  = model $ require :./model

  = App $ require :./view/app

  React.render (App (object)) document.body

  try $ do
    = raw $ localStorage.getItem :pudica
    = data $ or (JSON.parse raw) (array)
    model.reset data

  = window.onbeforeunload $ lambda ()
    = raw $ JSON.stringify (model.get)
    localStorage.setItem :pudica raw

  document.body.addEventListener :keydown $ lambda (event)
    if
      and (is event.keyCode 13) (is event.currentTarget this)
      do
        model.add
