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
    SDL Gamepad

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryGamepad, SDL3 Gamepad Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.gamepad;
import sdl.joystick;
import sdl.properties;
import sdl.iostream;
import sdl.guid;
import sdl.power;
import sdl.sensor;
import sdl.stdc;

extern (C) nothrow @nogc:

/**
    The structure used to identify an SDL gamepad
*/
struct SDL_Gamepad;

/**
    Standard gamepad types.

    This type does not necessarily map to first-party controllers from
    Microsoft/Sony/Nintendo; in many cases, third-party controllers can report
    as these, either because they were designed for a specific console, or they
    simply most closely match that console's controllers (does it have A/B/X/Y
    buttons or X/O/Square/Triangle? Does it have a touchpad? etc).
*/
enum SDL_GamepadType {
    SDL_GAMEPAD_TYPE_UNKNOWN = 0,
    SDL_GAMEPAD_TYPE_STANDARD,
    SDL_GAMEPAD_TYPE_XBOX360,
    SDL_GAMEPAD_TYPE_XBOXONE,
    SDL_GAMEPAD_TYPE_PS3,
    SDL_GAMEPAD_TYPE_PS4,
    SDL_GAMEPAD_TYPE_PS5,
    SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_PRO,
    SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_LEFT,
    SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_RIGHT,
    SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_PAIR,
    SDL_GAMEPAD_TYPE_COUNT
}

/**
    The list of buttons available on a gamepad

    For controllers that use a diamond pattern for the face buttons, the
    south/east/west/north buttons below correspond to the locations in the
    diamond pattern. For Xbox controllers, this would be A/B/X/Y, for Nintendo
    Switch controllers, this would be B/A/Y/X, for PlayStation controllers this
    would be Cross/Circle/Square/Triangle.

    For controllers that don't use a diamond pattern for the face buttons, the
    south/east/west/north buttons indicate the buttons labeled A, B, C, D, or
    1, 2, 3, 4, or for controllers that aren't labeled, they are the primary,
    secondary, etc. buttons.

    The activate action is often the south button and the cancel action is
    often the east button, but in some regions this is reversed, so your game
    should allow remapping actions based on user preferences.

    You can query the labels for the face buttons using
    SDL_GetGamepadButtonLabel()
*/
enum SDL_GamepadButton {
    SDL_GAMEPAD_BUTTON_INVALID = -1,
    SDL_GAMEPAD_BUTTON_SOUTH, /**< Bottom face button (e.g. Xbox A button) */
    SDL_GAMEPAD_BUTTON_EAST, /**< Right face button (e.g. Xbox B button) */
    SDL_GAMEPAD_BUTTON_WEST, /**< Left face button (e.g. Xbox X button) */
    SDL_GAMEPAD_BUTTON_NORTH, /**< Top face button (e.g. Xbox Y button) */
    SDL_GAMEPAD_BUTTON_BACK,
    SDL_GAMEPAD_BUTTON_GUIDE,
    SDL_GAMEPAD_BUTTON_START,
    SDL_GAMEPAD_BUTTON_LEFT_STICK,
    SDL_GAMEPAD_BUTTON_RIGHT_STICK,
    SDL_GAMEPAD_BUTTON_LEFT_SHOULDER,
    SDL_GAMEPAD_BUTTON_RIGHT_SHOULDER,
    SDL_GAMEPAD_BUTTON_DPAD_UP,
    SDL_GAMEPAD_BUTTON_DPAD_DOWN,
    SDL_GAMEPAD_BUTTON_DPAD_LEFT,
    SDL_GAMEPAD_BUTTON_DPAD_RIGHT,
    SDL_GAMEPAD_BUTTON_MISC1, /**< Additional button (e.g. Xbox Series X share button, PS5 microphone button, Nintendo Switch Pro capture button, Amazon Luna microphone button, Google Stadia capture button) */
    SDL_GAMEPAD_BUTTON_RIGHT_PADDLE1, /**< Upper or primary paddle, under your right hand (e.g. Xbox Elite paddle P1) */
    SDL_GAMEPAD_BUTTON_LEFT_PADDLE1, /**< Upper or primary paddle, under your left hand (e.g. Xbox Elite paddle P3) */
    SDL_GAMEPAD_BUTTON_RIGHT_PADDLE2, /**< Lower or secondary paddle, under your right hand (e.g. Xbox Elite paddle P2) */
    SDL_GAMEPAD_BUTTON_LEFT_PADDLE2, /**< Lower or secondary paddle, under your left hand (e.g. Xbox Elite paddle P4) */
    SDL_GAMEPAD_BUTTON_TOUCHPAD, /**< PS4/PS5 touchpad button */
    SDL_GAMEPAD_BUTTON_MISC2, /**< Additional button */
    SDL_GAMEPAD_BUTTON_MISC3, /**< Additional button */
    SDL_GAMEPAD_BUTTON_MISC4, /**< Additional button */
    SDL_GAMEPAD_BUTTON_MISC5, /**< Additional button */
    SDL_GAMEPAD_BUTTON_MISC6, /**< Additional button */
    SDL_GAMEPAD_BUTTON_COUNT
}

/**
    The set of gamepad button labels

    This isn't a complete set, just the face buttons to make it easy to show
    button prompts.

    For a complete set, you should look at the button and gamepad type and have
    a set of symbols that work well with your art style.
*/
enum SDL_GamepadButtonLabel {
    SDL_GAMEPAD_BUTTON_LABEL_UNKNOWN,
    SDL_GAMEPAD_BUTTON_LABEL_A,
    SDL_GAMEPAD_BUTTON_LABEL_B,
    SDL_GAMEPAD_BUTTON_LABEL_X,
    SDL_GAMEPAD_BUTTON_LABEL_Y,
    SDL_GAMEPAD_BUTTON_LABEL_CROSS,
    SDL_GAMEPAD_BUTTON_LABEL_CIRCLE,
    SDL_GAMEPAD_BUTTON_LABEL_SQUARE,
    SDL_GAMEPAD_BUTTON_LABEL_TRIANGLE
}

