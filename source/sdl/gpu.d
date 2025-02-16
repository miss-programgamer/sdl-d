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
    SDL GPU

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryAudio, SDL3 GPU Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.gpu;
import sdl.stdc;
import sdl.properties;
import sdl.pixels;
import sdl.rect;
import sdl.video;
import sdl.surface;

extern(C) nothrow @nogc:

/**
    An opaque handle representing the SDL_GPU context.
*/
struct SDL_GPUDevice;

/**
    An opaque handle representing a buffer.

    Used for vertices, indices, indirect draw commands, and general compute
    data.

    See_Also:
        $(D SDL_CreateGPUBuffer)
        $(D SDL_UploadToGPUBuffer)
        $(D SDL_DownloadFromGPUBuffer)
        $(D SDL_CopyGPUBufferToBuffer)
        $(D SDL_BindGPUVertexBuffers)
        $(D SDL_BindGPUIndexBuffer)
        $(D SDL_BindGPUVertexStorageBuffers)
        $(D SDL_BindGPUFragmentStorageBuffers)
        $(D SDL_DrawGPUPrimitivesIndirect)
        $(D SDL_DrawGPUIndexedPrimitivesIndirect)
        $(D SDL_BindGPUComputeStorageBuffers)
        $(D SDL_DispatchGPUComputeIndirect)
        $(D SDL_ReleaseGPUBuffer)
*/
struct SDL_GPUBuffer;

/**
    An opaque handle representing a transfer buffer.

    Used for transferring data to and from the device.

    See_Also:
        $(D SDL_CreateGPUTransferBuffer)
        $(D SDL_MapGPUTransferBuffer)
        $(D SDL_UnmapGPUTransferBuffer)
        $(D SDL_UploadToGPUBuffer)
        $(D SDL_UploadToGPUTexture)
        $(D SDL_DownloadFromGPUBuffer)
        $(D SDL_DownloadFromGPUTexture)
        $(D SDL_ReleaseGPUTransferBuffer)
*/
struct SDL_GPUTransferBuffer;

/**
    An opaque handle representing a texture.

    See_Also:
        $(D SDL_CreateGPUTexture)
        $(D SDL_UploadToGPUTexture)
        $(D SDL_DownloadFromGPUTexture)
        $(D SDL_CopyGPUTextureToTexture)
        $(D SDL_BindGPUVertexSamplers)
        $(D SDL_BindGPUVertexStorageTextures)
        $(D SDL_BindGPUFragmentSamplers)
        $(D SDL_BindGPUFragmentStorageTextures)
        $(D SDL_BindGPUComputeStorageTextures)
        $(D SDL_GenerateMipmapsForGPUTexture)
        $(D SDL_BlitGPUTexture)
        $(D SDL_ReleaseGPUTexture)
*/
struct SDL_GPUTexture;

/**
    An opaque handle representing a sampler.

    See_Also:
        $(D SDL_CreateGPUSampler)
        $(D SDL_BindGPUVertexSamplers)
        $(D SDL_BindGPUFragmentSamplers)
        $(D SDL_ReleaseGPUSampler)
*/
struct SDL_GPUSampler;

/**
    An opaque handle representing a compiled shader object.

    See_Also:
        $(D SDL_CreateGPUShader)
        $(D SDL_CreateGPUGraphicsPipeline)
        $(D SDL_ReleaseGPUShader)
*/
struct SDL_GPUShader;

/**
    An opaque handle representing a compute pipeline.

    Used during compute passes.

    See_Also:
        $(D SDL_CreateGPUComputePipeline)
        $(D SDL_BindGPUComputePipeline)
        $(D SDL_ReleaseGPUComputePipeline)
*/
struct SDL_GPUComputePipeline;

/**
    An opaque handle representing a graphics pipeline.

    Used during render passes.

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
        $(D SDL_BindGPUGraphicsPipeline)
        $(D SDL_ReleaseGPUGraphicsPipeline)
*/
struct SDL_GPUGraphicsPipeline;

/**
    An opaque handle representing a command buffer.

    Most state is managed via command buffers. When setting state using a
    command buffer, that state is local to the command buffer.

    Commands only begin execution on the GPU once SDL_SubmitGPUCommandBuffer is
    called. Once the command buffer is submitted, it is no longer valid to use
    it.

    Command buffers are executed in submission order. If you submit command
    buffer A and then command buffer B all commands in A will begin executing
    before any command in B begins executing.

    In multi-threading scenarios, you should only access a command buffer on
    the thread you acquired it from.

    See_Also:
        $(D SDL_AcquireGPUCommandBuffer)
        $(D SDL_SubmitGPUCommandBuffer)
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
*/
struct SDL_GPUCommandBuffer;

/**
    An opaque handle representing a render pass.

    This handle is transient and should not be held or referenced after
    SDL_EndGPURenderPass is called.

    See_Also:
        $(D SDL_BeginGPURenderPass)
        $(D SDL_EndGPURenderPass)
*/
struct SDL_GPURenderPass;

/**
    An opaque handle representing a compute pass.

    This handle is transient and should not be held or referenced after
    SDL_EndGPUComputePass is called.


    See_Also:
        $(D SDL_BeginGPUComputePass)
        $(D SDL_EndGPUComputePass)
*/
struct SDL_GPUComputePass;

/**
    An opaque handle representing a copy pass.

    This handle is transient and should not be held or referenced after
    SDL_EndGPUCopyPass is called.


    See_Also:
        $(D SDL_BeginGPUCopyPass)
        $(D SDL_EndGPUCopyPass)
*/
struct SDL_GPUCopyPass;

/**
    An opaque handle representing a fence.


    See_Also:
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
        $(D SDL_QueryGPUFence)
        $(D SDL_WaitForGPUFences)
        $(D SDL_ReleaseGPUFence)
*/
struct SDL_GPUFence;

/**
    Specifies the primitive topology of a graphics pipeline.
    
    If you are using POINTLIST you must include a point size output in the
    vertex shader.
    
    -   For HLSL compiling to SPIRV you must decorate a float output with
        [[vk::builtin("PointSize")]].
    -   For GLSL you must set the gl_PointSize builtin.
    -   For MSL you must include a float output with the [[point_size]]
        decorator.
    
    Note that sized point topology is totally unsupported on D3D12. Any size
    other than 1 will be ignored. In general, you should avoid using point
    topology for both compatibility and performance reasons. You WILL regret
    using it.
    
    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUPrimitiveType {
        
    /**
        A series of separate triangles. 
    */
    SDL_GPU_PRIMITIVETYPE_TRIANGLELIST,
        
    /**
        A series of connected triangles. 
    */
    SDL_GPU_PRIMITIVETYPE_TRIANGLESTRIP,
        
    /**
        A series of separate lines. 
    */
    SDL_GPU_PRIMITIVETYPE_LINELIST,
        
    /**
        A series of connected lines. 
    */
    SDL_GPU_PRIMITIVETYPE_LINESTRIP,
        
    /**
        A series of separate points. 
    */
    SDL_GPU_PRIMITIVETYPE_POINTLIST,
}

/**
    Specifies how the contents of a texture attached to a render pass are
    treated at the beginning of the render pass.

    See_Also:
        $(D SDL_BeginGPURenderPass)
*/
enum SDL_GPULoadOp {
    
    /**
        The previous contents of the texture will be preserved. 
    */
    SDL_GPU_LOADOP_LOAD,
        
    /**
        The contents of the texture will be cleared to a color. 
    */
    SDL_GPU_LOADOP_CLEAR,
        
    /**
        The previous contents of the texture need not be preserved. The contents will be undefined. 
    */
    SDL_GPU_LOADOP_DONT_CARE,
}

/**
    Specifies how the contents of a texture attached to a render pass are
    treated at the end of the render pass.

    See_Also:
        $(D SDL_BeginGPURenderPass)
*/
enum SDL_GPUStoreOp {
    
    /**
        The contents generated during the render pass will be written to memory. 
    */
    SDL_GPU_STOREOP_STORE,
        
    /**
        The contents generated during the render pass are not needed and may be discarded. The contents will be undefined. 
    */
    SDL_GPU_STOREOP_DONT_CARE,
        
    /**
        The multisample contents generated during the render pass will be resolved to a non-multisample texture. The contents in the multisample texture may then be discarded and will be undefined. 
    */
    SDL_GPU_STOREOP_RESOLVE,
        
    /**
        The multisample contents generated during the render pass will be resolved to a non-multisample texture. The contents in the multisample texture will be written to memory. 
    */
    SDL_GPU_STOREOP_RESOLVE_AND_STORE,
}

/**
    Specifies the size of elements in an index buffer.


        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUIndexElementSize {
        
    /**
        The index elements are 16-bit. 
    */
    SDL_GPU_INDEXELEMENTSIZE_16BIT,
        
    /**
        The index elements are 32-bit. 
    */
    SDL_GPU_INDEXELEMENTSIZE_32BIT,
}

/**
    Specifies the pixel format of a texture.

    Texture format support varies depending on driver, hardware, and usage
    flags. In general, you should use SDL_GPUTextureSupportsFormat to query if
    a format is supported before using it. However, there are a few guaranteed
    formats.

    FIXME: Check universal support for 32-bit component formats FIXME: Check
    universal support for SIMULTANEOUS_READ_WRITE

    For SAMPLER usage, the following formats are universally supported:

    - R8G8B8A8_UNORM
    - B8G8R8A8_UNORM
    - R8_UNORM
    - R8_SNORM
    - R8G8_UNORM
    - R8G8_SNORM
    - R8G8B8A8_SNORM
    - R16_FLOAT
    - R16G16_FLOAT
    - R16G16B16A16_FLOAT
    - R32_FLOAT
    - R32G32_FLOAT
    - R32G32B32A32_FLOAT
    - R11G11B10_UFLOAT
    - R8G8B8A8_UNORM_SRGB
    - B8G8R8A8_UNORM_SRGB
    - D16_UNORM

    For COLOR_TARGET usage, the following formats are universally supported:

    - R8G8B8A8_UNORM
    - B8G8R8A8_UNORM
    - R8_UNORM
    - R16_FLOAT
    - R16G16_FLOAT
    - R16G16B16A16_FLOAT
    - R32_FLOAT
    - R32G32_FLOAT
    - R32G32B32A32_FLOAT
    - R8_UINT
    - R8G8_UINT
    - R8G8B8A8_UINT
    - R16_UINT
    - R16G16_UINT
    - R16G16B16A16_UINT
    - R8_INT
    - R8G8_INT
    - R8G8B8A8_INT
    - R16_INT
    - R16G16_INT
    - R16G16B16A16_INT
    - R8G8B8A8_UNORM_SRGB
    - B8G8R8A8_UNORM_SRGB

    For STORAGE usages, the following formats are universally supported:

    - R8G8B8A8_UNORM
    - R8G8B8A8_SNORM
    - R16G16B16A16_FLOAT
    - R32_FLOAT
    - R32G32_FLOAT
    - R32G32B32A32_FLOAT
    - R8G8B8A8_UINT
    - R16G16B16A16_UINT
    - R8G8B8A8_INT
    - R16G16B16A16_INT

    For DEPTH_STENCIL_TARGET usage, the following formats are universally
    supported:

    - D16_UNORM
    - Either (but not necessarily both!) D24_UNORM or D32_FLOAT
    - Either (but not necessarily both!) D24_UNORM_S8_UINT or D32_FLOAT_S8_UINT

    Unless D16_UNORM is sufficient for your purposes, always check which of
    D24/D32 is supported before creating a depth-stencil texture!


        $(D SDL_CreateGPUTexture)
        $(D SDL_GPUTextureSupportsFormat)
*/
enum SDL_GPUTextureFormat {
    SDL_GPU_TEXTUREFORMAT_INVALID,

    /* Unsigned Normalized Float Color Formats */
    SDL_GPU_TEXTUREFORMAT_A8_UNORM,
    SDL_GPU_TEXTUREFORMAT_R8_UNORM,
    SDL_GPU_TEXTUREFORMAT_R8G8_UNORM,
    SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM,
    SDL_GPU_TEXTUREFORMAT_R16_UNORM,
    SDL_GPU_TEXTUREFORMAT_R16G16_UNORM,
    SDL_GPU_TEXTUREFORMAT_R16G16B16A16_UNORM,
    SDL_GPU_TEXTUREFORMAT_R10G10B10A2_UNORM,
    SDL_GPU_TEXTUREFORMAT_B5G6R5_UNORM,
    SDL_GPU_TEXTUREFORMAT_B5G5R5A1_UNORM,
    SDL_GPU_TEXTUREFORMAT_B4G4R4A4_UNORM,
    SDL_GPU_TEXTUREFORMAT_B8G8R8A8_UNORM,
    /* Compressed Unsigned Normalized Float Color Formats */
    SDL_GPU_TEXTUREFORMAT_BC1_RGBA_UNORM,
    SDL_GPU_TEXTUREFORMAT_BC2_RGBA_UNORM,
    SDL_GPU_TEXTUREFORMAT_BC3_RGBA_UNORM,
    SDL_GPU_TEXTUREFORMAT_BC4_R_UNORM,
    SDL_GPU_TEXTUREFORMAT_BC5_RG_UNORM,
    SDL_GPU_TEXTUREFORMAT_BC7_RGBA_UNORM,
    /* Compressed Signed Float Color Formats */
    SDL_GPU_TEXTUREFORMAT_BC6H_RGB_FLOAT,
    /* Compressed Unsigned Float Color Formats */
    SDL_GPU_TEXTUREFORMAT_BC6H_RGB_UFLOAT,
    /* Signed Normalized Float Color Formats  */
    SDL_GPU_TEXTUREFORMAT_R8_SNORM,
    SDL_GPU_TEXTUREFORMAT_R8G8_SNORM,
    SDL_GPU_TEXTUREFORMAT_R8G8B8A8_SNORM,
    SDL_GPU_TEXTUREFORMAT_R16_SNORM,
    SDL_GPU_TEXTUREFORMAT_R16G16_SNORM,
    SDL_GPU_TEXTUREFORMAT_R16G16B16A16_SNORM,
    /* Signed Float Color Formats */
    SDL_GPU_TEXTUREFORMAT_R16_FLOAT,
    SDL_GPU_TEXTUREFORMAT_R16G16_FLOAT,
    SDL_GPU_TEXTUREFORMAT_R16G16B16A16_FLOAT,
    SDL_GPU_TEXTUREFORMAT_R32_FLOAT,
    SDL_GPU_TEXTUREFORMAT_R32G32_FLOAT,
    SDL_GPU_TEXTUREFORMAT_R32G32B32A32_FLOAT,
    /* Unsigned Float Color Formats */
    SDL_GPU_TEXTUREFORMAT_R11G11B10_UFLOAT,
    /* Unsigned Integer Color Formats */
    SDL_GPU_TEXTUREFORMAT_R8_UINT,
    SDL_GPU_TEXTUREFORMAT_R8G8_UINT,
    SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UINT,
    SDL_GPU_TEXTUREFORMAT_R16_UINT,
    SDL_GPU_TEXTUREFORMAT_R16G16_UINT,
    SDL_GPU_TEXTUREFORMAT_R16G16B16A16_UINT,
    SDL_GPU_TEXTUREFORMAT_R32_UINT,
    SDL_GPU_TEXTUREFORMAT_R32G32_UINT,
    SDL_GPU_TEXTUREFORMAT_R32G32B32A32_UINT,
    /* Signed Integer Color Formats */
    SDL_GPU_TEXTUREFORMAT_R8_INT,
    SDL_GPU_TEXTUREFORMAT_R8G8_INT,
    SDL_GPU_TEXTUREFORMAT_R8G8B8A8_INT,
    SDL_GPU_TEXTUREFORMAT_R16_INT,
    SDL_GPU_TEXTUREFORMAT_R16G16_INT,
    SDL_GPU_TEXTUREFORMAT_R16G16B16A16_INT,
    SDL_GPU_TEXTUREFORMAT_R32_INT,
    SDL_GPU_TEXTUREFORMAT_R32G32_INT,
    SDL_GPU_TEXTUREFORMAT_R32G32B32A32_INT,
    /* SRGB Unsigned Normalized Color Formats */
    SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_B8G8R8A8_UNORM_SRGB,
    /* Compressed SRGB Unsigned Normalized Color Formats */
    SDL_GPU_TEXTUREFORMAT_BC1_RGBA_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_BC2_RGBA_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_BC3_RGBA_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_BC7_RGBA_UNORM_SRGB,
    /* Depth Formats */
    SDL_GPU_TEXTUREFORMAT_D16_UNORM,
    SDL_GPU_TEXTUREFORMAT_D24_UNORM,
    SDL_GPU_TEXTUREFORMAT_D32_FLOAT,
    SDL_GPU_TEXTUREFORMAT_D24_UNORM_S8_UINT,
    SDL_GPU_TEXTUREFORMAT_D32_FLOAT_S8_UINT,
    /* Compressed ASTC Normalized Float Color Formats*/
    SDL_GPU_TEXTUREFORMAT_ASTC_4x4_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_5x4_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_5x5_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_6x5_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_6x6_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x5_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x6_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x8_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x5_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x6_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x8_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x10_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_12x10_UNORM,
    SDL_GPU_TEXTUREFORMAT_ASTC_12x12_UNORM,
    /* Compressed SRGB ASTC Normalized Float Color Formats*/
    SDL_GPU_TEXTUREFORMAT_ASTC_4x4_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_5x4_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_5x5_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_6x5_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_6x6_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x5_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x6_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x8_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x5_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x6_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x8_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x10_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_12x10_UNORM_SRGB,
    SDL_GPU_TEXTUREFORMAT_ASTC_12x12_UNORM_SRGB,
    /* Compressed ASTC Signed Float Color Formats*/
    SDL_GPU_TEXTUREFORMAT_ASTC_4x4_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_5x4_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_5x5_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_6x5_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_6x6_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x5_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x6_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_8x8_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x5_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x6_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x8_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_10x10_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_12x10_FLOAT,
    SDL_GPU_TEXTUREFORMAT_ASTC_12x12_FLOAT
}

