# IwakenVerseToolkit

## 前提
- UEFN (Unreal Editor for Fortnite)が使用可能

# 導入手順

## インストール方法

- git cloneのやり方
- Download Zipのやり方

どちから一方で大丈夫です。
また、UEFNのリビジョン管理に.gitフォルダを含まないようにするために.urcignoreファイルの設定も説明します。

### git cloneのやり方
- UEFNのMenuバーから[Verse]>[Open project in VSCode]を選択し、VSCodeを開く
- VSCodeのMenuバーから[Terminal]>[New Terminal]から{Project Name}を選択
  - Terminal上の現在のディレクトリが`~/Fortnite Projects/{Project Name}/Plugins/{Project Name}/Content`の場所にいることを確認
- `git clone https://github.com/iwaken71/IwakenVerseToolkit.git`を実行
- UEFNのMenuバーから[Verse]>[Build Verse Code]を選択
- UEFNのContent/CreativeDevices以下にファイルが存在することを確認
### Download Zipでのやり方

- [Githubページ](https://github.com/iwaken71/IwakenVerseToolkit/)の[Code]>[Download Zip]をクリック
- IwakenVerseToolkit-master.zipを展開
- 1つ下の階層の「IwakenVerseToolkit-master」ディレクトリを「IwakenVerseToolkit」へ名前を変更 (★重要)
- `~/Fortnite Projects/{Project Name}/Plugins/{Project Name}/Content`以下に「IwakenVerseToolkit」ディレクトリを移動
- UEFNのMenuバーから[Verse]>[Build Verse Code]を選択
- UEFNのContent/CreativeDevices以下にファイルが存在することを確認

## .urcignoreの設定
UEFNのリビジョン管理に.gitフォルダを含まないようにする

- Fortnite Projects/{Project Name}以下にある`.urcignore`ファイルを開く
- `**/.git`を一行書き加える

# Sampleプロジェクト
## OnlyUp

https://github.com/iwaken71/IwakenVerseToolkit/releases/tag/OnlyUpSample

![onlyup](https://github.com/iwaken71/IwakenVerseToolkit/assets/10010842/ada4e92c-dd3f-4022-8ed3-7bf3b125dc99)

## 手順

- onlyup_manager_device
- text_ui_device
- mutator_zone (Fortnite/Devices以下)
を、レベル上に配置

`onlyup_manager_device`をOutlinerで選択し、Detailsから

- TextuUI
- EnterTrigger (mutator_zone)
- FloorHeight

を選択し、代入する。

## 遊び方

- mutator_zoneに入ると、ユーザーの高さを表示する