/**
    The list of axes available on a gamepad

    Thumbstick axis values range from SDL_JOYSTICK_AXIS_MIN to
    SDL_JOYSTICK_AXIS_MAX, and are centered within ~8000 of zero, though
    advanced UI will allow users to set or autodetect the dead zone, which
    varies between gamepads.

    Trigger axis values range from 0 (released) to SDL_JOYSTICK_AXIS_MAX (fully
    pressed) when reported by SDL_GetGamepadAxis(). Note that this is not the
    same range that will be reported by the lower-level SDL_GetJoystickAxis().
*/
enum SDL_GamepadAxis {
    SDL_GAMEPAD_AXIS_INVALID = -1,
    SDL_GAMEPAD_AXIS_LEFTX,
    SDL_GAMEPAD_AXIS_LEFTY,
    SDL_GAMEPAD_AXIS_RIGHTX,
    SDL_GAMEPAD_AXIS_RIGHTY,
    SDL_GAMEPAD_AXIS_LEFT_TRIGGER,
    SDL_GAMEPAD_AXIS_RIGHT_TRIGGER,
    SDL_GAMEPAD_AXIS_COUNT
}

/**
    Types of gamepad control bindings.

    A gamepad is a collection of bindings that map arbitrary joystick buttons,
    axes and hat switches to specific positions on a generic console-style
    gamepad. This enum is used as part of SDL_GamepadBinding to specify those
    mappings.
*/
enum SDL_GamepadBindingType {
    SDL_GAMEPAD_BINDTYPE_NONE = 0,
    SDL_GAMEPAD_BINDTYPE_BUTTON,
    SDL_GAMEPAD_BINDTYPE_AXIS,
    SDL_GAMEPAD_BINDTYPE_HAT
}

/**
    A mapping between one joystick input to a gamepad control.

    A gamepad has a collection of several bindings, to say, for example, when
    joystick button number 5 is pressed, that should be treated like the
    gamepad's "start" button.

    SDL has these bindings built-in for many popular controllers, and can add
    more with a simple text string. Those strings are parsed into a collection
    of these structs to make it easier to operate on the data.

    See_Also:
        $(D SDL_GetGamepadBindings)
*/
struct SDL_GamepadBinding {
    SDL_GamepadBindingType input_type;
    SDL_GamepadBindingInput input;
    SDL_GamepadBindingType output_type;
    SDL_GamepadBindingOutput output;

    static
    union SDL_GamepadBindingInput {
        int button;

        struct {
            int axis;
            int axis_min;
            int axis_max;
        }

        struct {
            int hat;
            int hat_mask;
        }
    }

    static
    union SDL_GamepadBindingOutput {
        SDL_GamepadButton button;

        struct {
            SDL_GamepadAxis axis;
            int axis_min;
            int axis_max;
        }

    }
}

/**
    Add support for gamepads that SDL is unaware of or change the binding of an
    existing gamepad.
    
    The mapping string has the format "GUID,name,mapping", where GUID is the
    string value from SDL_GUIDToString(), name is the human readable string for
    the device and mappings are gamepad mappings to joystick ones. Under
    Windows there is a reserved GUID of "xinput" that covers all XInput
    devices. The mapping format for joystick is:
    
    - `bX`: a joystick button, index X
    - `hX.Y`: hat X with value Y
    - `aX`: axis X of the joystick
    
    Buttons can be used as a gamepad axes and vice versa.
    
    If a device with this GUID is already plugged in, SDL will generate an
    SDL_EVENT_GAMEPAD_ADDED event.
    
    This string shows an example of a valid mapping for a gamepad:
    
    ---
    "341a3608000000000000504944564944,Afterglow PS3 Controller,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b8,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftshoulder:b4,rightshoulder:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7"
    ---
    
    Params:
        mapping = the mapping string.
    
    Returns:
        1 if a new mapping is added, 0 if an existing mapping is updated,
        -1 on failure; call SDL_GetError() for more information.
    
    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_AddGamepadMappingsFromFile)
        $(D SDL_AddGamepadMappingsFromIO)
        $(D SDL_GetGamepadMapping)
        $(D SDL_GetGamepadMappingForGUID)
        $(D SDL_HINT_GAMECONTROLLERCONFIG)
        $(D SDL_HINT_GAMECONTROLLERCONFIG_FILE)
        $(D SDL_EVENT_GAMEPAD_ADDED)
*/
extern int SDL_AddGamepadMapping(const(char)** mapping);

/**
    Load a set of gamepad mappings from an SDL_IOStream.

    You can call this function several times, if needed, to load different
    database files.

    If a new mapping is loaded for an already known gamepad GUID, the later
    version will overwrite the one currently loaded.

    Any new mappings for already plugged in controllers will generate
    SDL_EVENT_GAMEPAD_ADDED events.

    Mappings not belonging to the current platform or with no platform field
    specified will be ignored (i.e. mappings for Linux will be ignored in
    Windows, etc).

    This function will load the text database entirely in memory before
    processing it, so take this into consideration if you are in a memory
    constrained environment.

    Params:
        src =       the data stream for the mappings to be added.
        closeio =   if true, calls SDL_CloseIO() on `src` before returning, even
                    in the case of an error.
    
    Returns:
        the number of mappings added or -1 on failure; call SDL_GetError()
            for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_AddGamepadMapping)
        $(D SDL_AddGamepadMappingsFromFile)
        $(D SDL_GetGamepadMapping)
        $(D SDL_GetGamepadMappingForGUID)
        $(D SDL_HINT_GAMECONTROLLERCONFIG)
        $(D SDL_HINT_GAMECONTROLLERCONFIG_FILE)
        $(D SDL_EVENT_GAMEPAD_ADDED)
*/
extern int SDL_AddGamepadMappingsFromIO(SDL_IOStream* src, bool closeio);

