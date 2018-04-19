package pxling;

import hxPixels.Pixels;


class PixelTools {
  static public function enumerate(pixels:Pixels):PixelRectIterator {
    var rect:IntRect = {x:0, y:0, w:pixels.width, h:pixels.height};
    return new PixelRectIterator(pixels, rect);
  }
  
  static public function enumerateRect(pixels:Pixels, x:Int, y:Int, w:Int, h:Int):PixelRectIterator {
    var rect:IntRect = {x:x, y:y, w:w, h:h};
    return new PixelRectIterator(pixels, rect);
  }
}

/**
 * Iterates the specified rect along the x axis first, then y.
 */
class RectIterator {
  var rect:IntRect;
  var maxIdx:Int;
  var nextIdx:Int;
  
  public var idx(default, null):Int;
  public var x(default, null):Int;
  public var y(default, null):Int;
  
  public function new(rect:IntRect)
  {
    this.rect = rect;
    this.maxIdx = rect.w * rect.h;
    reset();
  }
  
  inline public function hasNext() {
    return nextIdx < maxIdx;
  }
  
  public function next() {
    idx = nextIdx;
    x = rect.x + idx % rect.w;
    y = rect.y + Std.int(idx / rect.w);
    nextIdx++;
    return this;
  }
  
  public function reset() {
    this.nextIdx = this.idx = 0;
    this.x = rect.x;
    this.y = rect.y;
  }
}

class PixelRectIterator extends RectIterator {
  var parent:Pixels;
  
  public var pixel(get, set):Pixel;
  
  public function new(pixels:Pixels, rect:IntRect)
  {
    super(rect);
    this.parent = pixels;
  }
  
  inline function get_pixel():Pixel {
    return parent.getPixel32(rect.x + x, rect.y + y);
  }
  
  inline function set_pixel(value:Pixel):Pixel {
    parent.setPixel32(rect.x + x, rect.y + y, value);
    return value;
  }
}

@:structInit
class IntRect {
  public var x:Int;
  public var y:Int;
  public var w:Int;
  public var h:Int;
  
  inline public function new(x:Int, y:Int, w:Int, h:Int)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}
