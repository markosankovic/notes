# WebGL2 Fundamentals

WebGL is just a *rasterization* engine. It draws points, lines, and triangles based on the supplied code.

WebGL runs on the GPU and you need to provide the code that runs on that GPU. You provide that code in the form of pairs of functions. Those 2 functions are called a vertex shader and a fragment shader and they are each written in a strictly typed C/C++ like language called GLSL (GL Shader Language).

> Rasterisation (or rasterization) is the task of taking an image described in a vector graphics format (shapes) and converting it into a raster image (a series of pixels, dots or lines that when they come together on a display, they recreate the image).

A vertex shader's job is to compute vertex positions. Based on the positions the function outputs WebGL can then rasterize various kinds of primitives including points, lines, or triangles. When rasterizing these primitives it calls a second user supplied function called a fragment shader. A fragment shader's job is to compute a color for each pixel of the primitive currently being drawn.

There are 4 ways a shader can receive data.

1. Attributes, Buffers, and Vertex Arrays

Buffers are arrays of binary data you upload to the GPU. Usually buffers contain things like positions, normals, texture coordinates, vertex colors, etc. although you're free to put anything you want in them.

Attributes are used to specify how to pull data out of your buffers and provide them to your vertex shader. For example you might put positions in a buffer as three 32bit floats per position. You would tell a particular attribute which buffer to pull the positions out of, what type of data it should pull out (3 component 32 bit floating point numbers), what offset in the buffer the positions start, and how many bytes to get from one position to the next.

Buffers are not random access. Instead a vertex shaders is executed a specified number of times. Each time it's executed the next value from each specified buffer is pulled out assigned to an attribute.

The state of attributes, which buffers to use for each one and how to pull out data from those buffers, is collected into a vertex array object (VAO).

2. Uniforms

Uniforms are effectively global variables you set before you execute your shader program.

3. Textures

Textures are arrays of data you can randomly access in your shader program. The most common thing to put in a texture is image data but textures are just data and can just as easily contain something other than colors.

4. Varyings

Varyings are a way for a vertex shader to pass data to a fragment shader. Depending on what is being rendered, points, lines, or triangles, the values set on a varying by a vertex shader will be interpolated while executing the fragment shader.

## WebGL Hello World

WebGL only cares about 2 things. Clipspace coordinates and colors. Your job as a programmer using WebGL is to provide WebGL with these 2 things. You provide your 2 "shaders" to do this. A Vertex shader which provides the clipspace coordinates and a fragment shader that provides the color.

Clipspace coordinates always go from -1 to +1 no matter what size your canvas is. Here is a simple WebGL example that shows WebGL in its simplest form.

Let's start with a vertex shader

```glsl
#version 300 es

// an attribute is an input (in) to a vertex shader.
// It will receive data from a buffer
int vec4 a_position;

// all shaders have a main function
void main() {

  // gl_Position is a special variable a vertex shader
  // is responsible for setting
  gl_Position = a_position;
}
```

When executed, if the entire thing was written in JavaScript instead of GLSL you could imagine it would be used like this

```js
// *** PSUEDO CODE!! ***

var positionBuffer = [
  0, 0, 0, 0,
  0, 0.5, 0, 0,
  0.7, 0, 0, 0,
];
var attributes = {};
var gl_Position;

drawArrays(..., offset, count) {
  var stride = 4;
  var size = 4;
  for (var i = 0; i < count; ++i) {
     // copy the next 4 values from positionBuffer to the a_position attribute
     const start = (offset + i) * stride;
     attributes.a_position = positionBuffer.slice(start, start + size);
     runVertexShader();
     ...
     doSomethingWith_gl_Position();
  }
}
```

In reality it's not quite that simple because positionBuffer would need to be converted to binary data (see below) and so the actual computation for getting data out of the buffer would be a little different but hopefully this gives you an idea of how a vertex shader will be executed.

Next we need a fragment shader

```glsl
#version 300 es

// fragment shaders don't have a default precision so we need
// to pick one. mediump is a good default. It means "medium precision"
precision mediump float;

// we need to declare an output for the fragment shader
out vec4 outColor;

void main() {
  // Just set the output to a constant redish-purple
  outColor = vec4(1, 0, 0.5, 1);
}
```

Above we declared outColor as our fragment shader's output. We're setting outColor to 1, 0, 0.5, 1 which is 1 for red, 0 for green, 0.5 for blue, 1 for alpha. Colors in WebGL go from 0 to 1.

Now that we have written the 2 shader functions lets get started with WebGL

First we need an HTML canvas element

```html
<canvas id="c"></canvas>
```

Then in JavaScript we can look that up

```js
var canvas = document.getElementById("c");
```

Now we can create a WebGL2RenderingContext

```js
 var gl = canvas.getContext("webgl2");
 if (!gl) {
    // no webgl2 for you!
    ...
```