/**
    Load a set of gamepad mappings from a file.

    You can call this function several times, if needed, to load different
    database files.

    If a new mapping is loaded for an already known gamepad GUID, the later
    version will overwrite the one currently loaded.

    Any new mappings for already plugged in controllers will generate
    SDL_EVENT_GAMEPAD_ADDED events.

    Mappings not belonging to the current platform or with no platform field
    specified will be ignored (i.e. mappings for Linux will be ignored in
    Windows, etc).

    Params:
        file = the mappings file to load.
    
    Returns:
        the number of mappings added or -1 on failure; call SDL_GetError()
        for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_AddGamepadMapping)
        $(D SDL_AddGamepadMappingsFromIO)
        $(D SDL_GetGamepadMapping)
        $(D SDL_GetGamepadMappingForGUID)
        $(D SDL_HINT_GAMECONTROLLERCONFIG)
        $(D SDL_HINT_GAMECONTROLLERCONFIG_FILE)
        $(D SDL_EVENT_GAMEPAD_ADDED)
*/
extern int SDL_AddGamepadMappingsFromFile(const(char)** file);

/**
    Reinitialize the SDL mapping database to its initial state.

    This will generate gamepad events as needed if device mappings change.

    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_ReloadGamepadMappings();

/**
    Get the current gamepad mappings.

    Params:
        count = a pointer filled in with the number of mappings returned, can
                be NULL.
    
    Returns:
        an array of the mapping strings, NULL-terminated, or NULL on
        failure; call SDL_GetError() for more information. This is a
        single allocation that should be freed with SDL_free() when it is
        no longer needed.
*/
extern char** SDL_GetGamepadMappings(int* count);

/**
    Get the gamepad mapping string for a given GUID.

    Params:
        guid =  a structure containing the GUID for which a mapping is desired.
    
    Returns:
        a mapping string or NULL on failure; call SDL_GetError() for more
        information. This should be freed with SDL_free() when it is no
        longer needed.

    See_Also:
        $(D SDL_GetJoystickGUIDForID)
        $(D SDL_GetJoystickGUID)
*/
extern char* SDL_GetGamepadMappingForGUID(SDL_GUID guid);

/**
    Get the current mapping of a gamepad.

    Details about mappings are discussed with SDL_AddGamepadMapping().

    Params:
        gamepad =   the gamepad you want to get the current mapping for.
    
    Returns:
        a string that has the gamepad's mapping or NULL if no mapping is
        available; call SDL_GetError() for more information. This should
        be freed with SDL_free() when it is no longer needed.

    See_Also:
        $(D SDL_AddGamepadMapping)
        $(D SDL_GetGamepadMappingForID)
        $(D SDL_GetGamepadMappingForGUID)
        $(D SDL_SetGamepadMapping)
*/
extern char* SDL_GetGamepadMapping(SDL_Gamepad* gamepad);

/**
    Set the current mapping of a joystick or gamepad.
    
    Details about mappings are discussed with SDL_AddGamepadMapping().
    
    Params:
        instance_id =   the joystick instance ID.
        mapping =       the mapping to use for this device, or NULL to clear the
                        mapping.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_AddGamepadMapping)
        $(D SDL_GetGamepadMapping)
*/
extern bool SDL_SetGamepadMapping(SDL_JoystickID instance_id, const(char)** mapping);

/**
    Return whether a gamepad is currently connected.
    
    Returns:
        true if a gamepad is connected, false otherwise.

    See_Also:
        $(D SDL_GetGamepads)
*/
extern bool SDL_HasGamepad();

/**
    Get a list of currently connected gamepads.
    
    Params:
        count = a pointer filled in with the number of gamepads returned, may
                be NULL.
    
    Returns:
        a 0 terminated array of joystick instance IDs or NULL on failure;
        call SDL_GetError() for more information. This should be freed
        with SDL_free() when it is no longer needed.

    See_Also:
        $(D SDL_HasGamepad)
        $(D SDL_OpenGamepad)
*/
extern SDL_JoystickID* SDL_GetGamepads(int* count);

/**
    Check if the given joystick is supported by the gamepad interface.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        true if the given joystick is supported by the gamepad interface,
        false if it isn't or it's an invalid index.

    See_Also:
        $(D SDL_GetJoysticks)
        $(D SDL_OpenGamepad)
*/
extern bool SDL_IsGamepad(SDL_JoystickID instance_id);

/**
    Get the implementation dependent name of a gamepad.
    
    This can be called before any gamepads are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the name of the selected gamepad. If no name can be found, this
        function returns NULL; call SDL_GetError() for more information.

    See_Also:
        $(D SDL_GetGamepadName)
        $(D SDL_GetGamepads)
*/
extern const(char)** SDL_GetGamepadNameForID(SDL_JoystickID instance_id);

/**
    Get the implementation dependent path of a gamepad.
    
    This can be called before any gamepads are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the path of the selected gamepad. If no path can be found, this
        function returns NULL; call SDL_GetError() for more information.

    See_Also:
        $(D SDL_GetGamepadPath)
        $(D SDL_GetGamepads)
*/
extern const(char)** SDL_GetGamepadPathForID(SDL_JoystickID instance_id);

/**
    Get the player index of a gamepad.
    
    This can be called before any gamepads are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the player index of a gamepad, or -1 if it's not available.

    See_Also:
        $(D SDL_GetGamepadPlayerIndex)
        $(D SDL_GetGamepads)
*/
extern int SDL_GetGamepadPlayerIndexForID(SDL_JoystickID instance_id);

/**
    Get the implementation-dependent GUID of a gamepad.
    
    This can be called before any gamepads are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        the GUID of the selected gamepad. If called on an invalid index,
        this function returns a zero GUID.

    See_Also:
        $(D SDL_GUIDToString)
        $(D SDL_GetGamepads)
*/
extern SDL_GUID SDL_GetGamepadGUIDForID(SDL_JoystickID instance_id);

