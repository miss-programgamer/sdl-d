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
    SDL Properties

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryProperties, SDL3 Properties Documentation)

    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.properties;
import sdl.stdc;

extern(C) nothrow @nogc:

/**
    SDL properties ID
*/
alias SDL_PropertiesID = Uint32;

/**
    SDL property type
*/
enum SDL_PropertyType {
    SDL_PROPERTY_TYPE_INVALID,
    SDL_PROPERTY_TYPE_POINTER,
    SDL_PROPERTY_TYPE_STRING,
    SDL_PROPERTY_TYPE_NUMBER,
    SDL_PROPERTY_TYPE_FLOAT,
    SDL_PROPERTY_TYPE_BOOLEAN
}

/**
    Get the global SDL properties.

    Returns:
        A valid property ID on success or 0 on failure; call
        $(D SDL_GetError) for more information.
*/
extern SDL_PropertiesID SDL_GetGlobalProperties();

/**
    Create a group of properties.

    All properties are automatically destroyed when $(D SDL_Quit) is called.
    
    Returns:
        An ID for a new group of properties, or 0 on failure; call
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_DestroyProperties)
*/
extern SDL_PropertiesID SDL_CreateProperties();

/**
    Copy a group of properties.

    Copy all the properties from one group of properties to another, with the
    exception of properties requiring cleanup (set using
    $(D SDL_SetPointerPropertyWithCleanup)), which will not be copied. Any
    property that already exists on `dst` will be overwritten.

    Params:
        src = the properties to copy.
        dst = the destination properties.

    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_CopyProperties(SDL_PropertiesID src, SDL_PropertiesID dst);

/**
    Lock a group of properties.

    Obtain a multi-threaded lock for these properties. Other threads will wait
    while trying to lock these properties until they are unlocked. Properties
    must be unlocked before they are destroyed.

    The lock is automatically taken when setting individual properties, this
    function is only needed when you want to set several properties atomically
    or want to guarantee that properties being queried aren't freed in another
    thread.

    Params:
        props = the properties to lock.

    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_UnlockProperties)
*/
extern bool SDL_LockProperties(SDL_PropertiesID props);

/**
    Unlock a group of properties.

    Params:
        props = the properties to unlock.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_LockProperties)
*/
extern void SDL_UnlockProperties(SDL_PropertiesID props);

/**
    A callback used to free resources when a property is deleted.

    This should release any resources associated with `value` that are no
    longer needed.

    This callback is set per-property. Different properties in the same group
    can have different cleanup callbacks.

    This callback will be called *during* SDL_SetPointerPropertyWithCleanup if
    the function fails for any reason.

    Params:
        userdata = an app-defined pointer passed to the callback.
        value = the pointer assigned to the property to clean up.

    Threadsafety:
        This callback may fire without any locks held; if this is a
        concern, the app should provide its own locking.

    See_Also:
        $(D SDL_SetPointerPropertyWithCleanup)
*/
alias SDL_CleanupPropertyCallback = void function(void* userdata, void* value);

/**
    Set a pointer property in a group of properties with a cleanup function
    that is called when the property is deleted.

    The cleanup function is also called if setting the property fails for any
    reason.

    For simply setting basic data types, like numbers, bools, or strings, use
    SDL_SetNumberProperty, SDL_SetBooleanProperty, or SDL_SetStringProperty
    instead, as those functions will handle cleanup on your behalf. This
    function is only for more complex, custom data.

    Params:
        props =     the properties to modify.
        name =      the name of the property to modify.
        value =     the new value of the property, or NULL to delete the property.
        cleanup =   the function to call when this property is deleted, or NULL
                    if no cleanup is necessary.
        userdata =  a pointer that is passed to the cleanup function.

    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPointerProperty)
        $(D SDL_SetPointerProperty)
        $(D SDL_CleanupPropertyCallback)


*/
extern bool SDL_SetPointerPropertyWithCleanup(SDL_PropertiesID props, const(char)* name, void* value, SDL_CleanupPropertyCallback cleanup, void* userdata);

