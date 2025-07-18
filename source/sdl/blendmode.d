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
    SDL Blending Modes

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryBlendmode, SDL3 Blending Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.blendmode;
import sdl.stdc;

extern(C) nothrow @nogc:

/**
    A set of blend modes used in drawing operations.

    These predefined blend modes are supported everywhere.

    Additional values may be obtained from SDL_ComposeCustomBlendMode.
    
    See_Also:
        $(D SDL_ComposeCustomBlendMode)
*/
alias SDL_BlendMode = Uint32;

/**
    no blending: dstRGBA = srcRGBA
*/
enum SDL_BlendMode SDL_BLENDMODE_NONE =                  0x00000000u;

/**
    alpha blending: dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA)), dstA = srcA + (dstA * (1-srcA))
*/
enum SDL_BlendMode SDL_BLENDMODE_BLEND =                 0x00000001u;

/**
    pre-multiplied alpha blending: dstRGBA = srcRGBA + (dstRGBA * (1-srcA))
*/
enum SDL_BlendMode SDL_BLENDMODE_BLEND_PREMULTIPLIED =   0x00000010u;

/**
    additive blending: dstRGB = (srcRGB * srcA) + dstRGB, dstA = dstA
*/
enum SDL_BlendMode SDL_BLENDMODE_ADD =                   0x00000002u;

/**
    pre-multiplied additive blending: dstRGB = srcRGB + dstRGB, dstA = dstA
*/
enum SDL_BlendMode SDL_BLENDMODE_ADD_PREMULTIPLIED =     0x00000020u;

/**
    color modulate: dstRGB = srcRGB * dstRGB, dstA = dstA
*/
enum SDL_BlendMode SDL_BLENDMODE_MOD =                   0x00000004u;

/**
    color multiply: dstRGB = (srcRGB * dstRGB) + (dstRGB * (1-srcA)), dstA = dstA
*/
enum SDL_BlendMode SDL_BLENDMODE_MUL =                   0x00000008u;
enum SDL_BlendMode SDL_BLENDMODE_INVALID =               0x7FFFFFFFu;

/**
    The blend operation used when combining source and destination pixel
    components.

    \since This enum is available since SDL 3.2.0.
*/
enum SDL_BlendOperation {
    
    /**
        dst + src: supported by all renderers
    */
    SDL_BLENDOPERATION_ADD              = 0x1,  
    
    /**
        src - dst : supported by D3D, OpenGL, OpenGLES, and Vulkan
    */
    SDL_BLENDOPERATION_SUBTRACT         = 0x2,  
    
    /**
        dst - src : supported by D3D, OpenGL, OpenGLES, and Vulkan
    */
    SDL_BLENDOPERATION_REV_SUBTRACT     = 0x3,  
    
    /**
        min(dst, src) : supported by D3D, OpenGL, OpenGLES, and Vulkan
    */
    SDL_BLENDOPERATION_MINIMUM          = 0x4,  
    
    /**
        max(dst, src) : supported by D3D, OpenGL, OpenGLES, and Vulkan
    */
    SDL_BLENDOPERATION_MAXIMUM          = 0x5   
}

/**
    The normalized factor used to multiply pixel components.

    The blend factors are multiplied with the pixels from a drawing operation
    (src) and the pixels from the render target (dst) before the blend
    operation. The comma-separated factors listed above are always applied in
    the component order red, green, blue, and alpha.

    \since This enum is available since SDL 3.2.0.
*/
enum SDL_BlendFactor {
    
    /**
        0, 0, 0, 0
    */
    SDL_BLENDFACTOR_ZERO                = 0x1,  
    
    /**
        1, 1, 1, 1
    */
    SDL_BLENDFACTOR_ONE                 = 0x2,  
    
    /**
        srcR, srcG, srcB, srcA
    */
    SDL_BLENDFACTOR_SRC_COLOR           = 0x3,  
    
    /**
        1-srcR, 1-srcG, 1-srcB, 1-srcA
    */
    SDL_BLENDFACTOR_ONE_MINUS_SRC_COLOR = 0x4,  
    
    /**
        srcA, srcA, srcA, srcA
    */
    SDL_BLENDFACTOR_SRC_ALPHA           = 0x5,  
    
    /**
        1-srcA, 1-srcA, 1-srcA, 1-srcA
    */
    SDL_BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 0x6,  
    
    /**
        dstR, dstG, dstB, dstA
    */
    SDL_BLENDFACTOR_DST_COLOR           = 0x7,  
    
