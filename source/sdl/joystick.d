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
import sdl.types;

extern(C) nothrow @nogc:

/**
 * The joystick structure used to identify an SDL joystick.
 *
 * This is opaque data.
 *
 * \since This struct is available since SDL 3.2.0.
 */
struct SDL_Joystick;

/**
 * This is a unique ID for a joystick for the time it is connected to the
 * system, and is never reused for the lifetime of the application.
 *
 * If the joystick is disconnected and reconnected, it will get a new ID.
 *
 * The value 0 is an invalid ID.
 *
 * \since This datatype is available since SDL 3.2.0.
 */
alias SDL_JoystickID = Uint32;

/**
 * An enum of some common joystick types.
 *
 * In some cases, SDL can identify a low-level joystick as being a certain
 * type of device, and will report it through SDL_GetJoystickType (or
 * SDL_GetJoystickTypeForID).
 *
 * This is by no means a complete list of everything that can be plugged into
 * a computer.
 *
 * \since This enum is available since SDL 3.2.0.
 */
enum SDL_JoystickType
{
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
 * Possible connection states for a joystick device.
 *
 * This is used by SDL_GetJoystickConnectionState to report how a device is
 * connected to the system.
 *
 * \since This enum is available since SDL 3.2.0.
 */
enum SDL_JoystickConnectionState
{
    SDL_JOYSTICK_CONNECTION_INVALID = -1,
    SDL_JOYSTICK_CONNECTION_UNKNOWN,
    SDL_JOYSTICK_CONNECTION_WIRED,
    SDL_JOYSTICK_CONNECTION_WIRELESS
}

/**
 * The largest value an SDL_Joystick's axis can report.
 *
 * \since This macro is available since SDL 3.2.0.
 *
 * \sa SDL_JOYSTICK_AXIS_MIN
 */
enum SDL_JOYSTICK_AXIS_MAX  = 32_767;

/**
 * The smallest value an SDL_Joystick's axis can report.
 *
 * This is a negative number!
 *
 * \since This macro is available since SDL 3.2.0.
 *
 * \sa SDL_JOYSTICK_AXIS_MAX
 */
enum SDL_JOYSTICK_AXIS_MIN = -32_768;