### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ bc532cd2-c75b-11ea-313f-8b5e771c9227
md"""# Image Filter 

The [Interactivity sample notebook](./sample/Interactivity.jl) explains how Pluto notebooks can use **`@bind`** to add _interactivity_ to your notebook. It's a simple concept - it uses the same reactivity that you have when editing code, except now you use sliders and buttons, instead of editing code.

However, code like

```julia
@bind x html"<input type=range min=5 max=15>"
```
is hard to memorize, so `PlutoUI` makes it more _Julian_:
```julia
@bind x Slider(5:15)
```
"""

# ╔═╡ 6ba59924-7089-44f3-ad16-fbe9cae123c0
url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK94qVLqAGYCjRWm7ze_w0Acl7nXsawILuGnZL3_Jo2Zje_uendS_aNSZcqcz4-V4PDkg&usqp=CAU"

# ╔═╡ 8b1bbb06-ede1-455b-8bd6-040170b3ae46
file = download(url)

# ╔═╡ 25de5be5-4ed1-4fdd-87ab-50582ef599bc
files = load(file)

# ╔═╡ 53777671-61aa-4536-833d-759ec375bf32
size(files)

# ╔═╡ 1e72c70a-8763-46ff-b496-3b53465e7c96
files[50, 50:100]

# ╔═╡ 3eff9592-cc63-11ea-2b61-4170d1a7656a


# ╔═╡ 051f31fc-cc63-11ea-1e2c-0704285ea6a9
md"""
#### Image filtering using kernels
Simply import the `Kernel` package, like gaussian
"""

# ╔═╡ fddb794c-c75c-11ea-1f55-eb9c178424cd
md"""
# Basics
"""

# ╔═╡ b819e9a8-c760-11ea-11ee-dd01da663b5c
md"## Slider"

# ╔═╡ a4488984-c760-11ea-2930-871f6b400ef5
kernel = Kernel.sobel()[2]


# ╔═╡ 1048d1e0-cc50-11ea-1bf3-d76cae42740a
sum(kernel)

# ╔═╡ bdae5599-81ff-47f5-9925-69b05cb04160
 kernelize(M) = OffsetArray( M, -1:1, -1:1)	    

# ╔═╡ fe2e1774-1624-4b89-b45d-1d9bcf576273
begin
	identity = [0 0 0 ; 0 1 0 ; 0 0 0]
	edge_detect = [0 -1 0; -1 4 -1; 0 -1 0]  
	box_blur = [1 1 1;1 1 1;1 1 1]/9
	∇x = [-1 0 1;-1 0 1;-1 0 1]/2 # centered deriv in x
	∇y = ∇x'
	
	kernels = [identity, edge_detect, box_blur, ∇x, ∇y]
	kernel_keys =["identity", "edge_detect", "box_blur", "∇x", "∇y"]
	selections = kernel_keys .=> kernel_keys
	kernel_matrix = Dict(kernel_keys .=> kernels)
	md"$(@bind kernel_name Select(selections))"
end

# ╔═╡ a709fd2e-c760-11ea-05c5-7bf673990de1
md"The first argument is a `Vector` or range. You can set the _default value_ using a keyword argument:"

# ╔═╡ 6275654d-ef01-43c5-aa01-b759a56ff1cb
kernel_matrix[kernel_name]

# ╔═╡ 9934973e-7291-4f6e-bc2c-90ad3e093f24
[imfilter( files, kernel_matrix[kernel_name])]

# ╔═╡ 00b9e0ba-3803-4f23-a03d-882ebd3dc6ae


# ╔═╡ 06962cde-cc4f-11ea-0d96-69a8cb7eeda2


# ╔═╡ 6605d010-d0d1-4cc8-a34d-3158b8572b5d
md"""
## Scrubbable

`Scrubbable` makes a number interactive, you can **click and drag** its value left or right. 

Try it in the text below:
"""

# ╔═╡ 756e2c82-6e2f-4d7b-a1ed-5de97be04269
md"""
_If Alice has $(@bind a Scrubbable(20)) apples, 
and she gives $(@bind b Scrubbable(3)) apples to Bob..._
"""

# ╔═╡ c07c5a9e-61f9-4247-86e7-7c3f9956d0ff
md"""
_...then Alice has **$(a - b)** apples left._
"""

# ╔═╡ c3fea1b2-fc11-4c19-9c01-a8e03fda2817
md"""
Use the Live Docs to learn more about `Scrubbable`!
"""

# ╔═╡ 221c308e-3cbe-4689-aa67-8970957f8cb0


# ╔═╡ e49623ac-c760-11ea-3689-c15f2e2f6081
md"## NumberField

A `NumberField` can be used just like a `Slider`, it just looks different:"

# ╔═╡ 314cb85a-c761-11ea-1cba-b73f84a52be8
@bind x_different NumberField(0:100, default=20)

# ╔═╡ ec4d1451-f4e0-410e-bcb5-92c93a3ef80a


# ╔═╡ 104b55ce-cc4f-11ea-1273-092a1717e399


# ╔═╡ 4513b730-c761-11ea-1460-2dca56081fcf
md"## CheckBox"

# ╔═╡ 4f8e4e1e-c761-11ea-1787-419cab59bb12
@bind z CheckBox()

