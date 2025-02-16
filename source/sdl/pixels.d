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
    SDL Pixel Managment

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryPixels, SDL3 Pixel Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.pixels;
import sdl.stdc;

extern(C) nothrow @nogc:

private {
    version(BigEndian) enum IsBigEndian = true;
    else enum IsBigEndian = false;
}

/**
    A fully opaque 8-bit alpha value.

    See_Also:
        $(D SDL_ALPHA_TRANSPARENT)
*/
enum SDL_ALPHA_OPAQUE = 255;

/**
    A fully opaque floating point alpha value.

    See_Also:
        $(D SDL_ALPHA_TRANSPARENT_FLOAT)
*/
enum SDL_ALPHA_OPAQUE_FLOAT = 1.0f;

/**
    A fully transparent 8-bit alpha value.

    See_Also:
        $(D SDL_ALPHA_OPAQUE)
*/
enum SDL_ALPHA_TRANSPARENT = 0;

/**
    A fully transparent floating point alpha value.

    See_Also:
        $(D SDL_ALPHA_OPAQUE_FLOAT)
*/
enum SDL_ALPHA_TRANSPARENT_FLOAT = 0.0f;

/**
    Pixel type.
*/
enum SDL_PixelType {
    SDL_PIXELTYPE_UNKNOWN,
    SDL_PIXELTYPE_INDEX1,
    SDL_PIXELTYPE_INDEX4,
    SDL_PIXELTYPE_INDEX8,
    SDL_PIXELTYPE_PACKED8,
    SDL_PIXELTYPE_PACKED16,
    SDL_PIXELTYPE_PACKED32,
    SDL_PIXELTYPE_ARRAYU8,
    SDL_PIXELTYPE_ARRAYU16,
    SDL_PIXELTYPE_ARRAYU32,
    SDL_PIXELTYPE_ARRAYF16,
    SDL_PIXELTYPE_ARRAYF32,

    /* appended at the end for compatibility with sdl2-compat:  */
    SDL_PIXELTYPE_INDEX2
}

/**
    Bitmap pixel order, high bit -> low bit.
*/
enum SDL_BitmapOrder {
    SDL_BITMAPORDER_NONE,
    SDL_BITMAPORDER_4321,
    SDL_BITMAPORDER_1234
}

/**
    Packed component order, high bit -> low bit.
*/
enum SDL_PackedOrder {
    SDL_PACKEDORDER_NONE,
    SDL_PACKEDORDER_XRGB,
    SDL_PACKEDORDER_RGBX,
    SDL_PACKEDORDER_ARGB,
    SDL_PACKEDORDER_RGBA,
    SDL_PACKEDORDER_XBGR,
    SDL_PACKEDORDER_BGRX,
    SDL_PACKEDORDER_ABGR,
    SDL_PACKEDORDER_BGRA
}

/**
    Array component order, low byte -> high byte.
*/
enum SDL_ArrayOrder {
    SDL_ARRAYORDER_NONE,
    SDL_ARRAYORDER_RGB,
    SDL_ARRAYORDER_RGBA,
    SDL_ARRAYORDER_ARGB,
    SDL_ARRAYORDER_BGR,
    SDL_ARRAYORDER_BGRA,
    SDL_ARRAYORDER_ABGR
}

/**
    Packed component layout.
*/
enum SDL_PackedLayout {
    SDL_PACKEDLAYOUT_NONE,
    SDL_PACKEDLAYOUT_332,
    SDL_PACKEDLAYOUT_4444,
    SDL_PACKEDLAYOUT_1555,
    SDL_PACKEDLAYOUT_5551,
    SDL_PACKEDLAYOUT_565,
    SDL_PACKEDLAYOUT_8888,
    SDL_PACKEDLAYOUT_2101010,
    SDL_PACKEDLAYOUT_1010102
}

