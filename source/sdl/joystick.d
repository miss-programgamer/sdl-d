/*
    DSDL
    Copyright (C) 2025 Inochi2D Project <luna@foxgirls.gay>

    This software is provided 'as-is', without any express or implied
    warranty.  In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
        claim that you wrote the original software. If you use this software
        in a product, an acknowledgment in the product documentation would be
        appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
        misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.

    ==========================================================================

    Simple DirectMedia Layer
    Copyright (C) 1997-2025 Sam Lantinga <slouken@libsdl.org>

    This software is provided 'as-is', without any express or implied
    warranty.  In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
        claim that you wrote the original software. If you use this software
        in a product, an acknowledgment in the product documentation would be
        appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
        misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.
*/

/**
    SDL Joystick Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryJoystick, SDL3 Joystick Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.joystick;
import sdl.guid;
import sdl.sensor;
import sdl.power;
import sdl.properties;
import sdl.stdc;

extern(C) nothrow @nogc:

/**
    The joystick structure used to identify an SDL joystick.

    This is opaque data.
*/
struct SDL_Joystick;

/**
    This is a unique ID for a joystick for the time it is connected to the
    system, and is never reused for the lifetime of the application.

    If the joystick is disconnected and reconnected, it will get a new ID.

    The value 0 is an invalid ID.
*/
alias SDL_JoystickID = Uint32;

/**
    An enum of some common joystick types.

    In some cases, SDL can identify a low-level joystick as being a certain
    type of device, and will report it through SDL_GetJoystickType (or
    SDL_GetJoystickTypeForID).

    This is by no means a complete list of everything that can be plugged into
    a computer.
*/
enum SDL_JoystickType {
    SDL_JOYSTICK_TYPE_UNKNOWN,
    SDL_JOYSTICK_TYPE_GAMEPAD,
    SDL_JOYSTICK_TYPE_WHEEL,
    SDL_JOYSTICK_TYPE_ARCADE_STICK,
    SDL_JOYSTICK_TYPE_FLIGHT_STICK,
    SDL_JOYSTICK_TYPE_DANCE_PAD,
    SDL_JOYSTICK_TYPE_GUITAR,
    SDL_JOYSTICK_TYPE_DRUM_KIT,
    SDL_JOYSTICK_TYPE_ARCADE_PAD,
    SDL_JOYSTICK_TYPE_THROTTLE,
    SDL_JOYSTICK_TYPE_COUNT
}

/**
    Possible connection states for a joystick device.

    This is used by SDL_GetJoystickConnectionState to report how a device is
    connected to the system.
*/
enum SDL_JoystickConnectionState {
    SDL_JOYSTICK_CONNECTION_INVALID = -1,
    SDL_JOYSTICK_CONNECTION_UNKNOWN,
    SDL_JOYSTICK_CONNECTION_WIRED,
    SDL_JOYSTICK_CONNECTION_WIRELESS
}

/**
    The largest value an SDL_Joystick's axis can report.

    See_Also:
        $(D SDL_JOYSTICK_AXIS_MIN)
*/
enum SDL_JOYSTICK_AXIS_MAX = 32_767;

/**
    The smallest value an SDL_Joystick's axis can report.

    This is a negative number!

    See_Also:
        $(D SDL_JOYSTICK_AXIS_MAX)
*/
enum SDL_JOYSTICK_AXIS_MIN = -32_768;

/**
    Locking for atomic access to the joystick API.

    The SDL joystick functions are thread-safe, however you can lock the
    joysticks while processing to guarantee that the joystick list won't change
    and joystick and gamepad events will not be delivered.
*/
extern void SDL_LockJoysticks();

/**
    Unlocking for atomic access to the joystick API.
*/
extern void SDL_UnlockJoysticks();

/**
    Return whether a joystick is currently connected.

    Returns:
        true if a joystick is connected, false otherwise.

    See_Also:
        $(D SDL_GetJoysticks)
*/
extern bool SDL_HasJoystick();

/**
    Get a list of currently connected joysticks.

    Params:
        count = a pointer filled in with the number of joysticks returned, may
                be NULL.
    
    Returns:
        a 0 terminated array of joystick instance IDs or NULL on failure;
        call SDL_GetError() for more information. This should be freed
        with SDL_free() when it is no longer needed.

    See_Also:
        $(D SDL_HasJoystick)
        $(D SDL_OpenJoystick)
*/
extern SDL_JoystickID* SDL_GetJoysticks(int* count);

