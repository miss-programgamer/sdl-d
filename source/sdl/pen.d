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
    SDL Pen Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryPen, SDL3 Mouse Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.pen;
import sdl.stdc;

extern(C) nothrow @nogc:

/**
    SDL pen instance IDs.

    Zero is used to signify an invalid/null device.

    These show up in pen events when SDL sees input from them. They remain
    consistent as long as SDL can recognize a tool to be the same pen; but if a
    pen physically leaves the area and returns, it might get a new ID.
*/
alias SDL_PenID = Uint32;

/**
    Pen input flags, as reported by various pen events' `pen_state` field.
*/
enum SDL_PenInputFlags : Uint32 {
    
    /**
        Pen is pressed down
    */
    SDL_PEN_INPUT_DOWN = (1u << 0),
    
    /**
        Button 1 is pressed
    */
    SDL_PEN_INPUT_BUTTON_1 = (1u << 1),
    
    /**
        Button 2 is pressed
    */
    SDL_PEN_INPUT_BUTTON_2 = (1u << 2),
    
    /**
        Button 3 is pressed
    */
    SDL_PEN_INPUT_BUTTON_3 = (1u << 3),
    
    /**
        Button 4 is pressed
    */
    SDL_PEN_INPUT_BUTTON_4 = (1u << 4),
    
    /**
        Button 5 is pressed
    */
    SDL_PEN_INPUT_BUTTON_5 = (1u << 5),
    
    /**
        Eraser tip is used
    */
    SDL_PEN_INPUT_ERASER_TIP = (1u << 30),
}

/**
    Pen axis indices.

    These are the valid values for the `axis` field in SDL_PenAxisEvent. All
    axes are either normalised to 0..1 or report a (positive or negative) angle
    in degrees, with 0.0 representing the centre. Not all pens/backends support
    all axes: unsupported axes are always zero.

    To convert angles for tilt and rotation into vector representation, use
    SDL_sinf on the XTILT, YTILT, or ROTATION component.

    Example:
        ---
        sinf(xtilt * PI / 180.0);
        ----
*/
enum SDL_PenAxis {
    
    /**
        Pen pressure.  Unidirectional: 0 to 1.0
    */
    SDL_PEN_AXIS_PRESSURE,
    
    /**
        Pen horizontal tilt angle.  Bidirectional: -90.0 to 90.0 (left-to-right).
    */
    SDL_PEN_AXIS_XTILT,
    
    /**
        Pen vertical tilt angle.  Bidirectional: -90.0 to 90.0 (top-to-down).
    */
    SDL_PEN_AXIS_YTILT,
    
    /**
        Pen distance to drawing surface.  Unidirectional: 0.0 to 1.0
    */
    SDL_PEN_AXIS_DISTANCE,
    
    /**
        Pen barrel rotation.  Bidirectional: -180 to 179.9 (clockwise, 0 is facing up, -180.0 is facing down).
    */
    SDL_PEN_AXIS_ROTATION,
    
    /**
        Pen finger wheel or slider (e.g., Airbrush Pen).  Unidirectional: 0 to 1.0
    */
    SDL_PEN_AXIS_SLIDER,
    
    /**
        Pressure from squeezing the pen ("barrel pressure").
    */
    SDL_PEN_AXIS_TANGENTIAL_PRESSURE,
    
    /**
    Total known pen axis types in this version of SDL. This number may grow in future releases!
    */
    SDL_PEN_AXIS_COUNT,
}