/**
    Pixel format.

    SDL's pixel formats have the following naming convention:

    -   Names with a list of components and a single bit count, such as RGB24 and
        ABGR32, define a platform-independent encoding into bytes in the order
        specified. For example, in RGB24 data, each pixel is encoded in 3 bytes
        (red, green, blue) in that order, and in ABGR32 data, each pixel is
        encoded in 4 bytes (alpha, blue, green, red) in that order. Use these
        names if the property of a format that is important to you is the order
        of the bytes in memory or on disk.
    -   Names with a bit count per component, such as ARGB8888 and XRGB1555, are
        "packed" into an appropriately-sized integer in the platform's native
        endianness. For example, ARGB8888 is a sequence of 32-bit integers; in
        each integer, the most significant bits are alpha, and the least
        significant bits are blue. On a little-endian CPU such as x86, the least
        significant bits of each integer are arranged first in memory, but on a
        big-endian CPU such as s390x, the most significant bits are arranged
        first. Use these names if the property of a format that is important to
        you is the meaning of each bit position within a native-endianness
        integer.
    -   In indexed formats such as INDEX4LSB, each pixel is represented by
        encoding an index into the palette into the indicated number of bits,
        with multiple pixels packed into each byte if appropriate. In LSB
        formats, the first (leftmost) pixel is stored in the least-significant
        bits of the byte; in MSB formats, it's stored in the most-significant
        bits. INDEX8 does not need LSB/MSB variants, because each pixel exactly
        fills one byte.

    The 32-bit byte-array encodings such as RGBA32 are aliases for the
    appropriate 8888 encoding for the current platform. For example, RGBA32 is
    an alias for ABGR8888 on little-endian CPUs like x86, or an alias for
    RGBA8888 on big-endian CPUs.
*/
enum SDL_PixelFormat {
    SDL_PIXELFORMAT_UNKNOWN = 0,
    SDL_PIXELFORMAT_INDEX1LSB = 0x11100100u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX1, SDL_BITMAPORDER_4321, 0, 1, 0), */
    SDL_PIXELFORMAT_INDEX1MSB = 0x11200100u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX1, SDL_BITMAPORDER_1234, 0, 1, 0), */
    SDL_PIXELFORMAT_INDEX2LSB = 0x1c100200u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX2, SDL_BITMAPORDER_4321, 0, 2, 0), */
    SDL_PIXELFORMAT_INDEX2MSB = 0x1c200200u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX2, SDL_BITMAPORDER_1234, 0, 2, 0), */
    SDL_PIXELFORMAT_INDEX4LSB = 0x12100400u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX4, SDL_BITMAPORDER_4321, 0, 4, 0), */
    SDL_PIXELFORMAT_INDEX4MSB = 0x12200400u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX4, SDL_BITMAPORDER_1234, 0, 4, 0), */
    SDL_PIXELFORMAT_INDEX8 = 0x13000801u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_INDEX8, 0, 0, 8, 1), */
    SDL_PIXELFORMAT_RGB332 = 0x14110801u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED8, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_332, 8, 1), */
    SDL_PIXELFORMAT_XRGB4444 = 0x15120c02u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_4444, 12, 2), */
    SDL_PIXELFORMAT_XBGR4444 = 0x15520c02u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_4444, 12, 2), */
    SDL_PIXELFORMAT_XRGB1555 = 0x15130f02u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_1555, 15, 2), */
    SDL_PIXELFORMAT_XBGR1555 = 0x15530f02u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_1555, 15, 2), */
    SDL_PIXELFORMAT_ARGB4444 = 0x15321002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_4444, 16, 2), */
    SDL_PIXELFORMAT_RGBA4444 = 0x15421002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_RGBA, SDL_PACKEDLAYOUT_4444, 16, 2), */
    SDL_PIXELFORMAT_ABGR4444 = 0x15721002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_4444, 16, 2), */
    SDL_PIXELFORMAT_BGRA4444 = 0x15821002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_BGRA, SDL_PACKEDLAYOUT_4444, 16, 2), */
    SDL_PIXELFORMAT_ARGB1555 = 0x15331002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_1555, 16, 2), */
    SDL_PIXELFORMAT_RGBA5551 = 0x15441002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_RGBA, SDL_PACKEDLAYOUT_5551, 16, 2), */
    SDL_PIXELFORMAT_ABGR1555 = 0x15731002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_1555, 16, 2), */
    SDL_PIXELFORMAT_BGRA5551 = 0x15841002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_BGRA, SDL_PACKEDLAYOUT_5551, 16, 2), */
    SDL_PIXELFORMAT_RGB565 = 0x15151002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_565, 16, 2), */
    SDL_PIXELFORMAT_BGR565 = 0x15551002u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED16, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_565, 16, 2), */
    SDL_PIXELFORMAT_RGB24 = 0x17101803u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU8, SDL_ARRAYORDER_RGB, 0, 24, 3), */
    SDL_PIXELFORMAT_BGR24 = 0x17401803u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU8, SDL_ARRAYORDER_BGR, 0, 24, 3), */
    SDL_PIXELFORMAT_XRGB8888 = 0x16161804u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_8888, 24, 4), */
    SDL_PIXELFORMAT_RGBX8888 = 0x16261804u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_RGBX, SDL_PACKEDLAYOUT_8888, 24, 4), */
    SDL_PIXELFORMAT_XBGR8888 = 0x16561804u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_8888, 24, 4), */
    SDL_PIXELFORMAT_BGRX8888 = 0x16661804u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_BGRX, SDL_PACKEDLAYOUT_8888, 24, 4), */
    SDL_PIXELFORMAT_ARGB8888 = 0x16362004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_8888, 32, 4), */
    SDL_PIXELFORMAT_RGBA8888 = 0x16462004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_RGBA, SDL_PACKEDLAYOUT_8888, 32, 4), */
    SDL_PIXELFORMAT_ABGR8888 = 0x16762004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_8888, 32, 4), */
    SDL_PIXELFORMAT_BGRA8888 = 0x16862004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_BGRA, SDL_PACKEDLAYOUT_8888, 32, 4), */
    SDL_PIXELFORMAT_XRGB2101010 = 0x16172004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XRGB, SDL_PACKEDLAYOUT_2101010, 32, 4), */
    SDL_PIXELFORMAT_XBGR2101010 = 0x16572004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_XBGR, SDL_PACKEDLAYOUT_2101010, 32, 4), */
    SDL_PIXELFORMAT_ARGB2101010 = 0x16372004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ARGB, SDL_PACKEDLAYOUT_2101010, 32, 4), */
    SDL_PIXELFORMAT_ABGR2101010 = 0x16772004u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_PACKED32, SDL_PACKEDORDER_ABGR, SDL_PACKEDLAYOUT_2101010, 32, 4), */
    SDL_PIXELFORMAT_RGB48 = 0x18103006u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU16, SDL_ARRAYORDER_RGB, 0, 48, 6), */
    SDL_PIXELFORMAT_BGR48 = 0x18403006u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU16, SDL_ARRAYORDER_BGR, 0, 48, 6), */
    SDL_PIXELFORMAT_RGBA64 = 0x18204008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU16, SDL_ARRAYORDER_RGBA, 0, 64, 8), */
    SDL_PIXELFORMAT_ARGB64 = 0x18304008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU16, SDL_ARRAYORDER_ARGB, 0, 64, 8), */
    SDL_PIXELFORMAT_BGRA64 = 0x18504008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU16, SDL_ARRAYORDER_BGRA, 0, 64, 8), */
    SDL_PIXELFORMAT_ABGR64 = 0x18604008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYU16, SDL_ARRAYORDER_ABGR, 0, 64, 8), */
    SDL_PIXELFORMAT_RGB48_FLOAT = 0x1a103006u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF16, SDL_ARRAYORDER_RGB, 0, 48, 6), */
    SDL_PIXELFORMAT_BGR48_FLOAT = 0x1a403006u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF16, SDL_ARRAYORDER_BGR, 0, 48, 6), */
    SDL_PIXELFORMAT_RGBA64_FLOAT = 0x1a204008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF16, SDL_ARRAYORDER_RGBA, 0, 64, 8), */
    SDL_PIXELFORMAT_ARGB64_FLOAT = 0x1a304008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF16, SDL_ARRAYORDER_ARGB, 0, 64, 8), */
    SDL_PIXELFORMAT_BGRA64_FLOAT = 0x1a504008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF16, SDL_ARRAYORDER_BGRA, 0, 64, 8), */
    SDL_PIXELFORMAT_ABGR64_FLOAT = 0x1a604008u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF16, SDL_ARRAYORDER_ABGR, 0, 64, 8), */
    SDL_PIXELFORMAT_RGB96_FLOAT = 0x1b10600cu,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF32, SDL_ARRAYORDER_RGB, 0, 96, 12), */
    SDL_PIXELFORMAT_BGR96_FLOAT = 0x1b40600cu,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF32, SDL_ARRAYORDER_BGR, 0, 96, 12), */
    SDL_PIXELFORMAT_RGBA128_FLOAT = 0x1b208010u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF32, SDL_ARRAYORDER_RGBA, 0, 128, 16), */
    SDL_PIXELFORMAT_ARGB128_FLOAT = 0x1b308010u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF32, SDL_ARRAYORDER_ARGB, 0, 128, 16), */
    SDL_PIXELFORMAT_BGRA128_FLOAT = 0x1b508010u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF32, SDL_ARRAYORDER_BGRA, 0, 128, 16), */
    SDL_PIXELFORMAT_ABGR128_FLOAT = 0x1b608010u,
        /* SDL_DEFINE_PIXELFORMAT(SDL_PIXELTYPE_ARRAYF32, SDL_ARRAYORDER_ABGR, 0, 128, 16), */

    SDL_PIXELFORMAT_YV12 = 0x32315659u,      /**< Planar mode: Y + V + U  (3 planes) */
        /* SDL_DEFINE_PIXELFOURCC('Y', 'V', '1', '2'), */
    SDL_PIXELFORMAT_IYUV = 0x56555949u,      /**< Planar mode: Y + U + V  (3 planes) */
        /* SDL_DEFINE_PIXELFOURCC('I', 'Y', 'U', 'V'), */
    SDL_PIXELFORMAT_YUY2 = 0x32595559u,      /**< Packed mode: Y0+U0+Y1+V0 (1 plane) */
        /* SDL_DEFINE_PIXELFOURCC('Y', 'U', 'Y', '2'), */
    SDL_PIXELFORMAT_UYVY = 0x59565955u,      /**< Packed mode: U0+Y0+V0+Y1 (1 plane) */
        /* SDL_DEFINE_PIXELFOURCC('U', 'Y', 'V', 'Y'), */
    SDL_PIXELFORMAT_YVYU = 0x55595659u,      /**< Packed mode: Y0+V0+Y1+U0 (1 plane) */
        /* SDL_DEFINE_PIXELFOURCC('Y', 'V', 'Y', 'U'), */
    SDL_PIXELFORMAT_NV12 = 0x3231564eu,      /**< Planar mode: Y + U/V interleaved  (2 planes) */
        /* SDL_DEFINE_PIXELFOURCC('N', 'V', '1', '2'), */
    SDL_PIXELFORMAT_NV21 = 0x3132564eu,      /**< Planar mode: Y + V/U interleaved  (2 planes) */
        /* SDL_DEFINE_PIXELFOURCC('N', 'V', '2', '1'), */
    SDL_PIXELFORMAT_P010 = 0x30313050u,      /**< Planar mode: Y + U/V interleaved  (2 planes) */
        /* SDL_DEFINE_PIXELFOURCC('P', '0', '1', '0'), */
    SDL_PIXELFORMAT_EXTERNAL_OES = 0x2053454fu,     /**< Android video texture format */
        /* SDL_DEFINE_PIXELFOURCC('O', 'E', 'S', ' ') */

    /* Aliases for RGBA byte arrays of color data, for the current platform */
    SDL_PIXELFORMAT_RGBA32 = IsBigEndian ? SDL_PIXELFORMAT_RGBA8888 : SDL_PIXELFORMAT_ABGR8888,
    SDL_PIXELFORMAT_ARGB32 = IsBigEndian ? SDL_PIXELFORMAT_ARGB8888 : SDL_PIXELFORMAT_BGRA8888,
    SDL_PIXELFORMAT_BGRA32 = IsBigEndian ? SDL_PIXELFORMAT_BGRA8888 : SDL_PIXELFORMAT_ARGB8888,
    SDL_PIXELFORMAT_ABGR32 = IsBigEndian ? SDL_PIXELFORMAT_ABGR8888 : SDL_PIXELFORMAT_RGBA8888,
    SDL_PIXELFORMAT_RGBX32 = IsBigEndian ? SDL_PIXELFORMAT_RGBX8888 : SDL_PIXELFORMAT_XBGR8888,
    SDL_PIXELFORMAT_XRGB32 = IsBigEndian ? SDL_PIXELFORMAT_XRGB8888 : SDL_PIXELFORMAT_BGRX8888,
    SDL_PIXELFORMAT_BGRX32 = IsBigEndian ? SDL_PIXELFORMAT_BGRX8888 : SDL_PIXELFORMAT_XRGB8888,
    SDL_PIXELFORMAT_XBGR32 = IsBigEndian ? SDL_PIXELFORMAT_XBGR8888 : SDL_PIXELFORMAT_RGBX8888
}

