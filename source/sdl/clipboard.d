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
    SDL Clipboard

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryClipboard, SDL3 Clipboard Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.clipboard;
import sdl.stdc;

extern(C) nothrow @nogc:

/**
    Put UTF-8 text into the clipboard.

    Params:
        text = the text to store in the clipboard.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also
        $(D SDL_GetClipboardText)
        $(D SDL_HasClipboardText)
*/
extern bool SDL_SetClipboardText(const(char)* text);

/**
    Get UTF-8 text from the clipboard.

    This functions returns an empty string if there was not enough memory left
    for a copy of the clipboard's content.

    Returns:
        the clipboard text on success or an empty string on failure; call
        SDL_GetError() for more information. This should be freed with
        SDL_free() when it is no longer needed.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_HasClipboardText)
        $(D SDL_SetClipboardText)
*/
extern char* SDL_GetClipboardText();

/**
    Query whether the clipboard exists and contains a non-empty text string.

    Returns:
        true if the clipboard has text, or false if it does not.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_GetClipboardText)
        $(D SDL_SetClipboardText)
*/
extern bool SDL_HasClipboardText();

/**
    Put UTF-8 text into the primary selection.

    Params:
        text = the text to store in the primary selection.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_GetPrimarySelectionText)
        $(D SDL_HasPrimarySelectionText)
*/
extern bool SDL_SetPrimarySelectionText(const(char)* text);

/**
    Get UTF-8 text from the primary selection.

    This functions returns an empty string if there was not enough memory left
    for a copy of the primary selection's content.

    Returns:
        the primary selection text on success or an empty string on
        failure; call SDL_GetError() for more information. This should be
        freed with SDL_free() when it is no longer needed.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_HasPrimarySelectionText)
        $(D SDL_SetPrimarySelectionText)
*/
extern char* SDL_GetPrimarySelectionText();

/**
    Query whether the primary selection exists and contains a non-empty text
    string.

    Returns:
        true if the primary selection has text, or false if it does not.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_GetPrimarySelectionText)
        $(D SDL_SetPrimarySelectionText)
*/
extern bool SDL_HasPrimarySelectionText();

/**
    Callback function that will be called when data for the specified mime-type
    is requested by the OS.

    The callback function is called with NULL as the mime_type when the
    clipboard is cleared or new data is set. The clipboard is automatically
    cleared in SDL_Quit().

    Params:
        userdata =  a pointer to provided user data.
        mime_type = the requested mime-type.
        size =      a pointer filled in with the length of the returned data.
    
    Returns:
        a pointer to the data for the provided mime-type. Returning NULL
        or setting length to 0 will cause no data to be sent to the
        "receiver". It is up to the receiver to handle this. Essentially
        returning no data is more or less undefined behavior and may cause
        breakage in receiving applications. The returned data will not be
        freed so it needs to be retained and dealt with internally.

    See_Also:
        $(D SDL_SetClipboardData)
*/
alias SDL_ClipboardDataCallback = const(void)* function(void* userdata, const(char)* mime_type, size_t* size);

/**
    Callback function that will be called when the clipboard is cleared, or new
    data is set.

    Params:
        userdata a pointer to provided user data.

    See_Also:
        $(D SDL_SetClipboardData)
*/
alias SDL_ClipboardCleanupCallback = void function(void* userdata);

/**
    Offer clipboard data to the OS.

    Tell the operating system that the application is offering clipboard data
    for each of the provided mime-types. Once another application requests the
    data the callback function will be called, allowing it to generate and
    respond with the data for the requested mime-type.

    The size of text data does not include any terminator, and the text does
    not need to be null terminated (e.g. you can directly copy a portion of a
    document).

    Params:
        callback =          a function pointer to the function that provides the
                            clipboard data.
        cleanup =           a function pointer to the function that cleans up the
                            clipboard data.
        userdata =          an opaque pointer that will be forwarded to the callbacks.
        mime_types =        a list of mime-types that are being offered.
        num_mime_types =    the number of mime-types in the mime_types list.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_ClearClipboardData)
        $(D SDL_GetClipboardData)
        $(D SDL_HasClipboardData)
*/
extern bool SDL_SetClipboardData(SDL_ClipboardDataCallback callback, SDL_ClipboardCleanupCallback cleanup, void* userdata, const(char)** mime_types, size_t num_mime_types);

/**
    Clear the clipboard data.

    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_SetClipboardData)
*/
extern bool SDL_ClearClipboardData();

/**
    Get the data from clipboard for a given mime type.

    The size of text data does not include the terminator, but the text is
    guaranteed to be null terminated.

    Params:
        mime_type = the mime type to read from the clipboard.
        size =      a pointer filled in with the length of the returned data.
    
    Returns:
        the retrieved data buffer or NULL on failure; call SDL_GetError()
        for more information. This should be freed with SDL_free() when it
        is no longer needed.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_HasClipboardData)
        $(D SDL_SetClipboardData)
*/
extern void*  SDL_GetClipboardData(const(char)* mime_type, size_t* size);

/**
    Query whether there is data in the clipboard for the provided mime type.

    Params:
        mime_type = the mime type to check for data for.
    
    Returns:
        true if there exists data in clipboard for the provided mime type,
        false if it does not.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_SetClipboardData)
        $(D SDL_GetClipboardData)
*/
extern bool SDL_HasClipboardData(const(char)* mime_type);

/**
    Retrieve the list of mime types available in the clipboard.

    Params:
        num_mime_types =    a pointer filled with the number of mime types, may
                            be NULL.

    Returns:
        a null terminated array of strings with mime types, or NULL on
        failure; call SDL_GetError() for more information. This should be
        freed with SDL_free() when it is no longer needed.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_SetClipboardData)
*/
extern char** SDL_GetClipboardMimeTypes(size_t* num_mime_types);