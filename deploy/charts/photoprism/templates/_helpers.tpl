{{/*
Expand the name of the chart.
*/}}
{{- define "photoprism.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "photoprism.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "photoprism.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Secret
*/}}
{{- define "photoprism.secret" -}}
{{- default .Chart.Name .Values.secretNameOverride  | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "photoprism.labels" -}}
helm.sh/chart: {{ include "photoprism.chart" . }}
{{ include "photoprism.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "photoprism.selectorLabels" -}}
app.kubernetes.io/name: {{ include "photoprism.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Env from
*/}}
{{- define "photoprism.envFrom" -}}
envFrom:
  {{ $fullName := include "photoprism.fullname" . }}
  - configMapRef:
      name: {{ $fullName }}-environment
  - configMapRef:
      name: {{ $fullName }}-storage
  {{ with .Values.secretRef }}
  - secretRef:
      {{ toYaml . }}
  {{ end }}
{{- end }}

{{/*
Env
*/}}
{{- define "photoprism.env" -}}
{{ with .Values.database.dsnSecretKeyRef }}
env:
  - name: PHOTOPRISM_DATABASE_DSN
    valueFrom:
      secretKeyRef:
        name: {{ .name }}
        key: {{ .key }}
{{ end }}
{{- end }}

{{/*
Volumes
*/}}
{{- define "photoprism.volumes" -}}
{{ if and .Values.persistence.enabled .Values.persistence.volumes }}
{{ toYaml .Values.persistence.volumes }}
{{ else if eq .Values.persistence.enabled false }}
- name: originals
  emptyDir: {}
- name: import
  emptyDir: {}
- name: storage
  emptyDir: {}
{{ end }}
{{- end }}

{{/*
Volume mounts
*/}}
{{- define "photoprism.volumeMounts" -}}
{{ if and .Values.persistence.enabled .Values.persistence.volumes }}
{{ toYaml .Values.persistence.volumeMounts }}
{{ end }}
{{- end }}