/**
    Get the implementation dependent name of a joystick.
    
    This can be called before any joysticks are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the name of the selected joystick. If no name can be found, this
        function returns NULL; call SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_GetJoystickName)
        $(D SDL_GetJoysticks)
*/
extern const(char)* SDL_GetJoystickNameForID(SDL_JoystickID instance_id);

/**
    Get the implementation dependent path of a joystick.

    This can be called before any joysticks are opened.

    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the path of the selected joystick. If no path can be found, this
        function returns NULL; call SDL_GetError() for more information.

    See_Also:
        $(D SDL_GetJoystickPath)
        $(D SDL_GetJoysticks)
*/
extern const(char)* SDL_GetJoystickPathForID(SDL_JoystickID instance_id);

/**
    Get the player index of a joystick.
    
    This can be called before any joysticks are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The player index of a joystick, or -1 if it's not available.
    
    See_Also:
        $(D SDL_GetJoystickPlayerIndex)
        $(D SDL_GetJoysticks)
*/
extern int SDL_GetJoystickPlayerIndexForID(SDL_JoystickID instance_id);

/**
    Get the implementation-dependent GUID of a joystick.

    This can be called before any joysticks are opened.

    Params:
        instance_id = The joystick instance ID.
    
    Returns:
        The GUID of the selected joystick. If called with an invalid
        instance_id, this function returns a zero GUID.

    See_Also:
        $(D SDL_GetJoystickGUID)
        $(D SDL_GUIDToString)
*/
extern SDL_GUID SDL_GetJoystickGUIDForID(SDL_JoystickID instance_id);

/**
    Get the USB vendor ID of a joystick, if available.
    
    This can be called before any joysticks are opened. If the vendor ID isn't
    available this function returns 0.
    
    Params:
        instance_id = The joystick instance ID.
    
    Returns:
        The USB vendor ID of the selected joystick. If called with an
        invalid instance_id, this function returns 0.
    
    See_Also:
        $(D SDL_GetJoystickVendor)
        $(D SDL_GetJoysticks)
*/
extern Uint16 SDL_GetJoystickVendorForID(SDL_JoystickID instance_id);

/**
    Get the USB product ID of a joystick, if available.
    
    This can be called before any joysticks are opened. If the product ID isn't
    available this function returns 0.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the USB product ID of the selected joystick. If called with an
        invalid instance_id, this function returns 0.
    
    See_Also:
        $(D SDL_GetJoystickProduct)
        $(D SDL_GetJoysticks)
*/
extern Uint16 SDL_GetJoystickProductForID(SDL_JoystickID instance_id);

/**
    Get the product version of a joystick, if available.
    
    This can be called before any joysticks are opened. If the product version
    isn't available this function returns 0.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The product version of the selected joystick. If called with an
        invalid instance_id, this function returns 0.
    
    See_Also:
        $(D SDL_GetJoystickProductVersion)
        $(D SDL_GetJoysticks)
*/
extern Uint16 SDL_GetJoystickProductVersionForID(SDL_JoystickID instance_id);

/**
    Get the type of a joystick, if available.
    
    This can be called before any joysticks are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the SDL_JoystickType of the selected joystick. If called with an
        invalid instance_id, this function returns
        `SDL_JOYSTICK_TYPE_UNKNOWN`.
    
    See_Also:
        $(D SDL_GetJoystickType)
        $(D SDL_GetJoysticks)
*/
extern SDL_JoystickType SDL_GetJoystickTypeForID(SDL_JoystickID instance_id);

/**
    Open a joystick for use.
    
    The joystick subsystem must be initialized before a joystick can be opened
    for use.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        a joystick identifier or NULL on failure; call SDL_GetError() for
        more information.
    
    See_Also:
        $(D SDL_CloseJoystick)
*/
extern SDL_Joystick* SDL_OpenJoystick(SDL_JoystickID instance_id);

/**
    Get the SDL_Joystick associated with an instance ID, if it has been opened.
    
    Params:
        instance_id = the instance ID to get the SDL_Joystick for.
    
    Returns:
        An SDL_Joystick on success or NULL on failure or if it hasn't been
        opened yet; call SDL_GetError() for more information.
*/
extern SDL_Joystick* SDL_GetJoystickFromID(SDL_JoystickID instance_id);

/**
    Get the SDL_Joystick associated with a player index.

    Params:
        player_index = the player index to get the SDL_Joystick for.
    
    Returns:
        An SDL_Joystick on success or NULL on failure; call SDL_GetError()
        for more information.

    See_Also:
        $(D SDL_GetJoystickPlayerIndex)
        $(D SDL_SetJoystickPlayerIndex)
*/
extern SDL_Joystick* SDL_GetJoystickFromPlayerIndex(int player_index);

