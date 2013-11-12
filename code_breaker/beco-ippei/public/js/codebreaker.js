$(function() {
  ws = new WebSocket("ws://beco-ippei.net:3011/");
  ws.onopen = function() {
    ws.send("msg:connected");
  };
  ws.onmessage = function(e) {
    var data = JSON.parse(e.data);
    var msg = data.msg;
    var status = data.status;

    if (msg) {
      $("#status").html(msg);
    } else if (status) {
      if (status != '++++') {
        $("#status").html("try again!").css("red");
      } else {
        $("#status").html("cleared !!!").css("green");
      }
      $("#input").val("");
      $("#history").append("<div class='box'>"+
        data.code+"<br>"+status+"</div>");
    }
  };

  ws.onclose = function() {
    console.log("socket closed.")
  };

  $("#input").keypress(function(e) {
    if(e.keyCode ==13) {
      var val = $("#input").val();
      ws.send('val:'+val);
    }
  });

  $("#input").focus();
});