# ╔═╡ b787ead6-c761-11ea-3b17-41c0a5434f9b
z

# ╔═╡ 177e6bf0-cc50-11ea-0de2-e77544f5c615


# ╔═╡ b08c347e-c761-11ea-1b61-7b69631d078b
md"Default value:"

# ╔═╡ b53c8ffa-c761-11ea-38d1-2d4ad96a7bee
@bind having_fun CheckBox(default=true)

# ╔═╡ adcf4e68-c761-11ea-00bb-c3b15c6dedc0
having_fun

# ╔═╡ 1a562ad4-cc50-11ea-2485-cdec6e1a78dc


# ╔═╡ 5d420570-c764-11ea-396b-cf0db01d34aa
having_fun ? md"🎈🎈" : md"☕"

# ╔═╡ 09393bf2-cc4f-11ea-1e48-cfbedab8e6b4


# ╔═╡ cd1b5872-c761-11ea-2179-57a3cb34d235
md"## TextField"

# ╔═╡ d9e85ed0-c761-11ea-30bf-83ce272526e0
@bind s TextField()

# ╔═╡ e4c262d6-c761-11ea-36b2-055419bfc981
s

# ╔═╡ 0934bc0c-cc50-11ea-0da8-0d6b2f275399


# ╔═╡ e690337c-c761-11ea-08be-ade40a464eb4
md"With a default value:"

# ╔═╡ f1f83980-c761-11ea-1e34-97c0ffca3f67
@bind sentence TextField(default="te dansen omdat men leeft")

# ╔═╡ f985c8de-c761-11ea-126c-1fd79d547b79
sentence

# ╔═╡ 1cbfd28e-cc50-11ea-2c90-a7807e4979ef


# ╔═╡ 0136af80-c762-11ea-2f1a-9dccff334a11
md"You can also create a **multi-line** text box!"

# ╔═╡ 0e6f0508-c762-11ea-0352-09bd694a9b35
@bind poem TextField((30, 3), "Je opent en sluit je armen,\nMaar houdt niets vast.\nHet is net zwemmen")

# (poem by: Sanne de Kroon)

# ╔═╡ 3dcd7002-c765-11ea-323d-a1fb49409011
split(poem, "\n")

# ╔═╡ 0aa3c85e-cc4f-11ea-2fba-4bdd513d9217


# ╔═╡ 5833f7f4-c763-11ea-0b95-9b21a40192a9
md"## Select"

# ╔═╡ 690cf3ac-c763-11ea-10f0-b3e28c380be9
@bind vegetable Select(["potato", "carrot"])

# ╔═╡ 705662e2-c763-11ea-2f6d-cdaffc1fc73a
vegetable

# ╔═╡ 1feebd8f-667a-42fd-965d-5e3167ff7c7a
@bind favourite_function Select([sin, cos, tan, sqrt])

# ╔═╡ 9128d2c1-364c-4446-baaa-6d0593edda47
favourite_function(2)

# ╔═╡ 3930f0d8-cc50-11ea-3de6-d91ac5c6cd9f


# ╔═╡ 787a2c88-c763-11ea-0a32-bb91ca60113d
md"Instead of an array of values, you can also give an array of **pairs**, where the first item is the bound value, and the second item is displayed. "

# ╔═╡ ac8c4dee-c763-11ea-1b2d-c590a2d50d7e
@bind fruit Select(["apple" => "🍎", "melon" => "🍉"])

# ╔═╡ dcda9ad2-c763-11ea-3ec6-093b823ba66d
fruit

# ╔═╡ 0c3ab1f8-cc4f-11ea-0cfb-8f076d2c9836


# ╔═╡ 62c6f866-f0fe-11ea-0961-319f28d040d4
md"""
## MultiSelect

This widget allows the user to select multiple element by holding `Ctrl` / `Cmd` while clicking a more items.
"""

# ╔═╡ a01c8096-f0fe-11ea-3e78-ad8551e84fa1
@bind vegetable_basket MultiSelect(["potato", "carrot", "boerenkool"])

# ╔═╡ a20e30f2-f0fe-11ea-0ca7-c5195c9eb24a
vegetable_basket

# ╔═╡ c819ef3e-f0fe-11ea-1213-9df7597e4e89
md"Just like `Select`, you can also give an array of pairs."

# ╔═╡ b104ba6d-0293-4378-9652-f628f1d08d97
md"""
## MultiCheckBox

This widget allows the user to select multiple elements using checkboxes.
"""

# ╔═╡ 16f2218d-f1bc-4b34-a355-53acfa77fbf5
@bind fruit_basket MultiCheckBox(["apple", "blueberry", "mango"])

# ╔═╡ 2c7811cb-d9ea-470c-8cb7-2b3803489f3f
fruit_basket

# ╔═╡ 78be41d1-7dda-4bec-b75f-fbcf8b7594a7
md"""
You can use `MultiSelect` and `MultiCheckBox` with any vector of objects, not just strings:
"""

# ╔═╡ 90d84f1b-042c-444e-8bac-fe358b6d68a1
@bind my_functions MultiCheckBox([sin, cos, tan])

# ╔═╡ b97cfb04-0c39-4709-9419-9294e677a872
[f(π) for f in my_functions]

