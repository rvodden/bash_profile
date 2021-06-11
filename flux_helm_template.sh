_flux-helm() {
  local path_to_flux_generated_yaml="$1"; shift
  local yq_filter="$1"; shift
  local tmp_helm_values_file="/tmp/helm_values.yaml"
  echo "Using Flux _generated YAML file \"$path_to_flux_generated_yaml\""
  yq -ye $yq_filter  <"$path_to_flux_generated_yaml" >"$tmp_helm_values_file"
  echo helm "$@" -f values.yaml -f "$tmp_helm_values_file"
  helm $@ -f values.yaml -f "$tmp_helm_values_file"
}
_flux-helm-template() {
  _flux-helm "$1" "$2" template -nfoo .
}
_flux-helm-diff-upgrade() {
  _flux-helm "$1" "$2" diff upgrade $(yq -r .name <Chart.yaml) .
}
# The functions below take a generated YAML file as an arg
flux-helm-template() {
  local flux_generated_values_path=$1
  _flux-helm-template "$flux_generated_values_path" .spec.values
}
flux-helm-template-subchart() {
  local flux_generated_values_path=$1
  _flux-helm-template "$flux_generated_values_path" .spec.values.$(yq .name <Chart.yaml)
}
flux-helm-diff-upgrade() {
  local flux_generated_values_path=$1
  _flux-helm-diff-upgrade "$flux_generated_values_path" .spec.values
}
flux-helm-diff-upgrade-subchart() {
  local flux_generated_values_path=$1
  _flux-helm-diff-upgrade "$flux_generated_values_path" .spec.values.$(yq .name <Chart.yaml)
}