/**
    Colorspace color type.
*/
enum SDL_ColorType {
    SDL_COLOR_TYPE_UNKNOWN = 0,
    SDL_COLOR_TYPE_RGB = 1,
    SDL_COLOR_TYPE_YCBCR = 2
}

/**
    Colorspace color range, as described by
    https://www.itu.int/rec/R-REC-BT.2100-2-201807-I/en
*/
enum SDL_ColorRange {
    SDL_COLOR_RANGE_UNKNOWN = 0,
    SDL_COLOR_RANGE_LIMITED = 1, /**< Narrow range, e.g. 16-235 for 8-bit RGB and luma, and 16-240 for 8-bit chroma */
    SDL_COLOR_RANGE_FULL = 2    /**< Full range, e.g. 0-255 for 8-bit RGB and luma, and 1-255 for 8-bit chroma */
}

/**
    Colorspace color primaries, as described by
    https://www.itu.int/rec/T-REC-H.273-201612-S/en
*/
enum SDL_ColorPrimaries {
    SDL_COLOR_PRIMARIES_UNKNOWN = 0,
    SDL_COLOR_PRIMARIES_BT709 = 1,                  /**< ITU-R BT.709-6 */
    SDL_COLOR_PRIMARIES_UNSPECIFIED = 2,
    SDL_COLOR_PRIMARIES_BT470M = 4,                 /**< ITU-R BT.470-6 System M */
    SDL_COLOR_PRIMARIES_BT470BG = 5,                /**< ITU-R BT.470-6 System B, G / ITU-R BT.601-7 625 */
    SDL_COLOR_PRIMARIES_BT601 = 6,                  /**< ITU-R BT.601-7 525, SMPTE 170M */
    SDL_COLOR_PRIMARIES_SMPTE240 = 7,               /**< SMPTE 240M, functionally the same as SDL_COLOR_PRIMARIES_BT601 */
    SDL_COLOR_PRIMARIES_GENERIC_FILM = 8,           /**< Generic film (color filters using Illuminant C) */
    SDL_COLOR_PRIMARIES_BT2020 = 9,                 /**< ITU-R BT.2020-2 / ITU-R BT.2100-0 */
    SDL_COLOR_PRIMARIES_XYZ = 10,                   /**< SMPTE ST 428-1 */
    SDL_COLOR_PRIMARIES_SMPTE431 = 11,              /**< SMPTE RP 431-2 */
    SDL_COLOR_PRIMARIES_SMPTE432 = 12,              /**< SMPTE EG 432-1 / DCI P3 */
    SDL_COLOR_PRIMARIES_EBU3213 = 22,               /**< EBU Tech. 3213-E */
    SDL_COLOR_PRIMARIES_CUSTOM = 31
}