/**
    Get the USB vendor ID of a gamepad, if available.
    
    This can be called before any gamepads are opened. If the vendor ID isn't
    available this function returns 0.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The USB vendor ID of the selected gamepad. If called on an invalid
        index, this function returns zero.

    See_Also:
        $(D SDL_GetGamepadVendor)
        $(D SDL_GetGamepads)
*/
extern Uint16 SDL_GetGamepadVendorForID(SDL_JoystickID instance_id);

/**
    Get the USB product ID of a gamepad, if available.
    
    This can be called before any gamepads are opened. If the product ID isn't
    available this function returns 0.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The USB product ID of the selected gamepad. If called on an
        invalid index, this function returns zero.

    See_Also:
        $(D SDL_GetGamepadProduct)
        $(D SDL_GetGamepads)
*/
extern Uint16 SDL_GetGamepadProductForID(SDL_JoystickID instance_id);

/**
    Get the product version of a gamepad, if available.
    
    This can be called before any gamepads are opened. If the product version
    isn't available this function returns 0.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The product version of the selected gamepad. If called on an
        invalid index, this function returns zero.

    See_Also:
        $(D SDL_GetGamepadProductVersion)
        $(D SDL_GetGamepads)
*/
extern Uint16 SDL_GetGamepadProductVersionForID(SDL_JoystickID instance_id);

/**
    Get the type of a gamepad.
    
    This can be called before any gamepads are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The gamepad type.

    See_Also:
        $(D SDL_GetGamepadType)
        $(D SDL_GetGamepads)
        $(D SDL_GetRealGamepadTypeForID)
*/
extern SDL_GamepadType SDL_GetGamepadTypeForID(SDL_JoystickID instance_id);

/**
    Get the type of a gamepad, ignoring any mapping override.
    
    This can be called before any gamepads are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The gamepad type.

    See_Also:
        $(D SDL_GetGamepadTypeForID)
        $(D SDL_GetGamepads)
        $(D SDL_GetRealGamepadType)
*/
extern SDL_GamepadType SDL_GetRealGamepadTypeForID(SDL_JoystickID instance_id);

/**
    Get the mapping of a gamepad.
    
    This can be called before any gamepads are opened.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        The mapping string. Returns NULL if no mapping is available. This
        should be freed with SDL_free() when it is no longer needed.

    See_Also:
        $(D SDL_GetGamepads)
        $(D SDL_GetGamepadMapping)
*/
extern char* SDL_GetGamepadMappingForID(SDL_JoystickID instance_id);

/**
    Open a gamepad for use.
    
    Params:
        instance_id = the joystick instance ID.
    
    Returns:
        A gamepad identifier or NULL if an error occurred; call
        SDL_GetError() for more information.

    See_Also:
        $(D SDL_CloseGamepad)
        $(D SDL_IsGamepad)
*/
extern SDL_Gamepad* SDL_OpenGamepad(SDL_JoystickID instance_id);

/**
    Get the SDL_Gamepad associated with a joystick instance ID, if it has been
    opened.
    
    Params:
        instance_id = the joystick instance ID of the gamepad.
    
    Returns:
        An SDL_Gamepad on success or NULL on failure or if it hasn't been
        opened yet; call SDL_GetError() for more information.
*/
extern SDL_Gamepad* SDL_GetGamepadFromID(SDL_JoystickID instance_id);

/**
    Get the SDL_Gamepad associated with a player index.
    
    Params:
        player_index = the player index, which different from the instance ID.
    
    Returns:
        The SDL_Gamepad associated with a player index.

    See_Also:
        $(D SDL_GetGamepadPlayerIndex)
        $(D SDL_SetGamepadPlayerIndex)
*/
extern SDL_Gamepad* SDL_GetGamepadFromPlayerIndex(int player_index);

/**
    Get the properties associated with an opened gamepad.
    
    These properties are shared with the underlying joystick object.
    
    The following read-only properties are provided by SDL:
    
    -   `SDL_PROP_GAMEPAD_CAP_MONO_LED_BOOLEAN`: true if this gamepad has an LED
        that has adjustable brightness
    -   `SDL_PROP_GAMEPAD_CAP_RGB_LED_BOOLEAN`: true if this gamepad has an LED
        that has adjustable color
    -   `SDL_PROP_GAMEPAD_CAP_PLAYER_LED_BOOLEAN`: true if this gamepad has a
        player LED
    -   `SDL_PROP_GAMEPAD_CAP_RUMBLE_BOOLEAN`: true if this gamepad has
        left/right rumble
    -   `SDL_PROP_GAMEPAD_CAP_TRIGGER_RUMBLE_BOOLEAN`: true if this gamepad has
        simple trigger rumble
    
    Params:
        gamepad =   a gamepad identifier previously returned by
                    SDL_OpenGamepad().
    
    Returns:
        a valid property ID on success or 0 on failure; call
        SDL_GetError() for more information.
*/
extern SDL_PropertiesID SDL_GetGamepadProperties(SDL_Gamepad* gamepad);

enum SDL_PROP_GAMEPAD_CAP_MONO_LED_BOOLEAN = SDL_PROP_JOYSTICK_CAP_MONO_LED_BOOLEAN;
enum SDL_PROP_GAMEPAD_CAP_RGB_LED_BOOLEAN = SDL_PROP_JOYSTICK_CAP_RGB_LED_BOOLEAN;
enum SDL_PROP_GAMEPAD_CAP_PLAYER_LED_BOOLEAN = SDL_PROP_JOYSTICK_CAP_PLAYER_LED_BOOLEAN;
enum SDL_PROP_GAMEPAD_CAP_RUMBLE_BOOLEAN = SDL_PROP_JOYSTICK_CAP_RUMBLE_BOOLEAN;
enum SDL_PROP_GAMEPAD_CAP_TRIGGER_RUMBLE_BOOLEAN = SDL_PROP_JOYSTICK_CAP_TRIGGER_RUMBLE_BOOLEAN;

