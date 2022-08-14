function __fish_helmfile_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = "helmfile" ]
        return 0
    end
    return 1
end

function __fish_helmfile_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

function __fish_helmfile_help_topics
    for c in deps repos charts diff template write-values lint fetch sync apply status delete destroy test build list cache version
        printf "%s\thelp topic\n" $c
    end
end

# help

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a help -s h -d "Shows a list of commands or help for one command"
complete -f -c helmfile -n "__fish_helmfile_using_command help" -a "(__fish_helmfile_help_topics)"

# deps

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a deps -d "update charts based on their requirements"
complete -f -c helmfile -n "__fish_helmfile_needs_command deps" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command deps" -l skip-repos -d "skip running \"helm repo update\" before running \"helm dependency build\""

# repos

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a repos -d "sync repositories from state file (helm repo add && helm repo update)"
complete -f -c helmfile -n "__fish_helmfile_needs_command repos" -l args -d "pass args to helm exec"

# charts

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a charts -d "DEPRECATED: sync releases from state file (helm upgrade --install)"
complete -f -c helmfile -n "__fish_helmfile_needs_command charts" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command charts" -l set -d "additional values to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command charts" -l values -d "additional value files to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command charts" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"

# diff

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a diff -d "diff releases from state file against env (helm diff)"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l set -d "additional values to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l values -d "additional value files to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l detailed-exitcode -d "return a non-zero exit code when there are changes"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l include-tests -d "enable the diffing of the helm test hooks"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l skip-needs -d "do not automatically include releases from the target release's \"needs\" when --selector/-l flag is provided. Does nothing when when --selector/-l flag is not provided. Defaults to true when --include-needs or --include-transitive-needs is not provided"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l include-needs -d "automatically include releases from the target release's \"needs\" when --selector/-l flag is provided. Does nothing when when --selector/-l flag is not provided"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l skip-diff-on-install -d "Skips running helm-diff on releases being newly installed on this apply. Useful when the release manifests are too huge to be reviewed, or it's too time-consuming to diff at all"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l suppress -d "suppress specified Kubernetes objects in the output. Can be provided multiple times. For example: --suppress KeycloakClient --suppress VaultSecret"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l suppress-secrets -d "suppress secrets in the output. highly recommended to specify on CI/CD use-cases"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l show-secrets -d "do not redact secret values in the output. should be used for debug purpose only"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l validate -d "validate your manifests against the Kubernetes cluster you are currently pointing at. Note that this requiers access to a Kubernetes cluster to obtain information necessary for validating, like the list of available API versions"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l context -d "output NUM lines of context around changes (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command diff" -l output -d "output format for diff plugin"

# template

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a template -d "template releases from state file against env (helm template)"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l args -d "pass args to helm template"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l set -d "additional values to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l values -d "additional value files to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l output-dir -d "output directory to pass to helm template (helm template --output-dir)"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l output-dir-template -d "go text template for generating the output directory. Default: {{ .OutputDir }}/{{ .State.BaseName }}-{{ .State.AbsPathSHA1 }}-{{ .Release.Name}}"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l concurrency -d "maximum number of concurrent downloads of release charts (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l validate -d "validate your manifests against the Kubernetes cluster you are currently pointing at. Note that this requiers access to a Kubernetes cluster to obtain information necessary for validating, like the list of available API versions"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l include-crds -d "include CRDs in the templated output"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l skip-tests -d "skip tests from templated output"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l include-needs -d "automatically include releases from the target release's \"needs\" when --selector/-l flag is provided. Does nothing when when --selector/-l flag is not provided"
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l include-transitive-needs -d "like --include-needs, but also includes transitive needs (needs of needs). Does nothing when when --selector/-l flag is not provided. Overrides exclusions of other selectors and conditions."
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""
complete -f -c helmfile -n "__fish_helmfile_needs_command template" -l skip-cleanup -d "Stop cleaning up temporary values generated by helmfile and helm-secrets. Useful for debugging. Don't use in production for security"

