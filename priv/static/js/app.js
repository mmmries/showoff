function appendDrawing(drawing, collection){
  collection.append(createClickableExample(drawing));
}
function prependDrawing(drawing, collection){
  collection.prepend(createClickableExample(drawing));
}
function appendDrawings(drawings, collection){
  $.each(drawings, function(index, drawing){
    appendDrawing(drawing, collection);
  });
}

function createClickableExample(drawing){
  var example_div = $("<div class='example'></div>");
  example_div.html(drawing.svg);

  example_div.click(function(ev){
    ev.preventDefault();
    $('#drawing_text').val(drawing.drawing_text);
    $('#screen').html(drawing.svg);
  });
  return example_div;
}

function publishDrawing() {
  var drawing_text = document.getElementById("drawing_text").value;
  $('.error').text('');
  $.ajax({
    type: "POST",
    url: "/publish",
    data: {drawing_text: drawing_text},
    dataType: 'json',
    success: function(response){
      var screen = document.getElementById("screen");
      screen.innerHTML = response.svg;
    },
    error: failedToDraw
  });
}

function submitDrawing() {
  var drawing_text = document.getElementById("drawing_text").value;
  $('.error').text('');
  $.ajax({
    type: "POST",
    url: "/draw",
    data: {drawing_text: drawing_text},
    dataType: 'json',
    success: function(response){
      var screen = document.getElementById("screen");
      screen.innerHTML = response.svg;
    },
    error: failedToDraw
  });
}

function failedToDraw(error) {
  var message = "an error occured when trying to draw that shape";

  if( error.responseJSON && error.responseJSON.error ) {
    message = error.responseJSON.error;
  }

  $('.error').text(message);
}
