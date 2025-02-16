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
    SDL Dialog

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryDialog, SDL3 MessageBox Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.dialog;
import sdl.video;
import sdl.properties;
import sdl.stdc;

extern(C) nothrow @nogc:

/**
    An entry for filters for file dialogs.

    `name` is a user-readable label for the filter (for example, "Office
    document").

    `pattern` is a semicolon-separated list of file extensions (for example,
    "doc;docx"). File extensions may only contain alphanumeric characters,
    hyphens, underscores and periods. Alternatively, the whole string can be a
    single asterisk ("*"), which serves as an "All files" filter.

    See_Also:
        $(D SDL_DialogFileCallback)
        $(D SDL_ShowOpenFileDialog)
        $(D SDL_ShowSaveFileDialog)
        $(D SDL_ShowOpenFolderDialog)
        $(D SDL_ShowFileDialogWithProperties)
*/
struct SDL_DialogFileFilter {
    const(char)* *name;
    const(char)* *pattern;
}

/**
    Callback used by file dialog functions.

    The specific usage is described in each function.

    If `filelist` is:

    - NULL, an error occurred. Details can be obtained with SDL_GetError().
    - A pointer to NULL, the user either didn't choose any file or canceled the
    dialog.
    - A pointer to non-`NULL`, the user chose one or more files. The argument
    is a null-terminated list of pointers to C strings, each containing a
    path.

    The filelist argument should not be freed; it will automatically be freed
    when the callback returns.

    The filter argument is the index of the filter that was selected, or -1 if
    no filter was selected or if the platform or method doesn't support
    fetching the selected filter.

    In Android, the `filelist` are `content://` URIs. They should be opened
    using SDL_IOFromFile() with appropriate modes. This applies both to open
    and save file dialog.

    Params:
        userdata =  an app-provided pointer, for the callback's use.
        filelist =  the file(s) chosen by the user.
        filter =    index of the selected filter.

    See_Also:
        $(D SDL_DialogFileFilter)
        $(D SDL_ShowOpenFileDialog)
        $(D SDL_ShowSaveFileDialog)
        $(D SDL_ShowOpenFolderDialog)
        $(D SDL_ShowFileDialogWithProperties)
*/
alias SDL_DialogFileCallback = void function(void *userdata, const(const(char)*)* filelist, int filter);

/**
    Displays a dialog that lets the user select a file on their filesystem.

    This is an asynchronous function; it will return immediately, and the
    result will be passed to the callback.

    The callback will be invoked with a null-terminated list of files the user
    chose. The list will be empty if the user canceled the dialog, and it will
    be NULL if an error occurred.

    Note that the callback may be called from a different thread than the one
    the function was invoked on.

    Depending on the platform, the user may be allowed to input paths that
    don't yet exist.

    On Linux, dialogs may require XDG Portals, which requires DBus, which
    requires an event-handling loop. Apps that do not use SDL to handle events
    should add a call to SDL_PumpEvents in their main loop.

    Params:
        callback =          a function pointer to be invoked when the user selects a
                            file and accepts, or cancels the dialog, or an error
                            occurs.
        userdata =          an optional pointer to pass extra data to the callback when
                            it will be invoked.
        window =            the window that the dialog should be modal for, may be NULL.
                            Not all platforms support this option.
        filters =           a list of filters, may be NULL. Not all platforms support
                            this option, and platforms that do support it may allow the
                            user to ignore the filters. If non-NULL, it must remain
                            valid at least until the callback is invoked.
        nfilters =          the number of filters. Ignored if filters is NULL.
        default_location =  the default folder or file to start the dialog at,
                            may be NULL. Not all platforms support this option.
        allow_many =        if non-zero, the user will be allowed to select multiple
                            entries. Not all platforms support this option.

    Threadsafety:
        This function should be called only from the main thread. The
        callback may be invoked from the same thread or from a
        different one, depending on the OS's constraints.

    See_Also:
        $(D SDL_DialogFileCallback)
        $(D SDL_DialogFileFilter)
        $(D SDL_ShowSaveFileDialog)
        $(D SDL_ShowOpenFolderDialog)
        $(D SDL_ShowFileDialogWithProperties)
*/
extern void SDL_ShowOpenFileDialog(SDL_DialogFileCallback callback, void *userdata, SDL_Window *window, const(SDL_DialogFileFilter)* *filters, int nfilters, const(char)* *default_location, bool allow_many);

