# TODO remove jquery dependence
# TODO implement meld js interface

advice =
	around: (base, wrapped) ->
		->
			args = $.makeArray(arguments)
			wrapped.apply(@, [$.proxy(base, @)].concat(args))

	before: (base, before) ->
		@around(base, ->
			args = $.makeArray(arguments)
			orig = args.shift()

			before.apply(@, args)
			orig.apply(@, args)
		)

	after: (base, after) ->
		@around(base, ->
			args = $.makeArray(arguments)
			orig = args.shift()
			res = orig.apply(@, args)
			after.apply(@, args)


			res
		)

mixin =
	before: (method, advicer) ->
		if typeof @[method] == 'function'
			@[method] = advice.before @[method], advicer

		throw new TypeError "Can only advice functions, attribute #{method} of #{@} is of type #{typeof @[method]}"
	after: (method, advicer) ->
		if typeof @[method] == 'function'
			@[method] = advice.after @[method], advicer

		throw new TypeError "Can only advice functions, attribute #{method} of #{@} is of type #{typeof @[method]}"
	around: (method, advicer) ->
		if typeof @[method] == 'function'
			@[method] = advice.around @[method], advicer

		throw new TypeError "Can only advice functions, attribute #{method} of #{@} is of type #{typeof @[method]}"

exports.mixin = (object) ->
  $.extend object, mixin
