Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E11D514F
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017367; cv=none; b=HwOFpcgppeoQWzM6C+4DFb8/nWY8alFGAjxtq42J6qXEV5MQBCcdgEE7PkutE8k50Hg4ELG19IiMBnJGMGegfeT9o+M4pWKWwy+2STdx6swBA0HFhY/T9yZchlGD8G2I0k/NnNk8xlLd5KmeqBpaMjKSRqofY9NthIiAQe/JKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017367; c=relaxed/simple;
	bh=wv/Nl/0TTuCuSzX9uge87xPhddp3iWORdXEDTuKUoaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uzaHLVuUMA8fCmgu5zCuP3eh4pc3ojvM2P0vg2dLXYi09ltOGRs3M70hDVeQdewaH0MyrJIwdqQ3McZ3KTYqmfLzRqqrJFfgOg4Ala3I1IfphURlnDVfz3DUqemWCwxWyD9L+Ka/rgvpPFIFohtnEHxQ+afJCdMLj+wajZ49X44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dT7hDd+7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dT7hDd+7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22178547841so11235635ad.1
        for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 18:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017364; x=1740622164; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q07ZPpGlxJD57O2WL3mxnzOyUUhqTVa6xALP0zRrY7w=;
        b=dT7hDd+7UZxsCI46EaF77hBFB/+BhLyQSfRVLex2DnsINoyAheLqB2oGGWk0JhEpNU
         iA02kLpoCE03e3yy5lsK9bhS1EIMLV1EtE7/GVK7Esvmy1yNiquNY2BrqHffp4G5m++Z
         eGFqvJkBJancEHeBpnHavMkinTaDbBak542iImwZjREoWPDZtCcPQUmF3NEo3h/xHamP
         j09ledemZaIJmrj75eVXvS1pemj/2TNsCd/H/xJjJezMydjEQIiwM7j3LfigZ8dxa7R4
         zpWxfT+1piKkO4Yl6W+BuPHJt4EhpX7j7Tflt06b001pUrgL3ShblJzrUUHL5fLk5LKE
         ACPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017364; x=1740622164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q07ZPpGlxJD57O2WL3mxnzOyUUhqTVa6xALP0zRrY7w=;
        b=Qw+27Az/Hbnoq6FCLrc+359fphgQba58P3+HaJUv19LrMffobcNxLk43iNlW0FRA3n
         t6uHMnxd0AOFw6WUsna8ThVI2V+5dc4aCPQ8JWKr5OTKj29Hwoednjloa3ewV7OyAvZZ
         cgdA4nhbI0oePUoWWJxDfjW7muwGsWrQd5j7Q7pC0jgod0m3Z3/5Qb/WfKiYUtMmoG8f
         EA/LM7jxy7VLkp/+lgWdMye0a3M0Tf6mQnTWTR9g3UM8M/g85VVDTLZoQL1Y4kYC3hZK
         LA3Zqoh2gm2scZMVRDlhZOgklRgo2wPlbthkwdY0jg2iV+bWi/fQrj6CGog3fwPO51G6
         wMHg==
X-Forwarded-Encrypted: i=1; AJvYcCVZxDNCSdQtRNsEc57dIa5Y1M8f1BCoZX+zsz6qYMt+O5cyuo4g5L3c6qzGcgo8upMiKGg2VqBhuBPxk+AI+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqpK6ZogD80UXc+Yln4nwKtrkFiitKzWvs91gXP4OqEzqAYucs
	Mxdupi+kGYC7KXWAkwT01OytklkydIJdT/1VIPP8ONwZqFfrSuVDkr3vKz5vWIahPd7efJwF15B
	U6Y1hF8zKJ9DNdLGZuzwUtw==
X-Google-Smtp-Source: AGHT+IGor0R9LeqETB1vktgkLfZglF28he79PoEeU9oNKftoaSUt6owPZhDmQ7APNsMa2/gZBH6jr+0UQACvRDYBbA==
X-Received: from plblq5.prod.google.com ([2002:a17:903:1445:b0:216:25a2:2ecf])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db10:b0:220:e7d8:a8a6 with SMTP id d9443c01a7336-221709892e6mr88623765ad.27.1740017364391;
 Wed, 19 Feb 2025 18:09:24 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:07 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-3-almasrymina@google.com>
Subject: [PATCH net-next v4 2/9] net: devmem: TCP tx netlink api
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
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
index 766b82005d18..aa8c289c254e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -739,6 +739,18 @@ operations:
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
index 4e82f3871473..a3ce02b55b5f 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -216,6 +216,7 @@ enum {
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
index c92fba65b20d..73420edd3f1f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -929,6 +929,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
index 4e82f3871473..a3ce02b55b5f 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -216,6 +216,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.48.1.601.g30ceb7b040-goog

