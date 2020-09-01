local Settings = {
    CommandBar = {
        Startup = {
            Key = Enum.KeyCode.BackSlash,
            Exit = Enum.KeyCode.Escape,
            HiddenPos = UDim2.new(0.3, 10, -1, 10),
            ShownPos = UDim2.new(0.3, 10, 0, 10),
        },
        Text = {
            Size = UDim2.new(0, 40, 0, 20),
            MaxSize = 500,
        },
        AutoComplete = {
            Key1 = Enum.KeyCode.Tab,
            Key2 = Enum.KeyCode.Return,
            UpKey = Enum.KeyCode.Up,
            DownKey = Enum.KeyCode.Down,
            SelectedColor = Color3.fromRGB(100, 100, 100),
            NonSelectedColor = Color3.fromRGB(0, 0, 0),
            ShowPos = UDim2.new(0.3, 10, 0, 32),
            FieldSize = UDim2.new(20, 0, 0, 20),
            FieldSpacing = 80,
            ArgSplit = " ",
            Words = {
                ["Jet"] = "was good, then bad, then tried to be good, but was actually bad the ENTIRE TIME, and then he became bad  because he was brain washed, but then he realized that he was brain washed so he became good, but then he was controlled again from the previous brain washing experience and became bad, but when he died, he becam,e good.",
                ["Potato"] = "Makes french fries!",
                ["HotDog"] = "Good with ketchup and mayo",
                ["HotMan"] = "Old Fire Nation Slang",
                ["Celery"] = "A VEG-ET-A-BLE",
                ["Cool"] = "Someone who is cool, or the temperature",
                ["coraa"] = "hated instantly by the fandom for no reason lol",
                ["ro ro ro ro hoe"] = "you're not professional until you use it",
                ["pizza"] = "some italian food idk never heard of it",
                ["crazy man"] = "some aero guy"
            }
        },
    },

}

return Settings