enum SDL_GPUTextureUsageFlags : Uint32 {
    
    /**
        Texture supports sampling. 
    */
    SDL_GPU_TEXTUREUSAGE_SAMPLER = (1u << 0),
        
    /**
        Texture is a color render target. 
    */
    SDL_GPU_TEXTUREUSAGE_COLOR_TARGET = (1u << 1),
        
    /**
        Texture is a depth stencil target. 
    */
    SDL_GPU_TEXTUREUSAGE_DEPTH_STENCIL_TARGET = (1u << 2),
        
    /**
        Texture supports storage reads in graphics stages. 
    */
    SDL_GPU_TEXTUREUSAGE_GRAPHICS_STORAGE_READ = (1u << 3),
        
    /**
        Texture supports storage reads in the compute stage. 
    */
    SDL_GPU_TEXTUREUSAGE_COMPUTE_STORAGE_READ = (1u << 4),
        
    /**
        Texture supports storage writes in the compute stage. 
    */
    SDL_GPU_TEXTUREUSAGE_COMPUTE_STORAGE_WRITE = (1u << 5),
        
    /**
        Texture supports reads and writes in the same compute shader. This is NOT equivalent to READ | WRITE. 
    */
    SDL_GPU_TEXTUREUSAGE_COMPUTE_STORAGE_SIMULTANEOUS_READ_WRITE = (1u << 6),
}

/**
    Specifies the type of a texture.
    

    See_Also:
        $(D SDL_CreateGPUTexture)
*/
enum SDL_GPUTextureType {
    
    /**
        The texture is a 2-dimensional image. 
    */
    SDL_GPU_TEXTURETYPE_2D,
        
    /**
        The texture is a 2-dimensional array image. 
    */
    SDL_GPU_TEXTURETYPE_2D_ARRAY,
        
    /**
        The texture is a 3-dimensional image. 
    */
    SDL_GPU_TEXTURETYPE_3D,
        
    /**
        The texture is a cube image. 
    */
    SDL_GPU_TEXTURETYPE_CUBE,
        
    /**
        The texture is a cube array image. 
    */
    SDL_GPU_TEXTURETYPE_CUBE_ARRAY,
}

/**
    Specifies the sample count of a texture.
    
    Used in multisampling. Note that this value only applies when the texture
    is used as a render target.
    

    See_Also:
        $(D SDL_CreateGPUTexture)
        $(D SDL_GPUTextureSupportsSampleCount)
*/
enum SDL_GPUSampleCount {
        
    /**
        No multisampling. 
    */
    SDL_GPU_SAMPLECOUNT_1,
        
    /**
        MSAA 2x 
    */
    SDL_GPU_SAMPLECOUNT_2,
        
    /**
        MSAA 4x 
    */
    SDL_GPU_SAMPLECOUNT_4,
        
    /**
        MSAA 8x 
    */
    SDL_GPU_SAMPLECOUNT_8,
}

/**
    Specifies the face of a cube map.

    Can be passed in as the layer field in texture-related structs.

*/
enum SDL_GPUCubeMapFace {
    SDL_GPU_CUBEMAPFACE_POSITIVEX,
    SDL_GPU_CUBEMAPFACE_NEGATIVEX,
    SDL_GPU_CUBEMAPFACE_POSITIVEY,
    SDL_GPU_CUBEMAPFACE_NEGATIVEY,
    SDL_GPU_CUBEMAPFACE_POSITIVEZ,
    SDL_GPU_CUBEMAPFACE_NEGATIVEZ
}

/**
    Specifies how a buffer is intended to be used by the client.

    A buffer must have at least one usage flag. Note that some usage flag
    combinations are invalid.

    Unlike textures, READ | WRITE can be used for simultaneous read-write
    usage. The same data synchronization concerns as textures apply.

    If you use a STORAGE flag, the data in the buffer must respect std140
    layout conventions. In practical terms this means you must ensure that vec3
    and vec4 fields are 16-byte aligned.


        $(D SDL_CreateGPUBuffer)
*/
enum SDL_GPUBufferUsageFlags : Uint32 {
    
    /**
        Buffer is a vertex buffer. 
    */
    SDL_GPU_BUFFERUSAGE_VERTEX = (1u << 0),
        
    /**
        Buffer is an index buffer. 
    */
    SDL_GPU_BUFFERUSAGE_INDEX = (1u << 1),
        
    /**
        Buffer is an indirect buffer. 
    */
    SDL_GPU_BUFFERUSAGE_INDIRECT = (1u << 2),
        
    /**
        Buffer supports storage reads in graphics stages. 
    */
    SDL_GPU_BUFFERUSAGE_GRAPHICS_STORAGE_READ = (1u << 3),
        
    /**
        Buffer supports storage reads in the compute stage. 
    */
    SDL_GPU_BUFFERUSAGE_COMPUTE_STORAGE_READ = (1u << 4),
        
    /**
        Buffer supports storage writes in the compute stage. 
    */
    SDL_GPU_BUFFERUSAGE_COMPUTE_STORAGE_WRITE = (1u << 5),

}

/**
    Specifies how a transfer buffer is intended to be used by the client.

    Note that mapping and copying FROM an upload transfer buffer or TO a
    download transfer buffer is undefined behavior.


        $(D SDL_CreateGPUTransferBuffer)
*/
enum SDL_GPUTransferBufferUsage {
    SDL_GPU_TRANSFERBUFFERUSAGE_UPLOAD,
    SDL_GPU_TRANSFERBUFFERUSAGE_DOWNLOAD
}

/**
    Specifies which stage a shader program corresponds to.


        $(D SDL_CreateGPUShader)
*/
enum SDL_GPUShaderStage {
    SDL_GPU_SHADERSTAGE_VERTEX,
    SDL_GPU_SHADERSTAGE_FRAGMENT
}

/**
    Specifies the format of shader code.
    
    Each format corresponds to a specific backend that accepts it.
    

    See_Also:
        $(D SDL_CreateGPUShader)
*/
enum SDL_GPUShaderFormat : Uint32 {
    SDL_GPU_SHADERFORMAT_INVALID = 0,
    
/**
    Shaders for NDA'd platforms. 
*/
SDL_GPU_SHADERFORMAT_PRIVATE = (1u << 0),
    
/**
    SPIR-V shaders for Vulkan. 
*/
SDL_GPU_SHADERFORMAT_SPIRV = (1u << 1),
    
/**
    DXBC SM5_1 shaders for D3D12. 
*/
SDL_GPU_SHADERFORMAT_DXBC = (1u << 2),
    
/**
    DXIL SM6_0 shaders for D3D12. 
*/
SDL_GPU_SHADERFORMAT_DXIL = (1u << 3),
    
/**
    MSL shaders for Metal. 
*/
SDL_GPU_SHADERFORMAT_MSL = (1u << 4),
    
/**
    Precompiled metallib shaders for Metal. 
*/
SDL_GPU_SHADERFORMAT_METALLIB = (1u << 5),

}

/**
    Specifies the format of a vertex attribute.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUVertexElementFormat {
    SDL_GPU_VERTEXELEMENTFORMAT_INVALID,

    /* 32-bit Signed Integers */
    SDL_GPU_VERTEXELEMENTFORMAT_INT,
    SDL_GPU_VERTEXELEMENTFORMAT_INT2,
    SDL_GPU_VERTEXELEMENTFORMAT_INT3,
    SDL_GPU_VERTEXELEMENTFORMAT_INT4,

    /* 32-bit Unsigned Integers */
    SDL_GPU_VERTEXELEMENTFORMAT_UINT,
    SDL_GPU_VERTEXELEMENTFORMAT_UINT2,
    SDL_GPU_VERTEXELEMENTFORMAT_UINT3,
    SDL_GPU_VERTEXELEMENTFORMAT_UINT4,

    /* 32-bit Floats */
    SDL_GPU_VERTEXELEMENTFORMAT_FLOAT,
    SDL_GPU_VERTEXELEMENTFORMAT_FLOAT2,
    SDL_GPU_VERTEXELEMENTFORMAT_FLOAT3,
    SDL_GPU_VERTEXELEMENTFORMAT_FLOAT4,

    /* 8-bit Signed Integers */
    SDL_GPU_VERTEXELEMENTFORMAT_BYTE2,
    SDL_GPU_VERTEXELEMENTFORMAT_BYTE4,

    /* 8-bit Unsigned Integers */
    SDL_GPU_VERTEXELEMENTFORMAT_UBYTE2,
    SDL_GPU_VERTEXELEMENTFORMAT_UBYTE4,

    /* 8-bit Signed Normalized */
    SDL_GPU_VERTEXELEMENTFORMAT_BYTE2_NORM,
    SDL_GPU_VERTEXELEMENTFORMAT_BYTE4_NORM,

    /* 8-bit Unsigned Normalized */
    SDL_GPU_VERTEXELEMENTFORMAT_UBYTE2_NORM,
    SDL_GPU_VERTEXELEMENTFORMAT_UBYTE4_NORM,

    /* 16-bit Signed Integers */
    SDL_GPU_VERTEXELEMENTFORMAT_SHORT2,
    SDL_GPU_VERTEXELEMENTFORMAT_SHORT4,

    /* 16-bit Unsigned Integers */
    SDL_GPU_VERTEXELEMENTFORMAT_USHORT2,
    SDL_GPU_VERTEXELEMENTFORMAT_USHORT4,

    /* 16-bit Signed Normalized */
    SDL_GPU_VERTEXELEMENTFORMAT_SHORT2_NORM,
    SDL_GPU_VERTEXELEMENTFORMAT_SHORT4_NORM,

    /* 16-bit Unsigned Normalized */
    SDL_GPU_VERTEXELEMENTFORMAT_USHORT2_NORM,
    SDL_GPU_VERTEXELEMENTFORMAT_USHORT4_NORM,

    /* 16-bit Floats */
    SDL_GPU_VERTEXELEMENTFORMAT_HALF2,
    SDL_GPU_VERTEXELEMENTFORMAT_HALF4
}

/**
    Specifies the rate at which vertex attributes are pulled from buffers.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUVertexInputRate {
    
/**
    Attribute addressing is a function of the vertex index. 
*/
SDL_GPU_VERTEXINPUTRATE_VERTEX,
    
/**
    Attribute addressing is a function of the instance index. 
*/
SDL_GPU_VERTEXINPUTRATE_INSTANCE,
}

/**
    Specifies the fill mode of the graphics pipeline.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUFillMode {
    
/**
    Polygons will be rendered via rasterization. 
*/
SDL_GPU_FILLMODE_FILL,
    
/**
    Polygon edges will be drawn as line segments. 
*/
SDL_GPU_FILLMODE_LINE,
}

/**
    Specifies the facing direction in which triangle faces will be culled.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUCullMode {
    
/**
    No triangles are culled. 
*/
SDL_GPU_CULLMODE_NONE,
    
/**
    Front-facing triangles are culled. 
*/
SDL_GPU_CULLMODE_FRONT,
    
/**
    Back-facing triangles are culled. 
*/
SDL_GPU_CULLMODE_BACK,
}

/**
    Specifies the vertex winding that will cause a triangle to be determined to
    be front-facing.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUFrontFace {
    
/**
    A triangle with counter-clockwise vertex winding will be considered front-facing. 
*/
SDL_GPU_FRONTFACE_COUNTER_CLOCKWISE,
    
/**
    A triangle with clockwise vertex winding will be considered front-facing. 
*/
SDL_GPU_FRONTFACE_CLOCKWISE,
}

/**
    Specifies a comparison operator for depth, stencil and sampler operations.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUCompareOp {
    SDL_GPU_COMPAREOP_INVALID,
    
/**
    The comparison always evaluates false. 
*/
SDL_GPU_COMPAREOP_NEVER,
    
/**
    The comparison evaluates reference < test. 
*/
SDL_GPU_COMPAREOP_LESS,
    
/**
    The comparison evaluates reference == test. 
*/
SDL_GPU_COMPAREOP_EQUAL,
    
/**
    The comparison evaluates reference <= test. 
*/
SDL_GPU_COMPAREOP_LESS_OR_EQUAL,
    
/**
    The comparison evaluates reference > test. 
*/
SDL_GPU_COMPAREOP_GREATER,
    
/**
    The comparison evaluates reference != test. 
*/
SDL_GPU_COMPAREOP_NOT_EQUAL,
    
/**
    The comparison evalutes reference >= test. 
*/
SDL_GPU_COMPAREOP_GREATER_OR_EQUAL,
    
/**
    The comparison always evaluates true. 
*/
SDL_GPU_COMPAREOP_ALWAYS,
}

/**
    Specifies what happens to a stored stencil value if stencil tests fail or
    pass.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUStencilOp {
    SDL_GPU_STENCILOP_INVALID,
        
    /**
        Keeps the current value. 
    */
    SDL_GPU_STENCILOP_KEEP,
        
    /**
        Sets the value to 0. 
    */
    SDL_GPU_STENCILOP_ZERO,
        
    /**
        Sets the value to reference. 
    */
    SDL_GPU_STENCILOP_REPLACE,
        
    /**
        Increments the current value and clamps to the maximum value. 
    */
    SDL_GPU_STENCILOP_INCREMENT_AND_CLAMP,
        
    /**
        Decrements the current value and clamps to 0. 
    */
    SDL_GPU_STENCILOP_DECREMENT_AND_CLAMP,
        
    /**
        Bitwise-inverts the current value. 
    */
    SDL_GPU_STENCILOP_INVERT,
        
    /**
        Increments the current value and wraps back to 0. 
    */
    SDL_GPU_STENCILOP_INCREMENT_AND_WRAP,
        
    /**
        Decrements the current value and wraps to the maximum value. 
    */
    SDL_GPU_STENCILOP_DECREMENT_AND_WRAP,
}

/**
    Specifies the operator to be used when pixels in a render target are
    blended with existing pixels in the texture.
    
    The source color is the value written by the fragment shader. The
    destination color is the value currently existing in the texture.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUBlendOp {
    SDL_GPU_BLENDOP_INVALID,
    
    /**
        (source * source_factor) + (destination * destination_factor) 
    */
    SDL_GPU_BLENDOP_ADD,
        
    /**
        (source * source_factor) - (destination * destination_factor) 
    */
    SDL_GPU_BLENDOP_SUBTRACT,
        
    /**
        (destination * destination_factor) - (source * source_factor) 
    */
    SDL_GPU_BLENDOP_REVERSE_SUBTRACT,
        
    /**
        min(source, destination) 
    */
    SDL_GPU_BLENDOP_MIN,
        
    /**
        max(source, destination) 
    */
    SDL_GPU_BLENDOP_MAX,
}

/**
    Specifies a blending factor to be used when pixels in a render target are
    blended with existing pixels in the texture.
    
    The source color is the value written by the fragment shader. The
    destination color is the value currently existing in the texture.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUBlendFactor {
    SDL_GPU_BLENDFACTOR_INVALID,
    
    /**
        0 
    */
    SDL_GPU_BLENDFACTOR_ZERO,
        
    /**
        1 
    */
    SDL_GPU_BLENDFACTOR_ONE,
        
    /**
        source color 
    */
    SDL_GPU_BLENDFACTOR_SRC_COLOR,
        
    /**
        1 - source color 
    */
    SDL_GPU_BLENDFACTOR_ONE_MINUS_SRC_COLOR,
        
    /**
        destination color 
    */
    SDL_GPU_BLENDFACTOR_DST_COLOR,
        
    /**
        1 - destination color 
    */
    SDL_GPU_BLENDFACTOR_ONE_MINUS_DST_COLOR,
        
    /**
        source alpha 
    */
    SDL_GPU_BLENDFACTOR_SRC_ALPHA,
        
    /**
        1 - source alpha 
    */
    SDL_GPU_BLENDFACTOR_ONE_MINUS_SRC_ALPHA,
        
    /**
        destination alpha 
    */
    SDL_GPU_BLENDFACTOR_DST_ALPHA,
        
    /**
        1 - destination alpha 
    */
    SDL_GPU_BLENDFACTOR_ONE_MINUS_DST_ALPHA,
        
    /**
        blend constant 
    */
    SDL_GPU_BLENDFACTOR_CONSTANT_COLOR,
        
    /**
        1 - blend constant 
    */
    SDL_GPU_BLENDFACTOR_ONE_MINUS_CONSTANT_COLOR,
        
    /**
        min(source alpha, 1 - destination alpha) 
    */
    SDL_GPU_BLENDFACTOR_SRC_ALPHA_SATURATE,
}

/**
    Specifies which color components are written in a graphics pipeline.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
*/
enum SDL_GPUColorComponentFlags : Uint8 {
    
    /**
        the red component 
    */
    SDL_GPU_COLORCOMPONENT_R = (1u << 0),
        
    /**
        the green component 
    */
    SDL_GPU_COLORCOMPONENT_G = (1u << 1),
        
    /**
        the blue component 
    */
    SDL_GPU_COLORCOMPONENT_B = (1u << 2),
        
    /**
        the alpha component 
    */
    SDL_GPU_COLORCOMPONENT_A = (1u << 3),
}