/**
    Displays a dialog that lets the user choose a new or existing file on their
    filesystem.

    This is an asynchronous function; it will return immediately, and the
    result will be passed to the callback.

    The callback will be invoked with a null-terminated list of files the user
    chose. The list will be empty if the user canceled the dialog, and it will
    be NULL if an error occurred.

    Note that the callback may be called from a different thread than the one
    the function was invoked on.

    The chosen file may or may not already exist.

    On Linux, dialogs may require XDG Portals, which requires DBus, which
    requires an event-handling loop. Apps that do not use SDL to handle events
    should add a call to SDL_PumpEvents in their main loop.

    Params:
        callback =          a function pointer to be invoked when the user selects a
                            file and accepts, or cancels the dialog, or an error
                            occurs.
        userdata =          an optional pointer to pass extra data to the callback when
                            it will be invoked.
        window =            the window that the dialog should be modal for, may be NULL.
                            Not all platforms support this option.
        filters =           a list of filters, may be NULL. Not all platforms support
                            this option, and platforms that do support it may allow the
                            user to ignore the filters. If non-NULL, it must remain
                            valid at least until the callback is invoked.
        nfilters =          the number of filters. Ignored if filters is NULL.
        default_location =  the default folder or file to start the dialog at,
                            may be NULL. Not all platforms support this option.

    Threadsafety:
        This function should be called only from the main thread. The
        callback may be invoked from the same thread or from a
        different one, depending on the OS's constraints.

    See_Also:
        $(D SDL_DialogFileCallback)
        $(D SDL_DialogFileFilter)
        $(D SDL_ShowOpenFileDialog)
        $(D SDL_ShowOpenFolderDialog)
        $(D SDL_ShowFileDialogWithProperties)
*/
extern void SDL_ShowSaveFileDialog(SDL_DialogFileCallback callback, void *userdata, SDL_Window *window, const(SDL_DialogFileFilter)* *filters, int nfilters, const(char)** default_location);

/**
    Displays a dialog that lets the user select a folder on their filesystem.

    This is an asynchronous function; it will return immediately, and the
    result will be passed to the callback.

    The callback will be invoked with a null-terminated list of files the user
    chose. The list will be empty if the user canceled the dialog, and it will
    be NULL if an error occurred.

    Note that the callback may be called from a different thread than the one
    the function was invoked on.

    Depending on the platform, the user may be allowed to input paths that
    don't yet exist.

    On Linux, dialogs may require XDG Portals, which requires DBus, which
    requires an event-handling loop. Apps that do not use SDL to handle events
    should add a call to SDL_PumpEvents in their main loop.

    Params:
        callback =          a function pointer to be invoked when the user selects a
                            file and accepts, or cancels the dialog, or an error
                            occurs.
        userdata =          an optional pointer to pass extra data to the callback when
                            it will be invoked.
        window =            the window that the dialog should be modal for, may be NULL.
                            Not all platforms support this option.
        default_location =  the default folder or file to start the dialog at,
                            may be NULL. Not all platforms support this option.
        allow_many =        if non-zero, the user will be allowed to select multiple
                            entries. Not all platforms support this option.

    Threadsafety:
        This function should be called only from the main thread. The
        callback may be invoked from the same thread or from a
        different one, depending on the OS's constraints.
    
    See_Also:
        $(D SDL_DialogFileCallback)
        $(D SDL_ShowOpenFileDialog)
        $(D SDL_ShowSaveFileDialog)
        $(D SDL_ShowFileDialogWithProperties)
*/
extern void SDL_ShowOpenFolderDialog(SDL_DialogFileCallback callback, void *userdata, SDL_Window *window, const(char)* *default_location, bool allow_many);

