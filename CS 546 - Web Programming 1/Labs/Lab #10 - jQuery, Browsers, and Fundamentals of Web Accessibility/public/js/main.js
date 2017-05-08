(function($) {

  const theForm = $("#email-form");
  const theEmail = $("#the-email");     // error 1 - id tag was not present in the index page
  const theMessage = $("#the-message"); // error 2 - id tag was not present in the index page
  const theResult = $(".the-result");   // error 3 - used incorrect notation to use class name

  theForm.submit(e => {
    e.preventDefault();
  
    const formData = {
      email: theEmail.val(),
      message: theMessage.val()
    };

    $.ajax({
      type: "POST",
      url: "/",
      data: JSON.stringify(formData),
      success: function(data) {
        theResult.html(data.reply);	//
      },
      contentType: "application/json",
      dataType: "json"
    });
  });
})(jQuery); // jQuery is exported as $ and jQuery
