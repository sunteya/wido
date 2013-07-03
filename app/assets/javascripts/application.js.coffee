//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.turbolinks
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