/**
    Get the instance ID of an opened gamepad.
    
    Params:
        gamepad =   a gamepad identifier previously returned by
                    SDL_OpenGamepad().
    
    Returns:
        the instance ID of the specified gamepad on success or 0 on
        failure; call SDL_GetError() for more information.
*/
extern SDL_JoystickID SDL_GetGamepadID(SDL_Gamepad* gamepad);

/**
    Get the implementation-dependent name for an opened gamepad.
    
    Params:
        gamepad =   a gamepad identifier previously returned by
                    SDL_OpenGamepad().
    
    Returns:
        the implementation dependent name for the gamepad, or NULL if
        there is no name or the identifier passed is invalid.

    See_Also:
        $(D SDL_GetGamepadNameForID)
*/
extern const(char)** SDL_GetGamepadName(SDL_Gamepad* gamepad);

/**
    Get the implementation-dependent path for an opened gamepad.
    
    Params:
        gamepad =   a gamepad identifier previously returned by
                    SDL_OpenGamepad().
    
    Returns:
        the implementation dependent path for the gamepad, or NULL if
        there is no path or the identifier passed is invalid.

    See_Also:
        $(D SDL_GetGamepadPathForID)
*/
extern const(char)** SDL_GetGamepadPath(SDL_Gamepad* gamepad);

/**
    Get the type of an opened gamepad.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the gamepad type, or SDL_GAMEPAD_TYPE_UNKNOWN if it's not
        available.

    See_Also:
        $(D SDL_GetGamepadTypeForID)
*/
extern SDL_GamepadType SDL_GetGamepadType(SDL_Gamepad* gamepad);

/**
    Get the type of an opened gamepad, ignoring any mapping override.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the gamepad type, or SDL_GAMEPAD_TYPE_UNKNOWN if it's not
        available.

    See_Also:
        $(D SDL_GetRealGamepadTypeForID)
*/
extern SDL_GamepadType SDL_GetRealGamepadType(SDL_Gamepad* gamepad);

/**
    Get the player index of an opened gamepad.
    
    For XInput gamepads this returns the XInput user index.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the player index for gamepad, or -1 if it's not available.

    See_Also:
        $(D SDL_SetGamepadPlayerIndex)
*/
extern int SDL_GetGamepadPlayerIndex(SDL_Gamepad* gamepad);

/**
    Set the player index of an opened gamepad.
    
    Params:
        gamepad =       the gamepad object to adjust.
        player_index =  player index to assign to this gamepad, or -1 to clear
                        the player index and turn off player LEDs.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetGamepadPlayerIndex)
*/
extern bool SDL_SetGamepadPlayerIndex(SDL_Gamepad* gamepad, int player_index);

/**
    Get the USB vendor ID of an opened gamepad, if available.
    
    If the vendor ID isn't available this function returns 0.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the USB vendor ID, or zero if unavailable.

    See_Also:
        $(D SDL_GetGamepadVendorForID)
*/
extern Uint16 SDL_GetGamepadVendor(SDL_Gamepad* gamepad);

/**
    Get the USB product ID of an opened gamepad, if available.
    
    If the product ID isn't available this function returns 0.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the USB product ID, or zero if unavailable.

    See_Also:
        $(D SDL_GetGamepadProductForID)
*/
extern Uint16 SDL_GetGamepadProduct(SDL_Gamepad* gamepad);

/**
    Get the product version of an opened gamepad, if available.
    
    If the product version isn't available this function returns 0.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the USB product version, or zero if unavailable.

    See_Also:
        $(D SDL_GetGamepadProductVersionForID)
*/
extern Uint16 SDL_GetGamepadProductVersion(SDL_Gamepad* gamepad);

/**
    Get the firmware version of an opened gamepad, if available.
    
    If the firmware version isn't available this function returns 0.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the gamepad firmware version, or zero if unavailable.
*/
extern Uint16 SDL_GetGamepadFirmwareVersion(SDL_Gamepad* gamepad);

/**
    Get the serial number of an opened gamepad, if available.
    
    Returns the serial number of the gamepad, or NULL if it is not available.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the serial number, or NULL if unavailable.
*/
extern const(char)** SDL_GetGamepadSerial(SDL_Gamepad* gamepad);

/**
    Get the Steam Input handle of an opened gamepad, if available.
    
    Returns an InputHandle_t for the gamepad that can be used with Steam Input
    API: https://partner.steamgames.com/doc/api/ISteamInput
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the gamepad handle, or 0 if unavailable.
*/
extern Uint64 SDL_GetGamepadSteamHandle(SDL_Gamepad* gamepad);

/**
    Get the connection state of a gamepad.
    
    Params:
        gamepad = the gamepad object to query.
    
    Returns:
        the connection state on success or
        `SDL_JOYSTICK_CONNECTION_INVALID` on failure; call SDL_GetError()
        for more information.

*/
extern SDL_JoystickConnectionState SDL_GetGamepadConnectionState(SDL_Gamepad* gamepad);

/**
    Get the battery state of a gamepad.
    
    You should never take a battery status as absolute truth. Batteries
    (especially failing batteries) are delicate hardware, and the values
    reported here are best estimates based on what that hardware reports. It's
    not uncommon for older batteries to lose stored power much faster than it
    reports, or completely drain when reporting it has 20 percent left, etc.
    
    Params:
        gamepad =   the gamepad object to query.
        percent =   a pointer filled in with the percentage of battery life
                    left, between 0 and 100, or NULL to ignore. This will be
                    filled in with -1 we can't determine a value or there is no
                    battery.
    
    Returns:
        the current battery state.
*/
extern SDL_PowerState SDL_GetGamepadPowerInfo(SDL_Gamepad* gamepad, int* percent);

