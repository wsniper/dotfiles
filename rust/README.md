## Settings of rust dev environments
### mirror of cargo

    mkdir ~/.cargo
    cp ./config ~/.cargo/config

- [Rust 中文 Wiki - 国内镜像](https://wiki.rust-china.org/%E5%9B%BD%E5%86%85%E9%95%9C%E5%83%8F)
- [Rust Crates 镜像使用帮助](https://lug.ustc.edu.cn/wiki/mirrors/help/rust-crates)

### mirror of `rustup` and toolchains

    export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
    export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

- [Rust Toolchain 反向代理使用帮助](https://mirrors.ustc.edu.cn/help/rust-static.html)
- [rust-lang-nursery/rustup.rs: The Rust toolchain installer](https://github.com/rust-lang-nursery/rustup.rs#environment-variables)