/**
    Specifies a filter operation used by a sampler.
    

    See_Also:
        $(D SDL_CreateGPUSampler)
*/
enum SDL_GPUFilter {
    
/**
    Point filtering. 
*/
SDL_GPU_FILTER_NEAREST,
    
/**
    Linear filtering. 
*/
SDL_GPU_FILTER_LINEAR,
}

/**
    Specifies a mipmap mode used by a sampler.
    

    See_Also:
        $(D SDL_CreateGPUSampler)
*/
enum SDL_GPUSamplerMipmapMode {
        
    /**
        Point filtering. 
    */
    SDL_GPU_SAMPLERMIPMAPMODE_NEAREST,
        
    /**
        Linear filtering. 
    */
    SDL_GPU_SAMPLERMIPMAPMODE_LINEAR,
}

/**
    Specifies behavior of texture sampling when the coordinates exceed the 0-1
    range.
    

    See_Also:
        $(D SDL_CreateGPUSampler)
*/
enum SDL_GPUSamplerAddressMode {
        
    /**
        Specifies that the coordinates will wrap around. 
    */
    SDL_GPU_SAMPLERADDRESSMODE_REPEAT,
        
    /**
        Specifies that the coordinates will wrap around mirrored. 
    */
    SDL_GPU_SAMPLERADDRESSMODE_MIRRORED_REPEAT,
        
    /**
        Specifies that the coordinates will clamp to the 0-1 range. 
    */
    SDL_GPU_SAMPLERADDRESSMODE_CLAMP_TO_EDGE,
}

/**
    Specifies the timing that will be used to present swapchain textures to the
    OS.
    
    VSYNC mode will always be supported. IMMEDIATE and MAILBOX modes may not be
    supported on certain systems.
    
    It is recommended to query SDL_WindowSupportsGPUPresentMode after claiming
    the window if you wish to change the present mode to IMMEDIATE or MAILBOX.
    
    - VSYNC: Waits for vblank before presenting. No tearing is possible. If
    there is a pending image to present, the new image is enqueued for
    presentation. Disallows tearing at the cost of visual latency.
    - IMMEDIATE: Immediately presents. Lowest latency option, but tearing may
    occur.
    - MAILBOX: Waits for vblank before presenting. No tearing is possible. If
    there is a pending image to present, the pending image is replaced by the
    new image. Similar to VSYNC, but with reduced visual latency.
    

    See_Also:
        $(D SDL_SetGPUSwapchainParameters)
        $(D SDL_WindowSupportsGPUPresentMode)
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
*/
enum SDL_GPUPresentMode {
    SDL_GPU_PRESENTMODE_VSYNC,
    SDL_GPU_PRESENTMODE_IMMEDIATE,
    SDL_GPU_PRESENTMODE_MAILBOX
}

/**
    Specifies the texture format and colorspace of the swapchain textures.
    
    SDR will always be supported. Other compositions may not be supported on
    certain systems.
    
    It is recommended to query SDL_WindowSupportsGPUSwapchainComposition after
    claiming the window if you wish to change the swapchain composition from
    SDR.
    
    - SDR: B8G8R8A8 or R8G8B8A8 swapchain. Pixel values are in sRGB encoding.
    - SDR_LINEAR: B8G8R8A8_SRGB or R8G8B8A8_SRGB swapchain. Pixel values are
    stored in memory in sRGB encoding but accessed in shaders in "linear
    sRGB" encoding which is sRGB but with a linear transfer function.
    - HDR_EXTENDED_LINEAR: R16G16B16A16_FLOAT swapchain. Pixel values are in
    extended linear sRGB encoding and permits values outside of the [0, 1]
    range.
    - HDR10_ST2084: A2R10G10B10 or A2B10G10R10 swapchain. Pixel values are in
    BT.2020 ST2084 (PQ) encoding.
    

    See_Also:
        $(D SDL_SetGPUSwapchainParameters)
        $(D SDL_WindowSupportsGPUSwapchainComposition)
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
*/
enum SDL_GPUSwapchainComposition {
    SDL_GPU_SWAPCHAINCOMPOSITION_SDR,
    SDL_GPU_SWAPCHAINCOMPOSITION_SDR_LINEAR,
    SDL_GPU_SWAPCHAINCOMPOSITION_HDR_EXTENDED_LINEAR,
    SDL_GPU_SWAPCHAINCOMPOSITION_HDR10_ST2084
}

/**
    A structure specifying a viewport.
    

    See_Also:
        $(D SDL_SetGPUViewport)
*/
struct SDL_GPUViewport {

    /**
        The left offset of the viewport.
    */
    float x;

    /**
        The top offset of the viewport.
    */
    float y;

    /**
        The width of the viewport.
    */
    float w;

    /**
        The height of the viewport.
    */
    float h;

    /**
        The minimum depth of the viewport.
    */
    float min_depth;

    /**
        The maximum depth of the viewport.
    */
    float max_depth;
}

/**
    A structure specifying parameters related to transferring data to or from a
    texture.
    

    See_Also:
        $(D SDL_UploadToGPUTexture)
        $(D SDL_DownloadFromGPUTexture)
*/
struct SDL_GPUTextureTransferInfo {

    /**
        The transfer buffer used in the transfer operation.
    */
    SDL_GPUTransferBuffer* transfer_buffer;

    /**
        The starting byte of the image data in the transfer buffer.
    */
    Uint32 offset;

    /**
        The number of pixels from one row to the next.
    */
    Uint32 pixels_per_row;

    /**
        The number of rows from one layer/depth-slice to the next.
    */
    Uint32 rows_per_layer;
}

/**
    A structure specifying a location in a transfer buffer.
    
    Used when transferring buffer data to or from a transfer buffer.
    

    See_Also:
        $(D SDL_UploadToGPUBuffer)
        $(D SDL_DownloadFromGPUBuffer)
*/
struct SDL_GPUTransferBufferLocation {

    /**
        The transfer buffer used in the transfer operation.
    */
    SDL_GPUTransferBuffer* transfer_buffer;

    /**
        The starting byte of the buffer data in the transfer buffer.
    */
    Uint32 offset;
}

/**
    A structure specifying a location in a texture.
    
    Used when copying data from one texture to another.
    

    See_Also:
        $(D SDL_CopyGPUTextureToTexture)
*/
struct SDL_GPUTextureLocation {

    /**
        The texture used in the copy operation.
    */
    SDL_GPUTexture* texture;

    /**
        The mip level index of the location.
    */
    Uint32 mip_level;

    /**
        The layer index of the location.
    */
    Uint32 layer;

    /**
        The left offset of the location.
    */
    Uint32 x;

    /**
        The top offset of the location.
    */
    Uint32 y;

    /**
        The front offset of the location.
    */
    Uint32 z;
}

/**
    A structure specifying a region of a texture.
    
    Used when transferring data to or from a texture.
    

    See_Also:
        $(D SDL_UploadToGPUTexture)
        $(D SDL_DownloadFromGPUTexture)
*/
struct SDL_GPUTextureRegion {

    /**
        The texture used in the copy operation.
    */
    SDL_GPUTexture* texture;

    /**
        The mip level index to transfer.
    */
    Uint32 mip_level;

    /**
        The layer index to transfer.
    */
    Uint32 layer;

    /**
        The left offset of the region.
    */
    Uint32 x;

    /**
        The top offset of the region.
    */
    Uint32 y;

    /**
        The front offset of the region.
    */
    Uint32 z;

    /**
        The width of the region.
    */
    Uint32 w;

    /**
        The height of the region.
    */
    Uint32 h;

    /**
        The depth of the region.
    */
    Uint32 d;
}

/**
    A structure specifying a region of a texture used in the blit operation.
    

    See_Also:
        $(D SDL_BlitGPUTexture)
*/
struct SDL_GPUBlitRegion {

    /**
        The texture.
    */
    SDL_GPUTexture* texture;

    /**
        The mip level index of the region.
    */
    Uint32 mip_level;

    /**
        The layer index or depth plane of the region. This value is treated as a layer index on 2D array and cube textures, and as a depth plane on 3D textures.
    */
    Uint32 layer_or_depth_plane;

    /**
        The left offset of the region.
    */
    Uint32 x;

    /**
        The top offset of the region. 
    */
    Uint32 y;

    /**
        The width of the region.
    */
    Uint32 w;

    /**
        The height of the region.
    */
    Uint32 h;
}

/**
    A structure specifying a location in a buffer.
    
    Used when copying data between buffers.
    

    See_Also:
        $(D SDL_CopyGPUBufferToBuffer)
*/
struct SDL_GPUBufferLocation {

    /**
        The buffer.
    */
    SDL_GPUBuffer* buffer;

    /**
        The starting byte within the buffer.
    */
    Uint32 offset;
}

/**
    A structure specifying a region of a buffer.
    
    Used when transferring data to or from buffers.
    

    See_Also:
        $(D SDL_UploadToGPUBuffer)
        $(D SDL_DownloadFromGPUBuffer)
*/
struct SDL_GPUBufferRegion {

    /**
        The buffer.
    */
    SDL_GPUBuffer* buffer;

    /**
        The starting byte within the buffer.
    */
    Uint32 offset;

    /**
        The size in bytes of the region.
    */
    Uint32 size;
}

/**
    A structure specifying the parameters of an indirect draw command.
    
    Note that the `first_vertex` and `first_instance` parameters are NOT
    compatible with built-in vertex/instance ID variables in shaders (for
    example, SV_VertexID); GPU APIs and shader languages do not define these
    built-in variables consistently, so if your shader depends on them, the
    only way to keep behavior consistent and portable is to always pass 0 for
    the correlating parameter in the draw calls.
    

    See_Also:
        $(D SDL_DrawGPUPrimitivesIndirect)
*/
struct SDL_GPUIndirectDrawCommand {

    /**
        The number of vertices to draw.
    */
    Uint32 num_vertices;

    /**
        The number of instances to draw.
    */
    Uint32 num_instances;

    /**
        The index of the first vertex to draw.
    */
    Uint32 first_vertex;

    /**
        The ID of the first instance to draw.
    */
    Uint32 first_instance;
}

/**
    A structure specifying the parameters of an indexed indirect draw command.
    
    Note that the `first_vertex` and `first_instance` parameters are NOT
    compatible with built-in vertex/instance ID variables in shaders (for
    example, SV_VertexID); GPU APIs and shader languages do not define these
    built-in variables consistently, so if your shader depends on them, the
    only way to keep behavior consistent and portable is to always pass 0 for
    the correlating parameter in the draw calls.
    

    See_Also:
        $(D SDL_DrawGPUIndexedPrimitivesIndirect)
*/
struct SDL_GPUIndexedIndirectDrawCommand {

    /**
        The number of indices to draw per instance.
    */
    Uint32 num_indices;

    /**
        The number of instances to draw.
    */
    Uint32 num_instances;

    /**
        The base index within the index buffer.
    */
    Uint32 first_index;

    /**
        The value added to the vertex index before indexing into the vertex buffer.
    */
    Sint32 vertex_offset;

    /**
        The ID of the first instance to draw.
    */
    Uint32 first_instance;
}

/**
    A structure specifying the parameters of an indexed dispatch command.
    

    See_Also:
        $(D SDL_DispatchGPUComputeIndirect)
*/
struct SDL_GPUIndirectDispatchCommand {

    /**
        The number of local workgroups to dispatch in the X dimension.
    */
    Uint32 groupcount_x;

    /**
        The number of local workgroups to dispatch in the Y dimension.
    */
    Uint32 groupcount_y;

    /**
        The number of local workgroups to dispatch in the Z dimension.
    */
    Uint32 groupcount_z;
}

/**
    A structure specifying the parameters of a sampler.
    See_Also:
        $(D SDL_CreateGPUSampler)
*/
struct SDL_GPUSamplerCreateInfo {

    /**
        The minification filter to apply to lookups.
    */
    SDL_GPUFilter min_filter;

    /**
        The magnification filter to apply to lookups.
    */
    SDL_GPUFilter mag_filter;

    /**
        The mipmap filter to apply to lookups.
    */
    SDL_GPUSamplerMipmapMode mipmap_mode;

    /**
        The addressing mode for U coordinates outside [0, 1).
    */
    SDL_GPUSamplerAddressMode address_mode_u;

    /**
        The addressing mode for V coordinates outside [0, 1).
    */
    SDL_GPUSamplerAddressMode address_mode_v;

    /**
        The addressing mode for W coordinates outside [0, 1).
    */
    SDL_GPUSamplerAddressMode address_mode_w;

    /**
        The bias to be added to mipmap LOD calculation.
    */
    float mip_lod_bias;

    /**
        The anisotropy value clamp used by the sampler. If enable_anisotropy is false, this is ignored.
    */
    float max_anisotropy;

    /**
        The comparison operator to apply to fetched data before filtering.
    */
    SDL_GPUCompareOp compare_op;

    /**
        Clamps the minimum of the computed LOD value.
    */
    float min_lod;

    /**
        Clamps the maximum of the computed LOD value.
    */
    float max_lod;

    /**
        true to enable anisotropic filtering.
    */
    bool enable_anisotropy;

    /**
        true to enable comparison against a reference value during lookups.
    */
    bool enable_compare;
    Uint8 padding1;
    Uint8 padding2;


    /**
        A properties ID for extensions. Should be 0 if no extensions are needed.
    */
    SDL_PropertiesID props;
}

/**
    A structure specifying the parameters of vertex buffers used in a graphics
    pipeline.
    
    When you call SDL_BindGPUVertexBuffers, you specify the binding slots of
    the vertex buffers. For example if you called SDL_BindGPUVertexBuffers with
    a first_slot of 2 and num_bindings of 3, the binding slots 2, 3, 4 would be
    used by the vertex buffers you pass in.
    
    Vertex attributes are linked to buffers via the buffer_slot field of
    SDL_GPUVertexAttribute. For example, if an attribute has a buffer_slot of
    0, then that attribute belongs to the vertex buffer bound at slot 0.
    

    See_Also:
        $(D SDL_GPUVertexAttribute)
        $(D SDL_GPUVertexInputState)
*/
struct SDL_GPUVertexBufferDescription {

    /**
        The binding slot of the vertex buffer.
    */
    Uint32 slot;

    /**
        The byte pitch between consecutive elements of the vertex buffer.
    */
    Uint32 pitch;

    /**
        Whether attribute addressing is a function of the vertex index or instance index.
    */
    SDL_GPUVertexInputRate input_rate;

    /**
        The number of instances to draw using the same per-instance data before advancing in the instance buffer by one element. Ignored unless input_rate is SDL_GPU_VERTEXINPUTRATE_INSTANCE
    */
    Uint32 instance_step_rate;
}

/**
    A structure specifying a vertex attribute.
    
    All vertex attribute locations provided to an SDL_GPUVertexInputState must
    be unique.
    

    See_Also:
        $(D SDL_GPUVertexBufferDescription)
        $(D SDL_GPUVertexInputState)
*/
struct SDL_GPUVertexAttribute {

    /**
        The shader input location index.
    */
    Uint32 location;

    /**
        The binding slot of the associated vertex buffer.
    */
    Uint32 buffer_slot;

    /**
        The size and type of the attribute data.
    */
    SDL_GPUVertexElementFormat format;

    /**
        The byte offset of this attribute relative to the start of the vertex element.
    */
    Uint32 offset;
}

/**
    A structure specifying the parameters of a graphics pipeline vertex input
    state.
    

    See_Also:
        $(D SDL_GPUGraphicsPipelineCreateInfo)
        $(D SDL_GPUVertexBufferDescription)
        $(D SDL_GPUVertexAttribute)
*/
struct SDL_GPUVertexInputState {

    /**
        A pointer to an array of vertex buffer descriptions.
    */
    const(SDL_GPUVertexBufferDescription)* vertex_buffer_descriptions;

    /**
        The number of vertex buffer descriptions in the above array.
    */
    Uint32 num_vertex_buffers;

    /**
        A pointer to an array of vertex attribute descriptions.
    */
    const(SDL_GPUVertexAttribute)* vertex_attributes;

    /**
        The number of vertex attribute descriptions in the above array.
    */
    Uint32 num_vertex_attributes;
}

/**
    A structure specifying the stencil operation state of a graphics pipeline.
    

    See_Also:
        $(D SDL_GPUDepthStencilState)
*/
struct SDL_GPUStencilOpState {

    /**
        The action performed on samples that fail the stencil test.
    */
    SDL_GPUStencilOp fail_op;

    /**
        The action performed on samples that pass the depth and stencil tests.
    */
    SDL_GPUStencilOp pass_op;

    /**
        The action performed on samples that pass the stencil test and fail the depth test.
    */
    SDL_GPUStencilOp depth_fail_op;

    /**
        The comparison operator used in the stencil test.
    */
    SDL_GPUCompareOp compare_op;
}

/**
    A structure specifying the blend state of a color target.
    

    See_Also:
        $(D SDL_GPUColorTargetDescription)
*/
struct SDL_GPUColorTargetBlendState {

    /**
        The value to be multiplied by the source RGB value.
    */
    SDL_GPUBlendFactor src_color_blendfactor;

    /**
        The value to be multiplied by the destination RGB value.
    */
    SDL_GPUBlendFactor dst_color_blendfactor;

    /**
        The blend operation for the RGB components.
    */
    SDL_GPUBlendOp color_blend_op;

    /**
        The value to be multiplied by the source alpha.
    */
    SDL_GPUBlendFactor src_alpha_blendfactor;

    /**
        The value to be multiplied by the destination alpha.
    */
    SDL_GPUBlendFactor dst_alpha_blendfactor;

    /**
        The blend operation for the alpha component.
    */
    SDL_GPUBlendOp alpha_blend_op;

