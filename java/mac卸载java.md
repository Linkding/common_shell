在“终端”窗口中，复制和粘贴命令：
```
sudo rm -fr /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
sudo rm -fr /Library/PreferencesPanes/JavaControlPanel.prefPane
sudo rm -fr ~/Library/Application\ Support/Java
```
请勿尝试通过从 /usr/bin 删除 Java 工具来卸载 Java。此目录是系统软件的一部分，下次对操作系统执行更新时，Apple 会重置所有更改。



>注意：上面是官网的卸载步骤，按照上面的卸载完后，要从finder中进入 /Library/Java/JavaVirtualMachines，然后删除jdk1.8.xxx，这样才算彻底卸载完成。