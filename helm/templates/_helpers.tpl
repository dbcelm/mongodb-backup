{{/*
Expand the name of the chart.
*/}}
{{- define "helm-template.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm-template.fullname" -}}
{{- $name := default .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm-template.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helm-template.labels" -}}
helm.sh/chart: {{ include "helm-template.chart" . }}
{{ include "helm-template.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
k8s/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
k8s/managed-by: {{ .Release.Service }}
k8s/name: {{ include "helm-template.name" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helm-template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm-template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}