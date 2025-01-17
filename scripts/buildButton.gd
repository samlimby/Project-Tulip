extends Button

var custom_popup: ColorRect
var is_popup_open := false

func _ready():
    # Create the custom popup
    custom_popup = ColorRect.new()
    add_child(custom_popup)
    
    # Set up the ColorRect properties
    custom_popup.color = Color(0.2, 0.2, 0.2, 0.9)
    custom_popup.custom_minimum_size = Vector2(200, 300)
    custom_popup.visible = false
    
    # Make it float above other elements
    custom_popup.set_anchors_preset(Control.PRESET_CENTER)
    custom_popup.mouse_filter = Control.MOUSE_FILTER_STOP
    
    # Add a VBoxContainer for content
    var container = VBoxContainer.new()
    container.set_anchors_preset(Control.PRESET_FULL_RECT)
    container.add_theme_constant_override("separation", 10)
    custom_popup.add_child(container)
    
    # Add some example build options
    var options = ["House", "Farm", "Workshop", "Mine"]
    for option in options:
        var build_button = Button.new()
        build_button.text = option
        build_button.custom_minimum_size.y = 40
        build_button.pressed.connect(_on_build_option_selected.bind(option))
        container.add_child(build_button)
    
    # Connect button press
    pressed.connect(_on_button_clicked)

func _on_button_clicked():
    if !is_popup_open:
        var button_pos = global_position
        custom_popup.global_position = Vector2(button_pos.x, button_pos.y + size.y)
        custom_popup.visible = true
        is_popup_open = true

# Instead of using gui_input, we'll use _input to check for clicks
func _input(event):
    if is_popup_open and event is InputEventMouseButton:
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
            var click_pos = event.global_position
            var popup_rect = custom_popup.get_global_rect()
            
            # If click is outside popup and not on the main button
            if not popup_rect.has_point(click_pos) and not get_global_rect().has_point(click_pos):
                close_popup()

func close_popup():
    custom_popup.visible = false
    is_popup_open = false

func _on_build_option_selected(option: String):
    print("Selected build option: ", option)
    # Add your build logic here
    close_popup()

# Optional: Close with ESC key
func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed and event.keycode == KEY_ESCAPE and is_popup_open:
            close_popup()