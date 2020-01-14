def _external_binary_impl(ctx):
    os = ctx.os.name
    if os == "mac os x":
        os = "darwin"

    url = ctx.attr.url[os].format(version = ctx.attr.version)
    args = {
        "url": url,
        "sha256": ctx.attr.sha256[os],
    }
    if any([url.endswith(suffix) for suffix in [".zip", ".tar.gz", ".tgz", ".tar.bz2", ".tar.xz"]]):
        ctx.download_and_extract(output="{name}/{name}_out".format(name = ctx.attr.name), **args)
    else:
        args["executable"] = True
        ctx.download(output="{name}/{name}".format(name = ctx.attr.name), **args)

    build_contents = """
    package(default_visibility = ["//visibility:public"])

    load("@bazel_skylib//rules:copy_file.bzl", "copy_file")

    filegroup(
        name = "{name}_filegroup",
        srcs = glob([
            "**/{name}",
            "**/{name}.exe",
        ]),
    )

    copy_file(
        name = "binary",
        src = ":{name}_filegroup",
        out = "{name}",
        is_executable = True,
    )
    """.format(name = ctx.attr.name)
    build_contents = '\n'.join([x.lstrip(' ') for x in build_contents.splitlines()])
    ctx.file("BUILD.bazel", build_contents)

_external_binary = repository_rule(
    implementation = _external_binary_impl,
    attrs = {
        "sha256": attr.string_dict(
            allow_empty = False,
            doc = "Checksum of the binaries, keyed by os name",
        ),
        "url": attr.string_dict(
            allow_empty = False,
            doc = "URL to download the binary from, keyed by platform; {version} will be replaced",
        ),
        "version": attr.string(
            doc = "Version of the binary",
            mandatory = False,
        ),
    },
)

def external_binary(name, config):
    _external_binary(
        name = name,
        sha256 = config.sha256,
        url = config.url,
        version = config.version,
    )

def _binary_location_impl(ctx):
    script = ctx.actions.declare_file(ctx.attr.name)
    contents = "echo \"$(realpath $(pwd)/{})\"".format(ctx.executable.binary.short_path)
    ctx.actions.write(script, contents, is_executable = True)
    return [DefaultInfo(
        executable = script,
        runfiles = ctx.runfiles(files = [ctx.executable.binary]),
    )]

binary_location = rule(
    implementation = _binary_location_impl,
    attrs = {
        "binary": attr.label(
            allow_single_file = True,
            cfg = "host",
            executable = True,
        ),
    },
    executable = True,
)
