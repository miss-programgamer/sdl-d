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
    SDL Surfaces

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategorySurface, SDL3 Surface Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.surface;
import sdl.stdc;
import sdl.properties;
import sdl.pixels;
import sdl.blendmode;
import sdl.rect;
import sdl.iostream;

extern(C) nothrow @nogc:


/**
    The flags on an SDL_Surface.

    These are generally considered read-only.
*/
alias SDL_SurfaceFlags = Uint32;

enum SDL_SurfaceFlags SDL_SURFACE_PREALLOCATED =    0x00000001u; /**< Surface uses preallocated pixel memory */
enum SDL_SurfaceFlags SDL_SURFACE_LOCK_NEEDED =     0x00000002u; /**< Surface needs to be locked to access pixels */
enum SDL_SurfaceFlags SDL_SURFACE_LOCKED =          0x00000004u; /**< Surface is currently locked */
enum SDL_SurfaceFlags SDL_SURFACE_SIMD_ALIGNED =    0x00000008u; /**< Surface uses pixel memory allocated with SDL_aligned_alloc() */

/**
    The scaling mode.
*/
enum SDL_ScaleMode {
    
    /**
        Nearest pixel sampling
    */
    SDL_SCALEMODE_NEAREST,
    
    /**
        Linear filtering
    */
    SDL_SCALEMODE_LINEAR,
}

/**
    The flip mode.
*/
enum SDL_FlipMode {
    
    /**
        Do not flip
    */
    SDL_FLIP_NONE,
    
    /**
        Flip horizontally
    */
    SDL_FLIP_HORIZONTAL,
    
    /** 
        Flip vertically
    */
    SDL_FLIP_VERTICAL
}

/**
    A collection of pixels used in software blitting.

    Pixels are arranged in memory in rows, with the top row first. Each row
    occupies an amount of memory given by the pitch (sometimes known as the row
    stride in non-SDL APIs).

    Within each row, pixels are arranged from left to right until the width is
    reached. Each pixel occupies a number of bits appropriate for its format,
    with most formats representing each pixel as one or more whole bytes (in
    some indexed formats, instead multiple pixels are packed into each byte),
    and a byte order given by the format. After encoding all pixels, any
    remaining bytes to reach the pitch are used as padding to reach a desired
    alignment, and have undefined contents.

    When a surface holds YUV format data, the planes are assumed to be
    contiguous without padding between them, e.g. a 32x32 surface in NV12
    format with a pitch of 32 would consist of 32x32 bytes of Y plane followed
    by 32x16 bytes of UV plane.

    See_Also:
        $(D SDL_CreateSurface)
        $(D SDL_DestroySurface)
*/
struct SDL_Surface;

/**
    Allocate a new surface with a specific pixel format.

    The pixels of the new surface are initialized to zero.

    Params:
        width =     the width of the surface.
        height =    the height of the surface.
        format =    the $(D SDL_PixelFormat) for the new surface's pixel format.

    Returns:
        The new SDL_Surface structure that is created or $(D null) on failure;
        call $(D SDL_GetError) for more information.

    See_Also:
        $(D SDL_CreateSurfaceFrom)
        $(D SDL_DestroySurface)
*/
extern SDL_Surface* SDL_CreateSurface(int width, int height, SDL_PixelFormat format);

/**
    Allocate a new surface with a specific pixel format and existing pixel
    data.

    No copy is made of the pixel data. Pixel data is not managed automatically;
    you must free the surface before you free the pixel data.

    Pitch is the offset in bytes from one row of pixels to the next, e.g.
    `width*4` for `SDL_PIXELFORMAT_RGBA8888`.

    You may pass $(D null) for pixels and 0 for pitch to create a surface that you
    will fill in with valid values later.

    Params:
        width =      the width of the surface.
        height =     the height of the surface.
        format =     the SDL_PixelFormat for the new surface's pixel format.
        pixels =     a pointer to existing pixel data.
        pitch =      the number of bytes between each row, including padding.

    Returns:
        The new $(D SDL_Surface) structure that is created or $(D null) on failure;
        call $(D SDL_GetError) for more information.

    See_Also:
        $(D SDL_CreateSurface)
        $(D SDL_DestroySurface)
*/
extern SDL_Surface*  SDL_CreateSurfaceFrom(int width, int height, SDL_PixelFormat format, void* pixels, int pitch);

/**
    Free a surface.

    It is safe to pass $(D null) to this function.

    Params:
        surface = the SDL_Surface to free.

    See_Also:
        $(D SDL_CreateSurface)
        $(D SDL_CreateSurfaceFrom)
*/
extern void SDL_DestroySurface(SDL_Surface* surface);

/**
    Get the properties associated with a surface.

    The following properties are understood by SDL:

    -   `SDL_PROP_SURFACE_SDR_WHITE_POINT_FLOAT`: for HDR10 and floating point
        surfaces, this defines the value of 100% diffuse white, with higher
        values being displayed in the High Dynamic Range headroom. This defaults
        to 203 for HDR10 surfaces and 1.0 for floating point surfaces.
    -   `SDL_PROP_SURFACE_HDR_HEADROOM_FLOAT`: for HDR10 and floating point
        surfaces, this defines the maximum dynamic range used by the content, in
        terms of the SDR white point. This defaults to 0.0, which disables tone
        mapping.
    -   `SDL_PROP_SURFACE_TONEMAP_OPERATOR_STRING`: the tone mapping operator
        used when compressing from a surface with high dynamic range to another
        with lower dynamic range. Currently this supports "chrome", which uses
        the same tone mapping that Chrome uses for HDR content, the form "*=N",
        where N is a floating point scale factor applied in linear space, and
        "none", which disables tone mapping. This defaults to "chrome".

    Params:
        surface = the SDL_Surface structure to query.
    
    Returns:
        a valid property ID on success or 0 on failure; call
        $(D SDL_GetError) for more information.
*/
extern SDL_PropertiesID SDL_GetSurfaceProperties(SDL_Surface* surface);

