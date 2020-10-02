function scroll() {
  const target = document.getElementById('comments')
  target.scrollIntoView(false)
}

addEventListener("load", scroll)