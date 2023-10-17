
using { /Fortnite.com/Devices }
using {/Fortnite.com/Characters}
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using {IwakenVerseToolkit.ui_module}

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
onlyup_manager_device := class(creative_device):

    @editable
    TextUI:text_ui = text_ui{}

    @editable
    EnterTrigger:mutator_zone_device = mutator_zone_device{}
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        EnterTrigger.AgentEntersEvent.Subscribe(OnTriggered)
        TextUI.InitializeUI()


    OnTriggered(Agent:agent):void=
        spawn{StartLoop(Agent)}

    StartLoop(Agent: agent)<suspends>:void=
        loop:
            Sleep(0.1)
            IntHeight := GetPlayerHeight(Agent)
            TextUI.UpdateText(Agent,"{IntHeight}m")
    

    CmToM(CM:float)<decides><transacts>:float = 
        return CM / 100.0
    
    GetPlayerHeight(Agent:agent):int=
        if (FortniteCharacter : fort_character = Agent.GetFortCharacter[]):
            if(Height := CmToM[FortniteCharacter.GetTransform().Translation.Z]):
                if(IntHeight := Floor[Height]):
                    return IntHeight
        return 0