enum SDL_PROP_SURFACE_SDR_WHITE_POINT_FLOAT =              "SDL.surface.SDR_white_point";
enum SDL_PROP_SURFACE_HDR_HEADROOM_FLOAT =                 "SDL.surface.HDR_headroom";
enum SDL_PROP_SURFACE_TONEMAP_OPERATOR_STRING =            "SDL.surface.tonemap";

/**
    Set the colorspace used by a surface.

    Setting the colorspace doesn't change the pixels, only how they are
    interpreted in color operations.

    Params:
        surface =       the SDL_Surface structure to update.
        colorspace =    an SDL_Colorspace value describing the surface
                        colorspace.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetSurfaceColorspace)
*/
extern bool SDL_SetSurfaceColorspace(SDL_Surface* surface, SDL_Colorspace colorspace);

/**
    Get the colorspace used by a surface.

    The colorspace defaults to SDL_COLORSPACE_SRGB_LINEAR for floating point
    formats, SDL_COLORSPACE_HDR10 for 10-bit formats, SDL_COLORSPACE_SRGB for
    other RGB surfaces and SDL_COLORSPACE_BT709_FULL for YUV textures.
    
    Params:
        surface = the SDL_Surface structure to query.

    Returns:
        The colorspace used by the surface, or $(D SDL_COLORSPACE_UNKNOWN) if
        the surface is $(D null).

    See_Also:
        $(D SDL_SetSurfaceColorspace)
*/
extern SDL_Colorspace SDL_GetSurfaceColorspace(SDL_Surface* surface);

/**
    Create a palette and associate it with a surface.

    This function creates a palette compatible with the provided surface. The
    palette is then returned for you to modify, and the surface will
    automatically use the new palette in future operations. You do not need to
    destroy the returned palette, it will be freed when the reference count
    reaches 0, usually when the surface is destroyed.

    Bitmap surfaces (with format SDL_PIXELFORMAT_INDEX1LSB or
    SDL_PIXELFORMAT_INDEX1MSB) will have the palette initialized with 0 as
    white and 1 as black. Other surfaces will get a palette initialized with
    white in every entry.

    If this function is called for a surface that already has a palette, a new
    palette will be created to replace it.

    Params:
        surface the SDL_Surface structure to update.

    Returns:
        a new SDL_Palette structure on success or NULL on failure (e.g. if
           the surface didn't have an index format); call SDL_GetError() for
           more information.

    See_Also:
        $(D SDL_SetPaletteColors)
*/
extern SDL_Palette*  SDL_CreateSurfacePalette(SDL_Surface* surface);

/**
    Set the palette used by a surface.

    A single palette can be shared with many surfaces.

    Params:
        surface =   the SDL_Surface structure to update.
        palette =   the SDL_Palette structure to use.

    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_CreatePalette)
        $(D SDL_GetSurfacePalette)
*/
extern bool SDL_SetSurfacePalette(SDL_Surface* surface, SDL_Palette* palette);

/**
    Get the palette used by a surface.

    Params:
        surface = the SDL_Surface structure to query.
    
    Returns:
        a pointer to the palette used by the surface, or NULL if there is
        no palette used.

    See_Also:
        $(D SDL_SetSurfacePalette)
*/
extern SDL_Palette*  SDL_GetSurfacePalette(SDL_Surface* surface);

/**
    Add an alternate version of a surface.

    This function adds an alternate version of this surface, usually used for
    content with high DPI representations like cursors or icons. The size,
    format, and content do not need to match the original surface, and these
    alternate versions will not be updated when the original surface changes.

    This function adds a reference to the alternate version, so you should call
    SDL_DestroySurface() on the image after this call.

    Params:
        surface =   the SDL_Surface structure to update.
        image =     a pointer to an alternate SDL_Surface to associate with this
                    surface.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_RemoveSurfaceAlternateImages)
        $(D SDL_GetSurfaceImages)
        $(D SDL_SurfaceHasAlternateImages)
*/
extern bool SDL_AddSurfaceAlternateImage(SDL_Surface* surface, SDL_Surface* image);

/**
    Return whether a surface has alternate versions available.

    Params:
        surface = the SDL_Surface structure to query.
    
    Returns:
        true if alternate versions are available or false otherwise.

    See_Also:
        $(D SDL_AddSurfaceAlternateImage)
        $(D SDL_RemoveSurfaceAlternateImages)
        $(D SDL_GetSurfaceImages)
*/
extern bool SDL_SurfaceHasAlternateImages(SDL_Surface* surface);

/**
    Get an array including all versions of a surface.

    This returns all versions of a surface, with the surface being queried as
    the first element in the returned array.

    Freeing the array of surfaces does not affect the surfaces in the array.
    They are still referenced by the surface being queried and will be cleaned
    up normally.

    Params:
        surface =   the SDL_Surface structure to query.
        count =     a pointer filled in with the number of surface pointers
                    returned, may be NULL.
    
    Returns:
        a NULL terminated array of SDL_Surface pointers or NULL on
        failure; call SDL_GetError() for more information. This should be
        freed with SDL_free() when it is no longer needed.

    See_Also:
        $(D SDL_AddSurfaceAlternateImage)
        $(D SDL_RemoveSurfaceAlternateImages)
        $(D SDL_SurfaceHasAlternateImages)
*/
extern SDL_Surface* * SDL_GetSurfaceImages(SDL_Surface* surface, int* count);

