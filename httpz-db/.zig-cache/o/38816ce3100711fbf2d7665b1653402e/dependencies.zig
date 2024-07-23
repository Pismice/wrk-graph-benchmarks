pub const packages = struct {
    pub const @"122019ea6e071dbd932c3e51d9631d99f007240e3e08d5436a1da20ad088343ca4a7" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/122019ea6e071dbd932c3e51d9631d99f007240e3e08d5436a1da20ad088343ca4a7";
        pub const build_zig = @import("122019ea6e071dbd932c3e51d9631d99f007240e3e08d5436a1da20ad088343ca4a7");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758";
        pub const build_zig = @import("1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758");
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"122034afde1b4ff5971787929d1a4a8ef175e1c18fe0cf4ffc1af1ce0c95c7b6be7b" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/122034afde1b4ff5971787929d1a4a8ef175e1c18fe0cf4ffc1af1ce0c95c7b6be7b";
        pub const build_zig = @import("122034afde1b4ff5971787929d1a4a8ef175e1c18fe0cf4ffc1af1ce0c95c7b6be7b");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "metrics", "1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758" },
            .{ "websocket", "12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e" },
        };
    };
    pub const @"12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e";
        pub const build_zig = @import("12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "httpz", "122034afde1b4ff5971787929d1a4a8ef175e1c18fe0cf4ffc1af1ce0c95c7b6be7b" },
    .{ "sqlite", "122019ea6e071dbd932c3e51d9631d99f007240e3e08d5436a1da20ad088343ca4a7" },
};
