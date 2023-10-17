using {/Fortnite.com/Devices }
using {/Fortnite.com/UI}
using {/UnrealEngine.com/Temporary/UI}
using {/UnrealEngine.com/Temporary/SpatialMath}
using {/Verse.org/Assets}
using {/Verse.org/Simulation}
using {/Verse.org/Colors}

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
text_ui := class(creative_device):

    var WidgetClassPerPlayer: [player]MyWidgetClass = map{}

    InitializeUI():void=
        AllPlayers := GetPlayspace().GetPlayers()
        for(Player : AllPlayers):
            if(not WidgetClassPerPlayer[Player]):
                if (WClass := set WidgetClassPerPlayer[Player] = MyWidgetClass{}):
                    WClass.AddUI(Player)
    
    UpdateText(Agent:agent,Text:string):void=
        if(Player := player[Agent], WClass := WidgetClassPerPlayer[Player]):
            WClass.UpdateText(Text)
    UpdateTextForAllPlayer(Text:string):void=
        AllPlayers := GetPlayspace().GetPlayers()
        for(Player : AllPlayers):
            if(WClass := WidgetClassPerPlayer[Player]):
                WClass.UpdateText(Text)


MyWidgetClass := class:

    var TextWidget:text_block = text_block{}
    TextToMessage<localizes>(Text:string):message="{Text}"

    AddUI(Agent:agent):void=
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]):
            Widget:canvas = CreateWidget(Agent)
            PlayerUI.AddWidget(Widget)
    CreateWidget(Agent:agent):canvas=
        set TextWidget = text_block{}
        MyCanvas: canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:=0.85}, Maximum := vector2{X:=0.5, Y:=0.85}}
                    Offsets := margin{Top := 0.0,Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := true
                    Widget := TextWidget
        return MyCanvas
    UpdateText(Text:string):void=
        TextWidget.SetText(TextToMessage(Text))