/**
    Remove all alternate versions of a surface.

    This function removes a reference from all the alternative versions,
    destroying them if this is the last reference to them.

    Params:
        surface = the SDL_Surface structure to update.

    See_Also:
        $(D SDL_AddSurfaceAlternateImage)
        $(D SDL_GetSurfaceImages)
        $(D SDL_SurfaceHasAlternateImages)
*/
extern void SDL_RemoveSurfaceAlternateImages(SDL_Surface* surface);

/**
    Set up a surface for directly accessing the pixels.

    Between calls to SDL_LockSurface() / SDL_UnlockSurface(), you can write to
    and read from `surface->pixels`, using the pixel format stored in
    `surface->format`. Once you are done accessing the surface, you should use
    SDL_UnlockSurface() to release it.

    Not all surfaces require locking. If `SDL_MUSTLOCK(surface)` evaluates to
    0, then you can read and write to the surface at any time, and the pixel
    format of the surface will not change.

    Params:
        surface = the SDL_Surface structure to be locked.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_MUSTLOCK)
        $(D SDL_UnlockSurface)
*/
extern bool SDL_LockSurface(SDL_Surface* surface);

/**
    Release a surface after directly accessing the pixels.

    Params:
        surface = the SDL_Surface structure to be unlocked.

    See_Also:
        $(D SDL_LockSurface)
*/
extern void SDL_UnlockSurface(SDL_Surface* surface);

/**
    Load a BMP image from a seekable SDL data stream.

    The new surface should be freed with SDL_DestroySurface(). Not doing so
    will result in a memory leak.

    Params:
        src =       the data stream for the surface.
        closeio =   if true, calls SDL_CloseIO() on `src` before returning, even
                    in the case of an error.
    
    Returns:
        a pointer to a new SDL_Surface structure or NULL on failure; call
        SDL_GetError() for more information.

    See_Also:
        $(D SDL_DestroySurface)
        $(D SDL_LoadBMP)
        $(D SDL_SaveBMP_IO)
*/
extern SDL_Surface*  SDL_LoadBMP_IO(SDL_IOStream* src, bool closeio);

/**
    Load a BMP image from a file.

    The new surface should be freed with SDL_DestroySurface(). Not doing so
    will result in a memory leak.

    Params:
        file = the BMP file to load.
    
    Returns:
        a pointer to a new SDL_Surface structure or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_DestroySurface)
        $(D SDL_LoadBMP_IO)
        $(D SDL_SaveBMP)
*/
extern SDL_Surface*  SDL_LoadBMP(const(char)* file);

/**
    Save a surface to a seekable SDL data stream in BMP format.

    Surfaces with a 24-bit, 32-bit and paletted 8-bit format get saved in the
    BMP directly. Other RGB formats with 8-bit or higher get converted to a
    24-bit surface or, if they have an alpha mask or a colorkey, to a 32-bit
    surface before they are saved. YUV and paletted 1-bit and 4-bit formats are
    not supported.

    Params:
        surface =   the SDL_Surface structure containing the image to be saved.
        dst =       a data stream to save to.
        closeio =   if true, calls SDL_CloseIO() on `dst` before returning, even
                    in the case of an error.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_LoadBMP_IO)
        $(D SDL_SaveBMP)
*/
extern bool SDL_SaveBMP_IO(SDL_Surface* surface, SDL_IOStream* dst, bool closeio);

/**
    Save a surface to a file.

    Surfaces with a 24-bit, 32-bit and paletted 8-bit format get saved in the
    BMP directly. Other RGB formats with 8-bit or higher get converted to a
    24-bit surface or, if they have an alpha mask or a colorkey, to a 32-bit
    surface before they are saved. YUV and paletted 1-bit and 4-bit formats are
    not supported.

    Params:
        surface =   the SDL_Surface structure containing the image to be saved.
        file =      a file to save to.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_LoadBMP)
        $(D SDL_SaveBMP_IO)
*/
extern bool SDL_SaveBMP(SDL_Surface* surface, const(char)* file);

/**
    Set the RLE acceleration hint for a surface.

    If RLE is enabled, color key and alpha blending blits are much faster, but
    the surface must be locked before directly accessing the pixels.

    Params:
        surface =   the SDL_Surface structure to optimize.
        enabled =   true to enable RLE acceleration, false to disable it.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_BlitSurface)
        $(D SDL_LockSurface)
        $(D SDL_UnlockSurface)
*/
extern bool SDL_SetSurfaceRLE(SDL_Surface* surface, bool enabled);

/**
    Returns whether the surface is RLE enabled.

    It is safe to pass a NULL `surface` here; it will return false.

    Params:
        surface = the SDL_Surface structure to query.
    
    Returns:
        true if the surface is RLE enabled, false otherwise.

    See_Also:
        $(D SDL_SetSurfaceRLE)
*/
extern bool SDL_SurfaceHasRLE(SDL_Surface* surface);

/**
    Set the color key (transparent pixel) in a surface.

    The color key defines a pixel value that will be treated as transparent in
    a blit. For example, one can use this to specify that cyan pixels should be
    considered transparent, and therefore not rendered.

    It is a pixel of the format used by the surface, as generated by
    SDL_MapRGB().

    Params:
        surface =   the SDL_Surface structure to update.
        enabled =   true to enable color key, false to disable color key.
        key =       the transparent pixel.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetSurfaceColorKey)
        $(D SDL_SetSurfaceRLE)
        $(D SDL_SurfaceHasColorKey)
*/
extern bool SDL_SetSurfaceColorKey(SDL_Surface* surface, bool enabled, Uint32 key);

