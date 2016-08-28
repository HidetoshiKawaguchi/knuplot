# -*- coding: utf-8 -*-
require 'json'
require 'gnuplot'

#------------------------------------------
#++
## Gnuplotの設定をHashから読み込んで書き出す関数
## _inputHash_ Gnuplotへの設定、データセット.JSONだと以下のような記法

## _filepath_ 書き出すファイルのパス
## _inputHash_ Gnuplotの設定
## _json_ jsonファイルを書き出すかどうか。gnuplotで書きだすファイルと同ディレクトリにjsonディレクトリを作って、そこにeps拡張子をjson拡張子に変更して保存する。
def knuplot(filepath, a_inputHash, json: nil,  auto_yrange: false, &block)
  inputHash = Marshal.load(Marshal.dump(a_inputHash))
  y_max = 0
  Gnuplot.open do |gp|
    Gnuplot::Plot.new(gp) do |plot|
      plot.output(filepath) #出力先の設定
      inputHash.each do |key, obj| #設定
        if key.to_s == 'data_set_list' #データセットの登録
          obj.each do |data|
            x = data.fetch(:x, data['x'])
            y = data.fetch(:y, data['y'])
            y_max = y.max if y_max < y.max
            xdelta = data.fetch(:xdelta, data['xdelta'])
            ydelta = data.fetch(:ydelta, data['ydelta'])
            plot.data << Gnuplot::DataSet.new([x, y, *([xdelta, ydelta]).compact]) do |ds|
              data.each do |dataKey, dataValue|
                #if dataKey.to_s != 'x' && dataKey.to_s != 'y' #データセット毎の設定
                if !['x', 'y', 'xdelta', 'ydelta'].include?(dataKey.to_s)
                  ds.send(dataKey.to_s + '=', dataValue)
                end
              end
            end
          end
        elsif key.to_s == 'set_command_list' #setメソッドの順次実行
          obj.each do |command|
            plot.set command.to_s
          end
        else #それ以外はkeyをメソッド,objを引数として設定
          plot.send(key.to_s, obj)
        end
      end
      plot.yrange " [0:#{y_max*auto_yrange}]" if auto_yrange
      if block #一応Gnuplot::Plotの設定をブロックでも渡せるようにする. ブロックで書いたものが優先される
        block.call(plot)
      end
    end
  end
  if json
    json_dir_path = File::dirname(filepath) + '/json/'
    system("mkdir -p #{json_dir_path}")
    File.write(json_dir_path + File::basename(filepath).gsub('eps', 'json'), JSON.pretty_generate(inputHash))
  end
end
