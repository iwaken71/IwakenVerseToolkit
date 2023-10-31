using { /Fortnite.com/Devices }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.
extensions<public> := module:

    (Sequencer:cinematic_sequence_device).AwaitPlay<public>()<suspends>:void=
        Sequencer.Play()
        Sequencer.StoppedEvent.Await()