/**
    Returns whether the surface has a color key.

    It is safe to pass a NULL `surface` here; it will return false.

    Params:
        surface = the SDL_Surface structure to query.
    
    Returns:
        true if the surface has a color key, false otherwise.

    See_Also:
        $(D SDL_SetSurfaceColorKey)
        $(D SDL_GetSurfaceColorKey)
*/
extern bool SDL_SurfaceHasColorKey(SDL_Surface* surface);

/**
    Get the color key (transparent pixel) for a surface.

    The color key is a pixel of the format used by the surface, as generated by
    SDL_MapRGB().

    If the surface doesn't have color key enabled this function returns false.

    Params:
        surface =   the SDL_Surface structure to query.
        key =       a pointer filled in with the transparent pixel.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_SetSurfaceColorKey)
        $(D SDL_SurfaceHasColorKey)
*/
extern bool SDL_GetSurfaceColorKey(SDL_Surface* surface, Uint32* key);

/**
    Set an additional color value multiplied into blit operations.

    When this surface is blitted, during the blit operation each source color
    channel is modulated by the appropriate color value according to the
    following formula:

    `srcC = srcC*  (color / 255)`

    Params:
        surface =   the SDL_Surface structure to update.
        r =         the red color value multiplied into blit operations.
        g =         the green color value multiplied into blit operations.
        b =         the blue color value multiplied into blit operations.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetSurfaceColorMod)
        $(D SDL_SetSurfaceAlphaMod)
*/
extern bool SDL_SetSurfaceColorMod(SDL_Surface* surface, Uint8 r, Uint8 g, Uint8 b);


/**
    Get the additional color value multiplied into blit operations.

    Params:
        surface =   the SDL_Surface structure to query.
        r =         a pointer filled in with the current red color value.
        g =         a pointer filled in with the current green color value.
        b =         a pointer filled in with the current blue color value.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetSurfaceAlphaMod)
        $(D SDL_SetSurfaceColorMod)
*/
extern bool SDL_GetSurfaceColorMod(SDL_Surface* surface, Uint8* r, Uint8* g, Uint8* b);

/**
    Set an additional alpha value used in blit operations.

    When this surface is blitted, during the blit operation the source alpha
    value is modulated by this alpha value according to the following formula:

    `srcA = srcA*  (alpha / 255)`

    Params:
        surface =   the SDL_Surface structure to update.
        alpha =     the alpha value multiplied into blit operations.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetSurfaceAlphaMod)
        $(D SDL_SetSurfaceColorMod)
*/
extern bool SDL_SetSurfaceAlphaMod(SDL_Surface* surface, Uint8 alpha);

/**
    Get the additional alpha value used in blit operations.

    Params:
        surface =   the SDL_Surface structure to query.
        alpha =     a pointer filled in with the current alpha value.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetSurfaceColorMod)
        $(D SDL_SetSurfaceAlphaMod)
*/
extern bool SDL_GetSurfaceAlphaMod(SDL_Surface* surface, Uint8* alpha);

/**
    Set the blend mode used for blit operations.

    To copy a surface to another surface (or texture) without blending with the
    existing data, the blendmode of the SOURCE surface should be set to
    `SDL_BLENDMODE_NONE`.

    Params:
        surface =   the SDL_Surface structure to update.
        blendMode = the SDL_BlendMode to use for blit blending.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_GetSurfaceBlendMode)
*/
extern bool SDL_SetSurfaceBlendMode(SDL_Surface* surface, SDL_BlendMode blendMode);

/**
    Get the blend mode used for blit operations.

    Params:
        surface =   the SDL_Surface structure to query.
        blendMode = a pointer filled in with the current SDL_BlendMode.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_SetSurfaceBlendMode)
*/
extern bool SDL_GetSurfaceBlendMode(SDL_Surface* surface, SDL_BlendMode* blendMode);

/**
    Set the clipping rectangle for a surface.

    When `surface` is the destination of a blit, only the area within the clip
    rectangle is drawn into.

    Note that blits are automatically clipped to the edges of the source and
    destination surfaces.

    Params:
        surface =   the SDL_Surface structure to be clipped.
        rect =      the SDL_Rect structure representing the clipping rectangle, or
                    NULL to disable clipping.
    
    Returns:
        true if the rectangle intersects the surface, otherwise false and
        blits will be completely clipped.

    See_Also:
        $(D SDL_GetSurfaceClipRect)
*/
extern bool SDL_SetSurfaceClipRect(SDL_Surface* surface, const(SDL_Rect)* rect);

/**
    Get the clipping rectangle for a surface.

    When `surface` is the destination of a blit, only the area within the clip
    rectangle is drawn into.
    
    Params:
        surface =   the SDL_Surface structure representing the surface to be
                    clipped.
        rect =      an SDL_Rect structure filled in with the clipping rectangle for
                    the surface.

    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_SetSurfaceClipRect)
*/
extern bool SDL_GetSurfaceClipRect(SDL_Surface* surface, SDL_Rect* rect);

/**
    Flip a surface vertically or horizontally.

    Params:
        surface =   the surface to flip.
        flip =      the direction to flip.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_FlipSurface(SDL_Surface* surface, SDL_FlipMode flip);

/**
    Creates a new surface identical to the existing surface.

    If the original surface has alternate images, the new surface will have a
    reference to them as well.

    The returned surface should be freed with SDL_DestroySurface().

    Params:
        surface = the surface to duplicate.
    
    Returns:
        a copy of the surface or NULL on failure; call SDL_GetError() for
        more information.

    See_Also:
        $(D SDL_DestroySurface)
*/
extern SDL_Surface*  SDL_DuplicateSurface(SDL_Surface* surface);

