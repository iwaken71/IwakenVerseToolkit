# IwakenVerseToolkit

## 前提
- UEFN (Unreal Editor for Fortnite)のVersion

# 導入手順
- UEFNのMenuバーから[Verse]>[Open project in VSCode]を選択し、VSCodeを開く
- VSCodeのMenuバーから[Terminal]>[New Terminal]から{Project Name}を選択
  - Terminal上の現在のディレクトリが`~/Fortnite Projects/{Project Name}/Plugins/{Project Name}/Content`の場所にいることを確認
- `git clone https://github.com/iwaken71/IwakenVerseToolkit.git`を実行
- UEFNのMenuバーから[Verse]>[Build Verse Code]を選択
- UEFNのContent/CreativeDevices以下にファイルが存在することを確認

## .urcignoreの設定
UEFNのリビジョン管理に.gitフォルダを含まないようにする

- Fortnite Projects/{Project Name}以下にある`.urcignore`ファイルを開く
- `**/.git`を一行書き加える

# OnlyUp

![onlyup](https://github.com/iwaken71/IwakenVerseToolkit/assets/10010842/ada4e92c-dd3f-4022-8ed3-7bf3b125dc99)

## 手順

- onlyup_manager_device
- text_ui
- mutator_zone (Fortnite/Devices以下)
を、レベル上に配置

`onlyup_manager_device`をOutlinerで選択し、Detailsから

- TextuUI
- EnterTrigger (mutator_zone)

を選択し、代入する。