    /**
        A bitmask specifying which of the RGBA components are enabled for writing. Writes to all channels if enable_color_write_mask is false.
    */
    SDL_GPUColorComponentFlags color_write_mask;

    /**
        Whether blending is enabled for the color target.
    */
    bool enable_blend;

    /**
        Whether the color write mask is enabled.
    */
    bool enable_color_write_mask;
    Uint8 padding1;
    Uint8 padding2;
}

/**
    A structure specifying code and metadata for creating a shader object.
    

    See_Also:
        $(D SDL_CreateGPUShader)
*/
struct SDL_GPUShaderCreateInfo {

    /**
        The size in bytes of the code pointed to.
    */
    size_t code_size;

    /**
        A pointer to shader code.
    */
    const(Uint8)* code;

    /**
        A pointer to a null-terminated UTF-8 string specifying the entry point function name for the shader.
    */
    const(char)* entrypoint;

    /**
        The format of the shader code.
    */
    SDL_GPUShaderFormat format;

    /**
        The stage the shader program corresponds to.
    */
    SDL_GPUShaderStage stage;

    /**
        The number of samplers defined in the shader.
    */
    Uint32 num_samplers;

    /**
        The number of storage textures defined in the shader.
    */
    Uint32 num_storage_textures;

    /**
        The number of storage buffers defined in the shader.
    */
    Uint32 num_storage_buffers;

    /**
        The number of uniform buffers defined in the shader.
    */
    Uint32 num_uniform_buffers;


    /**
        A properties ID for extensions. Should be 0 if no extensions are needed.
    */
    SDL_PropertiesID props;
}

/**
    A structure specifying the parameters of a texture.
    
    Usage flags can be bitwise OR'd together for combinations of usages. Note
    that certain usage combinations are invalid, for example SAMPLER and
    GRAPHICS_STORAGE.
    

    See_Also:
        $(D SDL_CreateGPUTexture)
        $(D SDL_GPUTextureType)
        $(D SDL_GPUTextureFormat)
        $(D SDL_GPUTextureUsageFlags)
        $(D SDL_GPUSampleCount)
*/
struct SDL_GPUTextureCreateInfo {

    /**
        The base dimensionality of the texture.
    */
    SDL_GPUTextureType type;

    /**
        The pixel format of the texture.
    */
    SDL_GPUTextureFormat format;

    /**
        How the texture is intended to be used by the client.
    */
    SDL_GPUTextureUsageFlags usage;

    /**
        The width of the texture.
    */
    Uint32 width;

    /**
        The height of the texture.
    */
    Uint32 height;

    /**
        The layer count or depth of the texture. This value is treated as a layer count on 2D array textures, and as a depth value on 3D textures.
    */
    Uint32 layer_count_or_depth;

    /**
        The number of mip levels in the texture.
    */
    Uint32 num_levels;

    /**
        The number of samples per texel. Only applies if the texture is used as a render target.
    */
    SDL_GPUSampleCount sample_count;


    /**
        A properties ID for extensions. Should be 0 if no extensions are needed.
    */
    SDL_PropertiesID props;
}

/**
    A structure specifying the parameters of a buffer.
    
    Usage flags can be bitwise OR'd together for combinations of usages. Note
    that certain combinations are invalid, for example VERTEX and INDEX.
    

    See_Also:
        $(D SDL_CreateGPUBuffer)
        $(D SDL_GPUBufferUsageFlags)
*/
struct SDL_GPUBufferCreateInfo {

    /**
        How the buffer is intended to be used by the client.
    */
    SDL_GPUBufferUsageFlags usage;

    /**
        The size in bytes of the buffer.
    */
    Uint32 size;


    /**
        A properties ID for extensions. Should be 0 if no extensions are needed.
    */
    SDL_PropertiesID props;
}

/**
    A structure specifying the parameters of a transfer buffer.
    

    See_Also:
        $(D SDL_CreateGPUTransferBuffer)
*/
struct SDL_GPUTransferBufferCreateInfo {

    /**
        How the transfer buffer is intended to be used by the client.
    */
    SDL_GPUTransferBufferUsage usage;

    /**
        The size in bytes of the transfer buffer.
    */
    Uint32 size;


    /**
        A properties ID for extensions. Should be 0 if no extensions are needed.
    */
    SDL_PropertiesID props;
}

/**
    A structure specifying the parameters of the graphics pipeline rasterizer
    state.
    
    NOTE: Some backend APIs (D3D11/12) will enable depth clamping even if
    enable_depth_clip is true. If you rely on this clamp+clip behavior,
    consider enabling depth clip and then manually clamping depth in your
    fragment shaders on Metal and Vulkan.
    

    See_Also:
        $(D SDL_GPUGraphicsPipelineCreateInfo)
*/
struct SDL_GPURasterizerState {

    /**
        Whether polygons will be filled in or drawn as lines.
    */
    SDL_GPUFillMode fill_mode;

    /**
        The facing direction in which triangles will be culled.
    */
    SDL_GPUCullMode cull_mode;

    /**
        The vertex winding that will cause a triangle to be determined as front-facing.
    */
    SDL_GPUFrontFace front_face;

    /**
        A scalar factor controlling the depth value added to each fragment.
    */
    float depth_bias_constant_factor;

    /**
        The maximum depth bias of a fragment.
    */
    float depth_bias_clamp;

    /**
        A scalar factor applied to a fragment's slope in depth calculations.
    */
    float depth_bias_slope_factor;

    /**
        true to bias fragment depth values.
    */
    bool enable_depth_bias;

    /**
        true to enable depth clip, false to enable depth clamp.
    */
    bool enable_depth_clip;
    Uint8 padding1;
    Uint8 padding2;
}

/**
    A structure specifying the parameters of the graphics pipeline multisample
    state.
    

    See_Also:
        $(D SDL_GPUGraphicsPipelineCreateInfo)
*/
struct SDL_GPUMultisampleState {

    /**
        The number of samples to be used in rasterization.
    */
    SDL_GPUSampleCount sample_count;

    /**
        Determines which samples get updated in the render targets. Treated as 0xFFFFFFFF if enable_mask is false.
    */
    Uint32 sample_mask;

    /**
        Enables sample masking.
    */
    bool enable_mask;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
}

/**
    A structure specifying the parameters of the graphics pipeline depth
    stencil state.
    

    See_Also:
        $(D SDL_GPUGraphicsPipelineCreateInfo)
*/
struct SDL_GPUDepthStencilState {

    /**
        The comparison operator used for depth testing.
    */
    SDL_GPUCompareOp compare_op;

    /**
        The stencil op state for back-facing triangles.
    */
    SDL_GPUStencilOpState back_stencil_state;

    /**
        The stencil op state for front-facing triangles.
    */
    SDL_GPUStencilOpState front_stencil_state;

    /**
        Selects the bits of the stencil values participating in the stencil test.
    */
    Uint8 compare_mask;

    /**
        Selects the bits of the stencil values updated by the stencil test.
    */
    Uint8 write_mask;

    /**
        true enables the depth test.
    */
    bool enable_depth_test;

    /**
        true enables depth writes. Depth writes are always disabled when enable_depth_test is false.
    */
    bool enable_depth_write;

    /**
        true enables the stencil test.
    */
    bool enable_stencil_test;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
}

/**
    A structure specifying the parameters of color targets used in a graphics
    pipeline.
    

    See_Also:
        $(D SDL_GPUGraphicsPipelineTargetInfo)
*/
struct SDL_GPUColorTargetDescription {

    /**
        The pixel format of the texture to be used as a color target.
    */
    SDL_GPUTextureFormat format;

    /**
        The blend state to be used for the color target.
    */
    SDL_GPUColorTargetBlendState blend_state;
}

/**
    A structure specifying the descriptions of render targets used in a
    graphics pipeline.
    

    See_Also:
        $(D SDL_GPUGraphicsPipelineCreateInfo)
*/
struct SDL_GPUGraphicsPipelineTargetInfo {

    /**
        A pointer to an array of color target descriptions.
    */
    const(SDL_GPUColorTargetDescription)* color_target_descriptions;

    /**
        The number of color target descriptions in the above array.
    */
    Uint32 num_color_targets;

    /**
        The pixel format of the depth-stencil target. Ignored if has_depth_stencil_target is false.
    */
    SDL_GPUTextureFormat depth_stencil_format;

    /**
        true specifies that the pipeline uses a depth-stencil target.
    */
    bool has_depth_stencil_target;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
}

/**
    A structure specifying the parameters of a graphics pipeline state.
    

    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
        $(D SDL_GPUShader)
        $(D SDL_GPUVertexInputState)
        $(D SDL_GPUPrimitiveType)
        $(D SDL_GPURasterizerState)
        $(D SDL_GPUMultisampleState)
        $(D SDL_GPUDepthStencilState)
        $(D SDL_GPUGraphicsPipelineTargetInfo)
*/
struct SDL_GPUGraphicsPipelineCreateInfo {

    /**
        The vertex shader used by the graphics pipeline.
    */
    SDL_GPUShader* vertex_shader;

    /**
        The fragment shader used by the graphics pipeline.
    */
    SDL_GPUShader* fragment_shader;

    /**
        The vertex layout of the graphics pipeline.
    */
    SDL_GPUVertexInputState vertex_input_state;

    /**
        The primitive topology of the graphics pipeline.
    */
    SDL_GPUPrimitiveType primitive_type;

    /**
        The rasterizer state of the graphics pipeline.
    */
    SDL_GPURasterizerState rasterizer_state;

    /**
        The multisample state of the graphics pipeline.
    */
    SDL_GPUMultisampleState multisample_state;

    /**
        The depth-stencil state of the graphics pipeline.
    */
    SDL_GPUDepthStencilState depth_stencil_state;

    /**
        Formats and blend modes for the render targets of the graphics pipeline.
    */
    SDL_GPUGraphicsPipelineTargetInfo target_info;


    /**
        A properties ID for extensions. Should be 0 if no extensions are needed.
    */
    SDL_PropertiesID props;
}

/**
    A structure specifying the parameters of a compute pipeline state.
    

    See_Also:
        $(D SDL_CreateGPUComputePipeline)
        $(D SDL_GPUShaderFormat)
*/
struct SDL_GPUComputePipelineCreateInfo {

    /**
        The size in bytes of the compute shader code pointed to.
    */
    size_t code_size;

    /**
        A pointer to compute shader code.
    */
    const(Uint8)* code;

    /**
        A pointer to a null-terminated UTF-8 string specifying the entry point function name for the shader.
    */
    const(char)* entrypoint;

    /**
        The format of the compute shader code.
    */
    SDL_GPUShaderFormat format;

    /**
        The number of samplers defined in the shader.
    */
    Uint32 num_samplers;

    /**
        The number of readonly storage textures defined in the shader.
    */
    Uint32 num_readonly_storage_textures;

    /**
        The number of readonly storage buffers defined in the shader.
    */
    Uint32 num_readonly_storage_buffers;

    /**
        The number of read-write storage textures defined in the shader.
    */
    Uint32 num_readwrite_storage_textures;

    /**
        The number of read-write storage buffers defined in the shader.
    */
    Uint32 num_readwrite_storage_buffers;

    /**
        The number of uniform buffers defined in the shader.
    */
    Uint32 num_uniform_buffers;

    /**
        The number of threads in the X dimension. This should match the value in the shader.
    */
    Uint32 threadcount_x;

    /**
        The number of threads in the Y dimension. This should match the value in the shader.
    */
    Uint32 threadcount_y;

    /**
        The number of threads in the Z dimension. This should match the value in the shader.
    */
    Uint32 threadcount_z;


    /**
        A properties ID for extensions. Should be 0 if no extensions are needed.
    */
    SDL_PropertiesID props;
}

/**
    A structure specifying the parameters of a color target used by a render
    pass.
    
    The load_op field determines what is done with the texture at the beginning
    of the render pass.
    
    - LOAD: Loads the data currently in the texture. Not recommended for
    multisample textures as it requires significant memory bandwidth.
    - CLEAR: Clears the texture to a single color.
    - DONT_CARE: The driver will do whatever it wants with the texture memory.
    This is a good option if you know that every single pixel will be touched
    in the render pass.
    
    The store_op field determines what is done with the color results of the
    render pass.
    
    - STORE: Stores the results of the render pass in the texture. Not
    recommended for multisample textures as it requires significant memory
    bandwidth.
    - DONT_CARE: The driver will do whatever it wants with the texture memory.
    This is often a good option for depth/stencil textures.
    - RESOLVE: Resolves a multisample texture into resolve_texture, which must
    have a sample count of 1. Then the driver may discard the multisample
    texture memory. This is the most performant method of resolving a
    multisample target.
    - RESOLVE_AND_STORE: Resolves a multisample texture into the
    resolve_texture, which must have a sample count of 1. Then the driver
    stores the multisample texture's contents. Not recommended as it requires
    significant memory bandwidth.
    

    See_Also:
        $(D SDL_BeginGPURenderPass)
*/
struct SDL_GPUColorTargetInfo {

    /**
        The texture that will be used as a color target by a render pass.
    */
    SDL_GPUTexture* texture;

    /**
        The mip level to use as a color target.
    */
    Uint32 mip_level;

    /**
        The layer index or depth plane to use as a color target. This value is treated as a layer index on 2D array and cube textures, and as a depth plane on 3D textures.
    */
    Uint32 layer_or_depth_plane;

    /**
        The color to clear the color target to at the start of the render pass. Ignored if SDL_GPU_LOADOP_CLEAR is not used.
    */
    SDL_FColor clear_color;

    /**
        What is done with the contents of the color target at the beginning of the render pass.
    */
    SDL_GPULoadOp load_op;

    /**
        What is done with the results of the render pass.
    */
    SDL_GPUStoreOp store_op;

    /**
        The texture that will receive the results of a multisample resolve operation. Ignored if a RESOLVE* store_op is not used.
    */
    SDL_GPUTexture* resolve_texture;

    /**
        The mip level of the resolve texture to use for the resolve operation. Ignored if a RESOLVE* store_op is not used.
    */
    Uint32 resolve_mip_level;

    /**
        The layer index of the resolve texture to use for the resolve operation. Ignored if a RESOLVE* store_op is not used.
    */
    Uint32 resolve_layer;

    /**
        true cycles the texture if the texture is bound and load_op is not LOAD
    */
    bool cycle;

    /**
        true cycles the resolve texture if the resolve texture is bound. Ignored if a RESOLVE* store_op is not used.
    */
    bool cycle_resolve_texture;
    Uint8 padding1;
    Uint8 padding2;
}

/**
    A structure specifying the parameters of a depth-stencil target used by a
    render pass.
    
    The load_op field determines what is done with the depth contents of the
    texture at the beginning of the render pass.
    
    - LOAD: Loads the depth values currently in the texture.
    - CLEAR: Clears the texture to a single depth.
    - DONT_CARE: The driver will do whatever it wants with the memory. This is
    a good option if you know that every single pixel will be touched in the
    render pass.
    
    The store_op field determines what is done with the depth results of the
    render pass.
    
    - STORE: Stores the depth results in the texture.
    - DONT_CARE: The driver will do whatever it wants with the depth results.
    This is often a good option for depth/stencil textures that don't need to
    be reused again.
    
    The stencil_load_op field determines what is done with the stencil contents
    of the texture at the beginning of the render pass.
    
    - LOAD: Loads the stencil values currently in the texture.
    - CLEAR: Clears the stencil values to a single value.
    - DONT_CARE: The driver will do whatever it wants with the memory. This is
    a good option if you know that every single pixel will be touched in the
    render pass.
    
    The stencil_store_op field determines what is done with the stencil results
    of the render pass.
    
    - STORE: Stores the stencil results in the texture.
    - DONT_CARE: The driver will do whatever it wants with the stencil results.
    This is often a good option for depth/stencil textures that don't need to
    be reused again.
    
    Note that depth/stencil targets do not support multisample resolves.
    

    See_Also:
        $(D SDL_BeginGPURenderPass)
*/
struct SDL_GPUDepthStencilTargetInfo {

    /**
        The texture that will be used as the depth stencil target by the render pass.
    */
    SDL_GPUTexture* texture;

    /**
        The value to clear the depth component to at the beginning of the render pass. Ignored if SDL_GPU_LOADOP_CLEAR is not used.
    */
    float clear_depth;

    /**
        What is done with the depth contents at the beginning of the render pass.
    */
    SDL_GPULoadOp load_op;

    /**
        What is done with the depth results of the render pass.
    */
    SDL_GPUStoreOp store_op;

    /**
        What is done with the stencil contents at the beginning of the render pass.
    */
    SDL_GPULoadOp stencil_load_op;

    /**
        What is done with the stencil results of the render pass.
    */
    SDL_GPUStoreOp stencil_store_op;

    /**
        true cycles the texture if the texture is bound and any load ops are not LOAD
    */
    bool cycle;

    /**
        The value to clear the stencil component to at the beginning of the render pass. Ignored if SDL_GPU_LOADOP_CLEAR is not used.
    */
    Uint8 clear_stencil;
    Uint8 padding1;
    Uint8 padding2;
}

/**
    A structure containing parameters for a blit command.
    

    See_Also:
        $(D SDL_BlitGPUTexture)
*/
struct SDL_GPUBlitInfo {

    /**
        The source region for the blit.
    */
    SDL_GPUBlitRegion source;

    /**
        The destination region for the blit.
    */
    SDL_GPUBlitRegion destination;

    /**
        What is done with the contents of the destination before the blit.
    */
    SDL_GPULoadOp load_op;

    /**
        The color to clear the destination region to before the blit. Ignored if load_op is not SDL_GPU_LOADOP_CLEAR.
    */
    SDL_FColor clear_color;