/**
    The structure that describes a virtual joystick touchpad.

    See_Also:
        $(D SDL_VirtualJoystickDesc)
*/
struct SDL_VirtualJoystickTouchpadDesc {

    /**
        The number of simultaneous fingers on this touchpad
    */
    Uint16[3] nfingers;
    Uint16 padding;
}

/**
    The structure that describes a virtual joystick sensor.

    See_Also:
        $(D SDL_VirtualJoystickDesc)
*/
struct SDL_VirtualJoystickSensorDesc {

    /**
        The type of this sensor
    */
    SDL_SensorType type;

    /**
        The update frequency of this sensor, may be 0.0f
    */
    float rate;
}

/**
    The structure that describes a virtual joystick.

    This structure should be initialized using SDL_INIT_INTERFACE(). All
    elements of this structure are optional.

    See_Also:
        $(D SDL_AttachVirtualJoystick)
        $(D SDL_INIT_INTERFACE)
        $(D SDL_VirtualJoystickSensorDesc)
        $(D SDL_VirtualJoystickTouchpadDesc)
*/
struct SDL_VirtualJoystickDesc {

    /**
        the version of this interface
    */
    Uint32 version_;

    /**
        `SDL_JoystickType`
    */
    Uint16 type;

    /**
        unused
    */
    Uint16 padding;

    /**
        the USB vendor ID of this joystick
    */
    Uint16 vendor_id;

    /**
        the USB product ID of this joystick
    */
    Uint16 product_id;

    /**
        the number of axes on this joystick
    */
    Uint16 naxes;

    /**
        the number of buttons on this joystick
    */
    Uint16 nbuttons;

    /**
        the number of balls on this joystick
    */
    Uint16 nballs;

    /**
        the number of hats on this joystick
    */
    Uint16 nhats;

    /**
        the number of touchpads on this joystick, requires `touchpads` to point at valid descriptions
    */
    Uint16 ntouchpads;

    /**
        the number of sensors on this joystick, requires `sensors` to point at valid descriptions
    */
    Uint16 nsensors;

    /**
        unused
    */
    Uint16[2] padding2;

    /**
        A mask of which buttons are valid for this controller
        e.g. (1 << SDL_GAMEPAD_BUTTON_SOUTH)
    */
    Uint32 button_mask;

    /**
        A mask of which axes are valid for this controller
        e.g. (1 << SDL_GAMEPAD_AXIS_LEFTX)
    */
    Uint32 axis_mask;

    /**
        The name of the joystick
    */
    const(char)* name;

    /**
        A pointer to an array of touchpad descriptions, required if `ntouchpads` is > 0
    */
    const(SDL_VirtualJoystickTouchpadDesc)* touchpads;

    /**
        A pointer to an array of sensor descriptions, required if `nsensors` is > 0
    */
    const(SDL_VirtualJoystickSensorDesc)* sensors;

    /**
        User data pointer passed to callbacks
    */
    void* userdata;

    /**
        Called when the joystick state should be updated
    */
    void function(void* userdata) Update;

    /**
        Called when the player index is set
    */
    void function(void* userdata, int player_index) SetPlayerIndex;

    /**
        Implements SDL_RumbleJoystick()
    */
    bool function(void* userdata, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble) Rumble;

    /**
        Implements SDL_RumbleJoystickTriggers()
    */
    bool function(void* userdata, Uint16 left_rumble, Uint16 right_rumble) RumbleTriggers;

    /**
        Implements SDL_SetJoystickLED()
    */
    bool function(void* userdata, Uint8 red, Uint8 green, Uint8 blue) SetLED;

    /**
        Implements SDL_SendJoystickEffect()
    */
    bool function(void* userdata, const void* data, int size) SendEffect;
    /**
        Implements SDL_SetGamepadSensorEnabled()
    */
    bool function(void* userdata, bool enabled) SetSensorsEnabled;

    /**
        Cleans up the userdata when the joystick is detached
    */
    void function(void* userdata) Cleanup;
}

/*
    Check the size of SDL_VirtualJoystickDesc

    If this assert fails, either the compiler is padding to an unexpected size,
    or the interface has been updated and this should be updated to match and
    the code using this interface should be updated to handle the old version.
*/
static assert(
    ((void*).sizeof == 4 && SDL_VirtualJoystickDesc.sizeof == 84) ||
        ((void*).sizeof == 8 && SDL_VirtualJoystickDesc.sizeof == 136),
        "SDL_VirtualJoystickDesc size mismatched!"
);

