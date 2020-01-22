load("@bazel_gazelle//:deps.bzl", "go_repository")

# Regenerate this file with:
# bazel run //:gazelle -- update-repos \
#   -to_macro rules/gazelle.bzl%gazelle_generated_repositories \
#   -from_file=deploy/containers/credhub_setup/go.mod

def gazelle_generated_repositories():
    """
    Declare the repositories of the golang dependencies.

    This should be generated via gazelle.
    """
    go_repository(
        name = "org_cloudfoundry_code_cli",
        importpath = "code.cloudfoundry.org/cli",
        replace = "github.com/mook-as/cf-cli",
        sum = "h1:BKqHzIyz5dR6U6jIXNOUWkJsMo1gl0AnM30/TpWS+zQ=",
        version = "v7.0.0-beta.28.0.20200120190804-b91c115fae48+incompatible",
    )
    go_repository(
        name = "com_github_apoydence_eachers",
        importpath = "github.com/apoydence/eachers",
        sum = "h1:afT88tB6u9JCKQZVAAaa9ICz/uGn5Uw9ekn6P22mYKM=",
        version = "v0.0.0-20181020210610-23942921fe77",
    )
    go_repository(
        name = "com_github_blang_semver",
        importpath = "github.com/blang/semver",
        sum = "h1:cQNTCjp13qL8KC3Nbxr/y2Bqb63oX6wdnnjpJbkM4JQ=",
        version = "v3.5.1+incompatible",
    )
    go_repository(
        name = "com_github_bmatcuk_doublestar",
        importpath = "github.com/bmatcuk/doublestar",
        sum = "h1:oC24CykoSAB8zd7XgruHo33E0cHJf/WhQA/7BeXj+x0=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_bmizerany_pat",
        importpath = "github.com/bmizerany/pat",
        sum = "h1:y4B3+GPxKlrigF1ha5FFErxK+sr6sWxQovRMzwMhejo=",
        version = "v0.0.0-20170815010413-6226ea591a40",
    )
    go_repository(
        name = "com_github_charlievieth_fs",
        importpath = "github.com/charlievieth/fs",
        sum = "h1:vTlpHKxJqykyKdW9bkrDJNWeKNuSIAJ0TP/K4lRsz/Q=",
        version = "v0.0.0-20170613215519-7dc373669fa1",
    )
    go_repository(
        name = "com_github_cloudfoundry_bosh_cli",
        importpath = "github.com/cloudfoundry/bosh-cli",
        sum = "h1:+0uaMFZgpA3+iwBzXwK79/dNaMaCQ9cTKeqeOObuMA8=",
        version = "v6.2.0+incompatible",
    )
    go_repository(
        name = "com_github_cloudfoundry_bosh_utils",
        importpath = "github.com/cloudfoundry/bosh-utils",
        sum = "h1:t5dnSPAMpesD29cA+zCzPCms3O97k49+t2OyghKd18c=",
        version = "v0.0.0-20200118100159-9dc014273348",
    )
    go_repository(
        name = "com_github_cloudfoundry_noaa",
        importpath = "github.com/cloudfoundry/noaa",
        sum = "h1:hr6VnM5VlYRN3YD+NmAedQLW8686sUMknOSe0mFS2vo=",
        version = "v2.1.0+incompatible",
    )
    go_repository(
        name = "com_github_cloudfoundry_sonde_go",
        importpath = "github.com/cloudfoundry/sonde-go",
        sum = "h1:cWfya7mo/zbnwYVio6eWGsFJHqYw4/k/uhwIJ1eqRPI=",
        version = "v0.0.0-20171206171820-b33733203bb4",
    )
    go_repository(
        name = "com_github_codegangsta_negroni",
        importpath = "github.com/codegangsta/negroni",
        sum = "h1:+aYywywx4bnKXWvoWtRfJ91vC59NbEhEY03sZjQhbVY=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_cppforlife_go_patch",
        importpath = "github.com/cppforlife/go-patch",
        sum = "h1:Y14MnCQjDlbw7WXT4k+u6DPAA9XnygN4BfrSpI/19RU=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_cyphar_filepath_securejoin",
        importpath = "github.com/cyphar/filepath-securejoin",
        sum = "h1:jCwT2GTP+PY5nBz3c/YL5PAIbusElVrPujOBSCj8xRg=",
        version = "v0.2.2",
    )
    go_repository(
        name = "com_github_davecgh_go_spew",
        importpath = "github.com/davecgh/go-spew",
        sum = "h1:vj9j/u1bqnvCEfJOwUhtlOARqs3+rkHYY13jYWTU97c=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_elazarl_goproxy",
        importpath = "github.com/elazarl/goproxy",
        sum = "h1:pEtiCjIXx3RvGjlUJuCNxNOw0MNblyR9Wi+vJGBFh+8=",
        version = "v0.0.0-20191011121108-aa519ddbe484",
    )
    go_repository(
        name = "com_github_elazarl_goproxy_ext",
        importpath = "github.com/elazarl/goproxy/ext",
        sum = "h1:aBgSK7SOjFeL1wfzfbIb/pkPpfRr6EP7b1Af4o/xkpU=",
        version = "v0.0.0-20191011121108-aa519ddbe484",
    )
    go_repository(
        name = "com_github_fatih_color",
        importpath = "github.com/fatih/color",
        sum = "h1:8xPHl4/q1VyqGIPif1F+1V3Y3lSmrq01EabUW3CoW5s=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_github_fsnotify_fsnotify",
        importpath = "github.com/fsnotify/fsnotify",
        sum = "h1:IXs+QLmnXW2CcXuY+8Mzv/fWEsPGWxqefPtCP5CnV9I=",
        version = "v1.4.7",
    )
    go_repository(
        name = "com_github_gogo_protobuf",
        importpath = "github.com/gogo/protobuf",
        sum = "h1:DqDEcV5aeaTmdFBePNpYsp3FlcVH/2ISVVM9Qf8PSls=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_golang_protobuf",
        importpath = "github.com/golang/protobuf",
        sum = "h1:6nsPYzhq5kReh6QImI3k5qWzO4PEbvbIW2cwSfR/6xs=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_google_go_querystring",
        importpath = "github.com/google/go-querystring",
        sum = "h1:Xkwi/a1rcvNg1PPYe5vI8GbeBY/jrVuDX5ASuANWTrk=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_gorilla_websocket",
        importpath = "github.com/gorilla/websocket",
        sum = "h1:q7AeDBpnBk8AogcD4DSag/Ukw/KV+YhzLj2bP5HvKCM=",
        version = "v1.4.1",
    )
    go_repository(
        name = "com_github_hpcloud_tail",
        importpath = "github.com/hpcloud/tail",
        sum = "h1:nfCOvKYfkgYP8hkirhJocXT2+zOD8yUNjXaWfTlyFKI=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_jessevdk_go_flags",
        importpath = "github.com/jessevdk/go-flags",
        sum = "h1:k9/LaykApavRKKlaWkunBd48Um+vMxnUNNsIjS7OJn8=",
        version = "v0.0.0-20170926144705-f88afde2fa19",
    )
    go_repository(
        name = "com_github_kisielk_errcheck",
        importpath = "github.com/kisielk/errcheck",
        sum = "h1:reN85Pxc5larApoH1keMBiu2GWtPqXQ1nc9gx+jOU+E=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_kisielk_gotool",
        importpath = "github.com/kisielk/gotool",
        sum = "h1:AV2c/EiW3KqPNT9ZKl07ehoAGi4C5/01Cfbblndcapg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_konsorten_go_windows_terminal_sequences",
        importpath = "github.com/konsorten/go-windows-terminal-sequences",
        sum = "h1:mweAR1A6xJ3oS2pRaGiHgQ4OO8tzTaLawm8vnODuwDk=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_kr_pretty",
        importpath = "github.com/kr/pretty",
        sum = "h1:L/CwN0zerZDmRFUapSPitk6f+Q3+0za1rQkzVuMiMFI=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_kr_pty",
        importpath = "github.com/kr/pty",
        sum = "h1:VkoXIwSboBpnk99O/KFauAEILuNHv5DVFKZMBN/gUgw=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_kr_text",
        importpath = "github.com/kr/text",
        sum = "h1:45sCR5RtlFHMR4UwH9sdQ5TC8v0qDQCHnXt+kaKSTVE=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_lunixbochs_vtclean",
        importpath = "github.com/lunixbochs/vtclean",
        sum = "h1:xu2sLAri4lGiovBDQKxl5mrXyESr3gUr5m5SM5+LVb8=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_mailru_easyjson",
        importpath = "github.com/mailru/easyjson",
        sum = "h1:aizVhC/NAAcKWb+5QsU1iNOZb4Yws5UO2I+aIprQITM=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_github_mattn_go_colorable",
        importpath = "github.com/mattn/go-colorable",
        sum = "h1:snbPLB8fVfU9iwbbo30TPtbLRzwWu6aJS6Xh4eaaviA=",
        version = "v0.1.4",
    )
    go_repository(
        name = "com_github_mattn_go_isatty",
        importpath = "github.com/mattn/go-isatty",
        sum = "h1:FxPOTFNqGkuDUGi3H/qkUbQO4ZiBa2brKq5r0l8TGeM=",
        version = "v0.0.11",
    )
    go_repository(
        name = "com_github_mattn_go_runewidth",
        importpath = "github.com/mattn/go-runewidth",
        sum = "h1:3tS41NlGYSmhhe/8fhGRzc+z3AYCw1Fe1WAyLuujKs0=",
        version = "v0.0.8",
    )
    go_repository(
        name = "com_github_nu7hatch_gouuid",
        importpath = "github.com/nu7hatch/gouuid",
        sum = "h1:VhgPp6v9qf9Agr/56bj7Y/xa04UccTW04VP0Qed4vnQ=",
        version = "v0.0.0-20131221200532-179d4d0c4d8d",
    )
    go_repository(
        name = "com_github_onsi_ginkgo",
        importpath = "github.com/onsi/ginkgo",
        sum = "h1:JAKSXpt1YjtLA7YpPiqO9ss6sNXEsPfSGdwN0UHqzrw=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_github_onsi_gomega",
        importpath = "github.com/onsi/gomega",
        sum = "h1:C5Dqfs/LeauYDX0jJXIe2SWmwCbGzx9yF8C8xy3Lh34=",
        version = "v1.8.1",
    )
    go_repository(
        name = "com_github_pkg_errors",
        importpath = "github.com/pkg/errors",
        sum = "h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_pmezard_go_difflib",
        importpath = "github.com/pmezard/go-difflib",
        sum = "h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_poy_eachers",
        importpath = "github.com/poy/eachers",
        sum = "h1:SNdqPRvRsVmYR0gKqFvrUKhFizPJ6yDiGQ++VAJIoDg=",
        version = "v0.0.0-20181020210610-23942921fe77",
    )
    go_repository(
        name = "com_github_rogpeppe_go_charset",
        importpath = "github.com/rogpeppe/go-charset",
        sum = "h1:BN/Nyn2nWMoqGRA7G7paDNDqTXE30mXGqzzybrfo05w=",
        version = "v0.0.0-20180617210344-2471d30d28b4",
    )
    go_repository(
        name = "com_github_sermodigital_jose",
        importpath = "github.com/SermoDigital/jose",
        sum = "h1:koK7z0nSsRiRiBWwa+E714Puh+DO+ZRdIyAXiXzL+lg=",
        version = "v0.9.2-0.20161205224733-f6df55f235c2",
    )
    go_repository(
        name = "com_github_sirupsen_logrus",
        importpath = "github.com/sirupsen/logrus",
        sum = "h1:SPIRibHv4MatM3XXNO2BJeFLZwZ2LvZgfQ5+UNI2im4=",
        version = "v1.4.2",
    )
    go_repository(
        name = "com_github_stretchr_objx",
        importpath = "github.com/stretchr/objx",
        sum = "h1:2vfRuCMp5sSVIDSqO8oNnWJq7mPa6KVP3iPIwFBuy8A=",
        version = "v0.1.1",
    )
    go_repository(
        name = "com_github_stretchr_testify",
        importpath = "github.com/stretchr/testify",
        sum = "h1:bSDNvY7ZPG5RlJ8otE/7V6gMiyenm9RtJ7IUVIAoJ1w=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_tedsuo_rata",
        importpath = "github.com/tedsuo/rata",
        sum = "h1:Sf9aZrYy6ElSTncjnGkyC2yuVvz5YJetBIUKJ4CmeKE=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_unrolled_secure",
        importpath = "github.com/unrolled/secure",
        sum = "h1:03qGAfIibsJ118NFxcJ+Km5zb4vjFoqbuAs3ENiC9rM=",
        version = "v0.0.0-20180416205222-a1cf62cc2159",
    )
    go_repository(
        name = "com_github_vito_go_interact",
        importpath = "github.com/vito/go-interact",
        sum = "h1:niLW3NjGoMWOayoR6iQ8AxWVM1Q4rR8VGZ1mt6uK3BM=",
        version = "v1.0.0",
    )
    go_repository(
        name = "in_gopkg_check_v1",
        importpath = "gopkg.in/check.v1",
        sum = "h1:qIbj1fsPNlZgppZ+VLlY7N33q108Sa+fhmuc+sWQYwY=",
        version = "v1.0.0-20180628173108-788fd7840127",
    )
    go_repository(
        name = "in_gopkg_cheggaaa_pb_v1",
        importpath = "gopkg.in/cheggaaa/pb.v1",
        sum = "h1:n1tBJnnK2r7g9OW2btFH91V92STTUevLXYFb8gy9EMk=",
        version = "v1.0.28",
    )
    go_repository(
        name = "in_gopkg_fsnotify_v1",
        importpath = "gopkg.in/fsnotify.v1",
        sum = "h1:xOHLXZwVvI9hhs+cLKq5+I5onOuwQLhQwiu63xxlHs4=",
        version = "v1.4.7",
    )
    go_repository(
        name = "in_gopkg_tomb_v1",
        importpath = "gopkg.in/tomb.v1",
        sum = "h1:uRGJdciOHaEIrze2W8Q3AKkepLTh2hOroT7a+7czfdQ=",
        version = "v1.0.0-20141024135613-dd632973f1e7",
    )
    go_repository(
        name = "in_gopkg_yaml_v2",
        importpath = "gopkg.in/yaml.v2",
        sum = "h1:VUgggvou5XRW9mHwD/yXxIYSMtY0zoKQf/v226p2nyo=",
        version = "v2.2.7",
    )
    go_repository(
        name = "org_cloudfoundry_code_bytefmt",
        importpath = "code.cloudfoundry.org/bytefmt",
        sum = "h1:2RuXx1+tSNWRjxhY0Bx52kjV2odJQ0a6MTbfTPhGAkg=",
        version = "v0.0.0-20190819182555-854d396b647c",
    )
    go_repository(
        name = "org_cloudfoundry_code_cli_plugin_repo",
        importpath = "code.cloudfoundry.org/cli-plugin-repo",
        sum = "h1:GxYOjVoB4MuNKzPGWqLJoJr8+DmMqWNS9QScckOfaVw=",
        version = "v0.0.0-20200109233838-92d011d9fc57",
    )
    go_repository(
        name = "org_cloudfoundry_code_gofileutils",
        importpath = "code.cloudfoundry.org/gofileutils",
        sum = "h1:UrKzEwTgeiff9vxdrfdqxibzpWjxLnuXDI5m6z3GJAk=",
        version = "v0.0.0-20170111115228-4d0c80011a0f",
    )
    go_repository(
        name = "org_cloudfoundry_code_ykk",
        importpath = "code.cloudfoundry.org/ykk",
        sum = "h1:M+zXqtXJqcsmpL76aU0tdl1ho23eYa4axYoM4gD62UA=",
        version = "v0.0.0-20170424192843-e4df4ce2fd4d",
    )
    go_repository(
        name = "org_golang_x_crypto",
        importpath = "golang.org/x/crypto",
        sum = "h1:Jh8cai0fqIK+f6nG0UgPW5wFk8wmiMhM3AyciDBdtQg=",
        version = "v0.0.0-20200117160349-530e935923ad",
    )
    go_repository(
        name = "org_golang_x_net",
        importpath = "golang.org/x/net",
        sum = "h1:F+8P+gmewFQYRk6JoLQLwjBCTu3mcIURZfNkVweuRKA=",
        version = "v0.0.0-20200114155413-6afb5195e5aa",
    )
    go_repository(
        name = "org_golang_x_sync",
        importpath = "golang.org/x/sync",
        sum = "h1:YUO/7uOKsKeq9UokNS62b8FYywz3ker1l1vDZRCRefw=",
        version = "v0.0.0-20181221193216-37e7f081c4d4",
    )
    go_repository(
        name = "org_golang_x_sys",
        importpath = "golang.org/x/sys",
        sum = "h1:YyJpGZS1sBuBCzLAR1VEpK193GlqGZbnPFnPV/5Rsb4=",
        version = "v0.0.0-20191026070338-33540a1f6037",
    )
    go_repository(
        name = "org_golang_x_text",
        importpath = "golang.org/x/text",
        sum = "h1:tW2bmiBqwgJj/UpqtC8EpXEZVYOwU0yG4iWbprSVAcs=",
        version = "v0.3.2",
    )
    go_repository(
        name = "org_golang_x_tools",
        importpath = "golang.org/x/tools",
        sum = "h1:NIou6eNFigscvKJmsbyez16S2cIS6idossORlFtSt2E=",
        version = "v0.0.0-20181030221726-6c7e314b6563",
    )
    go_repository(
        name = "org_golang_x_xerrors",
        importpath = "golang.org/x/xerrors",
        sum = "h1:9zdDQZ7Thm29KFXgAX/+yaf3eVbP7djjWp/dXAppNCc=",
        version = "v0.0.0-20190717185122-a985d3407aa7",
    )
    go_repository(
        name = "com_google_cloud_go",
        importpath = "cloud.google.com/go",
        sum = "h1:eOI3/cP2VTU6uZLDYAoic+eyzzB9YyGmJ7eIjl8rOPg=",
        version = "v0.34.0",
    )
    go_repository(
        name = "org_golang_google_appengine",
        importpath = "google.golang.org/appengine",
        sum = "h1:/wp5JvzpHIxhs/dumFmF7BXTf3Z+dd4uXta4kVyO508=",
        version = "v1.4.0",
    )
    go_repository(
        name = "org_golang_x_oauth2",
        importpath = "golang.org/x/oauth2",
        sum = "h1:TzXSXBo42m9gQenoE3b9BGiEpg5IG2JkU5FkPIawgtw=",
        version = "v0.0.0-20200107190931-bf48bf16ab8d",
    )
