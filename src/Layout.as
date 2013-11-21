package {

  import flash.display.DisplayObject;
  import flash.display.Sprite;

  public class Layout {

    private static const HORIZONTAL: uint = 0;
    private static const VERTICAL: uint = 1;
    private static const WIDTH: String = "width";
    private static const HEIGHT: String = "height";
    private static const X: String = "x";
    private static const Y: String = "y";

    public static function fitHorizontally(size: uint, ...objects: Array): Sprite {
      return fit(size, HORIZONTAL, objects);
    }

    public static function fitVertically(size: uint, ...objects: Array): Sprite {
      return fit(size, VERTICAL, objects);
    }

    public static function horizontal(padding: uint, ...objects: Array): Sprite {
      return layout(HORIZONTAL, objects, padding);
    }

    public static function vertical(padding: uint, ...objects: Array): Sprite {
      return layout(VERTICAL, objects, padding);
    }

    public static function centerHorizontally(object: Sprite): Sprite {
      return center(HORIZONTAL, object);
    }

    public static function absolute(x: uint, y: uint, object: Sprite): Sprite {
      object.x = x;
      object.y = y;
      return object;
    }

    public static function scale(object: Sprite, value: Number): Sprite {
      object.scaleX = value;
      object.scaleY = value;
      return object;
    }

    public static function middle(width: uint, height: uint, object: Sprite): Sprite {
      return fitHorizontally(width, fitVertically(height, object));
    }

    private static function center(direction: uint, object: Sprite): Sprite {
      var dimension: String = direction == HORIZONTAL ? WIDTH : HEIGHT;
      var property: String = direction == HORIZONTAL ? X : Y;

      var child: DisplayObject;
      var size: uint = object.numChildren;
      var largest: uint = 0;

      for (var i: uint = 0; i < size; i++) {
        child = object.getChildAt(i);
        largest = child[dimension] > largest ? child[dimension] : largest;
      }

      for (i = 0; i < size; i++) {
        child = object.getChildAt(i);
        child[property] += (largest - child[dimension]) / 2;
      }

      return object;
    }

    private static function fit(size: uint, direction: uint, objects: Array): Sprite {
      var dimension: String = direction == HORIZONTAL ? WIDTH : HEIGHT;

      var objSize: uint = sizeOf(objects, dimension);
      var offset: uint = (size - objSize) / (objects.length + 1);

      return layout(direction, objects, offset, offset);
    }

    private static function layout(direction: uint, objects: Array, padding: uint = 0, currentPosition: uint = 0): Sprite {
      var dimension: String = direction == HORIZONTAL ? WIDTH : HEIGHT;
      var property: String = direction == HORIZONTAL ? X : Y;

      var container: Sprite = new Sprite();
      for each(var object: DisplayObject in objects) {
        object[property] = currentPosition;
        container.addChild(object);
        currentPosition += object[dimension] + padding;
      }

      container.graphics.beginFill(0x000000, 0);
      container.graphics.drawRect(0, 0, container.width, container.height);
      container.graphics.endFill();

      return container;
    }

    private static function sizeOf(items: Array, property: String): uint {
      var value: uint = 0;
      for each(var item: DisplayObject in items) {
        value += item[property];
      }
      return value;
    }
  }

}