/**
    Colorspace transfer characteristics.

    These are as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en
*/
enum SDL_TransferCharacteristics {
    SDL_TRANSFER_CHARACTERISTICS_UNKNOWN = 0,
    SDL_TRANSFER_CHARACTERISTICS_BT709 = 1,         /**< Rec. ITU-R BT.709-6 / ITU-R BT1361 */
    SDL_TRANSFER_CHARACTERISTICS_UNSPECIFIED = 2,
    SDL_TRANSFER_CHARACTERISTICS_GAMMA22 = 4,       /**< ITU-R BT.470-6 System M / ITU-R BT1700 625 PAL & SECAM */
    SDL_TRANSFER_CHARACTERISTICS_GAMMA28 = 5,       /**< ITU-R BT.470-6 System B, G */
    SDL_TRANSFER_CHARACTERISTICS_BT601 = 6,         /**< SMPTE ST 170M / ITU-R BT.601-7 525 or 625 */
    SDL_TRANSFER_CHARACTERISTICS_SMPTE240 = 7,      /**< SMPTE ST 240M */
    SDL_TRANSFER_CHARACTERISTICS_LINEAR = 8,
    SDL_TRANSFER_CHARACTERISTICS_LOG100 = 9,
    SDL_TRANSFER_CHARACTERISTICS_LOG100_SQRT10 = 10,
    SDL_TRANSFER_CHARACTERISTICS_IEC61966 = 11,     /**< IEC 61966-2-4 */
    SDL_TRANSFER_CHARACTERISTICS_BT1361 = 12,       /**< ITU-R BT1361 Extended Colour Gamut */
    SDL_TRANSFER_CHARACTERISTICS_SRGB = 13,         /**< IEC 61966-2-1 (sRGB or sYCC) */
    SDL_TRANSFER_CHARACTERISTICS_BT2020_10BIT = 14, /**< ITU-R BT2020 for 10-bit system */
    SDL_TRANSFER_CHARACTERISTICS_BT2020_12BIT = 15, /**< ITU-R BT2020 for 12-bit system */
    SDL_TRANSFER_CHARACTERISTICS_PQ = 16,           /**< SMPTE ST 2084 for 10-, 12-, 14- and 16-bit systems */
    SDL_TRANSFER_CHARACTERISTICS_SMPTE428 = 17,     /**< SMPTE ST 428-1 */
    SDL_TRANSFER_CHARACTERISTICS_HLG = 18,          /**< ARIB STD-B67, known as "hybrid log-gamma" (HLG) */
    SDL_TRANSFER_CHARACTERISTICS_CUSTOM = 31
}

