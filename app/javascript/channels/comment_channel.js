import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.user_id == data.item_user_id) {
      const newContent = `${data.content.content}`
      const text = newContent.replace(/\n|\r\n|\r/g, '<br>')
      const html = `
        <div class="seller-content" id="content-${data.comment_id}">
          <div class="seller-content-box new">
            <p class="seller-nickname">${data.nickname}</p>
            <p class="seller-content">${text}</p>
          </div>
            <a class="seller-comment-destroy new" data-remote="true" rel="nofollow"
              data-method="delete" href="/items/${data.item_id}/comments/${data.comment_id}">削除</a>
        </div>`
      const comment = document.getElementById('comments')
      const newComment = document.getElementById('comment-content')
      comment.insertAdjacentHTML('beforeend', html)
      newComment.value = ''

    } else {
      const newContent = `${data.content.content}`
      const text = newContent.replace(/\n|\r\n|\r/g, '<br>')
      const html = `
        <div class="buyer-content" id="content-${data.comment_id}">
          <a class="buyer-comment-destroy new" data-remote="true" rel="nofollow"
            data-method="delete" href="/items/${data.item_id}/comments/${data.comment_id}">削除</a>
          <div class="buyer-content-box new">
            <p class="buyer-content">${text}</p>
            <p class="buyer-nickname">${data.nickname}</p>
          </div>
        </div>`
      const comment = document.getElementById('comments')
      const newComment = document.getElementById('comment-content')
      comment.insertAdjacentHTML('beforeend', html)
      newComment.value = ''
    }

    const scroll = document.querySelector('.comments')
    scroll.scrollTop = scroll.scrollHeight

    if (data.comments_size == 1) {
      $('#empty-content-box').fadeOut(900, function () {
        $(this).remove()
      })
    }
  }
})
