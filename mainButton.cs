using Godot;
using System;

public partial class mainButton : Button
{
    private globalScript mainScript;

    public override void _Ready()
    {
        Pressed += mainButtonPressed;
        
        // Access the global script through the singleton
        mainScript = GetNode<globalScript>("/root/Global");
    }

    private void mainButtonPressed()
    {
        if (mainScript != null)
        {
            mainScript.Score++; // Increment the shared score
            GD.Print($"Score updated to: {mainScript.Score}");
        }
    }
}