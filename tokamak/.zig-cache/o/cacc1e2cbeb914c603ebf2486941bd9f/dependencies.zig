pub const packages = struct {
    pub const @"122011721d5937350cc301e655455cfa21dc25c203930fdb24207a7e9c21e7268a1b" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/122011721d5937350cc301e655455cfa21dc25c203930fdb24207a7e9c21e7268a1b";
        pub const build_zig = @import("122011721d5937350cc301e655455cfa21dc25c203930fdb24207a7e9c21e7268a1b");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "httpz", "122089946af5ba1cdfae3f515f0fa1c96327f42a462515fbcecc719fe94fab38d9b8" },
        };
    };
    pub const @"1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758";
        pub const build_zig = @import("1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758");
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e";
        pub const build_zig = @import("12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"122089946af5ba1cdfae3f515f0fa1c96327f42a462515fbcecc719fe94fab38d9b8" = struct {
        pub const build_root = "/home/tetratrux/.cache/zig/p/122089946af5ba1cdfae3f515f0fa1c96327f42a462515fbcecc719fe94fab38d9b8";
        pub const build_zig = @import("122089946af5ba1cdfae3f515f0fa1c96327f42a462515fbcecc719fe94fab38d9b8");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "metrics", "1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758" },
            .{ "websocket", "12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e" },
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "tokamak", "122011721d5937350cc301e655455cfa21dc25c203930fdb24207a7e9c21e7268a1b" },
};