# ╔═╡ 283d1177-c605-4652-905b-9a70354cf878
md"Just like `Select`, you can also give an array of pairs. See the Live Docs for `MultiCheckBox` for all the customization options!"

# ╔═╡ 0b1ce22e-c764-11ea-3d60-e799d58aee30
md"## Button"

# ╔═╡ 6d9108a8-c765-11ea-0a38-09a1364998b1
@bind clicked Button("Hello world")

# ╔═╡ 7a14e496-c765-11ea-20a1-6fb960009251
clicked

# ╔═╡ 3eff932a-cc50-11ea-366e-812d3854dd4c


# ╔═╡ 7e10fb52-c765-11ea-2a71-0fc347d09885
md"""
### Button as reactive trigger

In the example above, _any cell that references `clicked` will re-evaluate_ when you click the button. This means that you can a button as a **reactive trigger**, by referencing its value in another cell.
"""

# ╔═╡ b91764e8-c765-11ea-27a2-4ba5777fbd89
@bind go Button("Recompute")

# ╔═╡ bb356b12-c765-11ea-2c36-697f4314bb93
let
	go
	
	md"I am $(rand(1:15)) years old!"
end

# ╔═╡ 9276da28-cc4f-11ea-17b3-65eec41a181e


# ╔═╡ 92def54a-cc4f-11ea-12c5-652f2bb46413
md"## FilePicker"

# ╔═╡ 9920e56c-cc4f-11ea-2d5e-f5371c79f048
@bind important_document FilePicker()

# ╔═╡ 44591b34-cc50-11ea-2005-2f7075e6f2db
important_document

# ╔═╡ 4fda3072-cc50-11ea-2804-197b6391b269
md"The file picker is useful if you want to show off your notebook on a dataset or image **uploaded by the reader**. It will work anywhere - you don't access files using their path.

The caveat is that large files might take a long time to get processed: everything needs to pass through the browser. If you are using large datasets, a better option is to use `Select` to let the reader pick a filename. You can then read the file using `Base.read(filename, type)`"

# ╔═╡ 3e5dd7d2-c760-11ea-1dca-6d8720b3558d
md"# Extras"

# ╔═╡ f31668c6-c768-11ea-1501-5f41afa7c83b
md"## Clock"

# ╔═╡ 417390ba-c760-11ea-27df-5908858ae88c
@bind t Clock()

# ╔═╡ 49e7cd06-c760-11ea-3f5d-2741d94278a6
t

# ╔═╡ 31a2f3c4-cc51-11ea-3652-bd814517a4b5


# ╔═╡ 67709812-c760-11ea-2bda-9756ead35749
md"You can set the interval (`5.0` seconds), and disable the UI (`true`):"

# ╔═╡ 4c2b45a0-c760-11ea-2b64-3fefc820cd5b
@bind t_slow Clock(5.0, true)

# ╔═╡ 5be148cc-c760-11ea-0819-a7bb403d27ff
t_slow

# ╔═╡ 347e3d06-cc51-11ea-012c-43e824eaffa2


# ╔═╡ 343d7118-cc51-11ea-387a-fb22d8c73506
md"You can use a `Clock` to drive an animation! Or use it to repeat the same command at an interval: just like with `Button`, you can reference a bound (reactive) variable without actually using it!"

# ╔═╡ 32e41ac2-cc51-11ea-3358-bbead9c68123


# ╔═╡ f74f434a-c768-11ea-079c-fb707e6ba17b
md"## DownloadButton"

# ╔═╡ ea00721c-cc4b-11ea-1e82-0b3dbe6a7f1e
md"""
The download button is not an **input** element that you can `@bind` to, it's an **output** that you can use to get processed data from your notebook easily. The second argument is the _output filename_.
"""

# ╔═╡ fc12280c-c768-11ea-3ebc-ebcd6b3459c1
DownloadButton(poem, "poem.txt")

# ╔═╡ 067cbcde-cc4c-11ea-3eed-972dc6d7bb3b
DownloadButton([0x01, 0x02, 0x03], "secret_data.bin")

# ╔═╡ 7da30d97-b28a-4eb9-a2ef-fad599b549d1
md"""
# High-level inputs
"""

# ╔═╡ 170089cd-f366-4c0a-b58d-fe6e36049db7
md"""
## Confirm

Normally, when you move a [`Slider`](@ref) or type in a [`TextField`](@ref), all intermediate values are sent back to `@bind`. By wrapping an input element in `confirm`, you get a button to manually **control when the value is sent**, intermediate updates are hidden from Pluto.

"""

# ╔═╡ b29215cb-8e7e-4382-822c-cdaa4c473ba1
@bind distance confirm(Slider(1:100))

# ╔═╡ 00f9f608-85bd-4932-b585-39f74dcf53b4
distance

# ╔═╡ 48a9ffbd-cac7-4c4e-85e5-c3d0693e5550
md"""
`confirm` can be wrapper around any input element to create a new one, including inputs from other packages, or inputs that you have made yourself!
"""

# ╔═╡ 5c85ee41-da68-4f5f-b45e-e1de7996747d


