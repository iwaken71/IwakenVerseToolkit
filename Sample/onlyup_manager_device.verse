using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }
using { IwakenVerseToolkit.ui_module }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

sample_only_up := module:
    # A Verse-authored creative device that can be placed in a level
    onlyup_manager_device := class(creative_device):

        @editable
        TextUIDevice:text_ui_device = text_ui_device{}

        @editable
        EnterTrigger:mutator_zone_device = mutator_zone_device{}

        @editable
        FloorHeight:float = 0.0 #基準となる床の高さ

        var StartPerPlayer: [agent]logic = map{}

        OnBegin<override>()<suspends>:void=
            EnterTrigger.AgentEntersEvent.Subscribe(OnStartTriggered)

        OnStartTriggered(Agent:agent):void=
            spawn{StartHeightDisplay(Agent)}

        StartHeightDisplay(Agent: agent)<suspends>:void=
            # 2回目以降は処理しない
            if(StartPerPlayer[Agent]?):
                return
            # 初めてのゾーン内であれば処理する
            if(set StartPerPlayer[Agent] = true):
                TextUIDevice.AddUI(Agent) # UIの付与
                loop:
                    Sleep(0.1) # 0.1秒待つ
                    IntHeight := GetPlayerHeight(Agent)
                    TextUIDevice.UpdateText(Agent,"{IntHeight}m")

        #単位をセンチメートルからからメートルに変換
        CmToMeter(CM:float)<decides><transacts>:float =
            return CM / 100.0

        GetPlayerHeight(Agent:agent):int=
            if:
                FortniteCharacter := Agent.GetFortCharacter[]
                Height := CmToMeter[FortniteCharacter.GetTransform().Translation.Z - FloorHeight]
                IntHeight := Floor[Height] #小数点以下を切り捨て
            then:
                return IntHeight
            return 0
