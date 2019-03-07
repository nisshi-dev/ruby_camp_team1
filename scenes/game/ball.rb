class Ball < CPCircle
    attr_accessor :on_stage   # 呼び出しているクラスからメソッドとしてよびだせるシンボル

    def move
      #@push_count = 0
      @power_bar_width = 10
      @power_v_size = 1
      @power_h_size = 1

      if @body.p.y > 555
        puts "スタートゾーン"
        #クリック時のx,y座標
        start_shoot if Input.mouse_push?(M_LBUTTON)   # こっちでカウント++しちゃうと引っ張っている間もループ回ってるからifに入らなくなる
        #	@start_y = mouse_pos_y if Input.mouse_down?(M_LBUTTON)
        #クリック終了後のx,y座標
        if Input.mouse_release?(M_LBUTTON)
          last_shoot(self)
        end
      else
        @on_stage = true
        if @body.v.x <= 100 && @body.v.x >= -100 && @body.v.y <= 100 && @body.v.y >= -100
          puts "はいったよ"
          @body.v.x = 0
          @body.v.y = 90
          @on_stage = false
        end
      end

      p @on_stage
    end

    def start_shoot
      @start_x = Input.mouse_pos_x    # インスタンス変数に格納
      @start_y = Input.mouse_pos_y    # インスタンス変数に格納
    end

    def last_shoot(ball)
      #p @current
      @last_x = Input.mouse_pos_x     # インスタンス変数に格納
      @last_y = Input.mouse_pos_y     # インスタンス変数に格納
      power_x = @start_x - @last_x    # x座標の変位を計算
      power_y = @last_y - @start_y    # y座標の変位を計算
      @power_v_size += power_y        # y方向の力を計算
      @power_h_size += power_x        # x方向の力を計算
      #p @current
      ball.apply_force(@power_h_size * 2.0, -@power_v_size * 2.0)   # 計算した外力を加える
      #@circle.apply_force(@power_h_size * 2.5, -@power_v_size * 2.5)
      #@circle.apply_force(100, -100)
      #@current.apply_force(100, -100)
      @power_h_size = 1   # x方向の外力の初期化
      @power_v_size = 1   # y方向の外力の初期化
    end
end