# ╔═╡ 8c51343f-cb35-4ff9-9fd8-642ffab57e22
md"""
## Combine

This next high-level component is a bit tricky, but very powerful!

Using `combine`, you can create a single input out of multiple existing ones! In the example below, we create a new input, `wind_speed_input`. Notice that the list of wind directions is *dynamic*: if you add a new direction, a 5th slider will appear!

"""

# ╔═╡ 621f2e82-5ab4-4ab9-a0ff-fb1cc1b41295
import PlutoUI: combine

# ╔═╡ a4837897-caae-447a-8db9-7775e7a4d0c8


# ╔═╡ d278189e-6a5b-428a-8c81-ce3d206b042c
function wind_speed_input(directions::Vector)
	
	return combine() do Child
		
		inputs = [
			md""" $(name): $(
				Child(name, Slider(1:100))
			)"""
			
			for name in directions
		]
		
		md"""
		#### Wind speeds
		$(inputs)
		"""
	end
end

# ╔═╡ f5c421cc-dbdb-459a-9bb4-d648507a87d2
@bind speeds wind_speed_input(["North", "East", "South", "West"])

# ╔═╡ a4eac824-ba87-473a-b39a-783c4de3f933
speeds

# ╔═╡ f9052ed8-84cc-4cca-abb2-9363aafc6040
speeds.North

# ╔═╡ 4ca9c749-08ee-467f-af2c-9b2f13199d72
md"""
Use the Live Docs to learn more about `combine` and to see additional examples. 

> 🙋 `combine` is very useful in combination with [HypertextLiteral.jl](https://github.com/MechanicalRabbit/HypertextLiteral.jl), which you can learn using our JavaScript sample notebook. 
"""

# ╔═╡ ad8e9b30-c75d-11ea-1fd0-0b53592135bf
md"""# Loading resources

Notebooks use data from different places. For example, you use [`Base.read`](https://docs.julialang.org/en/v1/base/io-network/#:~:text=read(filename%3A%3AAbstractString%2C%20String)) to access local data (files) inside your Julia code, and [`Downloads.jl`](https://github.com/JuliaLang/Downloads.jl) for remote data (interwebs). 

`PlutoUI` helps you communicate with the person reading the notebook!
- To get **remote media** (URL) inside your **Markdown text**, use `PlutoUI.Resource`.
- To get **local media** (file) inside your **Markdown text**, use `PlutoUI.LocalResource`.

(With _media_, we mean **images**, video and audio.)

> We **strongly recommend** that you use _remote_ media inside Pluto notebooks! 
> 
> If your notebook uses local images, then those images **will not show** when someone else opens your notebook, unless they have the same images on their computer, at the exact same location. _More on this later._

"""

# ╔═╡ 87d088d0-cc54-11ea-02c6-bd673b95b9d3
md"""## Resource

If you just want to show **images inside Markdown**, you can use the built-in syntax (without `PlutoUI`):

```
md"Here is a _dog_: ![](https://fonsp.com/img/doggoSmall.jpg)"
```

`PlutoUI.Resource` has some extra features:
- specify **image dimensions** and spacing
- support for videos
- support for audio"""

# ╔═╡ 6a7e7e54-c75e-11ea-2ea7-ed3da37e9e96
dog_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Welsh_Springer_Spaniel.jpg/640px-Welsh_Springer_Spaniel.jpg"

# ╔═╡ 3c68b25c-c761-11ea-226a-4f46579a6732
Resource(dog_url, :width => x * x_different)

# ╔═╡ 9ac7921c-c75e-11ea-30f5-c35e6ee370cb
t_rex_url = "https://upload.wikimedia.org/wikipedia/commons/transcoded/6/62/Meow.ogg/Meow.ogg.mp3"

# ╔═╡ a8c57442-c75e-11ea-1913-7d82cbd2c69c
flower_url = "https://upload.wikimedia.org/wikipedia/commons/4/41/Sunflower_Flower_Opening_Time_Lapse.ogv"

# ╔═╡ cb37b916-c75b-11ea-0c83-6ba759536075
md"""Hello I am a dog $(Resource(dog_url))"""

# ╔═╡ 16ea31fc-c75e-11ea-0f2d-dd790a56b2dc
md"""And I sound like this: $(Resource(t_rex_url))"""

# ╔═╡ 1dfd8cc6-c75e-11ea-3c04-a96734779c97
md"""This is my flower friend

$(Resource(flower_url, :width => 200))"""

# ╔═╡ 2fda30ea-c75e-11ea-2ff5-7f2dcf4f9b66
md"### Attributes

You can pass additional _HTML attributes_ to `Resource`, these will be added to the element. For example:"

# ╔═╡ 525ceea0-c75e-11ea-2766-f72418fd784e
md"""
$(Resource(dog_url, :width => 20))
$(Resource(dog_url, :width => 50))
$(Resource(dog_url, :width => 100))
$(Resource(dog_url, 
	:width => 100, 
	:style => "filter: grayscale(100%); border: 3px solid black;"))
"""

# ╔═╡ 382d41d8-c75e-11ea-2ae3-2ffe96e04b5a
Resource(flower_url, :width => 200, :autoplay => "", :loop => "")

# ╔═╡ 958ab19c-cc56-11ea-162e-d3664e66ff66
md"### YouTube, Vimeo, etc.

