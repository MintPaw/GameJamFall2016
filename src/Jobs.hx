package ;

class Jobs {

  public static function initJobs():Void {
    newJob("foo", 10, 17);
    newJob("foobar", 15, 24);
    newJob("foobarbaz", 8, 15);
  }

  public static function newJob(
    name:String,
    start:Int,
    end:Int
  ):Job {
    var job:Job = {
      name: name,
      start: start,
      end: end
    };
    Game.data.jobs.push(job);
    return job;
  }
}

typedef Job = {
  name:String,
  start:Int,
  end:Int
}
