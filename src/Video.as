package {

  import flash.events.NetStatusEvent;
  import flash.media.SoundTransform;
  import flash.net.NetConnection;
  import flash.net.NetStream;

  public class Video extends flash.media.Video {

    private var _url: String;
    private var _autoplay: Boolean;
    private var _loop: Boolean;
    private var _muted: Boolean;
    private var _playing: Boolean;
    private var _duration: Number;

    private var stream: NetStream;
    private var connection: NetConnection = new NetConnection();

    public function Video(url: String, width: uint, height: uint, autoplay: Boolean = true, loop: Boolean = true, muted: Boolean = true) {
      super(width, height);

      this._url = url;
      this._autoplay = autoplay;
      this._loop = loop;
      this._muted = muted;

      connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
      connection.connect(null);
    }

    public function play(): void {
      _playing = true;
      stream.resume();
    }

    public function pause(): void {
      _playing = false;
      stream.pause();
    }

    public function isPaused(): Boolean {
      return !_playing;
    }

    public function mute(): void {
      _muted = true;
      stream.soundTransform = new SoundTransform(0);
    }

    public function unmute(): void {
      _muted = false;
      stream.soundTransform = new SoundTransform(1);
    }

    public function isMuted(): Boolean {
      return _muted;
    }

    public function duration(): Number {
      return _duration;
    }

    private function netStatusHandler(e: NetStatusEvent): void {
      switch (e.info.code) {
        case "NetConnection.Connect.Success":
          stream = new NetStream(connection);
          stream.bufferTime = 0.5;
          stream.client = {};
          stream.client.onMetaData = function(metadata: Object): void {
            if (metadata.hasOwnProperty("duration") && metadata["duration"] is Number) {
              _duration = metadata["duration"];
            }
          };
          stream.soundTransform = new SoundTransform(_muted ? 0 : 1);
          stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
          attachNetStream(stream);

          stream.play(_url);
          if (_autoplay) {
            _playing = true;
          } else {
            _playing = false;
            pause();
          }
          break;
        case "NetStream.Play.Stop":
          if (_loop) stream.seek(0);
          break;
      }
    }

  }

}
