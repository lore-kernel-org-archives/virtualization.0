Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86B268FFF
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377897; cv=none; b=aZLwE+Y3PVt8EaGeW9Euv4zXCTjLc3bH8PZFQ/zUTg1LP80kKp5UGXhSMwnLdPJnO3EC8yaFa+AZT6ZjeXo54lw6exl/fo68VUAYfl64DjBWL5sv8CS1mHztTeEI1EC4Bf009jd9mhgP4tWTwkZYXZTbWBnGpu1QIoqdn6cl7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377897; c=relaxed/simple;
	bh=7NgBY2/M7RX3ZWIExGTnoM9nMea+0yUh7UHHWuhJ4Bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qmTkQc+S9eyLSxRf87BsDK56U4hA4+gXGPX+6nedLgdaCgplNO0xz2SDXGb3w0x+jAhhUZxdi/mw3O3ci9Neuo5Lh9EHkqZBHfMIHf/NpVJkd8Qg8zoXK63MxqeSADt6ETYpa+6GbIrdebbBpvJp1w3Qm/kY6+lpo1I02PYyKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ux1igbdv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ux1igbdv"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so5254637a91.0
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 20:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745377895; x=1745982695; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm+KUe9Ww/e6Vyl6aeeJ+DObwsjW8ys4qGoTcP5xOok=;
        b=Ux1igbdvu2UMKRMr567kCf1rRyzbkAhjG9dgvQkXR6mh21+RXQWAo/Yjd2xC2NEwIS
         r7KRxhVrQmxVo/yai0yGbg8Bey66V2LfAAApP0Uk1M5pKA2Fr4aQ/PVcVD8WJK9FDGit
         EaK2okhofaT82deTyxcl5SC1wPv1Vl1yB0XNJ3fIrQ9kq2XX0s/yYM03lscdSJefYuXU
         HP3LmV4njRMPhxRh0n3Tj3fJyxF+kz7JbFSZM3krt2HMP2oarODUBDDHAlam5so5LDwj
         SzojnKcsr063WumqwnQuAX2dZftLgdNwCkzW3dxtQVaK+5+uZk8KPq1rid9TPGUOlVPS
         FFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745377895; x=1745982695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm+KUe9Ww/e6Vyl6aeeJ+DObwsjW8ys4qGoTcP5xOok=;
        b=fwIM4FaIHheWIB72x1zcfUPpBnAHgGwRlyCHE6EvllrD960GRp1ZPH7IrMw3djTu8h
         iNyySoB1c2W/MAHf//9sZr8MFP675o1oAN9B95umQMGhOyUiVOex5DsKT+Ut2I8KPJzz
         K68MowRjq5040RwF3fzEAkPAiiz9krdxY43PKlqx1Ce+VZCn0ARqAFmPZ/PUitzaJzMC
         W/kuujHfeGXLAZzA6t7DvsIWm/lpzpchZ+0tToIPZ2IIdZ07PMcW+pd4s2dxYiTHXWQA
         MqhagvUMn/+PihvLpPeEwIMWA/GRijRhaWTthPlnryVwASSQIAIjddfq4c3gxui15/EJ
         eBBg==
X-Forwarded-Encrypted: i=1; AJvYcCWq49EAEztLSeD5xGI3fdpiZw8IeV/LE7lzvXRCVR8Ju7zp+mEy+kE2oTZhNNpgkq1hOLr5z/Bcmrve0Zzl9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6gMTte6IGSmDYSTvc7wrhHJEPezZcBV2nIrGo7DE5WFS0DFy9
	dvPJtYuDPyzdMGYqU0ahFEQl0RbT/DL3CQCDSHjimQ4ZW2qZUHDWX65qgqOfizBYsUumsDEksyr
	0fw3u/X42q6U/AThceTlW9w==
X-Google-Smtp-Source: AGHT+IHcL6V0wyIgxVPnSh9oujNfZm6xJMeeDAKJGJjxgwUzV9Gxqtp5X/qnGnjnB3+ge4ifRPfAJCgtsn2xzhI6TA==
X-Received: from pjvv13.prod.google.com ([2002:a17:90b:588d:b0:2fc:aac:e580])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2411:b0:2f9:d9fe:e72e with SMTP id 98e67ed59e1d1-3087bb6ba95mr25794082a91.16.1745377894793;
 Tue, 22 Apr 2025 20:11:34 -0700 (PDT)
Date: Wed, 23 Apr 2025 03:11:15 +0000
In-Reply-To: <20250423031117.907681-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423031117.907681-9-almasrymina@google.com>
Subject: [PATCH net-next v10 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v8:
- Rebase on latest net-next and resolve conflict.
- Remove likely (Paolo)

v5: https://lore.kernel.org/netdev/20250227041209.2031104-8-almasrymina@google.com/
- Check that the dmabuf mappings belongs to the specific device the TX
  is being sent from (Jakub)

v4:
- New patch

---
 net/core/dev.c         | 34 ++++++++++++++++++++++++++++++++--
 net/core/devmem.h      |  6 ++++++
 net/core/netdev-genl.c |  7 +++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d1a8cad0c99c4..66f0c122de80e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3896,12 +3896,42 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
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
+	if (!dev->netmem_tx)
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
 
-	if (!skb_frags_readable(skb))
-		goto out_kfree_skb;
+	skb = validate_xmit_unreadable_skb(skb, dev);
+	if (unlikely(!skb))
+		goto out_null;
 
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 67168aae5e5b3..919e6ed28fdcd 100644
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
index 292606df834de..84c033574eb16 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -979,6 +979,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock_netdev;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.49.0.805.g082f7c87e0-goog

