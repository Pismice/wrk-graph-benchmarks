pub const packages = struct {
    pub const @"1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758";
        pub const build_zig = @import("1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758");
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"12206297df84406cd4eed306acef30eb2a1a6a18b6771ebb4920391a3a7299b2e6a7" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/12206297df84406cd4eed306acef30eb2a1a6a18b6771ebb4920391a3a7299b2e6a7";
        pub const build_zig = @import("12206297df84406cd4eed306acef30eb2a1a6a18b6771ebb4920391a3a7299b2e6a7");
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
    .{ "httpz", "12206297df84406cd4eed306acef30eb2a1a6a18b6771ebb4920391a3a7299b2e6a7" },
};
