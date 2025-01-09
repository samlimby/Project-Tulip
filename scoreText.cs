using Godot;
using System;

public partial class scoreText : Label
{
    private globalScript mainScript;

    public override void _Ready()
    {
        // Access the global script through the singleton
        mainScript = GetNode<globalScript>("/root/Global");
    }

    public override void _Process(double delta)
    {
        // Update the label to reflect the current score
        if (mainScript != null)
        {
            Text = mainScript.Score.ToString();
        }
    }
}