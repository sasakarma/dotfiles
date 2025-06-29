# dotfiles

## 概要
tmuxとneovimの設定をまとめたもの。
職場・プライベート問わず同じ設定を利用しやすくするためにGithubで管理している。

Unix系OSでは、`install_config.sh`、Windowsでは`install_config.ps1`を実行することでセットアップが完了するようにしている。

## 運用

職場からGithubにpushはできないので、変更は主に自宅で加える。
職場内では専用のブランチを作成して使うこと。
職場用ブランチは定期的にmainに対してrebaseして、設定が古くならないようにすること。
たまにmainブランチとのdiffを取り、有用なものはmainに(自宅に帰ってから)取り込むこと。


