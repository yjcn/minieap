MiniEAP
=======

这是一个实现了 EAP-MD5-Challenge 的 EAP 客户端，支持通过插件来修改按标准生成的 EAP 数据包以通过特殊客户端的认证。目前带有一个支持锐捷 v3 (v4) 算法的插件。本插件的认证算法来自 [Hu Yunrui 的 MentoHUST 项目](https://github.com/hyrathb/mentohust)，在此表示感谢！

## 特性

#### 通用特性

* 模块化设计，需要编译哪些模块可在 `Makefile` 中直观选择。如需添加模块，直接复制一份现有的 `minieap.mk` 并按需修改即可。
* 网络帧收发由插件完成，可根据平台差异使用不同的插件。目前提供 `libpcap` 和 Raw Socket 两种实现插件。前者兼容性好但体积大，后者不需额外动态库但只能在 Linux 上使用。可选其中之一编译，也可全部编译，但运行时只能选取其中之一来使用。
* 数据包修改同样由插件完成，但可以启用多个插件，也可将一个插件启用多次，便于适配各种不同的认证环境。程序会让标准 EAP 算法生成的数据包按照命令行中 `--module` 参数的顺序让数据包流经这些插件。目前提供一个锐捷 v3 认证算法插件和一个打印流经的数据包大小的示例插件。
* 所有数据包生成逻辑均采用结构体对缓冲区进行读写，拒绝 magic number 从我做起！

#### 锐捷插件特性

* 认证算法来自 [Hu Yunrui 的 MentoHUST 项目](https://github.com/hyrathb/mentohust)
* 相比原本的 MentoHUST v3 (v4) 实现，能够支持更多的字段，更容易通过验证。
* 二次认证时，支持修改数据包头部、在常规字段以外的 IP 地址、网关、DNS 等信息，更容易通过验证。
* 所有字段都通过收集来的信息直接构造而成，不采用修改数据包模板的方式，避免各场景下偏移量不同导致的认证失败或数据包无法解析问题。
* 所有字段生成逻辑均采用结构体对缓冲区进行读写，拒绝 magic number 从我做起 x2！
* 字段中所用到的常量都有宏定义来注明其含义，定长字段的长度也通过宏定义声明，拒绝 magic number 从我做起 x3！
* 支持通过命令行来附加新的字段，也可覆盖内置字段。可以在不修改代码的情况下进行适配。
* 整体程序的内存占用比 MentoHUST 小约 78% （在 256 MB 内存的 ARMv7 平台上测试）.

## 编译

1. 编辑 `config.mk`，选择所需要的模块。在以 `if_impl` 开头的模块中，Linux 环境建议只选择 `if_impl_sockraw` 模块，其他平台建议只选择 `if_impl_libpcap` 模块并用 `COMMON_LDFLAGS` 和 `COMMON_CFLAGS` 指定 `libpcap` 的头文件及链接库位置。以 `packet_plugin` 开头的模块中请按需要选择。其他模块一般不需要改变。
2. 本程序需要使用 `getifaddrs`。如果您的平台没有提供此函数，可自行寻找需要的实现，并在 `include/` 中添加 `ifaddrs.h`，在 `util/ifaddrs/` 目录中添加必要的 C 文件，最后在 `config.mk` 中选中 `ifaddrs` 模块即可。
3. 如果服务器消息乱码，可将 `config.mk` 中的 `ENABLE_ICONV` 置为 1. 若平台未提供iconv相关函数，可在 `COMMON_CFLAGS` 中添加 `-I/path/to/your/libiconv-1.14/include`，在 `LIBS` 中添加 `/path/to/your/libiconv.a` （预先编译）。也可使用动态链接，即在 `COMMON_LDFLAGS` 中添加 `-liconv -L/path/to/libiconv/lib/`。
4. 执行 `make` 即可在根目录下编译出可执行文件。

注：如需要交叉编译，可自行增加一行 `CC := /path/to/your/cross/compiler/xxx-yyy-zzz-gcc`

## 运行

具体选项请参阅 `minieap -h` 的输出。这里列出必需的几个选项。

* -u 用户名
* -p 密码
* -n 网卡名

默认的网络帧收发模块是 `if_impl_sockraw`。如果要使用其他模块，如 `libpcap`，则必须指定 `--if-impl libpcap`。

默认不使用任何数据包修改器，将只会发送单纯的标准 EAP 数据包。**如需使用锐捷认证，则必须指定 `--module rjv3`。**可以指定多个 `--module` 参数，程序会按参数的顺序让数据包流经这些插件。

参数格式支持如下几种：

* -u myname
* -umyname
* --username myname

示例：在 en0 上使用锐捷认证，以 `libpcap` 作为网络帧收发模块，并且在数据包流经锐捷认证插件前后都打印出数据包的大小：

```
minieap -u 201000000 -p 15000000000 -n en0 --module printer --module rjv3 --module printer --if-impl libpcap
```

## 注意事项

本项目刚成立不久，虽然有过测试，但无法保证高可靠性。欢迎大家提出意见，谢谢！

非常感谢 HustMoon 工作室以及 Hu Yunrui 同学对这个领域做出的贡献！
