from PIL import Image
import sys 

def calculate_mean_colors(image_path, grid_size):
    img = Image.open(image_path)
    width, height = img.size
    mean_colors = []

    # Calculate grid dimensions
    cell_width = width // grid_size
    cell_height = height // grid_size

    for y in range(grid_size):
        for x in range(grid_size):
            # Define the bounding box for the current cell
            left = x * cell_width
            upper = y * cell_height
            right = left + cell_width
            lower = upper + cell_height

            # Crop the image to the bounding box
            cell = img.crop((left, upper, right, lower))

            # Calculate the mean color of the cell
            mean_color = calculate_mean_color(cell)

            # Add the mean color to the list
            mean_colors.append(mean_color)

    return mean_colors

def calculate_mean_color(image):
    # Calculate the mean color of the image
    pixels = list(image.getdata())
    num_pixels = len(pixels)
    total_r = sum(p[0] for p in pixels)
    total_g = sum(p[1] for p in pixels)
    total_b = sum(p[2] for p in pixels)
    mean_color = (total_r // num_pixels, total_g // num_pixels, total_b // num_pixels)
    return mean_color

if __name__ == "__main__":
    image_path = sys.argv[1]  # Replace with the path to your image
    grid_size = 20

    # Calculate the mean colors for the image grid
    mean_colors = calculate_mean_colors(image_path, grid_size)

    # Output the mean colors
    for color in mean_colors:
        print(color)
