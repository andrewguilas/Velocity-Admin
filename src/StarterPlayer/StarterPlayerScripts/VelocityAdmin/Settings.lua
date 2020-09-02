local Settings = {
    CommandBar = {
        OpenKey = Enum.KeyCode.BackSlash,
        ExitKey = Enum.KeyCode.Escape,
        DefaultPos = UDim2.new(0.3, 10, 0, 50),
        DefaultSize = UDim2.new(0, 40, 0, 20),
        Hint = {
            Spacing = 20,
            DefaultSize = UDim2.new(0, 10, 0, 30)
        },
        AutoComplete = {
            UpKey = Enum.KeyCode.Up,
            DownKey = Enum.KeyCode.Down,
            UseKey1 = Enum.KeyCode.Tab,
            UseKey2 = Enum.KeyCode.Return,            
            ArgSplit = " ",
            SelectedColor = Color3.fromRGB(100, 100, 100),
            UnselectedColor = Color3.fromRGB(0, 0, 0),
            MaxDescriptionSize = 500,
            FieldSize = UDim2.new(20, 0, 0, 20),
            FieldSpacing = 100,
        }
    }
}

return Settings