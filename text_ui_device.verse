using {/Fortnite.com/Devices }
using {/Fortnite.com/UI}
using {/UnrealEngine.com/Temporary/UI}
using {/UnrealEngine.com/Temporary/SpatialMath}
using {/Verse.org/Assets}
using {/Verse.org/Simulation}
using {/Verse.org/Colors}
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Characters }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
ui_module<public> := module:
    text_ui_device<public> := class(creative_device):

        var WidgetClassPerPlayer: [player]one_text_canvas = map{}

        InitializeUI<public>():void=
            for(Player : GetPlayspace().GetPlayers()):
                AddUI(Player)
        AddUI<public>(Agent:agent):void=
            if:
                Player := player[Agent]
                PlayerUI := GetPlayerUI[Player]
                not WidgetClassPerPlayer[Player]
                WClass := set WidgetClassPerPlayer[Player] = one_text_canvas{}
            then:
                Widget:canvas = WClass.CreateCanvas()
                PlayerUI.AddWidget(Widget)

        UpdateText<public>(Agent:agent,Text:string):void=
            if(Player := player[Agent]):
                if(WClass := WidgetClassPerPlayer[Player]):
                    WClass.UpdateText(Text)

        UpdateTextForAllPlayer<public>(Text:string):void=
            AllPlayers := GetPlayspace().GetPlayers()
            for(Player : AllPlayers):
                UpdateText(Player,Text)

    one_text_canvas := class():

        var TextWidget:text_block = text_block{}
        var MyCanvas: canvas = canvas{}

        TextToMessage<localizes>(Text:string):message = "{Text}"
        
        CreateCanvas():canvas=
            set TextWidget = text_block{DefaultTextColor := NamedColors.White}
            set MyCanvas = canvas:
                Slots := array:
                    canvas_slot:
                        Anchors := anchors{Minimum := vector2{X:=0.5, Y:=0.85}, Maximum := vector2{X:=0.5, Y:=0.85}}
                        Offsets := margin{Top := 0.0,Left := 0.0, Right := 0.0, Bottom := 0.0}
                        Alignment := vector2{X:=0.5, Y:=0.5}
                        SizeToContent := true
                        Widget := TextWidget
            return MyCanvas
        GetCanvas()<decides><transacts>:canvas = MyCanvas
        UpdateText(Text:string):void=
            TextWidget.SetText(TextToMessage(Text))