/**
    Check if a gamepad has been opened and is currently connected.
    
    Params:
        gamepad =   a gamepad identifier previously returned by
                    SDL_OpenGamepad().
    
    Returns:
        true if the gamepad has been opened and is currently connected, or
        false if not.

*/
extern bool SDL_GamepadConnected(SDL_Gamepad* gamepad);

/**
    Get the underlying joystick from a gamepad.
    
    This function will give you a SDL_Joystick object, which allows you to use
    the SDL_Joystick functions with a SDL_Gamepad object. This would be useful
    for getting a joystick's position at any given time, even if it hasn't
    moved (moving it would produce an event, which would have the axis' value).
    
    The pointer returned is owned by the SDL_Gamepad. You should not call
    SDL_CloseJoystick() on it, for example, since doing so will likely cause
    SDL to crash.
    
    Params:
        gamepad = the gamepad object that you want to get a joystick from.
    
    Returns:
        an SDL_Joystick object, or NULL on failure; call SDL_GetError()
        for more information.

*/
extern SDL_Joystick* SDL_GetGamepadJoystick(SDL_Gamepad* gamepad);

/**
    Set the state of gamepad event processing.
    
    If gamepad events are disabled, you must call SDL_UpdateGamepads() yourself
    and check the state of the gamepad when you want gamepad information.
    
    Params:
        enabled = whether to process gamepad events or not.

    See_Also:
        $(D SDL_GamepadEventsEnabled)
        $(D SDL_UpdateGamepads)
*/
extern void SDL_SetGamepadEventsEnabled(bool enabled);

/**
    Query the state of gamepad event processing.
    
    If gamepad events are disabled, you must call SDL_UpdateGamepads() yourself
    and check the state of the gamepad when you want gamepad information.
    
    Returns:
        true if gamepad events are being processed, false otherwise.

    See_Also:
        $(D SDL_SetGamepadEventsEnabled)
*/
extern bool SDL_GamepadEventsEnabled();

/**
    Get the SDL joystick layer bindings for a gamepad.
    
    Params:
        gamepad =   a gamepad.
        count =     a pointer filled in with the number of bindings returned.
    
    Returns:
        a NULL terminated array of pointers to bindings or NULL on
        failure; call SDL_GetError() for more information. This is a
        single allocation that should be freed with SDL_free() when it is
        no longer needed.

*/
extern SDL_GamepadBinding** SDL_GetGamepadBindings(SDL_Gamepad* gamepad, int* count);

/**
    Manually pump gamepad updates if not using the loop.
    
    This function is called automatically by the event loop if events are
    enabled. Under such circumstances, it will not be necessary to call this
    function.
*/
extern void SDL_UpdateGamepads();

/**
    Convert a string into SDL_GamepadType enum.
    
    This function is called internally to translate SDL_Gamepad mapping strings
    for the underlying joystick device into the consistent SDL_Gamepad mapping.
    You do not normally need to call this function unless you are parsing
    SDL_Gamepad mappings in your own code.
    
    Params:
        str = string representing a SDL_GamepadType type.
    
    Returns:
        the SDL_GamepadType enum corresponding to the input string, or
        `SDL_GAMEPAD_TYPE_UNKNOWN` if no match was found.

    See_Also:
        $(D SDL_GetGamepadStringForType)
*/
extern SDL_GamepadType SDL_GetGamepadTypeFromString(const(char)** str);

/**
    Convert from an SDL_GamepadType enum to a string.
    
    Params:
        type = an enum value for a given SDL_GamepadType.
    
    Returns:
        a string for the given type, or NULL if an invalid type is
        specified. The string returned is of the format used by
        SDL_Gamepad mapping strings.

    See_Also:
        $(D SDL_GetGamepadTypeFromString)
*/
extern const(char)** SDL_GetGamepadStringForType(SDL_GamepadType type);

/**
    Convert a string into SDL_GamepadAxis enum.
    
    This function is called internally to translate SDL_Gamepad mapping strings
    for the underlying joystick device into the consistent SDL_Gamepad mapping.
    You do not normally need to call this function unless you are parsing
    SDL_Gamepad mappings in your own code.
    
    Note specially that "righttrigger" and "lefttrigger" map to
    `SDL_GAMEPAD_AXIS_RIGHT_TRIGGER` and `SDL_GAMEPAD_AXIS_LEFT_TRIGGER`,
    respectively.
    
    Params:
        str = string representing a SDL_Gamepad axis.
    
    Returns:
        the SDL_GamepadAxis enum corresponding to the input string, or
        `SDL_GAMEPAD_AXIS_INVALID` if no match was found.

    See_Also:
        $(D SDL_GetGamepadStringForAxis)
*/
extern SDL_GamepadAxis SDL_GetGamepadAxisFromString(const(char)** str);

/**
    Convert from an SDL_GamepadAxis enum to a string.
    
    Params:
        axis = an enum value for a given SDL_GamepadAxis.
    
    Returns:
        a string for the given axis, or NULL if an invalid axis is
             specified. The string returned is of the format used by
             SDL_Gamepad mapping strings.

    See_Also:
        $(D SDL_GetGamepadAxisFromString)
*/
extern const(char)** SDL_GetGamepadStringForAxis(SDL_GamepadAxis axis);

/**
    Query whether a gamepad has a given axis.
    
    This merely reports whether the gamepad's mapping defined this axis, as
    that is all the information SDL has about the physical device.
    
    Params:
        gamepad =   a gamepad.
        axis =      an axis enum value (an SDL_GamepadAxis value).
    
    Returns:
        true if the gamepad has this axis, false otherwise.

    See_Also:
        $(D SDL_GamepadHasButton)
        $(D SDL_GetGamepadAxis)
*/
extern bool SDL_GamepadHasAxis(SDL_Gamepad* gamepad, SDL_GamepadAxis axis);