/**
    Attach a new virtual joystick.
    
    Params:
        desc = joystick description, initialized using SDL_INIT_INTERFACE().
    
    Returns:
        The joystick instance ID, or 0 on failure; call SDL_GetError() for
        more information.
    
    See_Also:
        $(D SDL_DetachVirtualJoystick)
*/
extern SDL_JoystickID SDL_AttachVirtualJoystick(const SDL_VirtualJoystickDesc* desc);

/**
    Detach a virtual joystick.

    Params:
        instance_id =   the joystick instance ID, previously returned from
                        SDL_AttachVirtualJoystick().
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_AttachVirtualJoystick)
*/
extern bool SDL_DetachVirtualJoystick(SDL_JoystickID instance_id);

/**
    Query whether or not a joystick is virtual.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        true if the joystick is virtual, false otherwise.
*/
extern bool SDL_IsJoystickVirtual(SDL_JoystickID instance_id);

/**
    Set the state of an axis on an opened virtual joystick.
    
    Please note that values set here will not be applied until the next call to
    SDL_UpdateJoysticks, which can either be called directly, or can be called
    indirectly through various other SDL APIs, including, but not limited to
    the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
    SDL_WaitEvent.
    
    Note that when sending trigger axes, you should scale the value to the full
    range of Sint16. For example, a trigger at rest would have the value of
    `SDL_JOYSTICK_AXIS_MIN`.
    
    Params:
        joystick =  the virtual joystick on which to set state.
        axis =      the index of the axis on the virtual joystick to update.
        value =     the new value for the specified axis.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SetJoystickVirtualAxis(SDL_Joystick* joystick, int axis, Sint16 value);

/**
    Generate ball motion on an opened virtual joystick.
    
    Please note that values set here will not be applied until the next call to
    SDL_UpdateJoysticks, which can either be called directly, or can be called
    indirectly through various other SDL APIs, including, but not limited to
    the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
    SDL_WaitEvent.
    
    Params:
        joystick =  the virtual joystick on which to set state.
        ball =      the index of the ball on the virtual joystick to update.
        xrel =      the relative motion on the X axis.
        yrel =      the relative motion on the Y axis.

    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SetJoystickVirtualBall(SDL_Joystick* joystick, int ball, Sint16 xrel, Sint16 yrel);

/**
    Set the state of a button on an opened virtual joystick.
    
    Please note that values set here will not be applied until the next call to
    SDL_UpdateJoysticks, which can either be called directly, or can be called
    indirectly through various other SDL APIs, including, but not limited to
    the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
    SDL_WaitEvent.
    
    Params:
        joystick =  the virtual joystick on which to set state.
        button =    the index of the button on the virtual joystick to update.
        down =      true if the button is pressed, false otherwise.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SetJoystickVirtualButton(SDL_Joystick* joystick, int button, bool down);

/**
    Set the state of a hat on an opened virtual joystick.
    
    Please note that values set here will not be applied until the next call to
    SDL_UpdateJoysticks, which can either be called directly, or can be called
    indirectly through various other SDL APIs, including, but not limited to
    the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
    SDL_WaitEvent.
    
    Params:
        joystick =  the virtual joystick on which to set state.
        hat =       the index of the hat on the virtual joystick to update.
        value =     the new value for the specified hat.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SetJoystickVirtualHat(SDL_Joystick* joystick, int hat, Uint8 value);

/**
    Set touchpad finger state on an opened virtual joystick.
    
    Please note that values set here will not be applied until the next call to
    SDL_UpdateJoysticks, which can either be called directly, or can be called
    indirectly through various other SDL APIs, including, but not limited to
    the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
    SDL_WaitEvent.
    
    Params:
        joystick =  the virtual joystick on which to set state.
        touchpad =  the index of the touchpad on the virtual joystick to
                    update.
        finger =    the index of the finger on the touchpad to set.
        down =      true if the finger is pressed, false if the finger is released.
        x =         the x coordinate of the finger on the touchpad, normalized 0 to 1,
                    with the origin in the upper left.
        y =         the y coordinate of the finger on the touchpad, normalized 0 to 1,
                    with the origin in the upper left.
        pressure =  the pressure of the finger.

    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SetJoystickVirtualTouchpad(SDL_Joystick* joystick, int touchpad, int finger, bool down, float x, float y, float pressure);

/**
    Send a sensor update for an opened virtual joystick.
    
    Please note that values set here will not be applied until the next call to
    SDL_UpdateJoysticks, which can either be called directly, or can be called
    indirectly through various other SDL APIs, including, but not limited to
    the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
    SDL_WaitEvent.
    
    Params:
        joystick =          the virtual joystick on which to set state.
        type =              the type of the sensor on the virtual joystick to update.
        sensor_timestamp =  a 64-bit timestamp in nanoseconds associated with
                            the sensor reading.
        data =              the data associated with the sensor reading.
        num_values =        the number of values pointed to by `data`.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SendJoystickVirtualSensorData(SDL_Joystick* joystick, SDL_SensorType type, Uint64 sensor_timestamp, const float* data, int num_values);

/**
    Get the properties associated with a joystick.
    
    The following read-only properties are provided by SDL:
    
    -   `SDL_PROP_JOYSTICK_CAP_MONO_LED_BOOLEAN`: true if this joystick has an
        LED that has adjustable brightness
    -   `SDL_PROP_JOYSTICK_CAP_RGB_LED_BOOLEAN`: true if this joystick has an LED
        that has adjustable color
    -   `SDL_PROP_JOYSTICK_CAP_PLAYER_LED_BOOLEAN`: true if this joystick has a
        player LED
    -   `SDL_PROP_JOYSTICK_CAP_RUMBLE_BOOLEAN`: true if this joystick has
        left/right rumble
    -   `SDL_PROP_JOYSTICK_CAP_TRIGGER_RUMBLE_BOOLEAN`: true if this joystick has
        simple trigger rumble
    
    Params:
        joystick = The SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        A valid property ID on success or 0 on failure; call
        SDL_GetError() for more information.
*/
extern SDL_PropertiesID SDL_GetJoystickProperties(SDL_Joystick* joystick);

