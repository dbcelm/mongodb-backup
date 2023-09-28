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
k8s.zsservices/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
k8s.zsservices/managed-by: {{ .Release.Service }}
k8s.zsservices/name: {{ include "helm-template.name" . }}
k8s.zsservices/component: {{ .Values.codes.tier }}
k8s.zsservices/tenant: {{ .Values.codes.tenant_code }}
k8s.zsservices/aws-account: {{ .Values.codes.account_id }}
k8s.zsservices/environment: {{ .Values.codes.environment }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helm-template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm-template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Metadata name base first part
*/}}
{{- define "_metaNameBaseFirst" -}}
{{ .Values.codes.cloud_code }}-k8s-{{ .Values.codes.account_id }}-{{ .Values.codes.env_short }}
{{- end }}

{{/*
Metadata name base last part
*/}}
{{- define "_metaNameBaseLast" -}}
{{ .Values.codes.tenant_code }}-{{ .Values.codes.app_code }}
{{- end }}

{{/*
Service metadata name base
*/}}
{{- define "helm-template.serviceMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-svc-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Deployment metadata name base
*/}}
{{- define "helm-template.deploymentMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-dep-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
HPA metadata name base
*/}}
{{- define "helm-template.hpaMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-hpa-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Ingress metadata name base
*/}}
{{- define "helm-template.ingressMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-ing-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Cronjob metadata name base
*/}}
{{- define "helm-template.cronjobMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-crn-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Statefulset metadata name base
*/}}
{{- define "helm-template.statefulsetMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-sta-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Daemonset metadata name base
*/}}
{{- define "helm-template.daemonsetMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-dae-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Configmap metadata name base
*/}}
{{- define "helm-template.configmapMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-cng-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Secret metadata name base
*/}}
{{- define "helm-template.secretMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-sec-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Persistent Volume metadata name base
*/}}
{{- define "helm-template.persistentvolumeMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-prv-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Persistent Volume Claim metadata name base
*/}}
{{- define "helm-template.persistentvolumeclaimMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-pvc-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Storage class metadata name base
*/}}
{{- define "helm-template.storageclassMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-stc-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Service Account metadata name base
*/}}
{{- define "helm-template.serviceaccountMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-sva-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Role metadata name base
*/}}
{{- define "helm-template.roleMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-rol-{{ include "_metaNameBaseLast" .}}
{{- end }}

{{/*
Role Binding metadata name base
*/}}
{{- define "helm-template.rolebindingMetaNameBase" -}}
{{ include "_metaNameBaseFirst" .}}-rlb-{{ include "_metaNameBaseLast" .}}
{{- end }}