If you use `Resource` for video, the URL has to point to a _video file_ (like `.mp4` or `.mov`). 

Popular video sites don't give you that link, instead, you can use their **embed codes**. You can find these inside the video player, by right clicking or using the menu buttons. You then use that inside an HTML block:
```
html\"\"\"
~ paste embed code here ~
\"\"\"
```

You might need to change the `width` to `100%` to make it fit."

# ╔═╡ 8477619c-cc57-11ea-0618-1778c502d28f
html"""

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/438210156" style="position:absolute;top:0;left:0;width:100%;height:100%;" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

"""

# ╔═╡ f743076c-cc57-11ea-1a8e-8799d9db985a


# ╔═╡ c65d28a2-c75d-11ea-2e13-7332f93d9c5e
md"## LocalResource _(not recommended)_

The examples above use `Resource` to make media from a URL available inside Markdown. To use **local files**, simply **replace `Resource` with `LocalResource`**, and use a _file path_ instead of a URL."

# ╔═╡ c16dff74-cc5d-11ea-380c-aff1639b5551


# ╔═╡ dada2154-c75d-11ea-2312-b9156a9a531e
html"<span style='font-family: cursive; color: purple;'>I really hope that this works</span>"

# ╔═╡ f809110c-cc55-11ea-1551-e138c28d5d82
md"""Hello I am a dog $(LocalResource("C:\\Users\\fons\\Pictures\\hannes.jpg"))"""

# ╔═╡ 1c930364-cc58-11ea-36c8-0ddf7c4700cd
md""" $(html"<span style='font-family: cursive; color: purple;'>OOPS</span>"), it didn't!

$(html"<br>")

Here are **two tips** for getting local images to work correctly:

1. Go to [imgur.com](https://imgur.com) and drag&drop the image to the page. Right click on the image, and select "Copy image location". You can now use the image like so: 

   ```PlutoUI.Resource("https://i.imgur.com/SAzsMMA.jpg")```


2. If your notebook is part of a git repository, place the image in the repository and use a relative path: 
   
    ```PlutoUI.LocalResource("../images/cat.jpg")```


"""

# ╔═╡ c48b48f6-cc5d-11ea-0f3b-d3481238625d


# ╔═╡ ea6ade22-cc5a-11ea-1782-97f2464fd148
md"#### Why does it have to be so difficult?

Pluto only stores _code_ in the notebook file, not images. This minimal file format is very valuable, but it means that images need to be _addressed_, not stored.

Addressing _local files_ is fragile: if someone else opens the notebook, or if you move the notebook to a different folder, that image file needs to be available at exactly the same path. This is difficult to do correctly, and if it works for you, it is hard to tell if it will work for someone else. 

Putting images online might be a hassle, but once it works, it will work everywhere! The stateless nature of URLs means that the images will work regardless of how the notebook file is accessed, while keeping a minimal file format."

# ╔═╡ a245dddc-cc59-11ea-3e1d-1763673ff706
md"# PlutoUI without Pluto

Huh?

Did you know that you can run Pluto notebooks _without Pluto_? If your notebook is called `wow.jl`, then 
```sh
$ julia wow.jl
```
will run the notebook just fine. 

When you use `@bind`, your notebook can still run without Pluto! Sort of. Normally, all bound variables are assigned the value `missing` when you run it elsewhere. However, the `PlutoUI` types have all been configured to assign a more sensible default value.

For example, if your notebook contains
```julia
@bind x Slider(10:20)
```
and you run it without Pluto, then this statement simply assigns `x = 10`.
"

# ╔═╡ 0cda8986-cc64-11ea-2acc-b5c38fdf17e5


# ╔═╡ 0da7bc30-cc64-11ea-1dde-2b7f2dd76036
md"`Pluto` and `PlutoUI` work independently of each other! In fact, _you_ could write a package with fun input elements, or add `@bind`able values to existing packages."

# ╔═╡ 512fe760-cc4c-11ea-1c5b-2b32da035aad
md"# Appendix"

# ╔═╡ 55bcdbf8-cc4c-11ea-1549-87c076a59ff4
space = html"<br><br><br>"

# ╔═╡ ebfc61b0-c765-11ea-1d66-cbf1dcdb8bdb
space

# ╔═╡ f69a5d5e-c765-11ea-3fa0-230c6c619730
space

# ╔═╡ 0b66c781-ecf2-445e-b2aa-82cb13371e46
space

# ╔═╡ 35523932-cc4f-11ea-0908-2d51c57176b7
space

# ╔═╡ d163f434-cc5a-11ea-19e9-9319ba994efa
space

# ╔═╡ 071d9ca5-9b42-4583-ad96-a48f93453a0e
using PlutoUI

# ╔═╡ 49d42de9-8766-4b99-8b5f-eeb9f9fde961
begin
	using Colors, ColorVectorSpace, QuartzImageIO, ImageShow, FileIO, ImageIO, ImageFiltering
	using PlutoUI
	using HypertextLiteral
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageFiltering = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
QuartzImageIO = "dca85d43-d64c-5e67-8c65-017450d5d020"