enum SDL_PROP_JOYSTICK_CAP_MONO_LED_BOOLEAN = "SDL.joystick.cap.mono_led";
enum SDL_PROP_JOYSTICK_CAP_RGB_LED_BOOLEAN = "SDL.joystick.cap.rgb_led";
enum SDL_PROP_JOYSTICK_CAP_PLAYER_LED_BOOLEAN = "SDL.joystick.cap.player_led";
enum SDL_PROP_JOYSTICK_CAP_RUMBLE_BOOLEAN = "SDL.joystick.cap.rumble";
enum SDL_PROP_JOYSTICK_CAP_TRIGGER_RUMBLE_BOOLEAN = "SDL.joystick.cap.trigger_rumble";

/**
    Get the implementation dependent name of a joystick.
    
    Params:
        joystick = The SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The name of the selected joystick. If no name can be found, this
        function returns NULL; call SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_GetJoystickNameForID)
*/
extern const(char)* SDL_GetJoystickName(SDL_Joystick* joystick);

/**
    Get the implementation dependent path of a joystick.

    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The path of the selected joystick. If no path can be found, this
        function returns NULL; call SDL_GetError() for more information.

    See_Also:
        $(D SDL_GetJoystickPathForID)
*/
extern const(char)* SDL_GetJoystickPath(SDL_Joystick* joystick);

/**
    Get the player index of an opened joystick.
    
    For XInput controllers this returns the XInput user index. Many joysticks
    will not be able to supply this information.
    
    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The player index, or -1 if it's not available.
    
    See_Also:
        $(D SDL_SetJoystickPlayerIndex)
*/
extern int SDL_GetJoystickPlayerIndex(SDL_Joystick* joystick);

/**
    Set the player index of an opened joystick.
    
    Params:
        joystick =      the SDL_Joystick obtained from SDL_OpenJoystick().
        player_index =  player index to assign to this joystick, or -1 to clear
                        the player index and turn off player LEDs.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
    
    See_Also:
        $(D SDL_GetJoystickPlayerIndex)
*/
extern bool SDL_SetJoystickPlayerIndex(SDL_Joystick* joystick, int player_index);

/**
    Get the implementation-dependent GUID for the joystick.

    This function requires an open joystick.

    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The GUID of the given joystick. If called on an invalid index,
        this function returns a zero GUID; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetJoystickGUIDForID)
        $(D SDL_GUIDToString)
*/
extern SDL_GUID SDL_GetJoystickGUID(SDL_Joystick* joystick);

/**
    Get the USB vendor ID of an opened joystick, if available.

    If the vendor ID isn't available this function returns 0.

    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The USB vendor ID of the selected joystick, or 0 if unavailable.

    See_Also:
        $(D SDL_GetJoystickVendorForID)
*/
extern Uint16 SDL_GetJoystickVendor(SDL_Joystick* joystick);

/**
    Get the USB product ID of an opened joystick, if available.

    If the product ID isn't available this function returns 0.

    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The USB product ID of the selected joystick, or 0 if unavailable.

    See_Also:
        $(D SDL_GetJoystickProductForID)
*/
extern Uint16 SDL_GetJoystickProduct(SDL_Joystick* joystick);

