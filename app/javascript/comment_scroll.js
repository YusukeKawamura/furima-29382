function endComments() {
  const scroll = document.querySelector('.comments')
  scroll.scrollTop = scroll.scrollHeight
}

addEventListener("load", endComments)