    /**
        The flip mode for the source region.
    */
    SDL_FlipMode flip_mode;

    /**
        The filter mode used when blitting.
    */
    SDL_GPUFilter filter;

    /**
        true cycles the destination texture if it is already bound.
    */
    bool cycle;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
}

/**
    A structure specifying parameters in a buffer binding call.
    

    See_Also:
        $(D SDL_BindGPUVertexBuffers)
        $(D SDL_BindGPUIndexBuffer)
*/
struct SDL_GPUBufferBinding {

    /**
        The buffer to bind. Must have been created with SDL_GPU_BUFFERUSAGE_VERTEX for SDL_BindGPUVertexBuffers, or SDL_GPU_BUFFERUSAGE_INDEX for SDL_BindGPUIndexBuffer.
    */
    SDL_GPUBuffer* buffer;

    /**
        The starting byte of the data to bind in the buffer.
    */
    Uint32 offset;
}

/**
    A structure specifying parameters in a sampler binding call.
    

    See_Also:
        $(D SDL_BindGPUVertexSamplers)
        $(D SDL_BindGPUFragmentSamplers)
*/
struct SDL_GPUTextureSamplerBinding {

    /**
        The texture to bind. Must have been created with SDL_GPU_TEXTUREUSAGE_SAMPLER.
    */
    SDL_GPUTexture* texture;

    /**
        The sampler to bind.
    */
    SDL_GPUSampler* sampler;
}

/**
    A structure specifying parameters related to binding buffers in a compute
    pass.
    

    See_Also:
        $(D SDL_BeginGPUComputePass)
*/
struct SDL_GPUStorageBufferReadWriteBinding {

    /**
        The buffer to bind. Must have been created with SDL_GPU_BUFFERUSAGE_COMPUTE_STORAGE_WRITE.
    */
    SDL_GPUBuffer* buffer;

    /**
        true cycles the buffer if it is already bound.
    */
    bool cycle;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
}

/**
    A structure specifying parameters related to binding textures in a compute
    pass.
    

    See_Also:
        $(D SDL_BeginGPUComputePass)
*/
struct SDL_GPUStorageTextureReadWriteBinding {

    /**
        The texture to bind. Must have been created with SDL_GPU_TEXTUREUSAGE_COMPUTE_STORAGE_WRITE or SDL_GPU_TEXTUREUSAGE_COMPUTE_STORAGE_SIMULTANEOUS_READ_WRITE.
    */
    SDL_GPUTexture* texture;

    /**
        The mip level index to bind.
    */
    Uint32 mip_level;

    /**
        The layer index to bind.
    */
    Uint32 layer;

    /**
        true cycles the texture if it is already bound.
    */
    bool cycle;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
}

/**
    Checks for GPU runtime support.
    
    Params:
        format_flags =  a bitflag indicating which shader formats the app is
                        able to provide.
        name =          the preferred GPU driver, or NULL to let SDL pick the optimal
                        driver.
    Returns:
        true if supported, false otherwise.
    
    See_Also:
        $(D SDL_CreateGPUDevice)
*/
extern bool SDL_GPUSupportsShaderFormats(
    SDL_GPUShaderFormat format_flags,
    const(char)* name);

/**
    Checks for GPU runtime support.
    
    Params:
        props = the properties to use.

    Returns:
        true if supported, false otherwise.

    See_Also:
        $(D SDL_CreateGPUDeviceWithProperties)
*/
extern bool SDL_GPUSupportsProperties(
    SDL_PropertiesID props);

/**
    Creates a GPU context.
    
    Params:
        format_flags =  a bitflag indicating which shader formats the app is
                        able to provide.
        debug_mode =    enable debug mode properties and validations.
        name =          the preferred GPU driver, or NULL to let SDL pick the optimal
                        driver.

    Returns:
        a GPU context on success or NULL on failure; call SDL_GetError()
        for more information.

    See_Also:
        $(D SDL_GetGPUShaderFormats)
        $(D SDL_GetGPUDeviceDriver)
        $(D SDL_DestroyGPUDevice)
        $(D SDL_GPUSupportsShaderFormats)
*/
extern SDL_GPUDevice* SDL_CreateGPUDevice(
    SDL_GPUShaderFormat format_flags,
    bool debug_mode,
    const(char)* name);

/**
    Creates a GPU context.
    
    These are the supported properties:
    
    - `SDL_PROP_GPU_DEVICE_CREATE_DEBUGMODE_BOOLEAN`: enable debug mode
    properties and validations, defaults to true.
    - `SDL_PROP_GPU_DEVICE_CREATE_PREFERLOWPOWER_BOOLEAN`: enable to prefer
    energy efficiency over maximum GPU performance, defaults to false.
    - `SDL_PROP_GPU_DEVICE_CREATE_NAME_STRING`: the name of the GPU driver to
    use, if a specific one is desired.
    
    These are the current shader format properties:
    
    - `SDL_PROP_GPU_DEVICE_CREATE_SHADERS_PRIVATE_BOOLEAN`: The app is able to
    provide shaders for an NDA platform.
    - `SDL_PROP_GPU_DEVICE_CREATE_SHADERS_SPIRV_BOOLEAN`: The app is able to
    provide SPIR-V shaders if applicable.
    - `SDL_PROP_GPU_DEVICE_CREATE_SHADERS_DXBC_BOOLEAN`: The app is able to
    provide DXBC shaders if applicable
    - `SDL_PROP_GPU_DEVICE_CREATE_SHADERS_DXIL_BOOLEAN`: The app is able to
    provide DXIL shaders if applicable.
    - `SDL_PROP_GPU_DEVICE_CREATE_SHADERS_MSL_BOOLEAN`: The app is able to
    provide MSL shaders if applicable.
    - `SDL_PROP_GPU_DEVICE_CREATE_SHADERS_METALLIB_BOOLEAN`: The app is able to
    provide Metal shader libraries if applicable.
    
    With the D3D12 renderer:
    
    - `SDL_PROP_GPU_DEVICE_CREATE_D3D12_SEMANTIC_NAME_STRING`: the prefix to
    use for all vertex semantics, default is "TEXCOORD".
    
    Params:
        props = the properties to use.

    Returns:
        a GPU context on success or NULL on failure; call SDL_GetError()
        for more information.
    
    See_Also:
        $(D SDL_GetGPUShaderFormats)
        $(D SDL_GetGPUDeviceDriver)
        $(D SDL_DestroyGPUDevice)
        $(D SDL_GPUSupportsProperties)
*/
extern SDL_GPUDevice* SDL_CreateGPUDeviceWithProperties(
    SDL_PropertiesID props);

enum SDL_PROP_GPU_DEVICE_CREATE_DEBUGMODE_BOOLEAN = "SDL.gpu.device.create.debugmode";
enum SDL_PROP_GPU_DEVICE_CREATE_PREFERLOWPOWER_BOOLEAN = "SDL.gpu.device.create.preferlowpower";
enum SDL_PROP_GPU_DEVICE_CREATE_NAME_STRING = "SDL.gpu.device.create.name";
enum SDL_PROP_GPU_DEVICE_CREATE_SHADERS_PRIVATE_BOOLEAN = "SDL.gpu.device.create.shaders.private";
enum SDL_PROP_GPU_DEVICE_CREATE_SHADERS_SPIRV_BOOLEAN = "SDL.gpu.device.create.shaders.spirv";
enum SDL_PROP_GPU_DEVICE_CREATE_SHADERS_DXBC_BOOLEAN = "SDL.gpu.device.create.shaders.dxbc";
enum SDL_PROP_GPU_DEVICE_CREATE_SHADERS_DXIL_BOOLEAN = "SDL.gpu.device.create.shaders.dxil";
enum SDL_PROP_GPU_DEVICE_CREATE_SHADERS_MSL_BOOLEAN = "SDL.gpu.device.create.shaders.msl";
enum SDL_PROP_GPU_DEVICE_CREATE_SHADERS_METALLIB_BOOLEAN = "SDL.gpu.device.create.shaders.metallib";
enum SDL_PROP_GPU_DEVICE_CREATE_D3D12_SEMANTIC_NAME_STRING = "SDL.gpu.device.create.d3d12.semantic";

/**
    Destroys a GPU context previously returned by SDL_CreateGPUDevice.
    
    Params:
        device = a GPU Context to destroy.
    
    See_Also:
        $(D SDL_CreateGPUDevice)
*/
extern void SDL_DestroyGPUDevice(SDL_GPUDevice* device);

/**
    Get the number of GPU drivers compiled into SDL.
    
    Returns:
        the number of built in GPU drivers.
    
    See_Also:
        $(D SDL_GetGPUDriver)
*/
extern int SDL_GetNumGPUDrivers();

/**
    Get the name of a built in GPU driver.
    
    The GPU drivers are presented in the order in which they are normally
    checked during initialization.
    
    The names of drivers are all simple, low-ASCII identifiers, like "vulkan",
    "metal" or "direct3d12". These never have Unicode characters, and are not
    meant to be proper names.
    
    Params:
        index = the index of a GPU driver.
    
    Returns:
        the name of the GPU driver with the given **index**.
    
    See_Also:
        $(D SDL_GetNumGPUDrivers)
*/
extern const(char)* SDL_GetGPUDriver(int index);

/**
    Returns the name of the backend used to create this GPU context.
    
    Params:
        device = a GPU context to query.
    
    Returns:
        the name of the device's driver, or NULL on error.
*/
extern const(char)* SDL_GetGPUDeviceDriver(SDL_GPUDevice* device);

/**
    Returns the supported shader formats for this GPU context.
    
    Params:
        device = a GPU context to query.
    
    Returns:
        a bitflag indicating which shader formats the driver is able to
        consume.
*/
extern SDL_GPUShaderFormat SDL_GetGPUShaderFormats(SDL_GPUDevice* device);

/* State Creation */

/**
    Creates a pipeline object to be used in a compute workflow.
    
    Shader resource bindings must be authored to follow a particular order
    depending on the shader format.
    
    For SPIR-V shaders, use the following resource sets:
    
    - 0: Sampled textures, followed by read-only storage textures, followed by
    read-only storage buffers
    - 1: Read-write storage textures, followed by read-write storage buffers
    - 2: Uniform buffers
    
    For DXBC and DXIL shaders, use the following register order:
    
    - (t[n], space0): Sampled textures, followed by read-only storage textures,
    followed by read-only storage buffers
    - (u[n], space1): Read-write storage textures, followed by read-write
    storage buffers
    - (b[n], space2): Uniform buffers
    
    For MSL/metallib, use the following order:
    
    - [[buffer]]: Uniform buffers, followed by read-only storage buffers,
    followed by read-write storage buffers
    - [[texture]]: Sampled textures, followed by read-only storage textures,
    followed by read-write storage textures
    
    There are optional properties that can be provided through `props`. These
    are the supported properties:
    
    - `SDL_PROP_GPU_COMPUTEPIPELINE_CREATE_NAME_STRING`: a name that can be
    displayed in debugging tools.
    
    Params:
        device =        a GPU Context.
        createinfo =    a struct describing the state of the compute pipeline to
                        create.

    Returns:
        a compute pipeline object on success, or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_BindGPUComputePipeline)
        $(D SDL_ReleaseGPUComputePipeline)
*/
extern SDL_GPUComputePipeline* SDL_CreateGPUComputePipeline(
    SDL_GPUDevice* device,
    const(SDL_GPUComputePipelineCreateInfo)* createinfo);

enum SDL_PROP_GPU_COMPUTEPIPELINE_CREATE_NAME_STRING = "SDL.gpu.computepipeline.create.name";

/**
    Creates a pipeline object to be used in a graphics workflow.
    
    There are optional properties that can be provided through `props`. These
    are the supported properties:
    
    - `SDL_PROP_GPU_GRAPHICSPIPELINE_CREATE_NAME_STRING`: a name that can be
    displayed in debugging tools.
    
    Params:
        device =        a GPU Context.
        createinfo =    a struct describing the state of the graphics pipeline to
                        create.
    
    Returns:
        a graphics pipeline object on success, or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_CreateGPUShader)
        $(D SDL_BindGPUGraphicsPipeline)
        $(D SDL_ReleaseGPUGraphicsPipeline)
*/
extern SDL_GPUGraphicsPipeline* SDL_CreateGPUGraphicsPipeline(
    SDL_GPUDevice* device,
    const(SDL_GPUGraphicsPipelineCreateInfo)* createinfo);

enum SDL_PROP_GPU_GRAPHICSPIPELINE_CREATE_NAME_STRING = "SDL.gpu.graphicspipeline.create.name";

/**
    Creates a sampler object to be used when binding textures in a graphics
    workflow.
    
    There are optional properties that can be provided through `props`. These
    are the supported properties:
    
    - `SDL_PROP_GPU_SAMPLER_CREATE_NAME_STRING`: a name that can be displayed
    in debugging tools.
    
    Params:
        device =        a GPU Context.
        createinfo =    a struct describing the state of the sampler to create.
    
    Returns:
        a sampler object on success, or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_BindGPUVertexSamplers)
        $(D SDL_BindGPUFragmentSamplers)
        $(D SDL_ReleaseGPUSampler)
*/
extern SDL_GPUSampler* SDL_CreateGPUSampler(
    SDL_GPUDevice* device,
    const(SDL_GPUSamplerCreateInfo)* createinfo);

enum SDL_PROP_GPU_SAMPLER_CREATE_NAME_STRING = "SDL.gpu.sampler.create.name";

/**
    Creates a shader to be used when creating a graphics pipeline.
    
    Shader resource bindings must be authored to follow a particular order
    depending on the shader format.
    
    For SPIR-V shaders, use the following resource sets:
    
    For vertex shaders:
    
    - 0: Sampled textures, followed by storage textures, followed by storage
    buffers
    - 1: Uniform buffers
    
    For fragment shaders:
    
    - 2: Sampled textures, followed by storage textures, followed by storage
    buffers
    - 3: Uniform buffers
    
    For DXBC and DXIL shaders, use the following register order:
    
    For vertex shaders:
    
    - (t[n], space0): Sampled textures, followed by storage textures, followed
    by storage buffers
    - (s[n], space0): Samplers with indices corresponding to the sampled
    textures
    - (b[n], space1): Uniform buffers
    
    For pixel shaders:
    
    - (t[n], space2): Sampled textures, followed by storage textures, followed
    by storage buffers
    - (s[n], space2): Samplers with indices corresponding to the sampled
    textures
    - (b[n], space3): Uniform buffers
    
    For MSL/metallib, use the following order:
    
    - [[texture]]: Sampled textures, followed by storage textures
    - [[sampler]]: Samplers with indices corresponding to the sampled textures
    - [[buffer]]: Uniform buffers, followed by storage buffers. Vertex buffer 0
    is bound at [[buffer(14)]], vertex buffer 1 at [[buffer(15)]], and so on.
    Rather than manually authoring vertex buffer indices, use the
    [[stage_in]] attribute which will automatically use the vertex input
    information from the SDL_GPUGraphicsPipeline.
    
    Shader semantics other than system-value semantics do not matter in D3D12
    and for ease of use the SDL implementation assumes that non system-value
    semantics will all be TEXCOORD. If you are using HLSL as the shader source
    language, your vertex semantics should start at TEXCOORD0 and increment
    like so: TEXCOORD1, TEXCOORD2, etc. If you wish to change the semantic
    prefix to something other than TEXCOORD you can use
    SDL_PROP_GPU_DEVICE_CREATE_D3D12_SEMANTIC_NAME_STRING with
    SDL_CreateGPUDeviceWithProperties().
    
    There are optional properties that can be provided through `props`. These
    are the supported properties:
    
    - `SDL_PROP_GPU_SHADER_CREATE_NAME_STRING`: a name that can be displayed in
    debugging tools.
    
    Params:
        device =        a GPU Context.
        createinfo =    a struct describing the state of the shader to create.
    
    Returns:
        a shader object on success, or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_CreateGPUGraphicsPipeline)
        $(D SDL_ReleaseGPUShader)
*/
extern SDL_GPUShader* SDL_CreateGPUShader(
    SDL_GPUDevice* device,
    const(SDL_GPUShaderCreateInfo)* createinfo);

enum SDL_PROP_GPU_SHADER_CREATE_NAME_STRING = "SDL.gpu.shader.create.name";

