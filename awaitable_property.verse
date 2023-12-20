
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Concurrency}

awaitable_property_module<public> := module:
    read_only_awaitable_property_interface<public>(t: type) := interface(awaitable(t)):
        GetValue<public>():t
    awaitable_property_interface<public>(t: type) := interface(read_only_awaitable_property_interface(t)):
        SetValue<public>(t2:t):void

    # This class is comment out because it has error message "Mutable members in parametric classes are not yet implemented."
    # awaitable_property(t: type) := class(awaitable_property_interface(t)):
    #     var Value:t # Mutable members in parametric classes are not yet implemented.
    #     ChangeEvent:event(t) = event(t){}
    #     SetValue<override>(InputValue:t):void=
    #         ChangeEvent.Signal(InputValue)
    #     GetValue<override>():t=
    #         return Value
    #     Await<override>()<suspends>:t=
    #         return ChangeEvent.Await()

    int_awaitable_property<public> := class(awaitable_property_interface(int)):
        var Value :int = 0
        ChangeEvent:event(int) = event(int){}
        SetValue<override>(InputValue:int):void=
            if(not Value = InputValue):
                set Value = InputValue
                ChangeEvent.Signal(InputValue)
        GetValue<override>():int=
            return Value
        AddValue<public>(InputValue:int):void=
            SetValue(Value + InputValue)
        Await<override>()<suspends>:int=
            return ChangeEvent.Await()

    string_awaitable_property<public> := class(awaitable_property_interface(string)):
        var Value :string = ""
        ChangeEvent:event(string) = event(string){}
        SetValue<override>(InputValue:string):void=
            if(not Value = InputValue):
                set Value = InputValue
                ChangeEvent.Signal(InputValue)
        GetValue<override>():string=
            return Value
        Await<override>()<suspends>:string=
            return ChangeEvent.Await()

    float_awaitable_property<public> := class(awaitable_property_interface(float)):
        var Value :float = 0.0
        ChangeEvent:event(float) = event(float){}
        SetValue<override>(InputValue:float):void=
            if(not Value = InputValue):
                set Value = InputValue
                ChangeEvent.Signal(InputValue)
        GetValue<override>():float=
            return Value
        Await<override>()<suspends>:float=
            return ChangeEvent.Await()