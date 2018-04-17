package pxling;

import hxPixels.Pixels;


class PixelFn {
  inline static public function gray(px:Pixel):Pixel {
    return grey(px);
  }
  inline static public function grey(px:Pixel):Pixel {
    var grey = Std.int((px.R + px.G + px.B) / 3);
    return Pixel.create(px.A, grey, grey, grey);
  }
  
  inline static public function apply(px:Pixel, fn:Pixel->Pixel):Pixel {
    return fn(px);
  }
}