/**
    Get the product version of an opened joystick, if available.
    
    If the product version isn't available this function returns 0.
    
    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The product version of the selected joystick, or 0 if unavailable.
    
    See_Also:
        $(D SDL_GetJoystickProductVersionForID)
*/
extern Uint16 SDL_GetJoystickProductVersion(SDL_Joystick* joystick);

/**
    Get the firmware version of an opened joystick, if available.
    
    If the firmware version isn't available this function returns 0.
    
    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The firmware version of the selected joystick, or 0 if
        unavailable.
*/
extern Uint16 SDL_GetJoystickFirmwareVersion(SDL_Joystick* joystick);

/**
    Get the serial number of an opened joystick, if available.

    Returns the serial number of the joystick, or NULL if it is not available.

    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The serial number of the selected joystick, or NULL if
        unavailable.
*/
extern const(char)* SDL_GetJoystickSerial(SDL_Joystick* joystick);

/**
    Get the type of an opened joystick.
    
    Params:
        joystick = the SDL_Joystick obtained from SDL_OpenJoystick().
    
    Returns:
        The SDL_JoystickType of the selected joystick.
    
    See_Also:
        $(D SDL_GetJoystickTypeForID)
*/
extern SDL_JoystickType SDL_GetJoystickType(SDL_Joystick* joystick);

/**
    Get the device information encoded in a SDL_GUID structure.
    
    Params
        guid =      the SDL_GUID you wish to get info about.
        vendor =    a pointer filled in with the device VID, or 0 if not
                    available.
        product =   a pointer filled in with the device PID, or 0 if not
                    available.
        version_ =  a pointer filled in with the device version, or 0 if not
                    available.
        crc16 =     a pointer filled in with a CRC used to distinguish different
                    products with the same VID/PID, or 0 if not available.
    
    See_Also:
        $(D SDL_GetJoystickGUIDForID)
*/
extern void SDL_GetJoystickGUIDInfo(SDL_GUID guid, Uint16* vendor, Uint16* product, Uint16* version_, Uint16* crc16);

/**
    Get the status of a specified joystick.
    
    Params:
        joystick = the joystick to query.
    
    Returns:
        true if the joystick has been opened, false if it has not; call
        SDL_GetError() for more information.
*/
extern bool SDL_JoystickConnected(SDL_Joystick* joystick);

/**
    Get the instance ID of an opened joystick.
    
    Params:
        joystick = an SDL_Joystick structure containing joystick information.
    
    Returns:
        The instance ID of the specified joystick on success or 0 on
        failure; call SDL_GetError() for more information.
*/
extern SDL_JoystickID SDL_GetJoystickID(SDL_Joystick* joystick);

/**
    Get the number of general axis controls on a joystick.
    
    Often, the directional pad on a game controller will either look like 4
    separate buttons or a POV hat, and not axes, but all of this is up to the
    device and platform.
    
    Params:
        joystick an SDL_Joystick structure containing joystick information.
    
    Returns:
        The number of axis controls/number of axes on success or -1 on
        failure; call SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_GetJoystickAxis)
        $(D SDL_GetNumJoystickBalls)
        $(D SDL_GetNumJoystickButtons)
        $(D SDL_GetNumJoystickHats)
*/
extern int SDL_GetNumJoystickAxes(SDL_Joystick* joystick);

/**
    Get the number of trackballs on a joystick.
    
    Joystick trackballs have only relative motion events associated with them
    and their state cannot be polled.
    
    Most joysticks do not have trackballs.
    
    Params:
        joystick = an SDL_Joystick structure containing joystick information.
    
    Returns:
        the number of trackballs on success or -1 on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_GetJoystickBall)
        $(D SDL_GetNumJoystickAxes)
        $(D SDL_GetNumJoystickButtons)
        $(D SDL_GetNumJoystickHats)
*/
extern int SDL_GetNumJoystickBalls(SDL_Joystick* joystick);

/**
    Get the number of POV hats on a joystick.
    
    Params:
        joystick = an SDL_Joystick structure containing joystick information.
    
    Returns:
        the number of POV hats on success or -1 on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_GetJoystickHat)
        $(D SDL_GetNumJoystickAxes)
        $(D SDL_GetNumJoystickBalls)
        $(D SDL_GetNumJoystickButtons)
*/
extern int SDL_GetNumJoystickHats(SDL_Joystick* joystick);

