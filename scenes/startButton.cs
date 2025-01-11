using Godot;
using System;

public partial class startButton : Button
{
    private globalScript mainScript;

    public override void _Ready()
    {
        Pressed += startButtonPressed;
        
        // Access the global script through the singleton
        mainScript = GetNode<globalScript>("/root/Global");
    }

    private void startButtonPressed()
    {
        if (mainScript != null)
        {
            // Load the main scene
            var mainScene = GD.Load<PackedScene>("res://scenes/main.tscn");
            
            // Change to the new scene
            GetTree().ChangeSceneToPacked(mainScene);
            
            GD.Print("Transitioning to main scene");
        }
    }
}