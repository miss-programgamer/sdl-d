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
    SDL Rects

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryRect, SDL3 Rect Documentation)

    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.rect;
import sdl.stdc;
import core.stdc.math;
import core.stdc.float_;

extern(C) nothrow @nogc:

/**
    The structure that defines a point (using integers).

    See_Also:
        $(D SDL_GetRectEnclosingPoints)
        $(D SDL_PointInRect)
*/
struct SDL_Point {
    int x;
    int y;
}

/**
    The structure that defines a point (using floating point values).

    See_Also:
        $(D SDL_GetRectEnclosingPointsFloat)
        $(D SDL_PointInRectFloat)
*/
struct SDL_FPoint {
    float x;
    float y;
}


/**
    A rectangle, with the origin at the upper left (using integers).

    See_Also:
        $(D SDL_RectEmpty)
        $(D SDL_RectsEqual)
        $(D SDL_HasRectIntersection)
        $(D SDL_GetRectIntersection)
        $(D SDL_GetRectAndLineIntersection)
        $(D SDL_GetRectUnion)
        $(D SDL_GetRectEnclosingPoints)
*/
struct SDL_Rect {
    int x, y;
    int w, h;
}


/**
    A rectangle, with the origin at the upper left (using floating point
    values).

    See_Also:
        $(D SDL_RectEmptyFloat)
        $(D SDL_RectsEqualFloat)
        $(D SDL_RectsEqualEpsilon)
        $(D SDL_HasRectIntersectionFloat)
        $(D SDL_GetRectIntersectionFloat)
        $(D SDL_GetRectAndLineIntersectionFloat)
        $(D SDL_GetRectUnionFloat)
        $(D SDL_GetRectEnclosingPointsFloat)
        $(D SDL_PointInRectFloat)
*/
struct SDL_FRect {
    float x;
    float y;
    float w;
    float h;
}


/**
    Convert an SDL_Rect to SDL_FRect
    
    Params:
        rect =  a pointer to an SDL_Rect.
        frect = a pointer filled in with the floating point representation of
                `rect`.
    
    Threadsafety:
        It is safe to call this function from any thread.
*/
pragma(inline, true)
void SDL_RectToFRect(const(SDL_Rect)* rect, SDL_FRect* frect) {
    frect.x = cast(float)rect.x;
    frect.y = cast(float)rect.y;
    frect.w = cast(float)rect.w;
    frect.h = cast(float)rect.h;
}

/**
    Determine whether a point resides inside a rectangle.

    A point is considered part of a rectangle if both `p` and `r` are not NULL,
    and `p`'s x and y coordinates are >= to the rectangle's top left corner,
    and < the rectangle's x+w and y+h. So a 1x1 rectangle considers point (0,0)
    as "inside" and (0,1) as not.

    Note that this is a forced-inline function in a header, and not a public
    API function available in the SDL library (which is to say, the code is
    embedded in the calling program and the linker and dynamic loader will not
    be able to find this function inside SDL itself).

    Params:
        p = the point to test.
        r = the rectangle to test.
    
    Returns:
        true if `p` is contained by `r`, false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.
*/
pragma(inline, true)
bool SDL_PointInRect(const(SDL_Point)* p, const(SDL_Rect)* r) {
    return ( p && r && (p.x >= r.x) && (p.x < (r.x + r.w)) &&
             (p.y >= r.y) && (p.y < (r.y + r.h)) ) ? true : false;
}

/**
    Determine whether a rectangle has no area.

    A rectangle is considered "empty" for this function if `r` is NULL, or if
    `r`'s width and/or height are <= 0.

    Note that this is a forced-inline function in a header, and not a public
    API function available in the SDL library (which is to say, the code is
    embedded in the calling program and the linker and dynamic loader will not
    be able to find this function inside SDL itself).

    Params:
        r = the rectangle to test.
    
    Returns:
        true if the rectangle is "empty", false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

*/
pragma(inline, true)
bool SDL_RectEmpty(const(SDL_Rect)* r) {
    return ((!r) || (r.w <= 0) || (r.h <= 0)) ? true : false;
}

/**
    Determine whether two rectangles are equal.

    Rectangles are considered equal if both are not NULL and each of their x,
    y, width and height match.

    Note that this is a forced-inline function in a header, and not a public
    API function available in the SDL library (which is to say, the code is
    embedded in the calling program and the linker and dynamic loader will not
    be able to find this function inside SDL itself).

    Params:
        a = the first rectangle to test.
        b = the second rectangle to test.
    
    Returns:
        true if the rectangles are equal, false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

*/
pragma(inline, true)
bool SDL_RectsEqual(const(SDL_Rect)* a, const(SDL_Rect)* b) {
    return (a && b && (a.x == b.x) && (a.y == b.y) &&
            (a.w == b.w) && (a.h == b.h)) ? true : false;
}

/**
    Determine whether two rectangles intersect.

    If either pointer is NULL the function will return false.

    Params:
        A = an SDL_Rect structure representing the first rectangle.
        B = an SDL_Rect structure representing the second rectangle.
    
    Returns:
        true if there is an intersection, false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.


    \sa SDL_GetRectIntersection
*/
extern bool SDL_HasRectIntersection(const(SDL_Rect)* A, const(SDL_Rect)* B);

