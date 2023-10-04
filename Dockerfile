FROM alpine:3.18.3

ENV HELM_SECRETS_VERSION=4.5.0
ENV KUBECTL_VERSION=1.28.2
ENV VALS_VERSION=0.27.1
ENV SOPS_VERSION=3.7.3
ENV AVP_VERSION=1.16.1

RUN apk --no-cache add \
    curl \
    tar \
    && mkdir -p /tools/helm-plugins \
    && wget -qO- https://github.com/jkroepke/helm-secrets/releases/download/v${HELM_SECRETS_VERSION}/helm-secrets.tar.gz | tar -xz -C /tools/helm-plugins \
    && wget -qO /tools/curl https://github.com/moparisthebest/static-curl/releases/latest/download/curl-amd64 \
    && wget -qO /tools/sops https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux \
    && wget -qO /tools/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && wget -qO- https://github.com/helmfile/vals/releases/download/v${VALS_VERSION}/vals_${VALS_VERSION}_linux_amd64.tar.gz | tar -xz -C /tools/ vals \
    && cp /tools/helm-plugins/helm-secrets/scripts/wrapper/helm.sh /tools/helm \
    && curl -L https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64 -o argocd-vault-plugin \
    && cp argocd-vault-plugin /tools/argocd-vault-plugin \
    && chmod +x /tools/*