/**
    Creates a new surface identical to the existing surface, scaled to the
    desired size.

    The returned surface should be freed with SDL_DestroySurface().

    Params:
        surface =   the surface to duplicate and scale.
        width =     the width of the new surface.
        height =    the height of the new surface.
        scaleMode = the SDL_ScaleMode to be used.
    
    Returns:
        a copy of the surface or NULL on failure; call SDL_GetError() for
        more information.

    See_Also:
        $(D SDL_DestroySurface)
*/
extern SDL_Surface*  SDL_ScaleSurface(SDL_Surface* surface, int width, int height, SDL_ScaleMode scaleMode);

/**
    Copy an existing surface to a new surface of the specified format.

    This function is used to optimize images for faster* repeat* blitting. This
    is accomplished by converting the original and storing the result as a new
    surface. The new, optimized surface can then be used as the source for
    future blits, making them faster.

    If you are converting to an indexed surface and want to map colors to a
    palette, you can use SDL_ConvertSurfaceAndColorspace() instead.

    If the original surface has alternate images, the new surface will have a
    reference to them as well.

    Params:
        surface =   the existing SDL_Surface structure to convert.
        format =    the new pixel format.
    
    Returns:
        the new SDL_Surface structure that is created or NULL on failure;
        call SDL_GetError() for more information.

    See_Also:
        $(D SDL_ConvertSurfaceAndColorspace)
        $(D SDL_DestroySurface)
*/
extern SDL_Surface*  SDL_ConvertSurface(SDL_Surface* surface, SDL_PixelFormat format);

/**
    Copy an existing surface to a new surface of the specified format and
    colorspace.

    This function converts an existing surface to a new format and colorspace
    and returns the new surface. This will perform any pixel format and
    colorspace conversion needed.

    If the original surface has alternate images, the new surface will have a
    reference to them as well.

    Params:
        surface =       the existing SDL_Surface structure to convert.
        format =        the new pixel format.
        palette =       an optional palette to use for indexed formats, may be NULL.
        colorspace =    the new colorspace.
        props =         an SDL_PropertiesID with additional color properties, or 0.
    
    Returns:
        the new SDL_Surface structure that is created or NULL on failure;
        call SDL_GetError() for more information.

    See_Also:
        $(D SDL_ConvertSurface)
        $(D SDL_DestroySurface)
*/
extern SDL_Surface* SDL_ConvertSurfaceAndColorspace(SDL_Surface* surface, SDL_PixelFormat format, SDL_Palette* palette, SDL_Colorspace colorspace, SDL_PropertiesID props);

/**
    Copy a block of pixels of one format to another format.

    Params:
        width =         the width of the block to copy, in pixels.
        height =        the height of the block to copy, in pixels.
        src_format =    an SDL_PixelFormat value of the `src` pixels format.
        src =           a pointer to the source pixels.
        src_pitch =     the pitch of the source pixels, in bytes.
        dst_format =    an SDL_PixelFormat value of the `dst` pixels format.
        dst =           a pointer to be filled in with new pixel data.
        dst_pitch =     the pitch of the destination pixels, in bytes.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_ConvertPixelsAndColorspace)
*/
extern bool SDL_ConvertPixels(int width, int height, SDL_PixelFormat src_format, const(void)* src, int src_pitch, SDL_PixelFormat dst_format, void* dst, int dst_pitch);

/**
    Copy a block of pixels of one format and colorspace to another format and
    colorspace.

        width =             the width of the block to copy, in pixels.
        height =            the height of the block to copy, in pixels.
        src_format =        an SDL_PixelFormat value of the `src` pixels format.
        src_colorspace =    an SDL_Colorspace value describing the colorspace of
                            the `src` pixels.
        src_properties =    an SDL_PropertiesID with additional source color
                            properties, or 0.
        src =               a pointer to the source pixels.
        src_pitch =         the pitch of the source pixels, in bytes.
        dst_format =        an SDL_PixelFormat value of the `dst` pixels format.
        dst_colorspace =    an SDL_Colorspace value describing the colorspace of
                            the `dst` pixels.
        dst_properties =    an SDL_PropertiesID with additional destination color
                            properties, or 0.
        dst =               a pointer to be filled in with new pixel data.
        dst_pitch =         the pitch of the destination pixels, in bytes.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_ConvertPixels)
*/
extern bool SDL_ConvertPixelsAndColorspace(int width, int height, SDL_PixelFormat src_format, SDL_Colorspace src_colorspace, SDL_PropertiesID src_properties, const(void)* src, int src_pitch, SDL_PixelFormat dst_format, SDL_Colorspace dst_colorspace, SDL_PropertiesID dst_properties, void* dst, int dst_pitch);

/**
    Premultiply the alpha on a block of pixels.

    This is safe to use with src == dst, but not for other overlapping areas.

    Params:
        width =         the width of the block to convert, in pixels.
        height =        the height of the block to convert, in pixels.
        src_format =    an SDL_PixelFormat value of the `src` pixels format.
        src =           a pointer to the source pixels.
        src_pitch =     the pitch of the source pixels, in bytes.
        dst_format =    an SDL_PixelFormat value of the `dst` pixels format.
        dst =           a pointer to be filled in with premultiplied pixel data.
        dst_pitch =     the pitch of the destination pixels, in bytes.
        linear =        true to convert from sRGB to linear space for the alpha
                        multiplication, false to do multiplication in sRGB space.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_PremultiplyAlpha(int width, int height, SDL_PixelFormat src_format, const(void)* src, int src_pitch, SDL_PixelFormat dst_format, void* dst, int dst_pitch, bool linear);

/**
    Premultiply the alpha in a surface.

    This is safe to use with src == dst, but not for other overlapping areas.

    Params:
        surface =   the surface to modify.
        linear =    true to convert from sRGB to linear space for the alpha
                    multiplication, false to do multiplication in sRGB space.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
           information.
*/
extern bool SDL_PremultiplySurfaceAlpha(SDL_Surface* surface, bool linear);

