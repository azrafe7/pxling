package pxling;

import hxPixels.Pixels;


class PixelTools {
  static public function enumerate(pixels:Pixels):PixelRectIterator {
    var rect:_Rect = {x:0, y:0, w:pixels.width, h:pixels.height};
    return new PixelRectIterator(pixels, rect);
  }
  
  static public function enumerateRect(pixels:Pixels, x:Int, y:Int, w:Int, h:Int):PixelRectIterator {
    var rect:_Rect = {x:x, y:y, w:w, h:h};
    return new PixelRectIterator(pixels, rect);
  }
}

/**
 * Iterates the specified rect along the x axis first, then y.
 */
class RectIterator {
  var rect:_Rect;
  var maxIdx:Int;
  var nextIdx:Int;
  
  public var idx(default, null):Int;
  public var x(default, null):Int;
  public var y(default, null):Int;
  
  public function new(rect:_Rect)
  {
    this.rect = rect;
    this.maxIdx = rect.w * rect.h;
    reset();
  }
  
  public function hasNext() {
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
  
  public function new(pixels:Pixels, rect:_Rect)
  {
    super(rect);
    this.parent = pixels;
  }
  
  override public function next() {
    super.next();
    return this;
  }
  
  inline function get_pixel():Pixel {
    return parent.getPixel32(rect.x + x, rect.y + y);
  }
  
  inline function set_pixel(value:Pixel):Pixel {
    parent.setPixel32(rect.x + x, rect.y + y, value);
    return value;
  }
}

typedef _Rect = {
  var x:Int;
  var y:Int;
  var w:Int;
  var h:Int;
}