/**
    Creates a texture object to be used in graphics or compute workflows.
    
    The contents of this texture are undefined until data is written to the
    texture.
    
    Note that certain combinations of usage flags are invalid. For example, a
    texture cannot have both the SAMPLER and GRAPHICS_STORAGE_READ flags.
    
    If you request a sample count higher than the hardware supports, the
    implementation will automatically fall back to the highest available sample
    count.
    
    There are optional properties that can be provided through
    SDL_GPUTextureCreateInfo's `props`. These are the supported properties:
    
    - `SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_R_FLOAT`: (Direct3D 12 only) if
    the texture usage is SDL_GPU_TEXTUREUSAGE_COLOR_TARGET, clear the texture
    to a color with this red intensity. Defaults to zero.
    - `SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_G_FLOAT`: (Direct3D 12 only) if
    the texture usage is SDL_GPU_TEXTUREUSAGE_COLOR_TARGET, clear the texture
    to a color with this green intensity. Defaults to zero.
    - `SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_B_FLOAT`: (Direct3D 12 only) if
    the texture usage is SDL_GPU_TEXTUREUSAGE_COLOR_TARGET, clear the texture
    to a color with this blue intensity. Defaults to zero.
    - `SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_A_FLOAT`: (Direct3D 12 only) if
    the texture usage is SDL_GPU_TEXTUREUSAGE_COLOR_TARGET, clear the texture
    to a color with this alpha intensity. Defaults to zero.
    - `SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_DEPTH_FLOAT`: (Direct3D 12 only)
    if the texture usage is SDL_GPU_TEXTUREUSAGE_DEPTH_STENCIL_TARGET, clear
    the texture to a depth of this value. Defaults to zero.
    - `SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_STENCIL_UINT8`: (Direct3D 12
    only) if the texture usage is SDL_GPU_TEXTUREUSAGE_DEPTH_STENCIL_TARGET,
    clear the texture to a stencil of this value. Defaults to zero.
    - `SDL_PROP_GPU_TEXTURE_CREATE_NAME_STRING`: a name that can be displayed
    in debugging tools.
    
    Params:
        device =        a GPU Context.
        createinfo =    a struct describing the state of the texture to create.
    
    Returns:
        a texture object on success, or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_UploadToGPUTexture)
        $(D SDL_DownloadFromGPUTexture)
        $(D SDL_BindGPUVertexSamplers)
        $(D SDL_BindGPUVertexStorageTextures)
        $(D SDL_BindGPUFragmentSamplers)
        $(D SDL_BindGPUFragmentStorageTextures)
        $(D SDL_BindGPUComputeStorageTextures)
        $(D SDL_BlitGPUTexture)
        $(D SDL_ReleaseGPUTexture)
        $(D SDL_GPUTextureSupportsFormat)
*/
extern SDL_GPUTexture* SDL_CreateGPUTexture(
    SDL_GPUDevice* device,
    const(SDL_GPUTextureCreateInfo)* createinfo);

enum SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_R_FLOAT = "SDL.gpu.texture.create.d3d12.clear.r";
enum SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_G_FLOAT = "SDL.gpu.texture.create.d3d12.clear.g";
enum SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_B_FLOAT = "SDL.gpu.texture.create.d3d12.clear.b";
enum SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_A_FLOAT = "SDL.gpu.texture.create.d3d12.clear.a";
enum SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_DEPTH_FLOAT = "SDL.gpu.texture.create.d3d12.clear.depth";
enum SDL_PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_STENCIL_UINT8 = "SDL.gpu.texture.create.d3d12.clear.stencil";
enum SDL_PROP_GPU_TEXTURE_CREATE_NAME_STRING = "SDL.gpu.texture.create.name";

/**
    Creates a buffer object to be used in graphics or compute workflows.
    
    The contents of this buffer are undefined until data is written to the
    buffer.
    
    Note that certain combinations of usage flags are invalid. For example, a
    buffer cannot have both the VERTEX and INDEX flags.
    
    If you use a STORAGE flag, the data in the buffer must respect std140
    layout conventions. In practical terms this means you must ensure that vec3
    and vec4 fields are 16-byte aligned.
    
    For better understanding of underlying concepts and memory management with
    SDL GPU API, you may refer
    [this blog post](https://moonside.games/posts/sdl-gpu-concepts-cycling/)
    .
    
    There are optional properties that can be provided through `props`. These
    are the supported properties:
    
    - `SDL_PROP_GPU_BUFFER_CREATE_NAME_STRING`: a name that can be displayed in
    debugging tools.
    
    Params:
        device =        a GPU Context.
        createinfo =    a struct describing the state of the buffer to create.

    Returns:
        a buffer object on success, or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_UploadToGPUBuffer)
        $(D SDL_DownloadFromGPUBuffer)
        $(D SDL_CopyGPUBufferToBuffer)
        $(D SDL_BindGPUVertexBuffers)
        $(D SDL_BindGPUIndexBuffer)
        $(D SDL_BindGPUVertexStorageBuffers)
        $(D SDL_BindGPUFragmentStorageBuffers)
        $(D SDL_DrawGPUPrimitivesIndirect)
        $(D SDL_DrawGPUIndexedPrimitivesIndirect)
        $(D SDL_BindGPUComputeStorageBuffers)
        $(D SDL_DispatchGPUComputeIndirect)
        $(D SDL_ReleaseGPUBuffer)
*/
extern SDL_GPUBuffer* SDL_CreateGPUBuffer(
    SDL_GPUDevice* device,
    const(SDL_GPUBufferCreateInfo)* createinfo);

enum SDL_PROP_GPU_BUFFER_CREATE_NAME_STRING = "SDL.gpu.buffer.create.name";

/**
    Creates a transfer buffer to be used when uploading to or downloading from
    graphics resources.
    
    Download buffers can be particularly expensive to create, so it is good
    practice to reuse them if data will be downloaded regularly.
    
    There are optional properties that can be provided through `props`. These
    are the supported properties:
    
    - `SDL_PROP_GPU_TRANSFERBUFFER_CREATE_NAME_STRING`: a name that can be
    displayed in debugging tools.
    
    Params:
        device =        a GPU Context.
        createinfo =    a struct describing the state of the transfer buffer to
                        create.
    
    Returns:
        a transfer buffer on success, or NULL on failure; call
        SDL_GetError() for more information.
    
    See_Also:
        $(D SDL_UploadToGPUBuffer)
        $(D SDL_DownloadFromGPUBuffer)
        $(D SDL_UploadToGPUTexture)
        $(D SDL_DownloadFromGPUTexture)
        $(D SDL_ReleaseGPUTransferBuffer)
*/
extern SDL_GPUTransferBuffer* SDL_CreateGPUTransferBuffer(
    SDL_GPUDevice* device,
    const(SDL_GPUTransferBufferCreateInfo)* createinfo);

enum SDL_PROP_GPU_TRANSFERBUFFER_CREATE_NAME_STRING = "SDL.gpu.transferbuffer.create.name";

/**
    Sets an arbitrary string constant to label a buffer.
    
    You should use SDL_PROP_GPU_BUFFER_CREATE_NAME_STRING with
    SDL_CreateGPUBuffer instead of this function to avoid thread safety issues.
    
    Params:
        device =    a GPU Context.
        buffer =    a buffer to attach the name to.
        text =      a UTF-8 string constant to mark as the name of the buffer.
    
    Threadsafety:
        This function is not thread safe, you must make sure the
        buffer is not simultaneously used by any other thread.
    
    See_Also:
        $(D SDL_CreateGPUBuffer)
*/
extern void SDL_SetGPUBufferName(
    SDL_GPUDevice* device,
    SDL_GPUBuffer* buffer,
    const(char)* text);

/**
    Sets an arbitrary string constant to label a texture.
    
    You should use SDL_PROP_GPU_TEXTURE_CREATE_NAME_STRING with
    SDL_CreateGPUTexture instead of this function to avoid thread safety
    issues.
    
    Params:
        device =    a GPU Context.
        texture =   a texture to attach the name to.
        text =      a UTF-8 string constant to mark as the name of the texture.
    
    Threadsafety:
        This function is not thread safe, you must make sure the
        texture is not simultaneously used by any other thread.
    
    See_Also:
        $(D SDL_CreateGPUTexture)
*/
extern void SDL_SetGPUTextureName(
    SDL_GPUDevice* device,
    SDL_GPUTexture* texture,
    const(char)* text);

/**
    Inserts an arbitrary string label into the command buffer callstream.
    
    Useful for debugging.
    
    Params:
        command_buffer =    a command buffer.
        text =              a UTF-8 string constant to insert as the label.
*/
extern void SDL_InsertGPUDebugLabel(
    SDL_GPUCommandBuffer* command_buffer,
    const(char)* text);

/**
    Begins a debug group with an arbitary name.
    
    Used for denoting groups of calls when viewing the command buffer
    callstream in a graphics debugging tool.
    
    Each call to SDL_PushGPUDebugGroup must have a corresponding call to
    SDL_PopGPUDebugGroup.
    
    On some backends (e.g. Metal), pushing a debug group during a
    render/blit/compute pass will create a group that is scoped to the native
    pass rather than the command buffer. For best results, if you push a debug
    group during a pass, always pop it in the same pass.
    
    Params:
        command_buffer =    a command buffer.
        name =              a UTF-8 string constant that names the group.
    
    See_Also:
        $(D SDL_PopGPUDebugGroup)
*/
extern void SDL_PushGPUDebugGroup(
    SDL_GPUCommandBuffer* command_buffer,
    const(char)* name);

/**
    Ends the most-recently pushed debug group.
    
    Params:
        command_buffer = a command buffer.
    
    See_Also:
        $(D SDL_PushGPUDebugGroup)
*/
extern void SDL_PopGPUDebugGroup(
    SDL_GPUCommandBuffer* command_buffer);

/**
    Frees the given texture as soon as it is safe to do so.
    
    You must not reference the texture after calling this function.
    
    Params:
        device =    a GPU context.
        texture =   a texture to be destroyed.
*/
extern void SDL_ReleaseGPUTexture(
SDL_GPUDevice* device,
SDL_GPUTexture* texture);

/**
    Frees the given sampler as soon as it is safe to do so.
    
    You must not reference the sampler after calling this function.
    
    Params:
        device =    a GPU context.
        sampler =   a sampler to be destroyed.
*/
extern void SDL_ReleaseGPUSampler(
SDL_GPUDevice* device,
SDL_GPUSampler* sampler);

/**
    Frees the given buffer as soon as it is safe to do so.
    
    You must not reference the buffer after calling this function.
    
    Params:
        device =    a GPU context.
        buffer =    a buffer to be destroyed.
*/
extern void SDL_ReleaseGPUBuffer(
SDL_GPUDevice* device,
SDL_GPUBuffer* buffer);

/**
    Frees the given transfer buffer as soon as it is safe to do so.
    
    You must not reference the transfer buffer after calling this function.
    
    Params:
        device =            a GPU context.
        transfer_buffer =   a transfer buffer to be destroyed.
*/
extern void SDL_ReleaseGPUTransferBuffer(
SDL_GPUDevice* device,
SDL_GPUTransferBuffer* transfer_buffer);

/**
    Frees the given compute pipeline as soon as it is safe to do so.
    
    You must not reference the compute pipeline after calling this function.
    
    Params:
        device =            a GPU context.
        compute_pipeline =  a compute pipeline to be destroyed.
*/
extern void SDL_ReleaseGPUComputePipeline(
SDL_GPUDevice* device,
SDL_GPUComputePipeline* compute_pipeline);

/**
    Frees the given shader as soon as it is safe to do so.
    
    You must not reference the shader after calling this function.
    
    Params:
        device =    a GPU context.
        shader =    a shader to be destroyed.
*/
extern void SDL_ReleaseGPUShader(
SDL_GPUDevice* device,
SDL_GPUShader* shader);

/**
    Frees the given graphics pipeline as soon as it is safe to do so.
    
    You must not reference the graphics pipeline after calling this function.
    
    Params:
        device =            a GPU context.
        graphics_pipeline = a graphics pipeline to be destroyed.
*/
extern void SDL_ReleaseGPUGraphicsPipeline(
SDL_GPUDevice* device,
SDL_GPUGraphicsPipeline* graphics_pipeline);

/**
    Acquire a command buffer.
    
    This command buffer is managed by the implementation and should not be
    freed by the user. The command buffer may only be used on the thread it was
    acquired on. The command buffer should be submitted on the thread it was
    acquired on.
    
    It is valid to acquire multiple command buffers on the same thread at once.
    In fact a common design pattern is to acquire two command buffers per frame
    where one is dedicated to render and compute passes and the other is
    dedicated to copy passes and other preparatory work such as generating
    mipmaps. Interleaving commands between the two command buffers reduces the
    total amount of passes overall which improves rendering performance.
    
    Params:
        device = a GPU context.
    
    Returns:
        a command buffer, or NULL on failure; call SDL_GetError() for more
        information.
    
    See_Also:
        $(D SDL_SubmitGPUCommandBuffer)
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
*/
extern SDL_GPUCommandBuffer* SDL_AcquireGPUCommandBuffer(
SDL_GPUDevice* device);

/* Uniform Data */

/**
    Pushes data to a vertex uniform slot on the command buffer.
    
    Subsequent draw calls will use this uniform data.
    
    The data being pushed must respect std140 layout conventions. In practical
    terms this means you must ensure that vec3 and vec4 fields are 16-byte
    aligned.
    
    Params:
        command_buffer =    a command buffer.
        slot_index =        the vertex uniform slot to push data to.
        data =              client data to write.
        length =            the length of the data to write.
*/
extern void SDL_PushGPUVertexUniformData(
SDL_GPUCommandBuffer* command_buffer,
Uint32 slot_index,
const(void)* data,
Uint32 length);

/**
    Pushes data to a fragment uniform slot on the command buffer.
    
    Subsequent draw calls will use this uniform data.
    
    The data being pushed must respect std140 layout conventions. In practical
    terms this means you must ensure that vec3 and vec4 fields are 16-byte
    aligned.
    
    Params:
        command_buffer =    a command buffer.
        slot_index =        the fragment uniform slot to push data to.
        data =              client data to write.
        length =            the length of the data to write.
*/
extern void SDL_PushGPUFragmentUniformData(
SDL_GPUCommandBuffer* command_buffer,
Uint32 slot_index,
const(void)* data,
Uint32 length);

/**
    Pushes data to a uniform slot on the command buffer.
    
    Subsequent draw calls will use this uniform data.
    
    The data being pushed must respect std140 layout conventions. In practical
    terms this means you must ensure that vec3 and vec4 fields are 16-byte
    aligned.
    
    Params:
        command_buffer =    a command buffer.
        slot_index =        the uniform slot to push data to.
        data =              client data to write.
        length =            the length of the data to write.
*/
extern void SDL_PushGPUComputeUniformData(
SDL_GPUCommandBuffer* command_buffer,
Uint32 slot_index,
const(void)* data,
Uint32 length);

/* Graphics State */

/**
    Begins a render pass on a command buffer.
    
    A render pass consists of a set of texture subresources (or depth slices in
    the 3D texture case) which will be rendered to during the render pass,
    along with corresponding clear values and load/store operations. All
    operations related to graphics pipelines must take place inside of a render
    pass. A default viewport and scissor state are automatically set when this
    is called. You cannot begin another render pass, or begin a compute pass or
    copy pass until you have ended the render pass.
    
    Params:
        command_buffer =            a command buffer.
        color_target_infos =        an array of texture subresources with
                                    corresponding clear values and load/store ops.
        num_color_targets =         the number of color targets in the
                                    color_target_infos array.
        depth_stencil_target_info = a texture subresource with corresponding
                                    clear value and load/store ops, may be
                                    NULL.
    
    Returns:
        A render pass handle.
    
    See_Also:
        $(D SDL_EndGPURenderPass)
*/
extern SDL_GPURenderPass* SDL_BeginGPURenderPass(
SDL_GPUCommandBuffer* command_buffer,
const(SDL_GPUColorTargetInfo)* color_target_infos,
Uint32 num_color_targets,
const(SDL_GPUDepthStencilTargetInfo)* depth_stencil_target_info);

/**
    Binds a graphics pipeline on a render pass to be used in rendering.
    
    A graphics pipeline must be bound before making any draw calls.
    
    Params:
        render_pass =       a render pass handle.
        graphics_pipeline = the graphics pipeline to bind.
*/
extern void SDL_BindGPUGraphicsPipeline(
SDL_GPURenderPass* render_pass,
SDL_GPUGraphicsPipeline* graphics_pipeline);

/**
    Sets the current viewport state on a command buffer.
    
    Params:
        render_pass =   a render pass handle.
        viewport =      the viewport to set.
*/
extern void SDL_SetGPUViewport(
SDL_GPURenderPass* render_pass,
const(SDL_GPUViewport)* viewport);

/**
    Sets the current scissor state on a command buffer.
    
    Params:
        render_pass =   a render pass handle.
        scissor =       the scissor area to set.
*/
extern void SDL_SetGPUScissor(
SDL_GPURenderPass* render_pass,
const(SDL_Rect)* scissor);

/**
    Sets the current blend constants on a command buffer.
    
    Params:
        render_pass =       a render pass handle.
        blend_constants =   the blend constant color.
    
    See_Also:
        $(D SDL_GPU_BLENDFACTOR_CONSTANT_COLOR)
        $(D SDL_GPU_BLENDFACTOR_ONE_MINUS_CONSTANT_COLOR)
*/
extern void SDL_SetGPUBlendConstants(
SDL_GPURenderPass* render_pass,
SDL_FColor blend_constants);

/**
    Sets the current stencil reference value on a command buffer.
    
    Params:
        render_pass =   a render pass handle.
        reference =     the stencil reference value to set.
*/
extern void SDL_SetGPUStencilReference(
SDL_GPURenderPass* render_pass,
Uint8 reference);

/**
    Binds vertex buffers on a command buffer for use with subsequent draw
    calls.
    
    Params:
        render_pass =   a render pass handle.
        first_slot =    the vertex buffer slot to begin binding from.
        bindings =      an array of SDL_GPUBufferBinding structs containing vertex
                        buffers and offset values.
        num_bindings =  the number of bindings in the bindings array.
*/
extern void SDL_BindGPUVertexBuffers(
SDL_GPURenderPass* render_pass,
Uint32 first_slot,
const(SDL_GPUBufferBinding)* bindings,
Uint32 num_bindings);

/**
    Binds an index buffer on a command buffer for use with subsequent draw
    calls.
    
    Params:
        render_pass =           a render pass handle.
        binding =               a pointer to a struct containing an index buffer and offset.
        index_element_size =    whether the index values in the buffer are 16- or
                                32-bit.
*/
extern void SDL_BindGPUIndexBuffer(
SDL_GPURenderPass* render_pass,
const(SDL_GPUBufferBinding)* binding,
SDL_GPUIndexElementSize index_element_size);