/**
    Set a pointer property in a group of properties.

    Params:
        props = the properties to modify.
        name =  the name of the property to modify.
        value = the new value of the property, or NULL to delete the property.

    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPointerProperty)
        $(D SDL_HasProperty)
        $(D SDL_SetBooleanProperty)
        $(D SDL_SetFloatProperty)
        $(D SDL_SetNumberProperty)
        $(D SDL_SetPointerPropertyWithCleanup)
        $(D SDL_SetStringProperty)
*/
extern bool SDL_SetPointerProperty(SDL_PropertiesID props, const(char)* name, void* value);

/**
    Set a string property in a group of properties.

    This function makes a copy of the string; the caller does not have to
    preserve the data after this call completes.

    Params:
        props = the properties to modify.
        name =  the name of the property to modify.
        value = the new value of the property, or NULL to delete the property.

    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetStringProperty)
*/
extern bool SDL_SetStringProperty(SDL_PropertiesID props, const(char)* name, const(char)* value);

/**
    Set an integer property in a group of properties.

    Params:
        props = the properties to modify.
        name =  the name of the property to modify.
        value = the new value of the property.

    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetNumberProperty)
*/
extern bool SDL_SetNumberProperty(SDL_PropertiesID props, const(char)* name, Sint64 value);

/**
    Set a floating point property in a group of properties.

    Params:
        props = the properties to modify.
        name =  the name of the property to modify.
        value = the new value of the property.
    
    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetFloatProperty)
*/
extern bool SDL_SetFloatProperty(SDL_PropertiesID props, const(char)* name, float value);

/**
    Set a boolean property in a group of properties.

    Params:
        props = the properties to modify.
        name =  the name of the property to modify.
        value = the new value of the property.
    
    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetBooleanProperty)
*/
extern bool SDL_SetBooleanProperty(SDL_PropertiesID props, const(char)* name, bool value);

/**
    Return whether a property exists in a group of properties.

    Params:
        props = the properties to query.
        name =  the name of the property to query.
    
    Returns:
        $(D true) true if the property exists, or $(D false) if it doesn't.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPropertyType)
*/
extern bool SDL_HasProperty(SDL_PropertiesID props, const(char)* name);

/**
    Get the type of a property in a group of properties.

    Params:
        props = the properties to query.
        name =  the name of the property to query.
    
    Returns:
        the type of the property, or $(D SDL_PROPERTY_TYPE_INVALID) if it is
        not set.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPropertyType)
*/
extern SDL_PropertyType SDL_GetPropertyType(SDL_PropertiesID props, const(char)* name);

/**
    Get a pointer property from a group of properties.

    By convention, the names of properties that SDL exposes on objects will
    start with "SDL.", and properties that SDL uses internally will start with
    "SDL.internal.". These should be considered read-only and should not be
    modified by applications.

    Params:
        props =         the properties to query.
        name =          the name of the property to query.
        default_value = the default value of the property.
    
    Returns:
        The value of the property, or `default_value` if it is not set or
        not a pointer property.

    Threadsafety:
        It is safe to call this function from any thread, although
        the data returned is not protected and could potentially be
        freed if you call $(D SDL_SetPointerProperty) or
        $(D SDL_ClearProperty) on these properties from another thread.
        If you need to avoid this, use $(D SDL_LockProperties) and
        $(D SDL_UnlockProperties).

    See_Also:
        $(D SDL_GetBooleanProperty)
        $(D SDL_GetFloatProperty)
        $(D SDL_GetNumberProperty)
        $(D SDL_GetPropertyType)
        $(D SDL_GetStringProperty)
        $(D SDL_HasProperty)
        $(D SDL_SetPointerProperty)
*/
extern void* SDL_GetPointerProperty(SDL_PropertiesID props, const(char)* name, void* default_value);

