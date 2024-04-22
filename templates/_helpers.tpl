{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "echoapp.fullname" -}}
{{- if .Values.appName }}
{{- .Values.appName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- default .Chart.Name }}
{{- end }}
{{- end }}

{{/*
Default Service Name.
*/}}
{{- define "echoapp.service.name" -}}
{{- default (include "echoapp.fullname" .) .Values.service.name }}
{{- end }}

{{/*
Default Service type.
*/}}
{{- define "echoapp.service.type" -}}
{{- default "LoadBalancer" .Values.service.type }}
{{- end }}

{{/*
Default Service Port.
*/}}
{{- define "echoapp.service.port" -}}
{{- default 80 .Values.service.port }}
{{- end }}

{{/*
Default Deployment name.
*/}}
{{- define "echoapp.deployment.name" -}}
{{- default (include "echoapp.fullname" .) .Values.deployment.name }}
{{- end }}

{{/*
Default Container Port.
*/}}
{{- define "echoapp.deployment.port" -}}
{{- default 8080 .Values.deployment.port }}
{{- end }}