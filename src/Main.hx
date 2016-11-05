package;

class Main
{
  
  public static function main() {
    clear();
    println("GAME START");
    pause();

    var result:String = menu("Main menu", ["Pets", "Shop"]);
    println(result+" was picked");
  }
}
