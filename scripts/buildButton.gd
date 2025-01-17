extends Button

# Create a PopupMenu node as a variable
var popup_menu: PopupMenu

func _ready():
    # Initialize the popup menu
    popup_menu = PopupMenu.new()
    add_child(popup_menu)
    
    # Add items to the popup menu
    popup_menu.add_item("Option 1", 0)
    popup_menu.add_item("Option 2", 1)
    popup_menu.add_item("Option 3", 2)
    
    # Connect the popup menu's id_pressed signal
    popup_menu.id_pressed.connect(_on_item_pressed)
    
    # Connect the input event signal
    gui_input.connect(_on_sprite_clicked)

func _on_sprite_clicked(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            # Show popup at mouse position
            popup_menu.position = get_global_mouse_position()
            popup_menu.popup()

func _on_item_pressed(id: int):
    match id:
        0:
            print("Option 1 selected")
        1:
            print("Option 2 selected")
        2:
            print("Option 3 selected")