/**
    Binds texture-sampler pairs for use on the vertex shader.
    
    The textures must have been created with SDL_GPU_TEXTUREUSAGE_SAMPLER.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        render_pass =               a render pass handle.
        first_slot =                the vertex sampler slot to begin binding from.
        texture_sampler_bindings =  an array of texture-sampler binding
                                    structs.
        num_bindings =              the number of texture-sampler pairs to bind from the
                                    array.
    
    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUVertexSamplers(
SDL_GPURenderPass* render_pass,
Uint32 first_slot,
const(SDL_GPUTextureSamplerBinding)* texture_sampler_bindings,
Uint32 num_bindings);

/**
    Binds storage textures for use on the vertex shader.
    
    These textures must have been created with
    SDL_GPU_TEXTUREUSAGE_GRAPHICS_STORAGE_READ.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        render_pass =       a render pass handle.
        first_slot =        the vertex storage texture slot to begin binding from.
        storage_textures =  an array of storage textures.
        num_bindings =      the number of storage texture to bind from the array.
    
    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUVertexStorageTextures(
SDL_GPURenderPass* render_pass,
Uint32 first_slot,
const(SDL_GPUTexture*)* storage_textures,
Uint32 num_bindings);

/**
    Binds storage buffers for use on the vertex shader.
    
    These buffers must have been created with
    SDL_GPU_BUFFERUSAGE_GRAPHICS_STORAGE_READ.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        render_pass =       a render pass handle.
        first_slot =        the vertex storage buffer slot to begin binding from.
        storage_buffers =   an array of buffers.
        num_bindings =      the number of buffers to bind from the array.
    
    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUVertexStorageBuffers(
SDL_GPURenderPass* render_pass,
Uint32 first_slot,
const(SDL_GPUBuffer*)* storage_buffers,
Uint32 num_bindings);

/**
    Binds texture-sampler pairs for use on the fragment shader.
    
    The textures must have been created with SDL_GPU_TEXTUREUSAGE_SAMPLER.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        render_pass =               a render pass handle.
        first_slot =                the fragment sampler slot to begin binding from.
        texture_sampler_bindings =  an array of texture-sampler binding
                                    structs.
        num_bindings =              the number of texture-sampler pairs to bind from the
                                    array.

    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUFragmentSamplers(
SDL_GPURenderPass* render_pass,
Uint32 first_slot,
const(SDL_GPUTextureSamplerBinding)* texture_sampler_bindings,
Uint32 num_bindings);

/**
    Binds storage textures for use on the fragment shader.
    
    These textures must have been created with
    SDL_GPU_TEXTUREUSAGE_GRAPHICS_STORAGE_READ.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        render_pass =       a render pass handle.
        first_slot =        the fragment storage texture slot to begin binding from.
        storage_textures =  an array of storage textures.
        num_bindings =      the number of storage textures to bind from the array.
    
    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUFragmentStorageTextures(
SDL_GPURenderPass* render_pass,
Uint32 first_slot,
const(SDL_GPUTexture*)* storage_textures,
Uint32 num_bindings);

/**
    Binds storage buffers for use on the fragment shader.
    
    These buffers must have been created with
    SDL_GPU_BUFFERUSAGE_GRAPHICS_STORAGE_READ.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        render_pass =       a render pass handle.
        first_slot =        the fragment storage buffer slot to begin binding from.
        storage_buffers =   an array of storage buffers.
        num_bindings =      the number of storage buffers to bind from the array.
    
    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUFragmentStorageBuffers(
    SDL_GPURenderPass* render_pass,
    Uint32 first_slot,
    const(SDL_GPUBuffer*)* storage_buffers,
    Uint32 num_bindings);


/**
    Draws data using bound graphics state with an index buffer and instancing
    enabled.
    
    You must not call this function before binding a graphics pipeline.
    
    Note that the `first_vertex` and `first_instance` parameters are NOT
    compatible with built-in vertex/instance ID variables in shaders (for
    example, SV_VertexID); GPU APIs and shader languages do not define these
    built-in variables consistently, so if your shader depends on them, the
    only way to keep behavior consistent and portable is to always pass 0 for
    the correlating parameter in the draw calls.
    
    Params:
        render_pass =       a render pass handle.
        num_indices =       the number of indices to draw per instance.
        num_instances =     the number of instances to draw.
        first_index =       the starting index within the index buffer.
        vertex_offset =     value added to vertex index before indexing into the
                            vertex buffer.
        first_instance =    the ID of the first instance to draw.
*/
extern void SDL_DrawGPUIndexedPrimitives(
    SDL_GPURenderPass* render_pass,
    Uint32 num_indices,
    Uint32 num_instances,
    Uint32 first_index,
    Sint32 vertex_offset,
    Uint32 first_instance);

/**
    Draws data using bound graphics state.
    
    You must not call this function before binding a graphics pipeline.
    
    Note that the `first_vertex` and `first_instance` parameters are NOT
    compatible with built-in vertex/instance ID variables in shaders (for
    example, SV_VertexID); GPU APIs and shader languages do not define these
    built-in variables consistently, so if your shader depends on them, the
    only way to keep behavior consistent and portable is to always pass 0 for
    the correlating parameter in the draw calls.
    
    Params:
        render_pass =       a render pass handle.
        num_vertices =      the number of vertices to draw.
        num_instances =     the number of instances that will be drawn.
        first_vertex =      the index of the first vertex to draw.
        first_instance =    the ID of the first instance to draw.
*/
extern void SDL_DrawGPUPrimitives(
    SDL_GPURenderPass* render_pass,
    Uint32 num_vertices,
    Uint32 num_instances,
    Uint32 first_vertex,
    Uint32 first_instance);

/**
    Draws data using bound graphics state and with draw parameters set from a
    buffer.
    
    The buffer must consist of tightly-packed draw parameter sets that each
    match the layout of SDL_GPUIndirectDrawCommand. You must not call this
    function before binding a graphics pipeline.
    
    Params:
        render_pass =   a render pass handle.
        buffer =        a buffer containing draw parameters.
        offset =        the offset to start reading from the draw buffer.
        draw_count =    the number of draw parameter sets that should be read
                        from the draw buffer.
*/
extern void SDL_DrawGPUPrimitivesIndirect(
SDL_GPURenderPass* render_pass,
SDL_GPUBuffer* buffer,
Uint32 offset,
Uint32 draw_count);

/**
    Draws data using bound graphics state with an index buffer enabled and with
    draw parameters set from a buffer.
    
    The buffer must consist of tightly-packed draw parameter sets that each
    match the layout of SDL_GPUIndexedIndirectDrawCommand. You must not call
    this function before binding a graphics pipeline.
    
    Params:
        render_pass =   a render pass handle.
        buffer =        a buffer containing draw parameters.
        offset =        the offset to start reading from the draw buffer.
        draw_count =    the number of draw parameter sets that should be read
                        from the draw buffer.
*/
extern void SDL_DrawGPUIndexedPrimitivesIndirect(
    SDL_GPURenderPass* render_pass,
    SDL_GPUBuffer* buffer,
    Uint32 offset,
    Uint32 draw_count);

/**
    Ends the given render pass.
    
    All bound graphics state on the render pass command buffer is unset. The
    render pass handle is now invalid.
    
    Params:
        render_pass = a render pass handle.
*/
extern void SDL_EndGPURenderPass(
SDL_GPURenderPass* render_pass);

/* Compute Pass */

/**
    Begins a compute pass on a command buffer.
    
    A compute pass is defined by a set of texture subresources and buffers that
    may be written to by compute pipelines. These textures and buffers must
    have been created with the COMPUTE_STORAGE_WRITE bit or the
    COMPUTE_STORAGE_SIMULTANEOUS_READ_WRITE bit. If you do not create a texture
    with COMPUTE_STORAGE_SIMULTANEOUS_READ_WRITE, you must not read from the
    texture in the compute pass. All operations related to compute pipelines
    must take place inside of a compute pass. You must not begin another
    compute pass, or a render pass or copy pass before ending the compute pass.
    
    A VERY IMPORTANT NOTE - Reads and writes in compute passes are NOT
    implicitly synchronized. This means you may cause data races by both
    reading and writing a resource region in a compute pass, or by writing
    multiple times to a resource region. If your compute work depends on
    reading the completed output from a previous dispatch, you MUST end the
    current compute pass and begin a new one before you can safely access the
    data. Otherwise you will receive unexpected results. Reading and writing a
    texture in the same compute pass is only supported by specific texture
    formats. Make sure you check the format support!
    
    Params:
        command_buffer =                a command buffer.
        storage_texture_bindings =      an array of writeable storage texture
                                        binding structs.
        num_storage_texture_bindings =  the number of storage textures to bind
                                        from the array.
        storage_buffer_bindings =       an array of writeable storage buffer binding
                                        structs.
        num_storage_buffer_bindings =   the number of storage buffers to bind
                                        from the array.

    Returns:
        A compute pass handle.

    See_Also:
        $(D SDL_EndGPUComputePass)
*/
extern SDL_GPUComputePass* SDL_BeginGPUComputePass(
    SDL_GPUCommandBuffer* command_buffer,
    const(SDL_GPUStorageTextureReadWriteBinding)* storage_texture_bindings,
    Uint32 num_storage_texture_bindings,
    const(SDL_GPUStorageBufferReadWriteBinding)* storage_buffer_bindings,
    Uint32 num_storage_buffer_bindings);

/**
    Binds a compute pipeline on a command buffer for use in compute dispatch.
    
    Params:
        compute_pass =      a compute pass handle.
        compute_pipeline =  a compute pipeline to bind.
*/
extern void SDL_BindGPUComputePipeline(
    SDL_GPUComputePass* compute_pass,
    SDL_GPUComputePipeline* compute_pipeline);

/**
    Binds texture-sampler pairs for use on the compute shader.
    
    The textures must have been created with SDL_GPU_TEXTUREUSAGE_SAMPLER.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        compute_pass =              a compute pass handle.
        first_slot =                the compute sampler slot to begin binding from.
        texture_sampler_bindings =  an array of texture-sampler binding
                                    structs.
        num_bindings =              the number of texture-sampler bindings to bind from the
                                    array.

    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUComputeSamplers(
SDL_GPUComputePass* compute_pass,
Uint32 first_slot,
const(SDL_GPUTextureSamplerBinding)* texture_sampler_bindings,
Uint32 num_bindings);

/**
    Binds storage textures as readonly for use on the compute pipeline.
    
    These textures must have been created with
    SDL_GPU_TEXTUREUSAGE_COMPUTE_STORAGE_READ.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        compute_pass =      a compute pass handle.
        first_slot =        the compute storage texture slot to begin binding from.
        storage_textures =  an array of storage textures.
        num_bindings =      the number of storage textures to bind from the array.
    
    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUComputeStorageTextures(
SDL_GPUComputePass* compute_pass,
Uint32 first_slot,
const(SDL_GPUTexture*)* storage_textures,
Uint32 num_bindings);

/**
    Binds storage buffers as readonly for use on the compute pipeline.
    
    These buffers must have been created with
    SDL_GPU_BUFFERUSAGE_COMPUTE_STORAGE_READ.
    
    Be sure your shader is set up according to the requirements documented in
    SDL_CreateGPUShader().
    
    Params:
        compute_pass =      a compute pass handle.
        first_slot =        the compute storage buffer slot to begin binding from.
        storage_buffers =   an array of storage buffer binding structs.
        num_bindings =      the number of storage buffers to bind from the array.
    
    See_Also:
        $(D SDL_CreateGPUShader)
*/
extern void SDL_BindGPUComputeStorageBuffers(
SDL_GPUComputePass* compute_pass,
Uint32 first_slot,
const(SDL_GPUBuffer*)* storage_buffers,
Uint32 num_bindings);

/**
    Dispatches compute work.
    
    You must not call this function before binding a compute pipeline.
    
    A VERY IMPORTANT NOTE If you dispatch multiple times in a compute pass, and
    the dispatches write to the same resource region as each other, there is no
    guarantee of which order the writes will occur. If the write order matters,
    you MUST end the compute pass and begin another one.
    
    Params:
        compute_pass =  a compute pass handle.
        groupcount_x =  number of local workgroups to dispatch in the X
                        dimension.
        groupcount_y =  number of local workgroups to dispatch in the Y
                        dimension.
        groupcount_z =  number of local workgroups to dispatch in the Z
                        dimension.
*/
extern void SDL_DispatchGPUCompute(
SDL_GPUComputePass* compute_pass,
Uint32 groupcount_x,
Uint32 groupcount_y,
Uint32 groupcount_z);

/**
    Dispatches compute work with parameters set from a buffer.
    
    The buffer layout should match the layout of
    SDL_GPUIndirectDispatchCommand. You must not call this function before
    binding a compute pipeline.
    
    A VERY IMPORTANT NOTE If you dispatch multiple times in a compute pass, and
    the dispatches write to the same resource region as each other, there is no
    guarantee of which order the writes will occur. If the write order matters,
    you MUST end the compute pass and begin another one.
    
    Params:
        compute_pass =  a compute pass handle.
        buffer =        a buffer containing dispatch parameters.
        offset =        the offset to start reading from the dispatch buffer.
*/
extern void SDL_DispatchGPUComputeIndirect(
SDL_GPUComputePass* compute_pass,
SDL_GPUBuffer* buffer,
Uint32 offset);

/**
    Ends the current compute pass.
    
    All bound compute state on the command buffer is unset. The compute pass
    handle is now invalid.
    
    Params:
        compute_pass = a compute pass handle.
*/
extern void SDL_EndGPUComputePass(
SDL_GPUComputePass* compute_pass);

/* TransferBuffer Data */

/**
    Maps a transfer buffer into application address space.
    
    You must unmap the transfer buffer before encoding upload commands. The
    memory is owned by the graphics driver - do NOT call SDL_free() on the
    returned pointer.
    
    Params:
        device =            a GPU context.
        transfer_buffer =   a transfer buffer.
        cycle =             if true, cycles the transfer buffer if it is already bound.
    
    Returns:
        the address of the mapped transfer buffer memory, or NULL on
        failure; call SDL_GetError() for more information.
*/
extern void* SDL_MapGPUTransferBuffer(
    SDL_GPUDevice* device,
    SDL_GPUTransferBuffer* transfer_buffer,
    bool cycle);

/**
    Unmaps a previously mapped transfer buffer.
    
    Params:
        device =            a GPU context.
        transfer_buffer =   a previously mapped transfer buffer.
*/
extern void SDL_UnmapGPUTransferBuffer(
    SDL_GPUDevice* device,
    SDL_GPUTransferBuffer* transfer_buffer);


/**
    Begins a copy pass on a command buffer.
    
    All operations related to copying to or from buffers or textures take place
    inside a copy pass. You must not begin another copy pass, or a render pass
    or compute pass before ending the copy pass.
    
    Params:
        command_buffer = a command buffer.
    
    Returns:
        A copy pass handle.
*/
extern SDL_GPUCopyPass* SDL_BeginGPUCopyPass(
    SDL_GPUCommandBuffer* command_buffer);

/**
    Uploads data from a transfer buffer to a texture.
    
    The upload occurs on the GPU timeline. You may assume that the upload has
    finished in subsequent commands.
    
    You must align the data in the transfer buffer to a multiple of the texel
    size of the texture format.
    
    Params:
        copy_pass =     a copy pass handle.
        source =        the source transfer buffer with image layout information.
        destination =   the destination texture region.
        cycle =         if true, cycles the texture if the texture is bound, otherwise
                        overwrites the data.
*/
extern void SDL_UploadToGPUTexture(
SDL_GPUCopyPass* copy_pass,
const(SDL_GPUTextureTransferInfo)* source,
const(SDL_GPUTextureRegion)* destination,
bool cycle);

/**
    Uploads data from a transfer buffer to a buffer.
    
    The upload occurs on the GPU timeline. You may assume that the upload has
    finished in subsequent commands.
    
    Params:
        copy_pass =     a copy pass handle.
        source =        the source transfer buffer with offset.
        destination =   the destination buffer with offset and size.
        cycle =         if true, cycles the buffer if it is already bound, otherwise
                        overwrites the data.
*/
extern void SDL_UploadToGPUBuffer(
    SDL_GPUCopyPass* copy_pass,
    const(SDL_GPUTransferBufferLocation)* source,
    const(SDL_GPUBufferRegion)* destination,
    bool cycle);

/**
    Performs a texture-to-texture copy.
    
    This copy occurs on the GPU timeline. You may assume the copy has finished
    in subsequent commands.
    
    Params:
        copy_pass =     a copy pass handle.
        source =        a source texture region.
        destination =   a destination texture region.
        w =             the width of the region to copy.
        h =             the height of the region to copy.
        d =             the depth of the region to copy.
        cycle =         if true, cycles the destination texture if the destination
                        texture is bound, otherwise overwrites the data.
*/
extern void SDL_CopyGPUTextureToTexture(
    SDL_GPUCopyPass* copy_pass,
    const(SDL_GPUTextureLocation)* source,
    const(SDL_GPUTextureLocation)* destination,
    Uint32 w,
    Uint32 h,
    Uint32 d,
    bool cycle);

/**
    Performs a buffer-to-buffer copy.
    
    This copy occurs on the GPU timeline. You may assume the copy has finished
    in subsequent commands.
    
    Params:
        copy_pass =     a copy pass handle.
        source =        the buffer and offset to copy from.
        destination =   the buffer and offset to copy to.
        size =          the length of the buffer to copy.
        cycle =         if true, cycles the destination buffer if it is already bound,
                        otherwise overwrites the data.
*/
extern void SDL_CopyGPUBufferToBuffer(
    SDL_GPUCopyPass* copy_pass,
    const(SDL_GPUBufferLocation)* source,
    const(SDL_GPUBufferLocation)* destination,
    Uint32 size,
    bool cycle);