/**
    Colorspace matrix coefficients.

    These are as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en
*/
enum SDL_MatrixCoefficients {
    SDL_MATRIX_COEFFICIENTS_IDENTITY = 0,
    SDL_MATRIX_COEFFICIENTS_BT709 = 1,              /**< ITU-R BT.709-6 */
    SDL_MATRIX_COEFFICIENTS_UNSPECIFIED = 2,
    SDL_MATRIX_COEFFICIENTS_FCC = 4,                /**< US FCC Title 47 */
    SDL_MATRIX_COEFFICIENTS_BT470BG = 5,            /**< ITU-R BT.470-6 System B, G / ITU-R BT.601-7 625, functionally the same as SDL_MATRIX_COEFFICIENTS_BT601 */
    SDL_MATRIX_COEFFICIENTS_BT601 = 6,              /**< ITU-R BT.601-7 525 */
    SDL_MATRIX_COEFFICIENTS_SMPTE240 = 7,           /**< SMPTE 240M */
    SDL_MATRIX_COEFFICIENTS_YCGCO = 8,
    SDL_MATRIX_COEFFICIENTS_BT2020_NCL = 9,         /**< ITU-R BT.2020-2 non-constant luminance */
    SDL_MATRIX_COEFFICIENTS_BT2020_CL = 10,         /**< ITU-R BT.2020-2 constant luminance */
    SDL_MATRIX_COEFFICIENTS_SMPTE2085 = 11,         /**< SMPTE ST 2085 */
    SDL_MATRIX_COEFFICIENTS_CHROMA_DERIVED_NCL = 12,
    SDL_MATRIX_COEFFICIENTS_CHROMA_DERIVED_CL = 13,
    SDL_MATRIX_COEFFICIENTS_ICTCP = 14,             /**< ITU-R BT.2100-0 ICTCP */
    SDL_MATRIX_COEFFICIENTS_CUSTOM = 31
}

/**
    Colorspace chroma sample location.
*/
enum SDL_ChromaLocation {
    SDL_CHROMA_LOCATION_NONE = 0,   /**< RGB, no chroma sampling */
    SDL_CHROMA_LOCATION_LEFT = 1,   /**< In MPEG-2, MPEG-4, and AVC, Cb and Cr are taken on midpoint of the left-edge of the 2x2 square. In other words, they have the same horizontal location as the top-left pixel, but is shifted one-half pixel down vertically. */
    SDL_CHROMA_LOCATION_CENTER = 2, /**< In JPEG/JFIF, H.261, and MPEG-1, Cb and Cr are taken at the center of the 2x2 square. In other words, they are offset one-half pixel to the right and one-half pixel down compared to the top-left pixel. */
    SDL_CHROMA_LOCATION_TOPLEFT = 3 /**< In HEVC for BT.2020 and BT.2100 content (in particular on Blu-rays), Cb and Cr are sampled at the same location as the group's top-left Y pixel ("co-sited", "co-located"). */
}

/**
    Colorspace definitions.

    Since similar colorspaces may vary in their details (matrix, transfer
    function, etc.), this is not an exhaustive list, but rather a
    representative sample of the kinds of colorspaces supported in SDL.

    See_Also:
       $(D SDL_ColorPrimaries)
       $(D SDL_ColorRange)
       $(D SDL_ColorType)
       $(D SDL_MatrixCoefficients)
       $(D SDL_TransferCharacteristics)
*/
enum SDL_Colorspace {
    SDL_COLORSPACE_UNKNOWN = 0,

    /* sRGB is a gamma corrected colorspace, and the default colorspace for SDL rendering and 8-bit RGB surfaces */
    SDL_COLORSPACE_SRGB = 0x120005a0u, /**< Equivalent to DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P709 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_RGB,
                                 SDL_COLOR_RANGE_FULL,
                                 SDL_COLOR_PRIMARIES_BT709,
                                 SDL_TRANSFER_CHARACTERISTICS_SRGB,
                                 SDL_MATRIX_COEFFICIENTS_IDENTITY,
                                 SDL_CHROMA_LOCATION_NONE), */

