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
    SDL Touch Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryTouch, SDL3 Touch Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.touch;
import sdl.stdc;
import sdl.mouse;

extern(C) nothrow @nogc:


/**
    A unique ID for a touch device.

    This ID is valid for the time the device is connected to the system, and is
    never reused for the lifetime of the application.

    The value 0 is an invalid ID.
*/
alias SDL_TouchID = Uint64;

/**
    A unique ID for a single finger on a touch device.
    
    This ID is valid for the time the finger (stylus, etc) is touching and will
    be unique for all fingers currently in contact, so this ID tracks the
    lifetime of a single continuous touch. This value may represent an index, a
    pointer, or some other unique ID, depending on the platform.
    
    The value 0 is an invalid ID.
*/
alias SDL_FingerID = Uint64;


/**
    An enum that describes the type of a touch device.
*/
enum SDL_TouchDeviceType {

    /**
        Invalid
    */
    SDL_TOUCH_DEVICE_INVALID = -1,

    /**
        Touch screen with window-relative coordinates
    */
    SDL_TOUCH_DEVICE_DIRECT,

    /**
        Trackpad with absolute device coordinates
    */
    SDL_TOUCH_DEVICE_INDIRECT_ABSOLUTE,

    /**
        Trackpad with screen cursor-relative coordinates
    */
    SDL_TOUCH_DEVICE_INDIRECT_RELATIVE
}

/**
    Data about a single finger in a multitouch event.

    Each touch event is a collection of fingers that are simultaneously in
    contact with the touch device (so a "touch" can be a "multitouch," in
    reality), and this struct reports details of the specific fingers.

    See_Also:
        $(D SDL_GetTouchFingers)
*/
struct SDL_Finger {
    
    /**
        The finger ID
    */
    SDL_FingerID id;
    
    /**
        The x-axis location of the touch event, normalized (0...1)
    */
    float x;
    
    /**
        The y-axis location of the touch event, normalized (0...1)
    */
    float y;
    
    /**
        The quantity of pressure applied, normalized (0...1)
    */
    float pressure;
}

/**
    The SDL_MouseID for mouse events simulated with touch input.
*/
enum SDL_MouseID SDL_TOUCH_MOUSEID = -1;

/**
    The SDL_TouchID for touch events simulated with mouse input.
*/
enum SDL_TouchID SDL_MOUSE_TOUCHID = -1;


/**
    Get a list of registered touch devices.

    On some platforms SDL first sees the touch device if it was actually used.
    Therefore the returned list might be empty, although devices are available.
    After using all devices at least once the number will be correct.

    Params:
        count = a pointer filled in with the number of devices returned, may
                be $(D null).

    Returns:
        a null-terminated array of touch device IDs or $(D null) on failure; call
        $(D SDL_GetError) for more information. This should be freed with
        $(D SDL_free) when it is no longer needed.
*/
extern SDL_TouchID* SDL_GetTouchDevices(int* count);

/**
    Get the touch device name as reported from the driver.

    Params:
        touchID = the touch device instance ID.
    
    Returns:
        touch device name, or $(D null) on failure; call $(D SDL_GetError) for
        more information.
*/
extern const(char)* SDL_GetTouchDeviceName(SDL_TouchID touchID);

/**
    Get the type of the given touch device.

    Params:
        touchID = the ID of a touch device.

    Returns:
        Touch device type.
*/
extern SDL_TouchDeviceType SDL_GetTouchDeviceType(SDL_TouchID touchID);

/**
    Get a list of active fingers for a given touch device.

    Params:
        touchID =   the ID of a touch device.
        count =     a pointer filled in with the number of fingers returned, can
                    be $(D null).

    Returns:
        A $(D null) terminated array of SDL_Finger pointers or $(D null) on failure;
        call $(D SDL_GetError) for more information. This is a single
        allocation that should be freed with $(D SDL_free) when it is no
        longer needed.
*/
extern SDL_Finger** SDL_GetTouchFingers(SDL_TouchID touchID, int* count);