/**
    Various types of file dialogs.

    This is used by SDL_ShowFileDialogWithProperties() to decide what kind of
    dialog to present to the user.

    See_Also:
        $(D SDL_ShowFileDialogWithProperties)
*/
enum SDL_FileDialogType {
    SDL_FILEDIALOG_OPENFILE,
    SDL_FILEDIALOG_SAVEFILE,
    SDL_FILEDIALOG_OPENFOLDER
}

/**
    Create and launch a file dialog with the specified properties.

    These are the supported properties:

    -   `SDL_PROP_FILE_DIALOG_FILTERS_POINTER`: a pointer to a list of
        SDL_DialogFileFilter structs, which will be used as filters for
        file-based selections. Ignored if the dialog is an "Open Folder" dialog.
        If non-NULL, the array of filters must remain valid at least until the
        callback is invoked.
    -   `SDL_PROP_FILE_DIALOG_NFILTERS_NUMBER`: the number of filters in the
        array of filters, if it exists.
    -   `SDL_PROP_FILE_DIALOG_WINDOW_POINTER`: the window that the dialog should
        be modal for.
    -   `SDL_PROP_FILE_DIALOG_LOCATION_STRING`: the default folder or file to
        start the dialog at.
    -   `SDL_PROP_FILE_DIALOG_MANY_BOOLEAN`: true to allow the user to select
        more than one entry.
    -   `SDL_PROP_FILE_DIALOG_TITLE_STRING`: the title for the dialog.
    -   `SDL_PROP_FILE_DIALOG_ACCEPT_STRING`: the label that the accept button
        should have.
    -   `SDL_PROP_FILE_DIALOG_CANCEL_STRING`: the label that the cancel button
        should have.

    Note that each platform may or may not support any of the properties.

    Params:
        type =      the type of file dialog.
        callback =  a function pointer to be invoked when the user selects a
                    file and accepts, or cancels the dialog, or an error
                    occurs.
        userdata =  an optional pointer to pass extra data to the callback when
                    it will be invoked.
        props =     the properties to use.

    Threadsafety:
        This function should be called only from the main thread. The
        callback may be invoked from the same thread or from a
        different one, depending on the OS's constraints.

    See_Also:
        $(D SDL_FileDialogType)
        $(D SDL_DialogFileCallback)
        $(D SDL_DialogFileFilter)
        $(D SDL_ShowOpenFileDialog)
        $(D SDL_ShowSaveFileDialog)
        $(D SDL_ShowOpenFolderDialog)
*/
extern void SDL_ShowFileDialogWithProperties(SDL_FileDialogType type, SDL_DialogFileCallback callback, void *userdata, SDL_PropertiesID props);

enum SDL_PROP_FILE_DIALOG_FILTERS_POINTER =     "SDL.filedialog.filters";
enum SDL_PROP_FILE_DIALOG_NFILTERS_NUMBER =     "SDL.filedialog.nfilters";
enum SDL_PROP_FILE_DIALOG_WINDOW_POINTER =      "SDL.filedialog.window";
enum SDL_PROP_FILE_DIALOG_LOCATION_STRING =     "SDL.filedialog.location";
enum SDL_PROP_FILE_DIALOG_MANY_BOOLEAN =        "SDL.filedialog.many";
enum SDL_PROP_FILE_DIALOG_TITLE_STRING =        "SDL.filedialog.title";
enum SDL_PROP_FILE_DIALOG_ACCEPT_STRING =       "SDL.filedialog.accept";
enum SDL_PROP_FILE_DIALOG_CANCEL_STRING =       "SDL.filedialog.cancel";
