## Pseudo-Hilbert curves generator

This script aims to create 2D pseudo-Hilbert curves of the desired order. This kind of curves have the property to fill spaces of higher dimension. This exercise provides a specific solution for the 2D pseudo-Hilbert curves, whose fractal dimension is 2. Nonetheless, it is relevant to remark that there are curves of this kind able to fill spaces of higher order, such as the 3D pseudo-Hilbert curves that can fill an space of dimension 3.
The script provides a solution using matrix operations, which is highly suitable for a vector based programming language as R.

## Arguments

The ```main()``` function takes the following arguments:
* order: specifies the order of the desired Hilbert curve. It can range between 1 and infinity, although orders higher than 10 are computationally expensive.
* corner: specifies the corner of the space where the curve should begin. It is set to "bottomleft" by default.
* orientation: specifies the orientation of the curve. Can take two values: "clockwise" and "counterclockwise".
* xfrac: fraction of the horizontal space of the subsquares where the points should be, ranging from 0 to 1. If set to 1/2 the points are centered in the horizontal direction.
* yfrac: fraction of the vertical space of the subsquares where the points should be, ranging from 0 to 1. If set to 1/2 the points are centered in the vertical direction.
* animation: boolean. If set to TRUE, an animation of all the iterations made until reaching the desired order is plotted.
* sleeptime: if animation = TRUE, specifies the time that each iteration remains in the screen (in seconds).

Have fun!