/**
    Get the number of buttons on a joystick.

    Params:
        joystick = an SDL_Joystick structure containing joystick information.
    
    Returns:
        The number of buttons on success or -1 on failure; call
        SDL_GetError() for more information.

    See_Also:
        $(D SDL_GetJoystickButton)
        $(D SDL_GetNumJoystickAxes)
        $(D SDL_GetNumJoystickBalls)
        $(D SDL_GetNumJoystickHats)
*/
extern int SDL_GetNumJoystickButtons(SDL_Joystick* joystick);

/**
    Set the state of joystick event processing.

    If joystick events are disabled, you must call SDL_UpdateJoysticks()
    yourself and check the state of the joystick when you want joystick
    information.

    Params:
        enabled = whether to process joystick events or not.

    See_Also:
        $(D SDL_JoystickEventsEnabled)
        $(D SDL_UpdateJoysticks)
*/
extern void SDL_SetJoystickEventsEnabled(bool enabled);

/**
    Query the state of joystick event processing.

    If joystick events are disabled, you must call SDL_UpdateJoysticks()
    yourself and check the state of the joystick when you want joystick
    information.

    Returns:
        true if joystick events are being processed, false otherwise.

    See_Also:
        $(D SDL_SetJoystickEventsEnabled)
*/
extern bool SDL_JoystickEventsEnabled();

/**
    Update the current state of the open joysticks.
    
    This is called automatically by the event loop if any joystick events are
    enabled.
*/
extern void SDL_UpdateJoysticks();

/**
    Get the current state of an axis control on a joystick.

    SDL makes no promises about what part of the joystick any given axis refers
    to. Your game should have some sort of configuration UI to let users
    specify what each axis should be bound to. Alternately, SDL's higher-level
    Game Controller API makes a great effort to apply order to this lower-level
    interface, so you know that a specific axis is the "left thumb stick," etc.

    The value returned by SDL_GetJoystickAxis() is a signed integer (-32768 to
    32767) representing the current position of the axis. It may be necessary
    to impose certain tolerances on these values to account for jitter.

    Params:
        joystick =  an SDL_Joystick structure containing joystick information.
        axis =      the axis to query; the axis indices start at index 0.
    
    Returns:
        A 16-bit signed integer representing the current position of the
        axis or 0 on failure; call SDL_GetError() for more information.

    See_Also:
        $(D SDL_GetNumJoystickAxes)
*/
extern Sint16 SDL_GetJoystickAxis(SDL_Joystick* joystick, int axis);

/**
    Get the initial state of an axis control on a joystick.
    
    The state is a value ranging from -32768 to 32767.
    
    The axis indices start at index 0.
    
    Params:
        joystick =  an SDL_Joystick structure containing joystick information.
        axis =      the axis to query; the axis indices start at index 0.
        state =     upon return, the initial value is supplied here.
    
    Returns:
        true if this axis has any initial value, or false if not.
*/
extern bool SDL_GetJoystickAxisInitialState(SDL_Joystick* joystick, int axis, Sint16* state);

/**
    Get the ball axis change since the last poll.

    Trackballs can only return relative motion since the last call to
    SDL_GetJoystickBall(), these motion deltas are placed into `dx` and `dy`.

    Most joysticks do not have trackballs.

    Params:
        joystick =  the SDL_Joystick to query.
        ball =      the ball index to query; ball indices start at index 0.
        dx =        stores the difference in the x axis position since the last poll.
        dy =        stores the difference in the y axis position since the last poll.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetNumJoystickBalls)
*/
extern bool SDL_GetJoystickBall(SDL_Joystick* joystick, int ball, int* dx, int* dy);

/**
    Get the current state of a POV hat on a joystick.
    
    The returned value will be one of the `SDL_HAT_*` values.
    
    Params:
        joystick =  an SDL_Joystick structure containing joystick information.
        hat =       the hat index to get the state from; indices start at index 0.
    
    Returns:
        The current hat position.
    
    See_Also:
        $(D SDL_GetNumJoystickHats)
*/
extern Uint8 SDL_GetJoystickHat(SDL_Joystick* joystick, int hat);

enum Uint8 SDL_HAT_CENTERED = 0x00u;
enum Uint8 SDL_HAT_UP = 0x01u;
enum Uint8 SDL_HAT_RIGHT = 0x02u;
enum Uint8 SDL_HAT_DOWN = 0x04u;
enum Uint8 SDL_HAT_LEFT = 0x08u;
enum Uint8 SDL_HAT_RIGHTUP = (SDL_HAT_RIGHT | SDL_HAT_UP);
enum Uint8 SDL_HAT_RIGHTDOWN = (SDL_HAT_RIGHT | SDL_HAT_DOWN);
enum Uint8 SDL_HAT_LEFTUP = (SDL_HAT_LEFT | SDL_HAT_UP);
enum Uint8 SDL_HAT_LEFTDOWN = (SDL_HAT_LEFT | SDL_HAT_DOWN);

