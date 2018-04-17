package pxling;

import hxPixels.Pixels;


class PixelTools {
  static public function enumerateRect(pixels:Pixels, x:Int, y:Int, w:Int, h:Int):PixelRectIterator {
    var rect:_Rect = {x:x, y:y, w:w, h:h};
    return new PixelRectIterator(pixels, rect);
  }
}

/**
 * Iterates the specified rect along the x axis first, then y.
 * 
 * Public fields' values will be relative to (0,0).
 */
class RectIterator {
  var rect:_Rect;
  var maxIdx:Int;
  var nextIdx:Int;
  
  // relative to rect (i.e. they're initialized to 0)
  public var idx(default, null):Int;
  public var x(default, null):Int;
  public var y(default, null):Int;
  
  public function new(rect:_Rect)
  {
    this.rect = rect;
    this.nextIdx = this.idx = this.x = this.y = 0;
    this.maxIdx = rect.w * rect.h;
  }
  
  public function hasNext() {
    return nextIdx < maxIdx;
  }
  
  public function next() {
    idx = nextIdx;
    x = idx % rect.w;
    y = Std.int(idx / rect.w);
    nextIdx++;
    return this;
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
