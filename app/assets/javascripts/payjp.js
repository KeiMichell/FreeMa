$(document).on('turbolinks:load', function(){
  
  Payjp.setPublicKey('pk_test_3ae9a2dfc10038c0229732f6');

  var form = $(".form");

  $("#charge-form").on("click",function() {
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
      number: $("#card_number").val(),
      cvc: $("#cvc").val(),
      exp_month: $("#exp_month").val(),
      exp_year: $("#exp_year").val(),
    };

    Payjp.createToken(card, function(status, response) {
      if (response.error){
        $("#charge-form").prop('disabled', false);
        alert("カード情報が正しくありません");
      } 
      else {
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id;
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
        alert("登録が完了しました");
      }
    });
  });
});