/**
    Calculate the intersection of two rectangles.

    If `result` is NULL then this function will return false.

    Params:
        A =         an SDL_Rect structure representing the first rectangle.
        B =         an SDL_Rect structure representing the second rectangle.
        result =    an SDL_Rect structure filled in with the intersection of
                    rectangles `A` and `B`.
    
    Returns:
        true if there is an intersection, false otherwise.

    See_Also:
        $(D SDL_HasRectIntersection)
*/
extern bool SDL_GetRectIntersection(const(SDL_Rect)* A, const(SDL_Rect)* B, SDL_Rect* result);

/**
    Calculate the union of two rectangles.

    Params:
        A =         an SDL_Rect structure representing the first rectangle.
        B =         an SDL_Rect structure representing the second rectangle.
        result =    an SDL_Rect structure filled in with the union of rectangles
                    `A` and `B`.
    Returns:
        true on success or false on failure; call SDL_GetError() for more
            information.

*/
extern bool SDL_GetRectUnion(const(SDL_Rect)* A, const(SDL_Rect)* B, SDL_Rect* result);

/**
    Calculate a minimal rectangle enclosing a set of points.

    If `clip` is not NULL then only points inside of the clipping rectangle are
    considered.

    Params:
        points =    an array of SDL_Point structures representing points to be
                    enclosed.
        count =     the number of structures in the `points` array.
        clip =      an SDL_Rect used for clipping or NULL to enclose all points.
        result =    an SDL_Rect structure filled in with the minimal enclosing
                    rectangle.
    
    Returns:
        true if any points were enclosed or false if all the points were
            outside of the clipping rectangle.

*/
extern bool SDL_GetRectEnclosingPoints(const(SDL_Point)* points, int count, const(SDL_Rect)* clip, SDL_Rect* result);

/**
    Calculate the intersection of a rectangle and line segment.

    This function is used to clip a line segment to a rectangle. A line segment
    contained entirely within the rectangle or that does not intersect will
    remain unchanged. A line segment that crosses the rectangle at either or
    both ends will be clipped to the boundary of the rectangle and the new
    coordinates saved in `X1`, `Y1`, `X2`, and/or `Y2` as necessary.

    Params:
        rect =  an SDL_Rect structure representing the rectangle to intersect.
        X1 =    a pointer to the starting X-coordinate of the line.
        Y1 =    a pointer to the starting Y-coordinate of the line.
        X2 =    a pointer to the ending X-coordinate of the line.
        Y2 =    a pointer to the ending Y-coordinate of the line.

    Returns:
        true if there is an intersection, false otherwise.

*/
extern bool SDL_GetRectAndLineIntersection(const(SDL_Rect)* rect, int* X1, int* Y1, int* X2, int* Y2);


/* SDL_FRect versions... */

/**
    Determine whether a point resides inside a floating point rectangle.

    A point is considered part of a rectangle if both `p` and `r` are not NULL,
    and `p`'s x and y coordinates are >= to the rectangle's top left corner,
    and <= the rectangle's x+w and y+h. So a 1x1 rectangle considers point
    (0,0) and (0,1) as "inside" and (0,2) as not.

    Note that this is a forced-inline function in a header, and not a public
    API function available in the SDL library (which is to say, the code is
    embedded in the calling program and the linker and dynamic loader will not
    be able to find this function inside SDL itself).

    Params:
        p = the point to test.
        r = the rectangle to test.
    
    Returns:
        true if `p` is contained by `r`, false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

*/
pragma(inline, true)
bool SDL_PointInRectFloat(const(SDL_FPoint)* p, const(SDL_FRect)* r) {
    return ( p && r && (p.x >= r.x) && (p.x <= (r.x + r.w)) &&
             (p.y >= r.y) && (p.y <= (r.y + r.h)) ) ? true : false;
}

/**
    Determine whether a floating point rectangle can contain any point.

    A rectangle is considered "empty" for this function if `r` is NULL, or if
    `r`'s width and/or height are < 0.0f.

    Note that this is a forced-inline function in a header, and not a public
    API function available in the SDL library (which is to say, the code is
    embedded in the calling program and the linker and dynamic loader will not
    be able to find this function inside SDL itself).

    Params:
        r = the rectangle to test.

    Returns:
        true if the rectangle is "empty", false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

*/
pragma(inline, true)
bool SDL_RectEmptyFloat(const(SDL_FRect)* r) {
    return ((!r) || (r.w < 0.0f) || (r.h < 0.0f)) ? true : false;
}