[compat]
ColorVectorSpace = "~0.9.8"
Colors = "~0.12.8"
FileIO = "~1.12.0"
HypertextLiteral = "~0.9.3"
ImageFiltering = "~0.7.1"
ImageIO = "~0.6.0"
ImageShow = "~0.3.3"
PlutoUI = "~0.7.24"
QuartzImageIO = "~0.7.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "485ee0867925449198280d4af84bdb46a2a404d0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.0.1"

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "abb72771fd8895a7ebd83d5632dc4b989b022b5b"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.2"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9faf218ea18c51fcccaf956c8d39614c9d30fe8b"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.2"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CEnum]]
git-tree-sha1 = "215a9aa4a1f23fbd05b92769fdd62559488d70e9"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.1"

[[CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "d711603452231bad418bd5e0c91f1abd650cba71"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.11.3"

[[ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "3f1f500312161f1ae067abe07d13b40f78f32e07"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.8"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "463cb335fa22c4ebacfd1faba5fde14edb80d96c"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.5"

[[FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "67551df041955cc6ee2ed098718c8fcd7fc7aebe"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.12.0"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "1c5a84319923bea76fa145d49e93aa4394c73fc2"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.1"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "9a5c62f231e5bba35695a20988fc7cd6de7eeb5a"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.3"

[[ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "15bd05c1c0d5dbb32a9a3d7e0ad2d50dd6167189"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.1"

[[ImageIO]]
deps = ["FileIO", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "816fc866edd8307a6e79a575e6585bfab8cef27f"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.0"

[[ImageShow]]
deps = ["Base64", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "d0ac64c9bee0aed6fdbb2bc0e5dfa9a3a78e3acc"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.3"

[[Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "87f7662e03a649cffa2e05bf19c303e168732d3e"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.2+0"

[[IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[Inflate]]
git-tree-sha1 = "f5fc07d4e706b84f72d54eedcc1c13d92fb0871c"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.2"

[[IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "e5718a00af0ab9756305a0392832c8952c7426c1"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.6"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "5455aef09b40e5020e1520f551fa3135040d4ed0"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2021.1.1+2"

[[MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "b34e3bc3ca7c94914418637cb10cc4d1d80d877d"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.3"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "f755f36b19a5116bb580de457cda0c140153f283"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.6"

[[Netpbm]]
deps = ["FileIO", "ImageCore"]
git-tree-sha1 = "18efc06f6ec36a8b801b23f076e3c6ac7c3bf153"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.0.2"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "043017e0bdeff61cfbb7afeb558ab29536bbb5ed"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.8"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "923319661e9a22712f24596ce81c54fc0366f304"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.1+0"

[[OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "6d105d40e30b635cfed9d52ec29cf456e27d38f8"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.12"

[[PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "03a7a85b76381a3d04c7a1656039197e70eda03d"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.11"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "a7a7e1a88853564e551e4eba8650f8c38df79b37"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.1.1"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "6c9fa3e4880242c666dafa4901a34d8e1cd1b243"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.24"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "2cf929d64681236a2e074ffafb8d568733d2e6af"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.3"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "afadeba63d90ff223a6a48d2009434ecee2ec9e8"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.1"

[[QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[QuartzImageIO]]
deps = ["FileIO", "ImageCore", "Libdl"]
git-tree-sha1 = "16de3b880ffdfbc8fc6707383c00a2e076bb0221"
uuid = "dca85d43-d64c-5e67-8c65-017450d5d020"
version = "0.7.4"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "8f82019e525f4d5c669692772a6f4b0a58b06a6a"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.2.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e08890d19787ec25029113e88c34ec20cac1c91e"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.0.0"

[[StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "de9e88179b584ba9cf3cc5edbb7a41f26ce42cda"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.3.0"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "991d34bbff0d9125d93ba15887d6594e8e84b305"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.5.3"

[[TiledIteration]]
deps = ["OffsetArrays"]
git-tree-sha1 = "5683455224ba92ef59db72d10690690f4a8dc297"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.3.1"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "78736dab31ae7a53540a6b752efc61f77b304c5b"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.8.6+1"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─bc532cd2-c75b-11ea-313f-8b5e771c9227
# ╠═49d42de9-8766-4b99-8b5f-eeb9f9fde961
# ╟─6ba59924-7089-44f3-ad16-fbe9cae123c0
# ╠═8b1bbb06-ede1-455b-8bd6-040170b3ae46
# ╠═25de5be5-4ed1-4fdd-87ab-50582ef599bc
# ╠═53777671-61aa-4536-833d-759ec375bf32
# ╠═1e72c70a-8763-46ff-b496-3b53465e7c96
# ╟─3eff9592-cc63-11ea-2b61-4170d1a7656a
# ╟─051f31fc-cc63-11ea-1e2c-0704285ea6a9
# ╠═071d9ca5-9b42-4583-ad96-a48f93453a0e
# ╟─fddb794c-c75c-11ea-1f55-eb9c178424cd
# ╟─b819e9a8-c760-11ea-11ee-dd01da663b5c
# ╠═a4488984-c760-11ea-2930-871f6b400ef5
# ╠═1048d1e0-cc50-11ea-1bf3-d76cae42740a
# ╠═bdae5599-81ff-47f5-9925-69b05cb04160
# ╠═fe2e1774-1624-4b89-b45d-1d9bcf576273
# ╟─a709fd2e-c760-11ea-05c5-7bf673990de1
# ╠═6275654d-ef01-43c5-aa01-b759a56ff1cb
# ╠═9934973e-7291-4f6e-bc2c-90ad3e093f24
# ╠═00b9e0ba-3803-4f23-a03d-882ebd3dc6ae
# ╟─06962cde-cc4f-11ea-0d96-69a8cb7eeda2
# ╟─6605d010-d0d1-4cc8-a34d-3158b8572b5d
# ╠═756e2c82-6e2f-4d7b-a1ed-5de97be04269
# ╠═c07c5a9e-61f9-4247-86e7-7c3f9956d0ff
# ╟─c3fea1b2-fc11-4c19-9c01-a8e03fda2817
# ╟─221c308e-3cbe-4689-aa67-8970957f8cb0
# ╟─e49623ac-c760-11ea-3689-c15f2e2f6081
# ╠═314cb85a-c761-11ea-1cba-b73f84a52be8
# ╠═3c68b25c-c761-11ea-226a-4f46579a6732
# ╠═ec4d1451-f4e0-410e-bcb5-92c93a3ef80a
# ╟─104b55ce-cc4f-11ea-1273-092a1717e399
# ╟─4513b730-c761-11ea-1460-2dca56081fcf
# ╠═4f8e4e1e-c761-11ea-1787-419cab59bb12
# ╟─b787ead6-c761-11ea-3b17-41c0a5434f9b
# ╟─177e6bf0-cc50-11ea-0de2-e77544f5c615
# ╟─b08c347e-c761-11ea-1b61-7b69631d078b
# ╠═b53c8ffa-c761-11ea-38d1-2d4ad96a7bee
# ╟─adcf4e68-c761-11ea-00bb-c3b15c6dedc0
# ╟─1a562ad4-cc50-11ea-2485-cdec6e1a78dc
# ╟─5d420570-c764-11ea-396b-cf0db01d34aa
# ╟─09393bf2-cc4f-11ea-1e48-cfbedab8e6b4
# ╟─cd1b5872-c761-11ea-2179-57a3cb34d235
# ╠═d9e85ed0-c761-11ea-30bf-83ce272526e0
# ╟─e4c262d6-c761-11ea-36b2-055419bfc981
# ╟─0934bc0c-cc50-11ea-0da8-0d6b2f275399
# ╟─e690337c-c761-11ea-08be-ade40a464eb4
# ╠═f1f83980-c761-11ea-1e34-97c0ffca3f67
# ╟─f985c8de-c761-11ea-126c-1fd79d547b79
# ╟─1cbfd28e-cc50-11ea-2c90-a7807e4979ef
# ╟─0136af80-c762-11ea-2f1a-9dccff334a11
# ╠═0e6f0508-c762-11ea-0352-09bd694a9b35
# ╠═3dcd7002-c765-11ea-323d-a1fb49409011
# ╟─0aa3c85e-cc4f-11ea-2fba-4bdd513d9217
# ╟─5833f7f4-c763-11ea-0b95-9b21a40192a9
# ╠═690cf3ac-c763-11ea-10f0-b3e28c380be9
# ╠═705662e2-c763-11ea-2f6d-cdaffc1fc73a
# ╠═1feebd8f-667a-42fd-965d-5e3167ff7c7a
# ╠═9128d2c1-364c-4446-baaa-6d0593edda47
# ╟─3930f0d8-cc50-11ea-3de6-d91ac5c6cd9f
# ╟─787a2c88-c763-11ea-0a32-bb91ca60113d
# ╠═ac8c4dee-c763-11ea-1b2d-c590a2d50d7e
# ╠═dcda9ad2-c763-11ea-3ec6-093b823ba66d
# ╟─0c3ab1f8-cc4f-11ea-0cfb-8f076d2c9836
# ╟─62c6f866-f0fe-11ea-0961-319f28d040d4
# ╠═a01c8096-f0fe-11ea-3e78-ad8551e84fa1
# ╠═a20e30f2-f0fe-11ea-0ca7-c5195c9eb24a
# ╟─c819ef3e-f0fe-11ea-1213-9df7597e4e89
# ╟─b104ba6d-0293-4378-9652-f628f1d08d97
# ╠═16f2218d-f1bc-4b34-a355-53acfa77fbf5
# ╠═2c7811cb-d9ea-470c-8cb7-2b3803489f3f
# ╟─78be41d1-7dda-4bec-b75f-fbcf8b7594a7
# ╠═90d84f1b-042c-444e-8bac-fe358b6d68a1
# ╠═b97cfb04-0c39-4709-9419-9294e677a872
# ╟─283d1177-c605-4652-905b-9a70354cf878
# ╟─0b1ce22e-c764-11ea-3d60-e799d58aee30
# ╠═6d9108a8-c765-11ea-0a38-09a1364998b1
# ╠═7a14e496-c765-11ea-20a1-6fb960009251
# ╟─3eff932a-cc50-11ea-366e-812d3854dd4c
# ╟─7e10fb52-c765-11ea-2a71-0fc347d09885
# ╠═b91764e8-c765-11ea-27a2-4ba5777fbd89
# ╠═bb356b12-c765-11ea-2c36-697f4314bb93
# ╟─9276da28-cc4f-11ea-17b3-65eec41a181e
# ╟─92def54a-cc4f-11ea-12c5-652f2bb46413
# ╠═9920e56c-cc4f-11ea-2d5e-f5371c79f048
# ╠═44591b34-cc50-11ea-2005-2f7075e6f2db
# ╟─4fda3072-cc50-11ea-2804-197b6391b269
# ╟─ebfc61b0-c765-11ea-1d66-cbf1dcdb8bdb
# ╟─3e5dd7d2-c760-11ea-1dca-6d8720b3558d
# ╟─f31668c6-c768-11ea-1501-5f41afa7c83b
# ╠═417390ba-c760-11ea-27df-5908858ae88c
# ╠═49e7cd06-c760-11ea-3f5d-2741d94278a6
# ╟─31a2f3c4-cc51-11ea-3652-bd814517a4b5
# ╟─67709812-c760-11ea-2bda-9756ead35749
# ╠═4c2b45a0-c760-11ea-2b64-3fefc820cd5b
# ╠═5be148cc-c760-11ea-0819-a7bb403d27ff
# ╟─347e3d06-cc51-11ea-012c-43e824eaffa2
# ╟─343d7118-cc51-11ea-387a-fb22d8c73506
# ╟─32e41ac2-cc51-11ea-3358-bbead9c68123
# ╟─f74f434a-c768-11ea-079c-fb707e6ba17b
# ╟─ea00721c-cc4b-11ea-1e82-0b3dbe6a7f1e
# ╠═fc12280c-c768-11ea-3ebc-ebcd6b3459c1
# ╠═067cbcde-cc4c-11ea-3eed-972dc6d7bb3b
# ╟─f69a5d5e-c765-11ea-3fa0-230c6c619730
# ╟─7da30d97-b28a-4eb9-a2ef-fad599b549d1
# ╟─170089cd-f366-4c0a-b58d-fe6e36049db7
# ╠═b29215cb-8e7e-4382-822c-cdaa4c473ba1
# ╠═00f9f608-85bd-4932-b585-39f74dcf53b4
# ╟─48a9ffbd-cac7-4c4e-85e5-c3d0693e5550
# ╟─5c85ee41-da68-4f5f-b45e-e1de7996747d
# ╟─8c51343f-cb35-4ff9-9fd8-642ffab57e22
# ╠═621f2e82-5ab4-4ab9-a0ff-fb1cc1b41295
# ╟─a4837897-caae-447a-8db9-7775e7a4d0c8
# ╠═f5c421cc-dbdb-459a-9bb4-d648507a87d2
# ╠═a4eac824-ba87-473a-b39a-783c4de3f933
# ╠═f9052ed8-84cc-4cca-abb2-9363aafc6040
# ╠═d278189e-6a5b-428a-8c81-ce3d206b042c
# ╟─4ca9c749-08ee-467f-af2c-9b2f13199d72
# ╟─0b66c781-ecf2-445e-b2aa-82cb13371e46
# ╟─ad8e9b30-c75d-11ea-1fd0-0b53592135bf
# ╟─87d088d0-cc54-11ea-02c6-bd673b95b9d3
# ╟─6a7e7e54-c75e-11ea-2ea7-ed3da37e9e96
# ╟─9ac7921c-c75e-11ea-30f5-c35e6ee370cb
# ╟─a8c57442-c75e-11ea-1913-7d82cbd2c69c
# ╠═cb37b916-c75b-11ea-0c83-6ba759536075
# ╠═16ea31fc-c75e-11ea-0f2d-dd790a56b2dc
# ╠═1dfd8cc6-c75e-11ea-3c04-a96734779c97
# ╟─2fda30ea-c75e-11ea-2ff5-7f2dcf4f9b66
# ╠═525ceea0-c75e-11ea-2766-f72418fd784e
# ╠═382d41d8-c75e-11ea-2ae3-2ffe96e04b5a
# ╟─958ab19c-cc56-11ea-162e-d3664e66ff66
# ╠═8477619c-cc57-11ea-0618-1778c502d28f
# ╟─f743076c-cc57-11ea-1a8e-8799d9db985a
# ╟─c65d28a2-c75d-11ea-2e13-7332f93d9c5e
# ╟─c16dff74-cc5d-11ea-380c-aff1639b5551
# ╟─dada2154-c75d-11ea-2312-b9156a9a531e
# ╠═f809110c-cc55-11ea-1551-e138c28d5d82
# ╟─1c930364-cc58-11ea-36c8-0ddf7c4700cd
# ╟─c48b48f6-cc5d-11ea-0f3b-d3481238625d
# ╟─ea6ade22-cc5a-11ea-1782-97f2464fd148
# ╟─35523932-cc4f-11ea-0908-2d51c57176b7
# ╟─a245dddc-cc59-11ea-3e1d-1763673ff706
# ╟─0cda8986-cc64-11ea-2acc-b5c38fdf17e5
# ╟─0da7bc30-cc64-11ea-1dde-2b7f2dd76036
# ╟─d163f434-cc5a-11ea-19e9-9319ba994efa
# ╟─512fe760-cc4c-11ea-1c5b-2b32da035aad
# ╠═55bcdbf8-cc4c-11ea-1549-87c076a59ff4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
