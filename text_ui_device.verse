using {/Fortnite.com/Devices }
using {/Fortnite.com/UI}
using {/UnrealEngine.com/Temporary/UI}
using {/UnrealEngine.com/Temporary/SpatialMath}
using {/Verse.org/Colors}
using {/Verse.org/Simulation}

# A Verse-authored creative device that can be placed in a level
ui_module<public> := module:
    text_ui_device<public> := class(creative_device):

        var WidgetClassPerPlayer: [player]one_text_canvas = map{}

        AddUI<public>(Agent:agent):void=
            if:
                Player := player[Agent]
                PlayerUI := GetPlayerUI[Player]
                not WidgetClassPerPlayer[Player]
                WClass := set WidgetClassPerPlayer[Player] = one_text_canvas{}
            then:
                Widget:canvas = WClass.CreateCanvas()
                PlayerUI.AddWidget(Widget)

        AddUIForAllPlayer<public>():void=
            for(Player : GetPlayspace().GetPlayers()):
                AddUI(Player)

        UpdateText<public>(Agent:agent,Text:string):void=
            if(Player := player[Agent],WClass := WidgetClassPerPlayer[Player]):
                WClass.UpdateText(Text)

        UpdateTextForAllPlayer<public>(Text:string):void=
            for(Player : GetPlayspace().GetPlayers()):
                UpdateText(Player,Text)

    one_text_canvas := class():

        var TextWidget:text_block = text_block{}
        var MyCanvas: canvas = canvas{}

        StringToMessage<localizes>(Text:string):message = "{Text}"

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
            TextWidget.SetText(StringToMessage(Text))