/**
    Copies data from a texture to a transfer buffer on the GPU timeline.
    
    This data is not guaranteed to be copied until the command buffer fence is
    signaled.
    
    Params:
        copy_pass =     a copy pass handle.
        source =        the source texture region.
        destination =   the destination transfer buffer with image layout
                        information.
*/
extern void SDL_DownloadFromGPUTexture(
    SDL_GPUCopyPass* copy_pass,
    const(SDL_GPUTextureRegion)* source,
    const(SDL_GPUTextureTransferInfo)* destination);

/**
    Copies data from a buffer to a transfer buffer on the GPU timeline.
    
    This data is not guaranteed to be copied until the command buffer fence is
    signaled.
    
    Params:
        copy_pass =     a copy pass handle.
        source =        the source buffer with offset and size.
        destination =   the destination transfer buffer with offset.
*/
extern void SDL_DownloadFromGPUBuffer(
    SDL_GPUCopyPass* copy_pass,
    const(SDL_GPUBufferRegion)* source,
    const(SDL_GPUTransferBufferLocation)* destination);

/**
    Ends the current copy pass.
    
    Params:
        copy_pass = a copy pass handle.
*/
extern void SDL_EndGPUCopyPass(
SDL_GPUCopyPass* copy_pass);

/**
    Generates mipmaps for the given texture.
    
    This function must not be called inside of any pass.
    
    Params:
        command_buffer =    a command_buffer.
        texture =           a texture with more than 1 mip level.
*/
extern void SDL_GenerateMipmapsForGPUTexture(
SDL_GPUCommandBuffer* command_buffer,
SDL_GPUTexture* texture);

/**
    Blits from a source texture region to a destination texture region.
    
    This function must not be called inside of any pass.
    
    Params:
        command_buffer =    a command buffer.
        info =              the blit info struct containing the blit parameters.
*/
extern void SDL_BlitGPUTexture(
SDL_GPUCommandBuffer* command_buffer,
const(SDL_GPUBlitInfo)* info);

/* Submission/Presentation */

/**
    Determines whether a swapchain composition is supported by the window.
    
    The window must be claimed before calling this function.
    
    Params:
        device =                a GPU context.
        window =                an SDL_Window.
        swapchain_composition = the swapchain composition to check.
    
    Returns:
        true if supported, false if unsupported.
    
    See_Also:
        $(D SDL_ClaimWindowForGPUDevice)
*/
extern bool SDL_WindowSupportsGPUSwapchainComposition(
    SDL_GPUDevice* device,
    SDL_Window* window,
    SDL_GPUSwapchainComposition swapchain_composition);

/**
    Determines whether a presentation mode is supported by the window.
    
    The window must be claimed before calling this function.
    
    Params:
        device =        a GPU context.
        window =        an SDL_Window.
        present_mode =  the presentation mode to check.
    
    Returns:
        true if supported, false if unsupported.
    
    See_Also:
        $(D SDL_ClaimWindowForGPUDevice)
*/
extern bool SDL_WindowSupportsGPUPresentMode(
    SDL_GPUDevice* device,
    SDL_Window* window,
    SDL_GPUPresentMode present_mode);

/**
    Claims a window, creating a swapchain structure for it.
    
    This must be called before SDL_AcquireGPUSwapchainTexture is called using
    the window. You should only call this function from the thread that created
    the window.
    
    The swapchain will be created with SDL_GPU_SWAPCHAINCOMPOSITION_SDR and
    SDL_GPU_PRESENTMODE_VSYNC. If you want to have different swapchain
    parameters, you must call SDL_SetGPUSwapchainParameters after claiming the
    window.
    

    Params:
        device =    a GPU context.
        window =    an SDL_Window.
    
    Returns:
        true on success, or false on failure; call SDL_GetError() for more
        information.
    
    Threadsafety:
        This function should only be called from the thread that
        created the window.
    
    See_Also:
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
        $(D SDL_ReleaseWindowFromGPUDevice)
        $(D SDL_WindowSupportsGPUPresentMode)
        $(D SDL_WindowSupportsGPUSwapchainComposition)
*/
extern bool SDL_ClaimWindowForGPUDevice(
    SDL_GPUDevice* device,
    SDL_Window* window);

/**
    Unclaims a window, destroying its swapchain structure.
    
    Params:
        device =    a GPU context.
        window =    an SDL_Window that has been claimed.
    
    See_Also:
        $(D SDL_ClaimWindowForGPUDevice)
*/
extern void SDL_ReleaseWindowFromGPUDevice(
SDL_GPUDevice* device,
SDL_Window* window);

/**
    Changes the swapchain parameters for the given claimed window.
    
    This function will fail if the requested present mode or swapchain
    composition are unsupported by the device. Check if the parameters are
    supported via SDL_WindowSupportsGPUPresentMode /
    SDL_WindowSupportsGPUSwapchainComposition prior to calling this function.
    
    SDL_GPU_PRESENTMODE_VSYNC and SDL_GPU_SWAPCHAINCOMPOSITION_SDR are always
    supported.
    
    Params:
        device =                a GPU context.
        window =                an SDL_Window that has been claimed.
        swapchain_composition = the desired composition of the swapchain.
        present_mode =          the desired present mode for the swapchain.
    
    Returns:
        true if successful, false on error; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_WindowSupportsGPUPresentMode)
        $(D SDL_WindowSupportsGPUSwapchainComposition)
*/
extern bool SDL_SetGPUSwapchainParameters(
SDL_GPUDevice* device,
SDL_Window* window,
SDL_GPUSwapchainComposition swapchain_composition,
SDL_GPUPresentMode present_mode);

/**
    Configures the maximum allowed number of frames in flight.
    
    The default value when the device is created is 2. This means that after
    you have submitted 2 frames for presentation, if the GPU has not finished
    working on the first frame, SDL_AcquireGPUSwapchainTexture() will fill the
    swapchain texture pointer with NULL, and
    SDL_WaitAndAcquireGPUSwapchainTexture() will block.
    
    Higher values increase throughput at the expense of visual latency. Lower
    values decrease visual latency at the expense of throughput.
    
    Note that calling this function will stall and flush the command queue to
    prevent synchronization issues.
    
    The minimum value of allowed frames in flight is 1, and the maximum is 3.
    
    Params:
        device =                    a GPU context.
        allowed_frames_in_flight =  the maximum number of frames that can be
                                    pending on the GPU.

    Returns:
        true if successful, false on error; call SDL_GetError() for more
        information.
*/
extern bool SDL_SetGPUAllowedFramesInFlight(
SDL_GPUDevice* device,
Uint32 allowed_frames_in_flight);

/**
    Obtains the texture format of the swapchain for the given window.
    
    Note that this format can change if the swapchain parameters change.
    
    Params:
        device =    a GPU context.
        window =    an SDL_Window that has been claimed.
    
    Returns:
        the texture format of the swapchain.
*/
extern SDL_GPUTextureFormat SDL_GetGPUSwapchainTextureFormat(
SDL_GPUDevice* device,
SDL_Window* window);

/**
    Acquire a texture to use in presentation.
    
    When a swapchain texture is acquired on a command buffer, it will
    automatically be submitted for presentation when the command buffer is
    submitted. The swapchain texture should only be referenced by the command
    buffer used to acquire it.
    
    This function will fill the swapchain texture handle with NULL if too many
    frames are in flight. This is not an error.
    
    If you use this function, it is possible to create a situation where many
    command buffers are allocated while the rendering context waits for the GPU
    to catch up, which will cause memory usage to grow. You should use
    SDL_WaitAndAcquireGPUSwapchainTexture() unless you know what you are doing
    with timing.
    
    The swapchain texture is managed by the implementation and must not be
    freed by the user. You MUST NOT call this function from any thread other
    than the one that created the window.
    
    Params:
        command_buffer =            a command buffer.
        window =                    a window that has been claimed.
        swapchain_texture =         a pointer filled in with a swapchain texture
                                    handle.
        swapchain_texture_width =   a pointer filled in with the swapchain
                                    texture width, may be NULL.
        swapchain_texture_height =  a pointer filled in with the swapchain
                                    texture height, may be NULL.
    
    Returns:
        true on success, false on error; call SDL_GetError() for more
        information.
    
    Threadsafety:
        This function should only be called from the thread that
        created the window.

    See_Also:
        $(D SDL_ClaimWindowForGPUDevice)
        $(D SDL_SubmitGPUCommandBuffer)
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
        $(D SDL_CancelGPUCommandBuffer)
        $(D SDL_GetWindowSizeInPixels)
        $(D SDL_WaitForGPUSwapchain)
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
        $(D SDL_SetGPUAllowedFramesInFlight)
*/
extern bool SDL_AcquireGPUSwapchainTexture(
SDL_GPUCommandBuffer* command_buffer,
SDL_Window* window,
SDL_GPUTexture** swapchain_texture,
Uint32* swapchain_texture_width,
Uint32* swapchain_texture_height);

/**
    Blocks the thread until a swapchain texture is available to be acquired.
    
    Params:
        device =    a GPU context.
        window =    a window that has been claimed.
    
    Returns:
        true on success, false on failure; call SDL_GetError() for more
        information.
    
    Threadsafety:
        This function should only be called from the thread that
        created the window.

    See_Also:
        $(D SDL_AcquireGPUSwapchainTexture)
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
        $(D SDL_SetGPUAllowedFramesInFlight)
*/
extern bool SDL_WaitForGPUSwapchain(
SDL_GPUDevice* device,
SDL_Window* window);

/**
    Blocks the thread until a swapchain texture is available to be acquired,
    and then acquires it.
    
    When a swapchain texture is acquired on a command buffer, it will
    automatically be submitted for presentation when the command buffer is
    submitted. The swapchain texture should only be referenced by the command
    buffer used to acquire it. It is an error to call
    SDL_CancelGPUCommandBuffer() after a swapchain texture is acquired.
    
    This function can fill the swapchain texture handle with NULL in certain
    cases, for example if the window is minimized. This is not an error. You
    should always make sure to check whether the pointer is NULL before
    actually using it.
    
    The swapchain texture is managed by the implementation and must not be
    freed by the user. You MUST NOT call this function from any thread other
    than the one that created the window.
    
    Params:
        command_buffer =            a command buffer.
        window =                    a window that has been claimed.
        swapchain_texture =         a pointer filled in with a swapchain texture
                                    handle.
        swapchain_texture_width =   a pointer filled in with the swapchain
                                    texture width, may be NULL.
        swapchain_texture_height =  a pointer filled in with the swapchain
                                    texture height, may be NULL.

    Returns:
        true on success, false on error; call SDL_GetError() for more
        information.
    
    Threadsafety:
        This function should only be called from the thread that
        created the window.

    See_Also:
        $(D SDL_SubmitGPUCommandBuffer)
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
*/
extern bool SDL_WaitAndAcquireGPUSwapchainTexture(
SDL_GPUCommandBuffer* command_buffer,
SDL_Window* window,
SDL_GPUTexture** swapchain_texture,
Uint32* swapchain_texture_width,
Uint32* swapchain_texture_height);

/**
    Submits a command buffer so its commands can be processed on the GPU.
    
    It is invalid to use the command buffer after this is called.
    
    This must be called from the thread the command buffer was acquired on.
    
    All commands in the submission are guaranteed to begin executing before any
    command in a subsequent submission begins executing.
    
    Params:
        command_buffer = a command buffer.
    
    Returns:
        true on success, false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_AcquireGPUCommandBuffer)
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
        $(D SDL_AcquireGPUSwapchainTexture)
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
*/
extern bool SDL_SubmitGPUCommandBuffer(
SDL_GPUCommandBuffer* command_buffer);

/**
    Submits a command buffer so its commands can be processed on the GPU, and
    acquires a fence associated with the command buffer.
    
    You must release this fence when it is no longer needed or it will cause a
    leak. It is invalid to use the command buffer after this is called.
    
    This must be called from the thread the command buffer was acquired on.
    
    All commands in the submission are guaranteed to begin executing before any
    command in a subsequent submission begins executing.
    
    Params:
        command_buffer = a command buffer.

    Returns:
        a fence associated with the command buffer, or NULL on failure;
        call SDL_GetError() for more information.

    See_Also:
        $(D SDL_AcquireGPUCommandBuffer)
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
        $(D SDL_AcquireGPUSwapchainTexture)
        $(D SDL_SubmitGPUCommandBuffer)
        $(D SDL_ReleaseGPUFence)
*/
extern SDL_GPUFence* SDL_SubmitGPUCommandBufferAndAcquireFence(
SDL_GPUCommandBuffer* command_buffer);

/**
    Cancels a command buffer.
    
    None of the enqueued commands are executed.
    
    It is an error to call this function after a swapchain texture has been
    acquired.
    
    This must be called from the thread the command buffer was acquired on.
    
    You must not reference the command buffer after calling this function.
    
    Params:
        command_buffer = a command buffer.
        
    Returns:
        true on success, false on error; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_WaitAndAcquireGPUSwapchainTexture)
        $(D SDL_AcquireGPUCommandBuffer)
        $(D SDL_AcquireGPUSwapchainTexture)
*/
extern bool SDL_CancelGPUCommandBuffer(
SDL_GPUCommandBuffer* command_buffer);

/**
    Blocks the thread until the GPU is completely idle.
    
    Params:
        device = a GPU context.

    Returns:
        true on success, false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_WaitForGPUFences)
*/
extern bool SDL_WaitForGPUIdle(
SDL_GPUDevice* device);

/**
    Blocks the thread until the given fences are signaled.
    
    Params:
        device =        a GPU context.
        wait_all =      if 0, wait for any fence to be signaled, if 1, wait for all
                        fences to be signaled.
        fences =        an array of fences to wait on.
        num_fences =    the number of fences in the fences array.

    Returns:
        true on success, false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
        $(D SDL_WaitForGPUIdle)
*/
extern bool SDL_WaitForGPUFences(
SDL_GPUDevice* device,
bool wait_all,
const(SDL_GPUFence*)* fences,
Uint32 num_fences);

/**
    Checks the status of a fence.
    
    Params:
        device =    a GPU context.
        fence =     a fence.
    
    Returns:
        true if the fence is signaled, false if it is not.

    See_Also:
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
*/
extern bool SDL_QueryGPUFence(
SDL_GPUDevice* device,
SDL_GPUFence* fence);

/**
    Releases a fence obtained from SDL_SubmitGPUCommandBufferAndAcquireFence.
    
    Params:
        device =    a GPU context.
        fence =     a fence.

    See_Also:
        $(D SDL_SubmitGPUCommandBufferAndAcquireFence)
*/
extern void SDL_ReleaseGPUFence(
SDL_GPUDevice* device,
SDL_GPUFence* fence);

/* Format Info */

/**
    Obtains the texel block size for a texture format.
    
    Params:
        format = the texture format you want to know the texel size of.

    Returns:
        the texel block size of the texture format.

    See_Also:
        $(D SDL_UploadToGPUTexture)
*/
extern Uint32 SDL_GPUTextureFormatTexelBlockSize(
SDL_GPUTextureFormat format);

/**
    Determines whether a texture format is supported for a given type and
    usage.
    
    Params:
        device =    a GPU context.
        format =    the texture format to check.
        type =      the type of texture (2D, 3D, Cube).
        usage =     a bitmask of all usage scenarios to check.
        
    Returns:
        whether the texture format is supported for this type and usage.
*/
extern bool SDL_GPUTextureSupportsFormat(
SDL_GPUDevice* device,
SDL_GPUTextureFormat format,
SDL_GPUTextureType type,
SDL_GPUTextureUsageFlags usage);

/**
    Determines if a sample count for a texture format is supported.
    
    Params:
        device =        a GPU context.
        format =        the texture format to check.
        sample_count =  the sample count to check.

    Returns:
        a hardware-specific version of min(preferred, possible).
*/
extern bool SDL_GPUTextureSupportsSampleCount(
SDL_GPUDevice* device,
SDL_GPUTextureFormat format,
SDL_GPUSampleCount sample_count);

/**
    Calculate the size in bytes of a texture format with dimensions.
    
    Params:
        format =                a texture format.
        width =                 width in pixels.
        height =                height in pixels.
        depth_or_layer_count =  depth for 3D textures or layer count otherwise.

    Returns:
        the size of a texture with this format and dimensions.
*/
extern Uint32 SDL_CalculateGPUTextureFormatSize(
SDL_GPUTextureFormat format,
Uint32 width,
Uint32 height,
Uint32 depth_or_layer_count);

version (SDL_PLATFORM_GDK) {

    /**
        Call this to suspend GPU operation on Xbox when you receive the
        SDL_EVENT_DID_ENTER_BACKGROUND event.

        Do NOT call any SDL_GPU functions after calling this function! This must
        also be called before calling SDL_GDKSuspendComplete.

        Params:
            device = a GPU context.
        
        See_Also:
            $(D SDL_AddEventWatch)
    */
    extern void SDL_GDKSuspendGPU(SDL_GPUDevice* device);

    /**
        Call this to resume GPU operation on Xbox when you receive the
        SDL_EVENT_WILL_ENTER_FOREGROUND event.

        When resuming, this function MUST be called before calling any other
        SDL_GPU functions.

        Params:
            device = a GPU context.
        
        See_Also
            $(D SDL_AddEventWatch)
    */
    extern void SDL_GDKResumeGPU(SDL_GPUDevice* device);
}
