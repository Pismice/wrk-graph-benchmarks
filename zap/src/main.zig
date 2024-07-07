const std = @import("std");
const zap = @import("zap");

fn on_request(r: zap.Request) void {
    r.sendBody("Hello") catch return;
}

pub fn main() !void {
    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = on_request,
        .log = false,
    });
    try listener.listen();

    // start worker threads
    zap.start(.{
        .threads = 4,
        .workers = 4, // user map cannot be shared among multiple worker processes
    });
}