/**
    Determine whether two floating point rectangles are equal, within some
    given epsilon.

    Rectangles are considered equal if both are not NULL and each of their x,
    y, width and height are within `epsilon` of each other. If you don't know
    what value to use for `epsilon`, you should call the SDL_RectsEqualFloat
    function instead.

    Note that this is a forced-inline function in a header, and not a public
    API function available in the SDL library (which is to say, the code is
    embedded in the calling program and the linker and dynamic loader will not
    be able to find this function inside SDL itself).

    Params:
        a =         the first rectangle to test.
        b =         the second rectangle to test.
        epsilon =   the epsilon value for comparison.
    
    Returns:
        true if the rectangles are equal, false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_RectsEqualFloat)
*/
pragma(inline, true)
bool SDL_RectsEqualEpsilon(const(SDL_FRect)* a, const(SDL_FRect)* b, const(float) epsilon) {
    return (a && b && ((a == b) ||
            ((fabsf(a.x - b.x) <= epsilon) &&
            (fabsf(a.y - b.y) <= epsilon) &&
            (fabsf(a.w - b.w) <= epsilon) &&
            (fabsf(a.h - b.h) <= epsilon))))
            ? true : false;
}

/**
    Determine whether two floating point rectangles are equal, within a default
    epsilon.

    Rectangles are considered equal if both are not NULL and each of their x,
    y, width and height are within SDL_FLT_EPSILON of each other. This is often
    a reasonable way to compare two floating point rectangles and deal with the
    slight precision variations in floating point calculations that tend to pop
    up.

    Note that this is a forced-inline function in a header, and not a public
    API function available in the SDL library (which is to say, the code is
    embedded in the calling program and the linker and dynamic loader will not
    be able to find this function inside SDL itself).

    Params:
        a = the first rectangle to test.
        b = the second rectangle to test.
    
    Returns:
        true if the rectangles are equal, false otherwise.

    Threadsafety:
        It is safe to call this function from any thread.


    \sa SDL_RectsEqualEpsilon
*/
pragma(inline, true)
bool SDL_RectsEqualFloat(const(SDL_FRect)* a, const(SDL_FRect)* b) {
    return SDL_RectsEqualEpsilon(a, b, FLT_EPSILON);
}

/**
    Determine whether two rectangles intersect with float precision.

    If either pointer is NULL the function will return false.

    Params:
        A = an SDL_FRect structure representing the first rectangle.
        B = an SDL_FRect structure representing the second rectangle.
    
    Returns:
        true if there is an intersection, false otherwise.

    See_Also:
        $(D SDL_GetRectIntersection)
*/
extern bool SDL_HasRectIntersectionFloat(const(SDL_FRect)* A, const(SDL_FRect)* B);

/**
    Calculate the intersection of two rectangles with float precision.

    If `result` is NULL then this function will return false.

    Params:
        A =         an SDL_FRect structure representing the first rectangle.
        B =         an SDL_FRect structure representing the second rectangle.
        result =    an SDL_FRect structure filled in with the intersection of
                    rectangles `A` and `B`.
    
    Returns:
        true if there is an intersection, false otherwise.


    \sa SDL_HasRectIntersectionFloat
*/
extern bool SDL_GetRectIntersectionFloat(const(SDL_FRect)* A, const(SDL_FRect)* B, SDL_FRect* result);

/**
    Calculate the union of two rectangles with float precision.

    Params:
        A =         an SDL_FRect structure representing the first rectangle.
        B =         an SDL_FRect structure representing the second rectangle.
        result =    an SDL_FRect structure filled in with the union of rectangles
                    `A` and `B`.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
            information.

*/
extern bool SDL_GetRectUnionFloat(const(SDL_FRect)* A, const(SDL_FRect)* B, SDL_FRect* result);

/**
    Calculate a minimal rectangle enclosing a set of points with float
    precision.

    If `clip` is not NULL then only points inside of the clipping rectangle are
    considered.

    Params:
        points =    an array of SDL_FPoint structures representing points to be
                    enclosed.
        count =     the number of structures in the `points` array.
        clip =      an SDL_FRect used for clipping or NULL to enclose all points.
        result =    an SDL_FRect structure filled in with the minimal enclosing
                    rectangle.
    
    Returns:
        true if any points were enclosed or false if all the points were
        outside of the clipping rectangle.

*/
extern bool SDL_GetRectEnclosingPointsFloat(const(SDL_FPoint)* points, int count, const(SDL_FRect)* clip, SDL_FRect* result);

/**
    Calculate the intersection of a rectangle and line segment with float
    precision.
    
    This function is used to clip a line segment to a rectangle. A line segment
    contained entirely within the rectangle or that does not intersect will
    remain unchanged. A line segment that crosses the rectangle at either or
    both ends will be clipped to the boundary of the rectangle and the new
    coordinates saved in `X1`, `Y1`, `X2`, and/or `Y2` as necessary.
    
    Params:
        rect =  an SDL_FRect structure representing the rectangle to intersect.
        X1 =    a pointer to the starting X-coordinate of the line.
        Y1 =    a pointer to the starting Y-coordinate of the line.
        X2 =    a pointer to the ending X-coordinate of the line.
        Y2 =    a pointer to the ending Y-coordinate of the line.
        
    Returns:
        true if there is an intersection, false otherwise.
    
*/
extern bool SDL_GetRectAndLineIntersectionFloat(const(SDL_FRect)* rect, float* X1, float* Y1, float* X2, float* Y2);