/**
    Clear a surface with a specific color, with floating point precision.

    This function handles all surface formats, and ignores any clip rectangle.

    If the surface is YUV, the color is assumed to be in the sRGB colorspace,
    otherwise the color is assumed to be in the colorspace of the suface.

    surface =   the SDL_Surface to clear.
    r =         the red component of the pixel, normally in the range 0-1.
    g =         the green component of the pixel, normally in the range 0-1.
    b =         the blue component of the pixel, normally in the range 0-1.
    a =         the alpha component of the pixel, normally in the range 0-1.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_ClearSurface(SDL_Surface* surface, float r, float g, float b, float a);

/**
    Perform a fast fill of a rectangle with a specific color.

    `color` should be a pixel of the format used by the surface, and can be
    generated by SDL_MapRGB() or SDL_MapRGBA(). If the color value contains an
    alpha component then the destination is simply filled with that alpha
    information, no blending takes place.

    If there is a clip rectangle set on the destination (set via
    SDL_SetSurfaceClipRect()), then this function will fill based on the
    intersection of the clip rectangle and `rect`.

    Params:
        dst =   the SDL_Surface structure that is the drawing target.
        rect =  the SDL_Rect structure representing the rectangle to fill, or
                NULL to fill the entire surface.
        color = the color to fill with.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_FillSurfaceRects)
*/
extern bool SDL_FillSurfaceRect(SDL_Surface* dst, const(SDL_Rect)* rect, Uint32 color);

/**
    Perform a fast fill of a set of rectangles with a specific color.

    `color` should be a pixel of the format used by the surface, and can be
    generated by SDL_MapRGB() or SDL_MapRGBA(). If the color value contains an
    alpha component then the destination is simply filled with that alpha
    information, no blending takes place.

    If there is a clip rectangle set on the destination (set via
    SDL_SetSurfaceClipRect()), then this function will fill based on the
    intersection of the clip rectangle and `rect`.

    Params:
        dst =   the SDL_Surface structure that is the drawing target.
        rects = an array of SDL_Rects representing the rectangles to fill.
        count = the number of rectangles in the array.
        color = the color to fill with.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_FillSurfaceRect)
*/
extern bool SDL_FillSurfaceRects(SDL_Surface* dst, const(SDL_Rect)* rects, int count, Uint32 color);

/**
    Performs a fast blit from the source surface to the destination surface
    with clipping.

    If either `srcrect` or `dstrect` are NULL, the entire surface (`src` or
    `dst`) is copied while ensuring clipping to `dst->clip_rect`.

    The final blit rectangles are saved in `srcrect` and `dstrect` after all
    clipping is performed.

    The blit function should not be called on a locked surface.

    The blit semantics for surfaces with and without blending and colorkey are
    defined as follows:

    ```
       RGBA->RGB:
       Source surface blend mode set to SDL_BLENDMODE_BLEND:
       alpha-blend (using the source alpha-channel and per-surface alpha)
       SDL_SRCCOLORKEY ignored.
       Source surface blend mode set to SDL_BLENDMODE_NONE:
       copy RGB.
       if SDL_SRCCOLORKEY set, only copy the pixels that do not match the
       RGB values of the source color key, ignoring alpha in the
       comparison.

    RGB->RGBA:
       Source surface blend mode set to SDL_BLENDMODE_BLEND:
       alpha-blend (using the source per-surface alpha)
       Source surface blend mode set to SDL_BLENDMODE_NONE:
       copy RGB, set destination alpha to source per-surface alpha value.
       both:
       if SDL_SRCCOLORKEY set, only copy the pixels that do not match the
       source color key.

    RGBA->RGBA:
       Source surface blend mode set to SDL_BLENDMODE_BLEND:
       alpha-blend (using the source alpha-channel and per-surface alpha)
       SDL_SRCCOLORKEY ignored.
       Source surface blend mode set to SDL_BLENDMODE_NONE:
       copy all of RGBA to the destination.
       if SDL_SRCCOLORKEY set, only copy the pixels that do not match the
       RGB values of the source color key, ignoring alpha in the
       comparison.

    RGB->RGB:
       Source surface blend mode set to SDL_BLENDMODE_BLEND:
       alpha-blend (using the source per-surface alpha)
       Source surface blend mode set to SDL_BLENDMODE_NONE:
       copy RGB.
       both:
       if SDL_SRCCOLORKEY set, only copy the pixels that do not match the
       source color key.
    ```

    Params:
        src =       the SDL_Surface structure to be copied from.
        srcrect =   the SDL_Rect structure representing the rectangle to be
                    copied, or NULL to copy the entire surface.
        dst     =   the SDL_Surface structure that is the blit target.
        dstrect =   the SDL_Rect structure representing the x and y position in
                    the destination surface, or NULL for (0,0). The width and
                    height are ignored, and are copied from `srcrect`. If you
                    want a specific width and height, you should use
                    SDL_BlitSurfaceScaled().
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        The same destination surface should not be used from two
        threads at once. It is safe to use the same source surface
        from multiple threads.

    See_Also:
        $(D SDL_BlitSurfaceScaled)
*/
extern bool SDL_BlitSurface(SDL_Surface* src, const(SDL_Rect)* srcrect, SDL_Surface* dst, const(SDL_Rect)* dstrect);

