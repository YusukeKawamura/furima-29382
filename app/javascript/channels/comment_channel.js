import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.user_id == data.item_id) {
      const newContent = `${data.content.content}`
      const text = newContent.replace(/\n|\r\n|\r/g, '<br>')
      const html = `
      <div class="seller-content-box">
        <p class="seller-nickname">${data.nickname}</p>
        <p class="seller-content">${text}</p>
      </div>`
      const comment = document.getElementById('comments')
      const newComment = document.getElementById('comment-content')
      const scroll = document.querySelector('.comments')
      comment.insertAdjacentHTML('beforeend', html)
      newComment.value = ''
      scroll.scrollTop = scroll.scrollHeight

    } else {
      const newContent = `${data.content.content}`
      const text = newContent.replace(/\n|\r\n|\r/g, '<br>')
      const html = `
      <div class="buyer-content-box">
        <p class="buyer-content">${text}</p>
        <p class="buyer-nickname">${data.nickname}</p>
      </div>`
      const comment = document.getElementById('comments')
      const newComment = document.getElementById('comment-content')
      const scroll = document.querySelector('.comments')
      comment.insertAdjacentHTML('beforeend', html)
      newComment.value = ''
      scroll.scrollTop = scroll.scrollHeight
    }
  }
})