    /* This is a linear colorspace and the default colorspace for floating point surfaces. On Windows this is the scRGB colorspace, and on Apple platforms this is kCGColorSpaceExtendedLinearSRGB for EDR content */
    SDL_COLORSPACE_SRGB_LINEAR = 0x12000500u, /**< Equivalent to DXGI_COLOR_SPACE_RGB_FULL_G10_NONE_P709  */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_RGB,
                                 SDL_COLOR_RANGE_FULL,
                                 SDL_COLOR_PRIMARIES_BT709,
                                 SDL_TRANSFER_CHARACTERISTICS_LINEAR,
                                 SDL_MATRIX_COEFFICIENTS_IDENTITY,
                                 SDL_CHROMA_LOCATION_NONE), */

    /* HDR10 is a non-linear HDR colorspace and the default colorspace for 10-bit surfaces */
    SDL_COLORSPACE_HDR10 = 0x12002600u, /**< Equivalent to DXGI_COLOR_SPACE_RGB_FULL_G2084_NONE_P2020  */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_RGB,
                                 SDL_COLOR_RANGE_FULL,
                                 SDL_COLOR_PRIMARIES_BT2020,
                                 SDL_TRANSFER_CHARACTERISTICS_PQ,
                                 SDL_MATRIX_COEFFICIENTS_IDENTITY,
                                 SDL_CHROMA_LOCATION_NONE), */

    SDL_COLORSPACE_JPEG = 0x220004c6u, /**< Equivalent to DXGI_COLOR_SPACE_YCBCR_FULL_G22_NONE_P709_X601 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_YCBCR,
                                 SDL_COLOR_RANGE_FULL,
                                 SDL_COLOR_PRIMARIES_BT709,
                                 SDL_TRANSFER_CHARACTERISTICS_BT601,
                                 SDL_MATRIX_COEFFICIENTS_BT601,
                                 SDL_CHROMA_LOCATION_NONE), */

    SDL_COLORSPACE_BT601_LIMITED = 0x211018c6u, /**< Equivalent to DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P601 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_YCBCR,
                                 SDL_COLOR_RANGE_LIMITED,
                                 SDL_COLOR_PRIMARIES_BT601,
                                 SDL_TRANSFER_CHARACTERISTICS_BT601,
                                 SDL_MATRIX_COEFFICIENTS_BT601,
                                 SDL_CHROMA_LOCATION_LEFT), */

    SDL_COLORSPACE_BT601_FULL = 0x221018c6u, /**< Equivalent to DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P601 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_YCBCR,
                                 SDL_COLOR_RANGE_FULL,
                                 SDL_COLOR_PRIMARIES_BT601,
                                 SDL_TRANSFER_CHARACTERISTICS_BT601,
                                 SDL_MATRIX_COEFFICIENTS_BT601,
                                 SDL_CHROMA_LOCATION_LEFT), */

    SDL_COLORSPACE_BT709_LIMITED = 0x21100421u, /**< Equivalent to DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P709 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_YCBCR,
                                 SDL_COLOR_RANGE_LIMITED,
                                 SDL_COLOR_PRIMARIES_BT709,
                                 SDL_TRANSFER_CHARACTERISTICS_BT709,
                                 SDL_MATRIX_COEFFICIENTS_BT709,
                                 SDL_CHROMA_LOCATION_LEFT), */

    SDL_COLORSPACE_BT709_FULL = 0x22100421u, /**< Equivalent to DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P709 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_YCBCR,
                                 SDL_COLOR_RANGE_FULL,
                                 SDL_COLOR_PRIMARIES_BT709,
                                 SDL_TRANSFER_CHARACTERISTICS_BT709,
                                 SDL_MATRIX_COEFFICIENTS_BT709,
                                 SDL_CHROMA_LOCATION_LEFT), */

    SDL_COLORSPACE_BT2020_LIMITED = 0x21102609u, /**< Equivalent to DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P2020 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_YCBCR,
                                 SDL_COLOR_RANGE_LIMITED,
                                 SDL_COLOR_PRIMARIES_BT2020,
                                 SDL_TRANSFER_CHARACTERISTICS_PQ,
                                 SDL_MATRIX_COEFFICIENTS_BT2020_NCL,
                                 SDL_CHROMA_LOCATION_LEFT), */

    SDL_COLORSPACE_BT2020_FULL = 0x22102609u, /**< Equivalent to DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P2020 */
        /* SDL_DEFINE_COLORSPACE(SDL_COLOR_TYPE_YCBCR,
                                 SDL_COLOR_RANGE_FULL,
                                 SDL_COLOR_PRIMARIES_BT2020,
                                 SDL_TRANSFER_CHARACTERISTICS_PQ,
                                 SDL_MATRIX_COEFFICIENTS_BT2020_NCL,
                                 SDL_CHROMA_LOCATION_LEFT), */

    SDL_COLORSPACE_RGB_DEFAULT = SDL_COLORSPACE_SRGB, /**< The default colorspace for RGB surfaces if no colorspace is specified */
    SDL_COLORSPACE_YUV_DEFAULT = SDL_COLORSPACE_JPEG  /**< The default colorspace for YUV surfaces if no colorspace is specified */
}

