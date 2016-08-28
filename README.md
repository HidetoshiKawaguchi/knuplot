# knuplot
gnuplotのwrapperである「Rubyのgnuplot」のwrapper。対話形式ではなく、連想配列(Hash)で設定を受け渡しできる。

## 動作環境
* Ruby (2.3.1のみ動作確認。多分他のバージョンでも動く)
* gnuplot(5.0.1のみ動作確認。多分他のバージョンでも動く)
* Rubyのgnuplotライブラリ(gemでインストールできます)
* Rubyのjsonライブラリ(gemでインストールできます)

## 思想
gnuplotの設定ファイルが対話形式であることに気が食わなかったので、連想配列(Hash)で一括して設定できるようにしたかった。

## 設定の例
具体例を見せたほうが早いと思うので、先に具体例をJSON記法で示す。HashとJSONは相互変換可能である。そのため、グラフの設定をJSON形式で保存可能となる。
```sample1.json
{
    "xlabel": "x",
    "ylabel": "y",
    "xrange": "[0:10]",
    "yrange": "[0:10]",
    "set_command_list": [
        "size ratio 1",
        "grid"
    ],
    "data_set_list": [
        {"title": "dots", "x": [7, 8.3, 7.5], "y": [2.1, 1, 3], "with": "points pointsize 3.0"},
        {"title": "lp", "x": [4, 5, 6, 5], "y": [4, 5, 6, 7], "with": "lp"},
        {"title": "xyerror_lines", "x": [1,2,3],"y": [1,2,3],"xdelta":[0.1,0.1,0.1],"ydelta":[0.2,0.2,0.2], "with": "xyerrorlines"}
    ]
}
```