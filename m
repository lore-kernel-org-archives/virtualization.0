Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D25226161
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614075; cv=none; b=V5G9DK1dhUUp8uxvLqTeggsywKdCRvNePwfb0cVMT2E85TxMgtcFNMr1LC5x9u7DjkFy0CehN1x4dCOdnjGhL/DgGN05zo0+q9LBp0LTcbysp2x6mUG4hsFje34qkWMnit05pEK9dzshpfEpIOPw4P52NNZ7Uz1mj0vVMrhBkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614075; c=relaxed/simple;
	bh=WD1GO/ru9UtTz6qymR/OHRXpuoG61TjNzFJ2EgLfrUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=afLxouP9TK/Zf5ejUhIUo3uiw4eJKayAHt7gps/j1KdVOg4aa4uulPMYmPzVJGE3OnoIG0FR401I25wo56w+jqZjjXpWy13kQ8lfVWvhmSBRVZr1criS2o9a+elMGEN4kfpaIFJBChsF29EVff70SfhT1A7pR5qN0RKSTPWGFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxPwr5VX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxPwr5VX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3086107d023so2463022a91.2
        for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745614071; x=1746218871; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GO97zaupdcKJn1NRY5NCNi+DrzKMTlWIDe9B/SH8FiI=;
        b=AxPwr5VX0A2iBDuqkwgXEEcptSrHfKjw+rA0hJelaKu+TS9wIYXVkbJ2kAqHVxAdhu
         lrH39ncozGgtQg16D2yva/yoB4V9aBc6eGI/OmDtq1NljfnAP2dSKyKqAIUrRAD62AdX
         mWACXdVCnWqa/Rh/R9Ds9HV4mymoCth4wk6nU6JFgjjf9y4BEFZmNRY0Jm6eebE3TwtJ
         TdSRYyr1YjEea/EhC/JuTz+SP9Ni1HLwn0DBvBRRGW3PrBphFqwq/2RXITQ5W4wR84yD
         exJGb7oQl1Q93xnPMVIewv6Eo1pfdMN8Y7PzaLBqNlNnem1Cr6cUpQQKZm0BsE47a25B
         XbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745614071; x=1746218871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO97zaupdcKJn1NRY5NCNi+DrzKMTlWIDe9B/SH8FiI=;
        b=XXj+xN9GtNtSRM6FJT2iScnyZwZpn0VUC0JulIOfncwlyTF1QmGjPXXEQWPZbe5vtu
         CrDP0yxOudZQ2ZkhkAZqnx3FDa2Fzh7trqFnkP+kcJa/DTLgJDpzHhcUEiqgasIdrjus
         TI/eajbJ6LRuB8Tqs+Vd0h+NhOIEO+KgiiGuOk7aeLuAFmVw1/UqQ7KnzkiuSWeANG7t
         NQNsVx/hW8zcKz3knl564gLjRfgoxMPQkrQRTQanW93V220M2kRXE9qOy/G84qt2DYl0
         /0soGsKgoJWyoAn5/+xG6F7hkH2kf8/L9cjEshX9vAJlXZu88LeYSEGcusk0fEU+20kP
         y1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOiwnYdQkAKEOiINnNyaZ8Kg12/kfIinzIO7Q1a4lesp1jpXw6IsUExzkztWpscOWAVtmYmRstZqQuXP0sBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoEfgxKeWH8ekUop1TRSFA0PcbHwmwTuIunMrTsPhzT6caeWri
	GJN1AfFcwwCOpe6G5GAX+F8B2UWcf8Ip9UZS5AXlAmgtMMsC5NLfXaVlWvbCCY8J+gEh4VADBh5
	K/9+GfuZN3OKJdJZ1awlLsg==
X-Google-Smtp-Source: AGHT+IE4tvk5Gua1sGt6hJT2U2Uyv++hSTd9BFuPFbKSdXdBg/FbDCoe2fzyjN2Gv0kxWTYxWWrtP/DG14qQhE1x6w==
X-Received: from pjzz5.prod.google.com ([2002:a17:90b:58e5:b0:2fc:2e92:6cf])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:51:b0:2f9:bcd8:da33 with SMTP id 98e67ed59e1d1-309f7e14b5bmr5732629a91.21.1745614071233;
 Fri, 25 Apr 2025 13:47:51 -0700 (PDT)
Date: Fri, 25 Apr 2025 20:47:37 +0000
In-Reply-To: <20250425204743.617260-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250425204743.617260-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425204743.617260-4-almasrymina@google.com>
Subject: [PATCH net-next v12 3/9] net: devmem: TCP tx netlink api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Stanislav Fomichev <sdf@fomichev.me>

Add bind-tx netlink call to attach dmabuf for TX; queue is not
required, only ifindex and dmabuf fd for attachment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v3:
- Fix ynl-regen.sh error (Simon).

---
 Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/netdev-genl-gen.c              | 13 +++++++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 6 files changed, 34 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f5e0750ab71db..c0ef6d0d77865 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -743,6 +743,18 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+    -
+      name: bind-tx
+      doc: Bind dmabuf to netdev for TX
+      attribute-set: dmabuf
+      do:
+        request:
+          attributes:
+            - ifindex
+            - fd
+        reply:
+          attributes:
+            - id
 
 kernel-family:
   headers: [ "net/netdev_netlink.h"]
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7600bf62dbdf0..7eb9571786b83 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 739f7b6506a6a..4fc44587f4936 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -99,6 +99,12 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPE
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
 };
 
+/* NETDEV_CMD_BIND_TX - do */
+static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -190,6 +196,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_TX,
+		.doit		= netdev_nl_bind_tx_doit,
+		.policy		= netdev_bind_tx_nl_policy,
+		.maxattr	= NETDEV_A_DMABUF_FD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 17d39fd64c948..cf3fad74511f5 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -34,6 +34,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2a1a399fc15d2..919ce851f1174 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -937,6 +937,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* stub */
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7600bf62dbdf0..7eb9571786b83 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.49.0.850.g28803427d3-goog

