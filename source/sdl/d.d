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
*/

/**
    DLang helpers for SDL.
    
    Copyright: © 2025 Inochi2D Project
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.d;

/**
    Creates a new unique handle type.

    Handle types are pointers to opaque structs.

    See_Also:
        $(LINK2 https://github.com/Inochi2D/numem/blob/main/source/numem/core/types.d, Original Implementation)

    Params:
        name = Unique name of the handle.

    License:
        This template is subject to the Boost License found in numem.

    Examples:
        ---
        alias VkInstance = OpaqueHandle!("VkInstance");
        ---
*/
template OpaqueHandle(string name) {
    struct OpaqueHandleT(string name);
    alias OpaqueHandle = OpaqueHandleT!(name)*;
}