$(function(){
  function buildHTML(comment){
    let html = `<div class="commentBox__index">
                  <p class="commentBox__index__comment-name">${comment.user_name}</p>
                  <div class="commentBox__index__list-a">
                    <p>${comment.comment}</p>
                    <div class="commentBox__index__list-icon">
                      <div class="commentBox__index__list-icon__left">
                        <time datetime="${comment.created_at}">{{moment(${comment.created_at}).fromNow()}}</time>
                        <i class="fa fa-clock"></i>
                      </div>
                      <div class="commentBox__index__list-icon__right">
                        <a rel="nofollow" data-method="delete" href="/items/${comment.item_id}/comments/${comment.id}"><i class="fas fa-trash-alt"></i>
                        </a>
                      </div>
                    </div>
                  </div>
                </div>`
    return html;
  }
  $('#new-comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.commentBox-area').append(html);
      $('.commentBox__new').val('');
      $('.commentBox__btn').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})