using Godot;
using System;

public partial class globalScript : Node
{
    public int Score { get; set; } = 0;
    
    private PackedScene startScene;

    public override void _Ready()
    {
        // Preload the start scene
        startScene = GD.Load<PackedScene>("res://scenes/startUI.tscn");
    }

    public override void _Input(InputEvent @event)
    {
        // Check if ESC was pressed
        if (@event.IsActionPressed("ui_cancel")) // This is the default ESC key action
        {
            // Get the current scene name
            var currentScene = GetTree().CurrentScene.SceneFilePath;
            
            // Only switch to start scene if we're in the main scene
            if (currentScene.Contains("main.tscn"))
            {
                GetTree().ChangeSceneToPacked(startScene);
                GD.Print("Returning to start menu");
            }
        }
    }
}