/**
    A structure that represents a color as RGBA components.

    The bits of this structure can be directly reinterpreted as an
    integer-packed color which uses the SDL_PIXELFORMAT_RGBA32 format
    (SDL_PIXELFORMAT_ABGR8888 on little-endian systems and
    SDL_PIXELFORMAT_RGBA8888 on big-endian systems).
*/
struct SDL_Color {
    Uint8 r;
    Uint8 g;
    Uint8 b;
    Uint8 a;
}

/**
* The bits of this structure can be directly reinterpreted as a float-packed
* color which uses the SDL_PIXELFORMAT_RGBA128_FLOAT format
*/
struct SDL_FColor {
    float r;
    float g;
    float b;
    float a;
}

/**
    A set of indexed colors representing a palette.

    See_Also:
        $(D SDL_SetPaletteColors)
*/
struct SDL_Palette {
    int ncolors;        /**< number of elements in `colors`. */
    SDL_Color* colors;  /**< an array of colors, `ncolors` long. */
    Uint32 version_;     /**< internal use only, do not touch. */
    int refcount;       /**< internal use only, do not touch. */
}

/**
    Details about the format of a pixel.
*/
struct SDL_PixelFormatDetails {
    SDL_PixelFormat format;
    Uint8 bits_per_pixel;
    Uint8 bytes_per_pixel;
    Uint8[2] padding;
    Uint32 Rmask;
    Uint32 Gmask;
    Uint32 Bmask;
    Uint32 Amask;
    Uint8 Rbits;
    Uint8 Gbits;
    Uint8 Bbits;
    Uint8 Abits;
    Uint8 Rshift;
    Uint8 Gshift;
    Uint8 Bshift;
    Uint8 Ashift;
}

/**
    Get the human readable name of a pixel format.

    Params:
        format = the pixel format to query.
    
    Returns:
        The human readable name of the specified pixel format or
        "SDL_PIXELFORMAT_UNKNOWN" if the format isn't recognized.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern const(char)*  SDL_GetPixelFormatName(SDL_PixelFormat format);

/**
    Convert one of the enumerated pixel formats to a bpp value and RGBA masks.

    Params:
        format =    one of the SDL_PixelFormat values.
        bpp =       a bits per pixel value; usually 15, 16, or 32.
        Rmask =     a pointer filled in with the red mask for the format.
        Gmask =     a pointer filled in with the green mask for the format.
        Bmask =     a pointer filled in with the blue mask for the format.
        Amask =     a pointer filled in with the alpha mask for the format.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPixelFormatForMasks)
*/
extern bool SDL_GetMasksForPixelFormat(SDL_PixelFormat format, int* bpp, Uint32* Rmask, Uint32* Gmask, Uint32* Bmask, Uint32* Amask);

/**
    Convert a bpp value and RGBA masks to an enumerated pixel format.

    This will return `SDL_PIXELFORMAT_UNKNOWN` if the conversion wasn't
    possible.

    Params:
        bpp =   a bits per pixel value; usually 15, 16, or 32.
        Rmask = the red mask for the format.
        Gmask = the green mask for the format.
        Bmask = the blue mask for the format.
        Amask = the alpha mask for the format.
    
    Returns:
        the SDL_PixelFormat value corresponding to the format masks, or
        SDL_PIXELFORMAT_UNKNOWN if there isn't a match.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetMasksForPixelFormat)
*/
extern SDL_PixelFormat SDL_GetPixelFormatForMasks(int bpp, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);

/**
    Create an SDL_PixelFormatDetails structure corresponding to a pixel format.

    Returned structure may come from a shared global cache (i.e. not newly
    allocated), and hence should not be modified, especially the palette. Weird
    errors such as `Blit combination not supported` may occur.

    Params:
        format = one of the SDL_PixelFormat values.
    
    Returns:
        a pointer to a SDL_PixelFormatDetails structure or NULL on
        failure; call SDL_GetError() for more information.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern const(SDL_PixelFormatDetails)* SDL_GetPixelFormatDetails(SDL_PixelFormat format);

/**
    Create a palette structure with the specified number of color entries.

    The palette entries are initialized to white.

    Params:
        ncolors = represents the number of color entries in the color palette.
    
    Returns:
        a new SDL_Palette structure on success or NULL on failure (e.g. if
        there wasn't enough memory); call SDL_GetError() for more
        information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_DestroyPalette)
        $(D SDL_SetPaletteColors)
        $(D SDL_SetSurfacePalette)
*/
extern SDL_Palette* SDL_CreatePalette(int ncolors);

/**
    Set a range of colors in a palette.

    Params:
        palette =       the SDL_Palette structure to modify.
        colors =        an array of SDL_Color structures to copy into the palette.
        firstcolor =    the index of the first palette entry to modify.
        ncolors =       the number of entries to modify.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        It is safe to call this function from any thread, as long as
        the palette is not modified or destroyed in another thread.
*/
extern bool SDL_SetPaletteColors(SDL_Palette* palette, const(SDL_Color)* colors, int firstcolor, int ncolors);

/**
    Free a palette created with SDL_CreatePalette().

    Params:
        palette the SDL_Palette structure to be freed.

    Threadsafety:
        It is safe to call this function from any thread, as long as
        the palette is not modified or destroyed in another thread.

    See_Also:
        $(D SDL_CreatePalette)
*/
extern void SDL_DestroyPalette(SDL_Palette* palette);