/**
    Get the current state of a button on a joystick.
    
    Params:
        joystick =  an SDL_Joystick structure containing joystick information.
        button =    the button index to get the state from; indices start at
                    index 0.
    
    Returns:
        true if the button is pressed, false otherwise.
    
    See_Also:
        $(D SDL_GetNumJoystickButtons)
*/
extern bool SDL_GetJoystickButton(SDL_Joystick* joystick, int button);

/**
    Start a rumble effect.
    
    Each call to this function cancels any previous rumble effect, and calling
    it with 0 intensity stops any rumbling.
    
    This function requires you to process SDL events or call
    SDL_UpdateJoysticks() to update rumble state.
    
    Params:
        joystick =              the joystick to vibrate.
        low_frequency_rumble =  the intensity of the low frequency (left)
                                rumble motor, from 0 to 0xFFFF.
        high_frequency_rumble = the intensity of the high frequency (right)
                                rumble motor, from 0 to 0xFFFF.
        duration_ms =           the duration of the rumble effect, in milliseconds.
    
    Returns:
        true, or false if rumble isn't supported on this joystick.
*/
extern bool SDL_RumbleJoystick(SDL_Joystick* joystick, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms);

/**
    Start a rumble effect in the joystick's triggers.
    
    Each call to this function cancels any previous trigger rumble effect, and
    calling it with 0 intensity stops any rumbling.
    
    Note that this is rumbling of the _triggers_ and not the game controller as
    a whole. This is currently only supported on Xbox One controllers. If you
    want the (more common) whole-controller rumble, use SDL_RumbleJoystick()
    instead.
    
    This function requires you to process SDL events or call
    SDL_UpdateJoysticks() to update rumble state.
    
    Params:
        joystick =      the joystick to vibrate.
        left_rumble =   the intensity of the left trigger rumble motor, from 0
                        to 0xFFFF.
        right_rumble =  the intensity of the right trigger rumble motor, from 0
                        to 0xFFFF.
        duration_ms =   the duration of the rumble effect, in milliseconds.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
    
    See_Also:
        $(D SDL_RumbleJoystick)
*/
extern bool SDL_RumbleJoystickTriggers(SDL_Joystick* joystick, Uint16 left_rumble, Uint16 right_rumble, Uint32 duration_ms);

/**
    Update a joystick's LED color.
    
    An example of a joystick LED is the light on the back of a PlayStation 4's
    DualShock 4 controller.
    
    For joysticks with a single color LED, the maximum of the RGB values will
    be used as the LED brightness.
    
    Params:
        joystick =  the joystick to update.
        red =       the intensity of the red LED.
        green =     the intensity of the green LED.
        blue =      the intensity of the blue LED.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SetJoystickLED(SDL_Joystick* joystick, Uint8 red, Uint8 green, Uint8 blue);

/**
    Send a joystick specific effect packet.

    Params:
        joystick =  the joystick to affect.
        data =      the data to send to the joystick.
        size =      the size of the data to send to the joystick.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_SendJoystickEffect(SDL_Joystick* joystick, const void* data, int size);

/**
    Close a joystick previously opened with SDL_OpenJoystick().
    
    Params:
        joystick = the joystick device to close.
    
    See_Also:
        $(D SDL_OpenJoystick)
*/
extern void SDL_CloseJoystick(SDL_Joystick* joystick);

/**
    Get the connection state of a joystick.
    
    Params:
        joystick = the joystick to query.
    
    Returns:
        the connection state on success or
        `SDL_JOYSTICK_CONNECTION_INVALID` on failure; call SDL_GetError()
        for more information.
*/
extern SDL_JoystickConnectionState SDL_GetJoystickConnectionState(SDL_Joystick* joystick);

/**
    Get the battery state of a joystick.

    You should never take a battery status as absolute truth. Batteries
    (especially failing batteries) are delicate hardware, and the values
    reported here are best estimates based on what that hardware reports. It's
    not uncommon for older batteries to lose stored power much faster than it
    reports, or completely drain when reporting it has 20 percent left, etc.

    Params:
        joystick =  the joystick to query.
        percent =   a pointer filled in with the percentage of battery life
                    left, between 0 and 100, or NULL to ignore. This will be
                    filled in with -1 we can't determine a value or there is no
                    battery.

    Returns:
        the current battery state or `SDL_POWERSTATE_ERROR` on failure;
        call SDL_GetError() for more information.
*/
extern SDL_PowerState SDL_GetJoystickPowerInfo(SDL_Joystick* joystick, int* percent);