/**
    Perform low-level surface blitting only.

    This is a semi-private blit function and it performs low-level surface
    blitting, assuming the input rectangles have already been clipped.

    Params:
        src =       the SDL_Surface structure to be copied from.
        srcrect =   the SDL_Rect structure representing the rectangle to be
                    copied, may not be NULL.
        dst =       the SDL_Surface structure that is the blit target.
        dstrect =   the SDL_Rect structure representing the target rectangle in
                    the destination surface, may not be NULL.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        The same destination surface should not be used from two
        threads at once. It is safe to use the same source surface
        from multiple threads.

    See_Also:
        $(D SDL_BlitSurface)
*/
extern bool SDL_BlitSurfaceUnchecked(SDL_Surface* src, const(SDL_Rect)* srcrect, SDL_Surface* dst, const(SDL_Rect)* dstrect);

/**
    Perform a scaled blit to a destination surface, which may be of a different
    format.

    Params:
        src =       the SDL_Surface structure to be copied from.
        srcrect =   the SDL_Rect structure representing the rectangle to be
                    copied, or NULL to copy the entire surface.
        dst =       the SDL_Surface structure that is the blit target.
        dstrect =   the SDL_Rect structure representing the target rectangle in
                    the destination surface, or NULL to fill the entire
                    destination surface.
        scaleMode = the SDL_ScaleMode to be used.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        The same destination surface should not be used from two
        threads at once. It is safe to use the same source surface
        from multiple threads.

    See_Also:
        $(D SDL_BlitSurface)
*/
extern bool SDL_BlitSurfaceScaled(SDL_Surface* src, const(SDL_Rect)* srcrect, SDL_Surface* dst, const(SDL_Rect)* dstrect, SDL_ScaleMode scaleMode);

/**
    Perform low-level surface scaled blitting only.

    This is a semi-private function and it performs low-level surface blitting,
    assuming the input rectangles have already been clipped.

    Params:
        src =       the SDL_Surface structure to be copied from.
        srcrect =   the SDL_Rect structure representing the rectangle to be
                    copied, may not be NULL.
        dst =       the SDL_Surface structure that is the blit target.
        dstrect =   the SDL_Rect structure representing the target rectangle in
                    the destination surface, may not be NULL.
        scaleMode = the SDL_ScaleMode to be used.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        The same destination surface should not be used from two
        threads at once. It is safe to use the same source surface
        from multiple threads.

    See_Also:
        $(D SDL_BlitSurfaceScaled)
*/
extern bool SDL_BlitSurfaceUncheckedScaled(SDL_Surface* src, const(SDL_Rect)* srcrect, SDL_Surface* dst, const(SDL_Rect)* dstrect, SDL_ScaleMode scaleMode);

/**
    Perform a tiled blit to a destination surface, which may be of a different
    format.

    The pixels in `srcrect` will be repeated as many times as needed to
    completely fill `dstrect`.

    Params:
        src =       the SDL_Surface structure to be copied from.
        srcrect =   the SDL_Rect structure representing the rectangle to be
                    copied, or NULL to copy the entire surface.
        dst =       the SDL_Surface structure that is the blit target.
        dstrect =   the SDL_Rect structure representing the target rectangle in
                    the destination surface, or NULL to fill the entire surface.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        The same destination surface should not be used from two
        threads at once. It is safe to use the same source surface
        from multiple threads.

    See_Also:
        $(D SDL_BlitSurface)
*/
extern bool SDL_BlitSurfaceTiled(SDL_Surface* src, const(SDL_Rect)* srcrect, SDL_Surface* dst, const(SDL_Rect)* dstrect);

/**
    Perform a scaled and tiled blit to a destination surface, which may be of a
    different format.

    The pixels in `srcrect` will be scaled and repeated as many times as needed
    to completely fill `dstrect`.

    Params:
        src =       the SDL_Surface structure to be copied from.
        srcrect =   the SDL_Rect structure representing the rectangle to be
                    copied, or NULL to copy the entire surface.
        scale =     the scale used to transform srcrect into the destination
                    rectangle, e.g. a 32x32 texture with a scale of 2 would fill
                    64x64 tiles.
        scaleMode = scale algorithm to be used.
        dst =       the SDL_Surface structure that is the blit target.
        dstrect =   the SDL_Rect structure representing the target rectangle in
                    the destination surface, or NULL to fill the entire surface.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        The same destination surface should not be used from two
        threads at once. It is safe to use the same source surface
        from multiple threads.

    See_Also:
        $(D SDL_BlitSurface)
*/
extern bool SDL_BlitSurfaceTiledWithScale(SDL_Surface* src, const(SDL_Rect)* srcrect, float scale, SDL_ScaleMode scaleMode, SDL_Surface* dst, const(SDL_Rect)* dstrect);

/**
    Perform a scaled blit using the 9-grid algorithm to a destination surface,
    which may be of a different format.

    The pixels in the source surface are split into a 3x3 grid, using the
    different corner sizes for each corner, and the sides and center making up
    the remaining pixels. The corners are then scaled using `scale` and fit
    into the corners of the destination rectangle. The sides and center are
    then stretched into place to cover the remaining destination rectangle.

    Params:
        src =           the SDL_Surface structure to be copied from.
        srcrect =       the SDL_Rect structure representing the rectangle to be used
                        for the 9-grid, or NULL to use the entire surface.
        left_width =    the width, in pixels, of the left corners in `srcrect`.
        right_width =   the width, in pixels, of the right corners in `srcrect`.
        top_height =    the height, in pixels, of the top corners in `srcrect`.
        bottom_height = the height, in pixels, of the bottom corners in
                        `srcrect`.
        scale =         the scale used to transform the corner of `srcrect` into the
                        corner of `dstrect`, or 0.0f for an unscaled blit.
        scaleMode =     scale algorithm to be used.
        dst =           the SDL_Surface structure that is the blit target.
        dstrect =       the SDL_Rect structure representing the target rectangle in
                        the destination surface, or NULL to fill the entire surface.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        The same destination surface should not be used from two
        threads at once. It is safe to use the same source surface
        from multiple threads.

    See_Also:
        $(D SDL_BlitSurface)
*/
extern bool SDL_BlitSurface9Grid(SDL_Surface* src, const(SDL_Rect)* srcrect, int left_width, int right_width, int top_height, int bottom_height, float scale, SDL_ScaleMode scaleMode, SDL_Surface* dst, const(SDL_Rect)* dstrect);