/**
    Get a string property from a group of properties.

    Params:
        props =         the properties to query.
        name =          the name of the property to query.
        default_value = the default value of the property.
    
    Returns:
        The value of the property, or `default_value` if it is not set or
        not a string property.

    Threadsafety:
        It is safe to call this function from any thread, although
        the data returned is not protected and could potentially be
        freed if you call $(D SDL_SetPointerProperty) or
        $(D SDL_ClearProperty) on these properties from another thread.
        If you need to avoid this, use $(D SDL_LockProperties) and
        $(D SDL_UnlockProperties).

    See_Also:
        $(D SDL_GetPropertyType)
        $(D SDL_HasProperty)
        $(D SDL_SetStringProperty)
*/
extern const(char)* SDL_GetStringProperty(SDL_PropertiesID props, const(char)* name, const(char)* default_value);

/**
    Get a number property from a group of properties.

    You can use SDL_GetPropertyType() to query whether the property exists and
    is a number property.

    Params:
        props =         the properties to query.
        name =          the name of the property to query.
        default_value = the default value of the property.
    
    Returns:
        The value of the property, or `default_value` if it is not set or
        not a number property.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPropertyType)
        $(D SDL_HasProperty)
        $(D SDL_SetNumberProperty)
*/
extern Sint64 SDL_GetNumberProperty(SDL_PropertiesID props, const(char)* name, Sint64 default_value);

/**
    Get a floating point property from a group of properties.

    You can use $(D SDL_GetPropertyType) to query whether the property exists and
    is a floating point property.

    Params:
        props =         the properties to query.
        name =          the name of the property to query.
        default_value = the default value of the property.

    Returns:
        The value of the property, or `default_value` if it is not set or
        not a float property.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPropertyType)
        $(D SDL_HasProperty)
        $(D SDL_SetFloatProperty)
*/
extern float SDL_GetFloatProperty(SDL_PropertiesID props, const(char)* name, float default_value);

/**
    Get a boolean property from a group of properties.

    You can use $(D SDL_GetPropertyType) to query whether the property exists and
    is a boolean property.

    Params:
        props =         the properties to query.
        name =          the name of the property to query.
        default_value = the default value of the property.
    
    Returns:
        The value of the property, or `default_value` if it is not set or
        not a boolean property.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPropertyType)
        $(D SDL_HasProperty)
        $(D SDL_SetBooleanProperty)
*/
extern bool SDL_GetBooleanProperty(SDL_PropertiesID props, const(char)* name, bool default_value);

/**
    Clear a property from a group of properties.

    Params:
        props = the properties to modify.
        name =  the name of the property to clear.
    
    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_ClearProperty(SDL_PropertiesID props, const(char)* name);

/**
    A callback used to enumerate all the properties in a group of properties.

    This callback is called from SDL_EnumerateProperties(), and is called once
    per property in the set.

    Params:
        userdata =  an app-defined pointer passed to the callback.
        props =     the SDL_PropertiesID that is being enumerated.
        name =      the next property name in the enumeration.

    Threadsafety:
        SDL_EnumerateProperties holds a lock on `props` during this
        callback. 

    See_Also:
        $(D SDL_EnumerateProperties)
*/
alias SDL_EnumeratePropertiesCallback = void function(void* userdata, SDL_PropertiesID props, const(char)* name);

/**
    Enumerate the properties contained in a group of properties.

    The callback function is called for each property in the group of
    properties. The properties are locked during enumeration.

    Params:
        props =     the properties to query.
        callback =  the function to call for each property.
        userdata =  a pointer that is passed to `callback`.

    Threadsafety:
        It is safe to call this function from any thread.
    
    Returns:
        $(D true) on success or $(D false) on failure; call 
        $(D SDL_GetError) for more information.
*/
extern bool SDL_EnumerateProperties(SDL_PropertiesID props, SDL_EnumeratePropertiesCallback callback, void* userdata);

/**
    Destroy a group of properties.

    All properties are deleted and their cleanup functions will be called, if
    any.

    Params:
        props = the properties to destroy.

    Threadsafety:
        This function should not be called while these properties are
        locked or other threads might be setting or getting values
        from these properties.

    See_Also:
        $(D SDL_CreateProperties)
*/
extern void SDL_DestroyProperties(SDL_PropertiesID props);