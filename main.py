from keract import display_activations
# The image path
img_path = './tree.png'
# Preprocessing the image for the model
x = preprocess_image(img_path=img_path,model=model,resize=target_size)
# Generate the activations 
activations = get_activations(model, x)
display_activations(activations, save=False)

