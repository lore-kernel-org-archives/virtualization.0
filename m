Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27A2135A8
	for <virtualization@lists.linux.dev>; Sat,  8 Mar 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470054; cv=none; b=B2zf3Zeo3DkWA0XeJEPz4k7xtXQZe3ayORYC5zp14nB0+mqX07/Tlb4VRiaKgQwMdsszOvHLiTV7u8VUprD888Iur7ACSwxtKVawBC4vAKOqEaWvIkk4jOBkeEBZj5VOstXy4ksgdZyxTYpf43UQdIRCKP0wgyNbO8USq1ZR970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470054; c=relaxed/simple;
	bh=GgKXq6iE0gzrYkfJCs/+4j6Jqrx0/CCwuPwPGpNWSe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hIJuuZtIpD7J71k9xwo+tMJKQL8jDA6qXPdMqXmIEcc/vZaeTtuAbtJzyTyEZkIJctSSPmNA40LxD4VxrRTvDmAL/wzL7XFU0jZeJYPOrFzDL/eJrH51XNeAusOHc490qJPLEKXdrao1W1T33bXba64SCeN1a22vMWUKBl8HClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NaNXqsEb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaNXqsEb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224347aef79so35192325ad.2
        for <virtualization@lists.linux.dev>; Sat, 08 Mar 2025 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741470052; x=1742074852; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVSp6KkQQ3nBS0Irfd9WWWqAtqD5umJDSeIajOkZRLA=;
        b=NaNXqsEbiviDEujdSD78sQgdKs/Jtaj6RUPuWp2QgBai8q4LQND1WsdOmH/+8j6KtH
         EsirHKrzD7zQya2wsajU22T/VZl4tV1a18Or4D5/rDqSec3HWUhBP0vI+DATmlpkEYKq
         fzJSojA7mdsfI+vzceN5yrvO13IhgdRjliMYKUWcuO7831BBTd57yyo7S9wbQ6Kf+6FH
         gX+1zkF+aRu32n2ZgFCR3WZcUA40nfywQXpfEMD7czzSzZrayabZMWg/vYKbvf8TTIlY
         BV0VjwS0UxlZHrZ9JGr5nH2Ltms6BYZVfmosH8BJf2O5A1vv2E6fXSQS49RlKzos/mB0
         +erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470052; x=1742074852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVSp6KkQQ3nBS0Irfd9WWWqAtqD5umJDSeIajOkZRLA=;
        b=qwd4x+PbDZHZd1guAc/4uHlInXvSSQegJmGRB5Vpl96YqpcH+riFqGUZMEXWqswP7/
         +k+gZdQ+2Z/f5PjLy9oclKvLm0QnB9SgFunK+stttIMoeFBwyEx5Bi3X7bWi/00CWQqv
         L/g6s0c1Ro9mCaMl4Mycd7TcpjtV2C0YoaBdj5qgB2k8kJk9+fWZkFaVHCYWx7NxJdmC
         Sfq5MIT41qi8j1dh8W5c43Q1z5kT0v1eMZbLltH3afKUJVrS5MZ5dGUNuWICJuqA5fce
         INNu8DSUO5ewdsVMq+EMf8urRTBhfd6taMoJDd551wFd+ngjSV7Uoes9yv7exZUmwnG0
         dnRg==
X-Forwarded-Encrypted: i=1; AJvYcCVWHYn2RJE2jz3+y7xgx3QQvAHVzNVk1/9Sh3tjTd9wltsTNsj8/xPb3sc+2se1ZXcxQ0BL8tCmYJDpKBGoBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhkLhpqPKQmiRY3CUtfZ9/SQpKga6xGSCnpqK8Bli+B8YxUx0p
	Dbm/TWMFlYfm7y6VQp385d+w9R+kfzB9H40GNdZFkMm10PiSImfzhmsDuieoLjsH++X6PRXuMAx
	bkbRuoKTEa4scs5aUDG3f3g==
X-Google-Smtp-Source: AGHT+IEJxGXdpquM70KYwrulbd57ZH/XyG67NkpllY5yK/S0TKLlEOlhc3K4p6RYqVYqjeOM/HYNoBDPLGSNEiADOw==
X-Received: from plbml14.prod.google.com ([2002:a17:903:34ce:b0:223:6c8e:eaf1])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce8a:b0:220:faa2:c911 with SMTP id d9443c01a7336-2242888a696mr143314875ad.14.1741470052036;
 Sat, 08 Mar 2025 13:40:52 -0800 (PST)
Date: Sat,  8 Mar 2025 21:40:39 +0000
In-Reply-To: <20250308214045.1160445-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308214045.1160445-4-almasrymina@google.com>
Subject: [PATCH net-next v7 3/9] net: devmem: TCP tx netlink api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
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
index 36f1152bfac3..e560b05eb528 100644
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
   headers: [ "linux/list.h"]
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7600bf62dbdf..7eb9571786b8 100644
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
index 996ac6a449eb..f27608d6301c 100644
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
index e09dd7539ff2..c1fed66e92b9 100644
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
index 2b774183d31c..6e5f2de4d947 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -931,6 +931,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* stub */
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 void netdev_nl_sock_priv_init(struct list_head *priv)
 {
 	INIT_LIST_HEAD(priv);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7600bf62dbdf..7eb9571786b8 100644
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
2.49.0.rc0.332.g42c0ae87b1-goog

