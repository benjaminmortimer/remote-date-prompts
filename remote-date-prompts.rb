require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

colour_pairs = [
	{"background_colour" => "darkblue", "text_colour" => "white"},
	{"background_colour" => "hotpink", "text_colour" => "white"},
	{"background_colour" => "lightblue", "text_colour" => "black"},
	{"background_colour" => "lightgreen", "text_colour" => "black"},
]

verbs = [
	"take",
	"go",
	"put",
	"imagine",
	"remove"
]

nouns = [
	"your laptop",
	"it",
	"your favourite outfit",
	"lipstick",
	"someone else's business",
	"the nearest ornament"
]

endings = [
	"outside",
	"slowly",
	"boldly",
	"tenderly",
	"with gay abandon",
	"in an ambiguous way"
]

class Prompter
	def initialize(verbs, nouns, endings)
		@verbs = verbs
		@nouns = nouns 
		@endings = endings
	end

	def prompt
		@verbs.sample  + " " + @nouns.sample + " " + @endings.sample + ", " + @endings.sample
	end

end

class ColourPicker
	def initialize(colour_pairs)
		@colour_pairs = colour_pairs
		@colour_pair = colour_pairs.sample
	end

	def background 
		@colour_pair["background_colour"]
	end

	def foreground
		@colour_pair["text_colour"]
	end

	def new_pair
		@colour_pair = @colour_pairs.sample
	end
end

colour_picker = ColourPicker.new(colour_pairs)
prompter = Prompter.new(verbs, nouns, endings)

get '/' do
	erb :index, :locals => {
		:background_colour => colour_picker.background,
		:text_colour => colour_picker.foreground,
	}
end

get '/prompt' do 
	colour_picker.new_pair
	erb :prompt, :locals => {
		:background_colour => colour_picker.background,
		:text_colour => colour_picker.foreground,
		:prompt => prompter.prompt 
	}
end