/**
    Map an RGB triple to an opaque pixel value for a given pixel format.

    This function maps the RGB color value to the specified pixel format and
    returns the pixel value best approximating the given RGB color value for
    the given pixel format.

    If the format has a palette (8-bit) the index of the closest matching color
    in the palette will be returned.

    If the specified pixel format has an alpha component it will be returned as
    all 1 bits (fully opaque).

    If the pixel format bpp (color depth) is less than 32-bpp then the unused
    upper bits of the return value can safely be ignored (e.g., with a 16-bpp
    format the return value can be assigned to a Uint16, and similarly a Uint8
    for an 8-bpp format).

    Params:
        format =    a pointer to SDL_PixelFormatDetails describing the pixel
                    format.
        palette =   an optional palette for indexed formats, may be NULL.
        r =         the red component of the pixel in the range 0-255.
        g =         the green component of the pixel in the range 0-255.
        b =         the blue component of the pixel in the range 0-255.
    
    Returns:
        a pixel value.

    Threadsafety:
        It is safe to call this function from any thread, as long as
        the palette is not modified.

    See_Also:
        $(D SDL_GetPixelFormatDetails)
        $(D SDL_GetRGB)
        $(D SDL_MapRGBA)
        $(D SDL_MapSurfaceRGB)
*/
extern Uint32 SDL_MapRGB(const(SDL_PixelFormatDetails)* format, const(SDL_Palette)* palette, Uint8 r, Uint8 g, Uint8 b);

/**
    Map an RGBA quadruple to a pixel value for a given pixel format.

    This function maps the RGBA color value to the specified pixel format and
    returns the pixel value best approximating the given RGBA color value for
    the given pixel format.

    If the specified pixel format has no alpha component the alpha value will
    be ignored (as it will be in formats with a palette).

    If the format has a palette (8-bit) the index of the closest matching color
    in the palette will be returned.

    If the pixel format bpp (color depth) is less than 32-bpp then the unused
    upper bits of the return value can safely be ignored (e.g., with a 16-bpp
    format the return value can be assigned to a Uint16, and similarly a Uint8
    for an 8-bpp format).

    Params:
        format      a pointer to SDL_PixelFormatDetails describing the pixel
                    format.
        palette =   an optional palette for indexed formats, may be NULL.
        r =         the red component of the pixel in the range 0-255.
        g =         the green component of the pixel in the range 0-255.
        b =         the blue component of the pixel in the range 0-255.
        a =         the alpha component of the pixel in the range 0-255.
    
    Returns:
        a pixel value.

    Threadsafety:
        It is safe to call this function from any thread, as long as
        the palette is not modified.

    See_Also:
        $(D SDL_GetPixelFormatDetails)
        $(D SDL_GetRGBA)
        $(D SDL_MapRGB)
        $(D SDL_MapSurfaceRGBA)
*/
extern Uint32 SDL_MapRGBA(const(SDL_PixelFormatDetails)* format, const(SDL_Palette)* palette, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

/**
    Get RGB values from a pixel in the specified format.

    This function uses the entire 8-bit [0..255] range when converting color
    components from pixel formats with less than 8-bits per RGB component
    (e.g., a completely white pixel in 16-bit RGB565 format would return [0xff,
    0xff, 0xff] not [0xf8, 0xfc, 0xf8]).

    Params:
        pixel =     a pixel value.
        format =    a pointer to SDL_PixelFormatDetails describing the pixel
                    format.
        palette =   an optional palette for indexed formats, may be NULL.
        r =         a pointer filled in with the red component, may be NULL.
        g =         a pointer filled in with the green component, may be NULL.
        b =         a pointer filled in with the blue component, may be NULL.

    Threadsafety:
        It is safe to call this function from any thread, as long as
        the palette is not modified.

    See_Also:
        $(D SDL_GetPixelFormatDetails)
        $(D SDL_GetRGBA)
        $(D SDL_MapRGB)
        $(D SDL_MapRGBA)
*/
extern void SDL_GetRGB(Uint32 pixel, const(SDL_PixelFormatDetails)* format, const(SDL_Palette)* palette, Uint8* r, Uint8* g, Uint8* b);

/**
    Get RGBA values from a pixel in the specified format.

    This function uses the entire 8-bit [0..255] range when converting color
    components from pixel formats with less than 8-bits per RGB component
    (e.g., a completely white pixel in 16-bit RGB565 format would return [0xff,
    0xff, 0xff] not [0xf8, 0xfc, 0xf8]).

    If the surface has no alpha component, the alpha will be returned as 0xff
    (100% opaque).

    Params:
        pixel =     a pixel value.
        format =    a pointer to SDL_PixelFormatDetails describing the pixel
                    format.
        palette =   an optional palette for indexed formats, may be NULL.
        r =         a pointer filled in with the red component, may be NULL.
        g =         a pointer filled in with the green component, may be NULL.
        b =         a pointer filled in with the blue component, may be NULL.
        a =         a pointer filled in with the alpha component, may be NULL.

    Threadsafety:
        It is safe to call this function from any thread, as long as
        the palette is not modified.

    See_Also:
        $(D SDL_GetPixelFormatDetails)
        $(D SDL_GetRGB)
        $(D SDL_MapRGB)
        $(D SDL_MapRGBA)
*/
extern void SDL_GetRGBA(Uint32 pixel, const(SDL_PixelFormatDetails)* format, const(SDL_Palette)* palette, Uint8* r, Uint8* g, Uint8* b, Uint8* a);
