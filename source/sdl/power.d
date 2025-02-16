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
    SDL Power Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryPower, SDL3 Mouse Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.power;
import sdl.stdc;

extern(C) nothrow @nogc:

enum SDL_PowerState {
    
    /**
        Error determining power status
    */
    SDL_POWERSTATE_ERROR = -1,   
    
    /**
        Cannot determine power status
    */
    SDL_POWERSTATE_UNKNOWN,      
    
    /**
        Not plugged in, running on the battery
    */
    SDL_POWERSTATE_ON_BATTERY,   
    
    /**
        Plugged in, no battery available
    */
    SDL_POWERSTATE_NO_BATTERY,   
    
    /**
        Plugged in, charging battery
    */
    SDL_POWERSTATE_CHARGING,     
    
    /**
        Plugged in, battery charged
    */
    SDL_POWERSTATE_CHARGED       
}

/**
    Get the current power supply details.

    You should never take a battery status as absolute truth. Batteries
    (especially failing batteries) are delicate hardware, and the values
    reported here are best estimates based on what that hardware reports. It's
    not uncommon for older batteries to lose stored power much faster than it
    reports, or completely drain when reporting it has 20 percent left, etc.

    Battery status can change at any time; if you are concerned with power
    state, you should call this function frequently, and perhaps ignore changes
    until they seem to be stable for a few seconds.

    It's possible a platform can only report battery percentage or time left
    but not both.

    Params:
        seconds =   a pointer filled in with the seconds of battery life left,
                    or NULL to ignore. This will be filled in with -1 if we
                    can't determine a value or there is no battery.
        percent =   a pointer filled in with the percentage of battery life
                    left, between 0 and 100, or NULL to ignore. This will be
                    filled in with -1 we can't determine a value or there is no
                    battery.

    Returns:
        The current battery state or `SDL_POWERSTATE_ERROR` on failure;
        call SDL_GetError() for more information.
*/
extern SDL_DECLSPEC SDL_PowerState SDLCALL SDL_GetPowerInfo(int *seconds, int *percent);