# Localization 本土化

This is localization folder of THLoOP.
Following is the introduction of how to add a new language for THLoOP.

这是东方梦摇篮的本土化文件夹。
以下是关于如何为梦摇篮添加一个新语言的介绍。

## Steps to Add a New Language for THLoOP

## 为东方梦摇篮添加一个新语言的步骤

### Step 0

### 步骤 0

Download Visual Studio Code(VSCode), a user-friendly IDE and a powerful text editor.

After installing VSCode, right-click on the "localization" folder and select "Open with Code".

Press Ctrl+Shift+X in VSCode, search and download EmmyLua, an extension for Lua.

(You can also download language pack extension of your language for VSCode)

Even if you have not learnt Lua, this extension can tell you about the structure of code and prevent you from unintentionally delete original code.

What's more, The search function in VSCode (Ctrl+Shift+F) allows you to accurately locate and replace a specific keyword in bulk, which is a very useful feature in localization.

The preparation above is not necessary, but I strongly recommend doing so to make the following work easier.

下载Visual Studio Code（VSCode），一个易于上手的IDE，同时也是一个强大的文本编辑器。

安装完成VSCode之后，右键localization文件夹并选择“通过 Code 打开”。

在VSCode中按Ctrl+Shift+X，搜索并下载EmmyLua，一个为Lua设计的扩展。

（你也可以为VSCode下载你的语言的语言包扩展）

即使你没有学过Lua，这个扩展也可以告诉你代码的结构，防止你无意中删掉原先的代码。

VSCode的搜索功能（Ctrl+Shift+F）还可以让你准确地定位并批量替换某个关键词，这在本土化中会是一个非常有用的功能。

以上的准备工作并不是必须的，但为了使接下来的工作更加简单，我强烈推荐你这么做。

### Step 1

### 步骤 1

Create a folder named by your language.

Then copy all the files from one of other folders.

创建一个以你的语言命名的文件夹。

然后从其他文件夹中的一个复制所有文件。

### Step 2

### 步骤 2

Find "aic.l10n.lua" in "AiC" directory.

In this file, you need to call function `aic.l10n.init` with 3 arguments: formal_name(name of folder), simplified_name(write in 2 uppercase letters) and full_name(will be displayed in game).

You will also find tips in this file. It's not so hard! You just need to be careful not to delete the original code.

This is a sample:

```Lua
aic.l10n.init("zh_cn", "CH", "中文(CN)")
```

在AiC目录中找到“aic.l10n.lua”。

在这个文件中，你需要使用3个参数调用函数`aic.l10n.init`：正式名称（文件夹的名称），简化名称（使用两个大写字母）和全名（将会在游戏中显示）。

在这个文件中你也会找到提示。这并不是那么难！你只需要注意别把原本的代码删掉就行。

这是一个例子：

```Lua
aic.l10n.init("zh_cn", "CH", "中文(CN)")
```

### Step 3

### 步骤 3

Start your translation following the tips in the files.
根据文件中的提示开始你的翻译。