/**
    Map an RGB triple to an opaque pixel value for a surface.

    This function maps the RGB color value to the specified pixel format and
    returns the pixel value best approximating the given RGB color value for
    the given pixel format.

    If the surface has a palette, the index of the closest matching color in
    the palette will be returned.

    If the surface pixel format has an alpha component it will be returned as
    all 1 bits (fully opaque).

    If the pixel format bpp (color depth) is less than 32-bpp then the unused
    upper bits of the return value can safely be ignored (e.g., with a 16-bpp
    format the return value can be assigned to a Uint16, and similarly a Uint8
    for an 8-bpp format).

    Params:
    surface =   the surface to use for the pixel format and palette.
    r =         the red component of the pixel in the range 0-255.
    g =         the green component of the pixel in the range 0-255.
    b =         the blue component of the pixel in the range 0-255.
    
    Returns:
        A pixel value.

    See_Also:
        $(D SDL_MapSurfaceRGBA)
*/
extern Uint32 SDL_MapSurfaceRGB(SDL_Surface* surface, Uint8 r, Uint8 g, Uint8 b);

/**
    Map an RGBA quadruple to a pixel value for a surface.

    This function maps the RGBA color value to the specified pixel format and
    returns the pixel value best approximating the given RGBA color value for
    the given pixel format.

    If the surface pixel format has no alpha component the alpha value will be
    ignored (as it will be in formats with a palette).

    If the surface has a palette, the index of the closest matching color in
    the palette will be returned.

    If the pixel format bpp (color depth) is less than 32-bpp then the unused
    upper bits of the return value can safely be ignored (e.g., with a 16-bpp
    format the return value can be assigned to a Uint16, and similarly a Uint8
    for an 8-bpp format).

    Params:
    surface =   the surface to use for the pixel format and palette.
    r =         the red component of the pixel in the range 0-255.
    g =         the green component of the pixel in the range 0-255.
    b =         the blue component of the pixel in the range 0-255.
    a =         the alpha component of the pixel in the range 0-255.
    
    Returns:
        A pixel value.

    See_Also:
        $(D SDL_MapSurfaceRGB)
*/
extern Uint32 SDL_MapSurfaceRGBA(SDL_Surface* surface, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

/**
    Retrieves a single pixel from a surface.

    This function prioritizes correctness over speed: it is suitable for unit
    tests, but is not intended for use in a game engine.

    Like SDL_GetRGBA, this uses the entire 0..255 range when converting color
    components from pixel formats with less than 8 bits per RGB component.

    Params:
        surface =   the surface to read.
        x =         the horizontal coordinate, 0 <= x < width.
        y =         the vertical coordinate, 0 <= y < height.
        r =         a pointer filled in with the red channel, 0-255, or NULL to ignore
                    this channel.
        g =         a pointer filled in with the green channel, 0-255, or NULL to
                    ignore this channel.
        b =         a pointer filled in with the blue channel, 0-255, or NULL to
                    ignore this channel.
        a =         a pointer filled in with the alpha channel, 0-255, or NULL to
                    ignore this channel.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_ReadSurfacePixel(SDL_Surface* surface, int x, int y, Uint8* r, Uint8* g, Uint8* b, Uint8* a);

/**
    Retrieves a single pixel from a surface.

    This function prioritizes correctness over speed: it is suitable for unit
    tests, but is not intended for use in a game engine.

    Params:
        surface the surface to read.
        x = the horizontal coordinate, 0 <= x < width.
        y = the vertical coordinate, 0 <= y < height.
        r = a pointer filled in with the red channel, normally in the range
            0-1, or NULL to ignore this channel.
        g = a pointer filled in with the green channel, normally in the range
            0-1, or NULL to ignore this channel.
        b = a pointer filled in with the blue channel, normally in the range
            0-1, or NULL to ignore this channel.
        a = a pointer filled in with the alpha channel, normally in the range
            0-1, or NULL to ignore this channel.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_ReadSurfacePixelFloat(SDL_Surface* surface, int x, int y, float* r, float* g, float* b, float* a);

/**
    Writes a single pixel to a surface.

    This function prioritizes correctness over speed: it is suitable for unit
    tests, but is not intended for use in a game engine.

    Like SDL_MapRGBA, this uses the entire 0..255 range when converting color
    components from pixel formats with less than 8 bits per RGB component.

    Params:
        surface =   the surface to write.
        x =         the horizontal coordinate, 0 <= x < width.
        y =         the vertical coordinate, 0 <= y < height.
        r =         the red channel value, 0-255.
        g =         the green channel value, 0-255.
        b =         the blue channel value, 0-255.
        a =         the alpha channel value, 0-255.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_WriteSurfacePixel(SDL_Surface* surface, int x, int y, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

/**
    Writes a single pixel to a surface.

    This function prioritizes correctness over speed: it is suitable for unit
    tests, but is not intended for use in a game engine.

    Params:
        surface =   the surface to write.
        x =         the horizontal coordinate, 0 <= x < width.
        y =         the vertical coordinate, 0 <= y < height.
        r =         the red channel value, normally in the range 0-1.
        g =         the green channel value, normally in the range 0-1.
        b =         the blue channel value, normally in the range 0-1.
        a =         the alpha channel value, normally in the range 0-1.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_WriteSurfacePixelFloat(SDL_Surface* surface, int x, int y, float r, float g, float b, float a);