# write-values

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a write-values -d "write values files for releases. Similar to `helmfile template`, write values files instead of manifests."
complete -f -c helmfile -n "__fish_helmfile_needs_command write-values" -l set -d "additional values to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command write-values" -l values -d "additional value files to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command write-values" -l output-file-template -d "go text template for generating the output file. Default: {{ .State.BaseName }}-{{ .State.AbsPathSHA1 }}/{{ .Release.Name}}.yaml"
complete -f -c helmfile -n "__fish_helmfile_needs_command write-values" -l concurrency -d "aximum number of concurrent downloads of release charts (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command write-values" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""

# lint

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a lint -d "lint charts from state file (helm lint)"
complete -f -c helmfile -n "__fish_helmfile_needs_command lint" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command lint" -l set -d "additional values to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command lint" -l values -d "additional value files to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command lint" -l concurrency -d "maximum number of concurrent downloads of release charts (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command lint" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""

# fetch

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a fetch -d "fetch charts from state file"
complete -f -c helmfile -n "__fish_helmfile_needs_command fetch" -l concurrency -d "maximum number of concurrent downloads of release charts (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command fetch" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""
complete -f -c helmfile -n "__fish_helmfile_needs_command fetch" -l output-dir -d "directory to store charts (default: temporary directory which is deleted when the command terminates)"

# sync

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a sync -d "sync all resources from state file (repos, releases and chart deps)"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l set -d "additional values to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l values -d "additional value files to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l skip-crds -d "if set, no CRDs will be installed on sync. By default, CRDs are installed if not already present"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l skip-needs -d "do not automatically include releases from the target release's \"needs\" when --selector/-l flag is provided. Does nothing when when --selector/-l flag is not provided. Defaults to true when --include-needs or --include-transitive-needs is not provided"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l include-needs -d "automatically include releases from the target release's \"needs\" when --selector/-l flag is provided. Does nothing when when --selector/-l flag is not provided"
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l include-transitive-needs -d "like --include-needs, but also includes transitive needs (needs of needs). Does nothing when when --selector/-l flag is not provided. Overrides exclusions of other selectors and conditions."
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l wait -d "Override helmDefaults.wait setting \"helm upgrade --install --wait\""
complete -f -c helmfile -n "__fish_helmfile_needs_command sync" -l wait-for-jobs -d "Override helmDefaults.waitForJobs setting \"helm upgrade --install --wait-for-jobs\""

# apply

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a apply -d "apply all resources from state file only when there are changes"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l set -d "additional values to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l values -d "additional value files to be merged into the command"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l validate -d "validate your manifests against the Kubernetes cluster you are currently pointing at. Note that this requiers access to a Kubernetes cluster to obtain information necessary for validating, like the list of available API versions"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l context -d "output NUM lines of context around changes (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l output -d "output format for diff plugin"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l detailed-exitcode -d "return a non-zero exit code 2 instead of 0 when there were changes detected AND the changes are synced successfully"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l retain-values-files -d "DEPRECATED: Use skip-cleanup instead"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l skip-cleanup -d "Stop cleaning up temporary values generated by helmfile and helm-secrets. Useful for debugging. Don't use in production for security"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l skip-crds -d "if set, no CRDs will be installed on sync. By default, CRDs are installed if not already present"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l skip-needs -d " do not automatically include releases from the target release's \"needs\" when --selector/-l flag is provided. Does nothing when when --selector/-l flag is not provided. Defaults to true when --include-needs or --include-transitive-needs is not provided"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l include-needs -d "automatically include releases from the target release's \"needs\" when --selector/-l flag is provided. Does nothing when when --selector/-l flag is not provided"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l include-transitive-needs -d "like --include-needs, but also includes transitive needs (needs of needs). Does nothing when when --selector/-l flag is not provided. Overrides exclusions of other selectors and conditions."
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l skip-diff-on-install -d "Skips running helm-diff on releases being newly installed on this apply. Useful when the release manifests are too huge to be reviewed, or it's too time-consuming to diff at all"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l include-tests -d "enable the diffing of the helm test hooks"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l suppress -d "suppress specified Kubernetes objects in the diff output. Can be provided multiple times. For example: --suppress KeycloakClient --suppress VaultSecret"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l suppress-secrets -d "suppress secrets in the diff output. highly recommended to specify on CI/CD use-cases"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l show-secrets -d "do not redact secret values in the diff output. should be used for debug purpose only"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l suppress-diff -d "suppress diff in the output. Usable in new installs"
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l wait -d "Override helmDefaults.wait setting \"helm upgrade --install --wait\""
complete -f -c helmfile -n "__fish_helmfile_needs_command apply" -l wait-for-jobs -d "Override helmDefaults.waitForJobs setting \"helm upgrade --install --wait-for-jobs\""

# status

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a status -d "retrieve status of releases in state file"
complete -f -c helmfile -n "__fish_helmfile_needs_command status" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command status" -l args -d "pass args to helm exec"

# delete

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a delete -d "DEPRECATED: delete releases from state file (helm delete)"
complete -f -c helmfile -n "__fish_helmfile_needs_command delete" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command delete" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command delete" -l purge -d "purge releases i.e. free release names and histories"
complete -f -c helmfile -n "__fish_helmfile_needs_command delete" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""

# destroy

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a destroy -d "deletes and then purges releases"
complete -f -c helmfile -n "__fish_helmfile_needs_command destroy" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command destroy" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command destroy" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""

# test

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a test -d "test releases from state file (helm test)"
complete -f -c helmfile -n "__fish_helmfile_needs_command test" -l cleanup -d "delete test pods upon completion"
complete -f -c helmfile -n "__fish_helmfile_needs_command test" -l logs -d "Dump the logs from test pods (this runs after all tests are complete, but before any cleanup)"
complete -f -c helmfile -n "__fish_helmfile_needs_command test" -l args -d "pass args to helm exec"
complete -f -c helmfile -n "__fish_helmfile_needs_command test" -l timeout -d "maximum time for tests to run before being considered failed (default: 300"
complete -f -c helmfile -n "__fish_helmfile_needs_command test" -l concurrency -d "maximum number of concurrent helm processes to run, 0 is unlimited (default: 0)"
complete -f -c helmfile -n "__fish_helmfile_needs_command test" -l skip-deps -d "skip running \"helm repo update\" and \"helm dependency build\""

# build

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a build -d "output compiled helmfile state(s) as YAML"
complete -f -c helmfile -n "__fish_helmfile_needs_command build" -l embed-values -d "Read all the values files for every release and embed into the output helmfile.yaml"

# list

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a list -d "list releases defined in state file"
complete -f -c helmfile -n "__fish_helmfile_needs_command list" -l output -d "output releases list as a json string"
complete -f -c helmfile -n "__fish_helmfile_needs_command list" -l keep-temp-dir -d "Keep temporary directory"

# cache

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a cache -d "cache management"

# version

complete -f -c helmfile -n "__fish_helmfile_needs_command" -a version -d "Show the version for Helmfile."

# Global Options

complete -f -c helmfile -n "__fish_helmfile_needs_command" -l helm-binary -s b -d "path to helm binary (default: "helm")"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l file -s f -d "load config from file or directory. defaults to helmfile.yaml or `helmfile.d`(means `helmfile.d/*.yaml`) in this preference"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l environment -s e -d "specify the environment name. defaults to \"default\""
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l state-values-set -d "set state values on the command line (can specify multiple or separate values with commas: key1=val1,key2=val2)"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l state-values-file -d "specify state values in a YAML file"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l quiet -s q -d "Silence output. Equivalent to log-level warn"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l kube-context -d "Set kubectl context. Uses current context by default"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l debug -s c -d "Enable verbose output for Helm and set log-level to debug, this disables --quiet/-q effect"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l no-color -d "Output without color"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l log-level -d "Set log level, default info"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l namespace -s n -d "Set namespace. Uses the namespace set in the context by default, and is available in templates as {{ .Namespace }}"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l chart -s c -d "Set chart. Uses the chart set in release by default, and is available in template as {{ .Chart }}"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l selector -s l -d "Only run using the releases that match labels. Labels can take the form of foo=bar or foo!=bar.
                                           A release must match all labels in a group in order to be used. Multiple groups can be specified at once.
                                           --selector tier=frontend,tier!=proxy --selector tier=backend. Will match all frontend, non-proxy releases AND all backend releases.
                                           The name of a release can be used as a label. --selector name=myrelease"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l allow-no-matching-release -d "Do not exit with an error code if the provided selector has no matching releases."
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l interactive -s i -d "Request confirmation before attempting to modify clusters"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l help -s h -d "show help"
complete -f -c helmfile -n "__fish_helmfile_needs_command" -l version -s v -d "print the version"
