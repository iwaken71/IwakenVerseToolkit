
using { /Fortnite.com/Devices }
using {/Fortnite.com/Characters}
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using {IwakenVerseToolkit.ui_module}

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

sample_only_up := module:
    # A Verse-authored creative device that can be placed in a level
    onlyup_manager_device := class(creative_device):

        @editable
        TextUIDevice:text_ui_device = text_ui_device{}

        @editable
        EnterTrigger:mutator_zone_device = mutator_zone_device{}

        @editable
        FloorHeight:float = 0.0

        var StartPerPlayer: [agent]logic = map{}
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
            EnterTrigger.AgentEntersEvent.Subscribe(OnStartTriggered)
            TextUIDevice.InitializeUI()


        OnStartTriggered(Agent:agent):void=
            spawn{StartHeightDisplay(Agent)}

        StartHeightDisplay(Agent: agent)<suspends>:void=
            if(StartPerPlayer[Agent]?):
                return
            if(set StartPerPlayer[Agent] = true):
                loop:
                    Sleep(0.1)
                    IntHeight := GetPlayerHeight(Agent)
                    TextUIDevice.UpdateText(Agent,"{IntHeight}m")

        CmToMeter(CM:float)<decides><transacts>:float =
            return CM / 100.0

        GetPlayerHeight(Agent:agent):int=
            if:
                FortniteCharacter : fort_character = Agent.GetFortCharacter[]
                Height := CmToMeter[FortniteCharacter.GetTransform().Translation.Z - FloorHeight]
                IntHeight := Floor[Height]
            then:
                return IntHeight
            return 0
