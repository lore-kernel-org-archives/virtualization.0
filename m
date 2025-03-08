Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCDF216610
	for <virtualization@lists.linux.dev>; Sat,  8 Mar 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470064; cv=none; b=qkn3Biy9EYmjml57OU/W8uOjDk9z+Jc2yii3zw7yYmIx4Gm3/J40W9YzQ7+V+SHyXHV0/sEmhf/ip3E0sQfXnLLURkK1XwdobCJE+7ou9a9M0THSy7HcnC0gr4Pjlu8oxKrKeWDdL/0Cxe/Qv/5rha8aPxn4CV0bfGcufBSuLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470064; c=relaxed/simple;
	bh=5hyZYxezWmmiBT1IswLrJGF/zzJLGbfExZqICWkHdIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xpcs7tyYINj7uc8SFFZNmqOagIgihaIDtrIUKnru9ZtQJh01MA8hCzD5bOphhBtEdTl6/GZ47b2PF4tMfVQaq4zb9vaweFeCeS5SsSazPok96XKQfGFv5O2pIn1ULjC6FzzpciRR/yIxoRWtZo71uWwQOGqxrbzCSgneOAR/bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqcqDekA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqcqDekA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso8496327a91.1
        for <virtualization@lists.linux.dev>; Sat, 08 Mar 2025 13:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741470060; x=1742074860; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Wr/uTxLJd/vHEpArrWTAzyhW/+/hW24sD4ijoGNq1A=;
        b=QqcqDekAwiY5Q7gX/hI7LMdyXsh49N6ClnP8tYdM3umebgRXBNAOToPA1v6cHqOV4p
         A3HeI4jAo5LqaD2SoLlOS8u5Y2vtMjMuCzpXNv3QB+t5tHddkCsATCFp5/9+2NHUfZ90
         lOu9+zuK1Xsyr7Pt9TIsj+kC9k7cdO6HvZvE/jBvgGBNZFl/tDblvPGoSyGUieYWmt2h
         jYM9IfQH6mAH018bcYDSGFRUNFfvZy33z6i0rAI/E3Q9Wbnfermb7fvWk/68Po8uzsdD
         Vj3eX3dJXfiCsL15oK26n4VIg+BFS+XnyUAu6G70dB97kQN5/fj7HoheztiDkHVToa5V
         DkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470060; x=1742074860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Wr/uTxLJd/vHEpArrWTAzyhW/+/hW24sD4ijoGNq1A=;
        b=q16iea7fNLwHrrfoXackjsGZGa5sc3G7UbGbrRbQwVBSWZF44bbROvLplDKGzgXbtH
         PuERDJjOMLB/CgRNlrgEI8vA/4F7WTdXqLX7kJ81MxFzKv765wcFGjQ8dGyZQc9PcCLc
         DeNZ3mgsyFldc5IGL2bC2u9gDN4RcIX2xucX1gzkUv4BvsCkWqQsNuTCCpt+dtskDR5o
         HV8RRGzjGTJHSbiVpofeTn+AKsQsmMlkyepyZbFFFR6u4Fk+isDc75uP+v/usRURgXHu
         ZyVmRf5wyeDVuRU4kyJMpARjBLo6jmj+4rg9HdFz3yEdHu+TLFoOayjTaoYXjDnBVBi9
         nNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo/D6XmD7VbywrWrkVdR1Y0PvVHPlhisD3qmbKXe1y0eaHnYHA54LZWHFcErSwBChDQqDJNowBEkYqjYtW/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw13JPP61tTFcaT9KD/jw+ntwFeVRVTQBrVAfeMpi5NAwIShil
	TTeKQ0JlxMTlVbsgknmbV0RYF2dfLXMT7lF8ZAy2EBvQo7sSdF/yy5w3TbbppmG6EOWB7+y/CVj
	kE2vCMkhlYcQ4aWaWZuUdwQ==
X-Google-Smtp-Source: AGHT+IGyjeNA1taw2RdrwgYQli42mPxkFOYVzCwbtW6YJ7SSHLfeooUxpgj7xkNuM+/XP23C+mt2BUcMUhn7WAB/+A==
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:2ea:9d23:79a0])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr12864048a91.28.1741470060429;
 Sat, 08 Mar 2025 13:41:00 -0800 (PST)
Date: Sat,  8 Mar 2025 21:40:44 +0000
In-Reply-To: <20250308214045.1160445-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308214045.1160445-9-almasrymina@google.com>
Subject: [PATCH net-next v7 8/9] net: check for driver support in netmem TX
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

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5: https://lore.kernel.org/netdev/20250227041209.2031104-8-almasrymina@google.com/
- Check that the dmabuf mappings belongs to the specific device the TX
  is being sent from (Jakub)

v4:
- New patch

---
 net/core/dev.c         | 33 +++++++++++++++++++++++++++++++++
 net/core/devmem.h      |  6 ++++++
 net/core/netdev-genl.c |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1cb134ff7327..5553947123a0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3868,10 +3868,43 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
 
+static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
+						    struct net_device *dev)
+{
+	struct skb_shared_info *shinfo;
+	struct net_iov *niov;
+
+	if (likely(skb_frags_readable(skb)))
+		goto out;
+
+	if (likely(!dev->netmem_tx))
+		goto out_free;
+
+	shinfo = skb_shinfo(skb);
+
+	if (shinfo->nr_frags > 0) {
+		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
+		if (net_is_devmem_iov(niov) &&
+		    net_devmem_iov_binding(niov)->dev != dev)
+			goto out_free;
+	}
+
+out:
+	return skb;
+
+out_free:
+	kfree_skb(skb);
+	return NULL;
+}
+
 static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	netdev_features_t features;
 
+	skb = validate_xmit_unreadable_skb(skb, dev);
+	if (unlikely(!skb))
+		goto out_null;
+
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
 	if (unlikely(!skb))
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 67168aae5e5b..919e6ed28fdc 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -229,6 +229,12 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
 {
 	return NULL;
 }
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_iov_binding(const struct net_iov *niov)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6e7cd6a5c177..6c5d62df0d65 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -972,6 +972,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

