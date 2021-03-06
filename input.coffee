class Input extends Layer
	@define "style",
		get: -> @input.style
		set: (value) ->
			_.extend @input.style, value

	@define "value",
		get: -> @input.value
		set: (value) ->
			@input.value = value

	constructor: (options = {}) ->
		options.setup ?= false
		options.width ?= 20
		options.clip ?= false
		options.height ?= 30
		options.backgroundColor ?= if options.setup then "rgba(255, 255, 255, .8)" else "transparent"
		options.fontSize ?= 26
		options.lineHeight ?= 26
		options.padding ?= 10
		options.text ?= ""
		options.placeholder ?= ""
		options.type ?= "text"
		options.goButton ?= false

		super options

		@placeholderColor = options.placeholderColor if options.placeholderColor?
		@input = document.createElement "input"
		@input.id = "input-#{_.now()}"
		@input.style.cssText = "font-size: #{options.fontSize}px; line-height: #{options.lineHeight}px; padding: #{options.padding}px; width: #{options.width}px; height: #{options.height}px; border: 1px solid #000; outline-width: 0; background-image: url(about:blank); background-color: #{options.backgroundColor};"
		@input.value = options.text
		@input.type = options.type
		@input.placeholder = options.placeholder
		@form = document.createElement "form"

		if options.goButton
			@form.action = "#"
			@form.addEventListener "submit", (event) ->
				event.preventDefault()
				print @input.value

		@form.appendChild @input
		@_element.appendChild @form

		@backgroundColor = "transparent"
		@updatePlaceholderColor options.placeholderColor if @placeholderColor


	updatePlaceholderColor: (color) ->
		@placeholderColor = color
		if @pageStyle?
			document.head.removeChild @pageStyle
		@pageStyle = document.createElement "style"
		@pageStyle.type = "text/css"
		css = "##{@input.id}::-webkit-input-placeholder { color: #{@placeholderColor}; }"
		@pageStyle.appendChild(document.createTextNode css)
		document.head.appendChild @pageStyle

	focus: () ->
		@input.focus()