/**
    Get the current state of an axis control on a gamepad.
    
    The axis indices start at index 0.
    
    For thumbsticks, the state is a value ranging from -32768 (up/left) to
    32767 (down/right).
    
    Triggers range from 0 when released to 32767 when fully pressed, and never
    return a negative value. Note that this differs from the value reported by
    the lower-level SDL_GetJoystickAxis(), which normally uses the full range.
    
    Params:
        gamepad =   a gamepad.
        axis =      an axis index (one of the SDL_GamepadAxis values).
    
    Returns:
        axis state (including 0) on success or 0 (also) on failure; call
        SDL_GetError() for more information.

    See_Also:
        $(D SDL_GamepadHasAxis)
        $(D SDL_GetGamepadButton)
*/
extern Sint16 SDL_GetGamepadAxis(SDL_Gamepad* gamepad, SDL_GamepadAxis axis);

/**
    Convert a string into an SDL_GamepadButton enum.
    
    This function is called internally to translate SDL_Gamepad mapping strings
    for the underlying joystick device into the consistent SDL_Gamepad mapping.
    You do not normally need to call this function unless you are parsing
    SDL_Gamepad mappings in your own code.
    
    Params:
        str = string representing a SDL_Gamepad axis.
    
    Returns:
        the SDL_GamepadButton enum corresponding to the input string, or
        `SDL_GAMEPAD_BUTTON_INVALID` if no match was found.

    See_Also:
        $(D SDL_GetGamepadStringForButton)
*/
extern SDL_GamepadButton SDL_GetGamepadButtonFromString(const(char)** str);

/**
    Convert from an SDL_GamepadButton enum to a string.
    
    Params:
        button = an enum value for a given SDL_GamepadButton.
    
    Returns:
        a string for the given button, or NULL if an invalid button is
        specified. The string returned is of the format used by
        SDL_Gamepad mapping strings.

    See_Also:
        $(D SDL_GetGamepadButtonFromString)
*/
extern const(char)** SDL_GetGamepadStringForButton(SDL_GamepadButton button);

/**
    Query whether a gamepad has a given button.
    
    This merely reports whether the gamepad's mapping defined this button, as
    that is all the information SDL has about the physical device.
    
    Params:
        gamepad =   a gamepad.
        button =    a button enum value (an SDL_GamepadButton value).
    
    Returns:
        true if the gamepad has this button, false otherwise.

    See_Also:
        $(D SDL_GamepadHasAxis)
*/
extern bool SDL_GamepadHasButton(SDL_Gamepad* gamepad, SDL_GamepadButton button);

/**
    Get the current state of a button on a gamepad.
    
    Params:
        gamepad =   a gamepad.
        button =    a button index (one of the SDL_GamepadButton values).
    
    Returns:
        true if the button is pressed, false otherwise.

    See_Also:
        $(D SDL_GamepadHasButton)
        $(D SDL_GetGamepadAxis)
*/
extern bool SDL_GetGamepadButton(SDL_Gamepad* gamepad, SDL_GamepadButton button);

/**
    Get the label of a button on a gamepad.
    
    Params:
        type =      the type of gamepad to check.
        button =    a button index (one of the SDL_GamepadButton values).
    
    Returns:
        the SDL_GamepadButtonLabel enum corresponding to the button label.

    See_Also:
        $(D SDL_GetGamepadButtonLabel)
*/
extern SDL_GamepadButtonLabel SDL_GetGamepadButtonLabelForType(SDL_GamepadType type, SDL_GamepadButton button);

/**
    Get the label of a button on a gamepad.
    
    Params:
        gamepad =   a gamepad.
        button =    a button index (one of the SDL_GamepadButton values).
    
    Returns:
        the SDL_GamepadButtonLabel enum corresponding to the button label.

    See_Also:
        $(D SDL_GetGamepadButtonLabelForType)
*/
extern SDL_GamepadButtonLabel SDL_GetGamepadButtonLabel(SDL_Gamepad* gamepad, SDL_GamepadButton button);

/**
    Get the number of touchpads on a gamepad.
    
    Params:
        gamepad = a gamepad.
    
    Returns:
        number of touchpads.

    See_Also:
        $(D SDL_GetNumGamepadTouchpadFingers)
*/
extern int SDL_GetNumGamepadTouchpads(SDL_Gamepad* gamepad);

/**
    Get the number of supported simultaneous fingers on a touchpad on a game
    gamepad.
    
    Params:
        gamepad =   a gamepad.
        touchpad =  a touchpad.
    
    Returns:
        number of supported simultaneous fingers.

    See_Also:
        $(D SDL_GetGamepadTouchpadFinger)
        $(D SDL_GetNumGamepadTouchpads)
*/
extern int SDL_GetNumGamepadTouchpadFingers(SDL_Gamepad* gamepad, int touchpad);

/**
    Get the current state of a finger on a touchpad on a gamepad.
    
    Params:
        gamepad =   a gamepad.
        touchpad =  a touchpad.
        finger =    a finger.
        down =      a pointer filled with true if the finger is down, false
                    otherwise, may be NULL.
        x =         a pointer filled with the x position, normalized 0 to 1, with the
                    origin in the upper left, may be NULL.
        y =         a pointer filled with the y position, normalized 0 to 1, with the
                    origin in the upper left, may be NULL.
        pressure =  a pointer filled with pressure value, may be NULL.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetNumGamepadTouchpadFingers)
*/
extern bool SDL_GetGamepadTouchpadFinger(SDL_Gamepad* gamepad, int touchpad, int finger, bool* down, float* x, float* y, float* pressure);

/**
    Return whether a gamepad has a particular sensor.
    
    Params:
        gamepad =   the gamepad to query.
        type =      the type of sensor to query.
    
    Returns:
        true if the sensor exists, false otherwise.
    
    See_Also:
        $(D SDL_GetGamepadSensorData)
        $(D SDL_GetGamepadSensorDataRate)
        $(D SDL_SetGamepadSensorEnabled)
*/
extern bool SDL_GamepadHasSensor(SDL_Gamepad* gamepad, SDL_SensorType type);

