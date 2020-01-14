"""
This module implements the gomplate rule
"""

def _gomplate_impl(ctx):
    # We want the output file name to be the same as the input file name,
    # relative to the build file path.  This way the generated path is correct
    # when dealing with subsequent build steps.
    base_dir = ctx.build_file_path.rpartition("/")[0]
    relative_path = ctx.file.src.short_path.partition(base_dir + "/")[2]
    output_file = ctx.actions.declare_file(relative_path)
    ctx.actions.run(
        inputs = ctx.files.src,
        outputs = [output_file],
        tools = [ctx.executable._gomplate],
        progress_message = "Rendering templates",
        executable = ctx.executable._gomplate,
        env = {
            "DATA": struct(values = ctx.attr.data).to_json(),
        },
        arguments = [
            "--file", ctx.file.src.short_path,
            "--out", output_file.path,
            "--context", ".=env:DATA?type=application/json",
            "--left-delim", ctx.attr.left_delim,
            "--right-delim", ctx.attr.right_delim,
        ]
    )
    return [DefaultInfo(files = depset([output_file]))]

gomplate = rule(
    implementation = _gomplate_impl,
    attrs = {
        "src": attr.label(
            doc = "Template to render",
            allow_single_file  = True,
            mandatory = True,
        ),
        "data": attr.string_dict(
            default = {},
            doc = "Data to supply to the template",
        ),
        "left_delim": attr.string(
            default = "{{",
            doc = "Override starting template delimiter",
        ),
        "right_delim": attr.string(
            default = "}}",
            doc = "Override ending template delimiter",
        ),
        "_gomplate": attr.label(
            allow_single_file = True,
            cfg = "host",
            default = "@gomplate//:binary",
            executable = True,
        ),
    },
)
