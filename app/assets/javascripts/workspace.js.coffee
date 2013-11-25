#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require ./bootstrap-datetimepicker.js
#= require bootstrap-tagsinput/dist/bootstrap-tagsinput.js

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

	# $('form').on 'click', '.add_fields', (event) ->
	# 	event.preventDefault()
	# 	time = new Date().getTime()
	# 	regexp = new RegExp($(this).data('id'), 'g')
	# 	content = $(this).data('fields').replace(regexp, time)

	# 	appendToTarget = $(this).data('append-to');
	# 	return $(content).appendTo(appendToTarget) if appendToTarget

	# 	insertBeforeTarget = $(this).data("insert-before");
	# 	return $(content).insertBefore(insertBeforeTarget) if insertBeforeTarget

	# 	$(this).before(content)

	$('.datepicker .input-group').datetimepicker
		language: 'zh-cn',
		pickTime: false


	$(document).on 'click.bs.tab.data-api', '.wd-tabs-radio > li > label', (event)->
		# event.preventDefault()
		$(this).tab('show')