/**
    Set whether data reporting for a gamepad sensor is enabled.
    
    Params:
        gamepad =   the gamepad to update.
        type =      the type of sensor to enable/disable.
        enabled =   whether data reporting should be enabled.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GamepadHasSensor)
        $(D SDL_GamepadSensorEnabled)
*/
extern bool SDL_SetGamepadSensorEnabled(SDL_Gamepad* gamepad, SDL_SensorType type, bool enabled);

/**
    Query whether sensor data reporting is enabled for a gamepad.
    
    Params:
        gamepad =   the gamepad to query.
        type =      the type of sensor to query.
    
    Returns:
        true if the sensor is enabled, false otherwise.

    See_Also:
        $(D SDL_SetGamepadSensorEnabled)
*/
extern bool SDL_GamepadSensorEnabled(SDL_Gamepad* gamepad, SDL_SensorType type);

/**
    Get the data rate (number of events per second) of a gamepad sensor.
    
    Params:
        gamepad =   the gamepad to query.
        type =      the type of sensor to query.
    
    Returns:
        the data rate, or 0.0f if the data rate is not available.

*/
extern float SDL_GetGamepadSensorDataRate(SDL_Gamepad* gamepad, SDL_SensorType type);

/**
    Get the current state of a gamepad sensor.
    
    The number of values and interpretation of the data is sensor dependent.
    See SDL_sensor.h for the details for each type of sensor.
    
    Params:
        gamepad =       the gamepad to query.
        type =          the type of sensor to query.
        data =          a pointer filled with the current sensor state.
        num_values =    the number of values to write to data.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

*/
extern bool SDL_GetGamepadSensorData(SDL_Gamepad* gamepad, SDL_SensorType type, float* data, int num_values);

/**
    Start a rumble effect on a gamepad.
    
    Each call to this function cancels any previous rumble effect, and calling
    it with 0 intensity stops any rumbling.
    
    This function requires you to process SDL events or call
    SDL_UpdateJoysticks() to update rumble state.
    
    Params:
        gamepad =               the gamepad to vibrate.
        low_frequency_rumble =  the intensity of the low frequency (left)
                                rumble motor, from 0 to 0xFFFF.
        high_frequency_rumble = the intensity of the high frequency (right)
                                rumble motor, from 0 to 0xFFFF.
        duration_ms =           the duration of the rumble effect, in milliseconds.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

*/
extern bool SDL_RumbleGamepad(SDL_Gamepad* gamepad, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms);

/**
    Start a rumble effect in the gamepad's triggers.
    
    Each call to this function cancels any previous trigger rumble effect, and
    calling it with 0 intensity stops any rumbling.
    
    Note that this is rumbling of the _triggers_ and not the gamepad as a
    whole. This is currently only supported on Xbox One gamepads. If you want
    the (more common) whole-gamepad rumble, use SDL_RumbleGamepad() instead.
    
    This function requires you to process SDL events or call
    SDL_UpdateJoysticks() to update rumble state.
    
    Params:
        gamepad =       the gamepad to vibrate.
        left_rumble =   the intensity of the left trigger rumble motor, from 0
                        to 0xFFFF.
        right_rumble =  the intensity of the right trigger rumble motor, from 0
                        to 0xFFFF.
        duration_ms =   the duration of the rumble effect, in milliseconds.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_RumbleGamepad)
*/
extern bool SDL_RumbleGamepadTriggers(SDL_Gamepad* gamepad, Uint16 left_rumble, Uint16 right_rumble, Uint32 duration_ms);

/**
    Update a gamepad's LED color.
    
    An example of a joystick LED is the light on the back of a PlayStation 4's
    DualShock 4 controller.
    
    For gamepads with a single color LED, the maximum of the RGB values will be
    used as the LED brightness.
    
    Params:
        gamepad =   the gamepad to update.
        red =       the intensity of the red LED.
        green =     the intensity of the green LED.
        blue =      the intensity of the blue LED.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

*/
extern bool SDL_SetGamepadLED(SDL_Gamepad* gamepad, Uint8 red, Uint8 green, Uint8 blue);

/**
    Send a gamepad specific effect packet.
    
    Params:
        gamepad =   the gamepad to affect.
        data =      the data to send to the gamepad.
        size =      the size of the data to send to the gamepad.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

*/
extern bool SDL_SendGamepadEffect(SDL_Gamepad* gamepad, const(void)** data, int size);

/**
    Close a gamepad previously opened with SDL_OpenGamepad().
    
    Params:
        gamepad =   a gamepad identifier previously returned by
                    SDL_OpenGamepad().
    
    See_Also:
        $(D SDL_OpenGamepad)
*/
extern void SDL_CloseGamepad(SDL_Gamepad* gamepad);

/**
    Return the sfSymbolsName for a given button on a gamepad on Apple
    platforms.
    
    Params:
        gamepad =   the gamepad to query.
        button =    a button on the gamepad.
    
    Returns:
        the sfSymbolsName or NULL if the name can't be found.
    
    See_Also:
        $(D SDL_GetGamepadAppleSFSymbolsNameForAxis)
*/
extern const(char)** SDL_GetGamepadAppleSFSymbolsNameForButton(
    SDL_Gamepad* gamepad, SDL_GamepadButton button);

/**
    Return the sfSymbolsName for a given axis on a gamepad on Apple platforms.
    
    Params:
        gamepad =   the gamepad to query.
        axis =      an axis on the gamepad.
    
    Returns:
        the sfSymbolsName or NULL if the name can't be found.

    See_Also:
        $(D SDL_GetGamepadAppleSFSymbolsNameForButton)
*/
extern const(char)** SDL_GetGamepadAppleSFSymbolsNameForAxis(SDL_Gamepad* gamepad, SDL_GamepadAxis axis);
