workspace(name = "kubecf")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("//rules/external_binary:def.bzl", "external_binary")
load(":def.bzl", "project")

[external_binary(name = name, config = config) for name, config in project.external_binaries.items()]

[http_archive(
    name = name,
    sha256 = config.sha256,
    urls = [u.format(version = config.version) for u in config.urls],
    strip_prefix = getattr(config, "strip_prefix", "").format(version = config.version),
) for name, config in project.bazel_libs.items()]

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")
container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")
container_deps()

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")
go_rules_dependencies()
go_register_toolchains()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
gazelle_dependencies()

load("@io_bazel_rules_docker//go:image.bzl", _go_image_repos = "repositories")
_go_image_repos()

load("@rules_python//python:pip.bzl", "pip_repositories", "pip3_import")

pip_repositories()

pip3_import(
    name = "yamllint",
    requirements = "//dev/linters/yamllint:requirements.txt",
)

load("@yamllint//:requirements.bzl", "pip_install")

pip_install()

http_archive(
    name = "cf_deployment",
    build_file_content = """
package(default_visibility = ["//visibility:public"])
files = [
    "cf-deployment.yml",
    "operations/bits-service/use-bits-service.yml",
]
filegroup(
    name = "cf_deployment",
    srcs = files,
)
exports_files(files)
""",
    sha256 = project.cf_deployment.sha256,
    strip_prefix = "cf-deployment-{}".format(project.cf_deployment.version),
    url = "https://github.com/cloudfoundry/cf-deployment/archive/v{}.tar.gz".format(project.cf_deployment.version),
)

http_file(
    name = "cf_operator",
    sha256 = project.cf_operator.chart.sha256,
    urls = [project.cf_operator.chart.url],
)

http_file(
    name = "local_path_provisioner",
    sha256 = project.local_path_provisioner.sha256,
    urls = [project.local_path_provisioner.url],
)

http_file(
    name = "kube_dashboard",
    sha256 = project.kube_dashboard.sha256,
    urls = [project.kube_dashboard.url],
)

http_archive(
    name = "com_github_kubernetes_incubator_metrics_server",
    build_file_content = """
package(default_visibility = ["//visibility:public"])
filegroup(
    name = "deploy",
    srcs = glob(["deploy/1.8+/**/*"]),
)
""",
    sha256 = project.metrics_server.sha256,
    strip_prefix = "metrics-server-{}".format(project.metrics_server.version),
    url = "https://github.com/kubernetes-incubator/metrics-server/archive/v{}.tar.gz".format(project.metrics_server.version),
)

http_file(
    name = "mysql_chart",
    sha256 = project.mysql_chart.sha256,
    urls = ["https://kubernetes-charts.storage.googleapis.com/mysql-{}.tgz".format(project.mysql_chart.version)],
)
