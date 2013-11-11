$(function() {
  ws = new WebSocket("ws://beco-ippei.net:3011/");
  ws.onopen = function() {
    ws.send("msg:connected");
  };
  ws.onmessage = function(e) {
    //TODO to json
    res = e.data.split(":");

    if (res[0] == 'msg') {
      $("#msg").html(res[1]);
    } else if (res[0] == 'status') {
      if (res[1] != '0') {
        $("#msg").html("try again!");
      } else {
        $("#msg").html("cleared !!!");
      }
      $("#input").val("");
      $("#history").append("<p>"+res[1]+"</p>");
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
});
