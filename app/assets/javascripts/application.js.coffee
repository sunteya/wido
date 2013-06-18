//= require jquery
//= require jquery_ujs
//= require bootstrap

jQuery ->
	$(document).on "submit", "#link-form-modal form", (event)->
		event.preventDefault()
		form = this
		$.ajax form.action, 
			type: form.method,
			data: $(form).serializeArray(),
			# dataType: "json",
			success: (data)->
				console.log(data)
				form.reset()
				$(form).closest(".modal").modal('hide')
				# location.reload() # TODO

	# event.stopPropagation().
	$(".list").on "click", "li", (event)->
		return if event.target.tagName == "A"

		url = $(this).data("url");
		location.href = url