    /**
        1-dstR, 1-dstG, 1-dstB, 1-dstA
    */
    SDL_BLENDFACTOR_ONE_MINUS_DST_COLOR = 0x8,  
    
    /**
        dstA, dstA, dstA, dstA
    */
    SDL_BLENDFACTOR_DST_ALPHA           = 0x9,  
    
    /**
        1-dstA, 1-dstA, 1-dstA, 1-dstA
    */
    SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA = 0xA   
}

/**
    Compose a custom blend mode for renderers.

    The functions SDL_SetRenderDrawBlendMode and SDL_SetTextureBlendMode accept
    the SDL_BlendMode returned by this function if the renderer supports it.

    A blend mode controls how the pixels from a drawing operation (source) get
    combined with the pixels from the render target (destination). First, the
    components of the source and destination pixels get multiplied with their
    blend factors. Then, the blend operation takes the two products and
    calculates the result that will get stored in the render target.

    Expressed in pseudocode, it would look like this:

    ```c
    dstRGB = colorOperation(srcRGB * srcColorFactor, dstRGB * dstColorFactor);
    dstA = alphaOperation(srcA * srcAlphaFactor, dstA * dstAlphaFactor);
    ```

    Where the functions `colorOperation(src, dst)` and `alphaOperation(src,
    dst)` can return one of the following:

    - `src + dst`
    - `src - dst`
    - `dst - src`
    - `min(src, dst)`
    - `max(src, dst)`

    The red, green, and blue components are always multiplied with the first,
    second, and third components of the SDL_BlendFactor, respectively. The
    fourth component is not used.

    The alpha component is always multiplied with the fourth component of the
    SDL_BlendFactor. The other components are not used in the alpha
    calculation.

    Support for these blend modes varies for each renderer. To check if a
    specific SDL_BlendMode is supported, create a renderer and pass it to
    either SDL_SetRenderDrawBlendMode or SDL_SetTextureBlendMode. They will
    return with an error if the blend mode is not supported.

    This list describes the support of custom blend modes for each renderer.
    All renderers support the four blend modes listed in the SDL_BlendMode
    enumeration.

    - **direct3d**: Supports all operations with all factors. However, some
    factors produce unexpected results with `SDL_BLENDOPERATION_MINIMUM` and
    `SDL_BLENDOPERATION_MAXIMUM`.
    - **direct3d11**: Same as Direct3D 9.
    - **opengl**: Supports the `SDL_BLENDOPERATION_ADD` operation with all
    factors. OpenGL versions 1.1, 1.2, and 1.3 do not work correctly here.
    - **opengles2**: Supports the `SDL_BLENDOPERATION_ADD`,
    `SDL_BLENDOPERATION_SUBTRACT`, `SDL_BLENDOPERATION_REV_SUBTRACT`
    operations with all factors.
    - **psp**: No custom blend mode support.
    - **software**: No custom blend mode support.

    Some renderers do not provide an alpha component for the default render
    target. The `SDL_BLENDFACTOR_DST_ALPHA` and
    `SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA` factors do not have an effect in this
    case.

    Params:
        srcColorFactor =    the SDL_BlendFactor applied to the red, green, and
                            blue components of the source pixels.
        dstColorFactor =    the SDL_BlendFactor applied to the red, green, and
                            blue components of the destination pixels.
        colorOperation =    the SDL_BlendOperation used to combine the red,
                            green, and blue components of the source and
                            destination pixels.
        srcAlphaFactor =    the SDL_BlendFactor applied to the alpha component of
                            the source pixels.
        dstAlphaFactor =    the SDL_BlendFactor applied to the alpha component of
                            the destination pixels.
        alphaOperation =    The SDL_BlendOperation used to combine the alpha
                            component of the source and destination pixels.
    
    Returns:
        An SDL_BlendMode that represents the chosen factors and
        operations.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_SetRenderDrawBlendMode)
        $(D SDL_GetRenderDrawBlendMode)
        $(D SDL_SetTextureBlendMode)
        $(D SDL_GetTextureBlendMode)
*/
extern SDL_BlendMode SDL_ComposeCustomBlendMode(SDL_BlendFactor srcColorFactor,
                                                SDL_BlendFactor dstColorFactor,
                                                SDL_BlendOperation colorOperation,
                                                SDL_BlendFactor srcAlphaFactor,
                                                SDL_BlendFactor dstAlphaFactor,
                                                SDL_BlendOperation alphaOperation);
