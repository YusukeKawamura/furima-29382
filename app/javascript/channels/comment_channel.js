import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `
    <div class="seller-content-box">
      <p class="seller-nickname"></p>
      <p class="seller-content">${data.content.content}</p>
    </div>`
    const comment = document.getElementById('comments')
    const newComment = document.getElementById('comment_content')
    comment.insertAdjacentHTML('beforeend', html)
    newComment.value = ''
  }
});
