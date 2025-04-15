Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D72D29B5
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757293; cv=none; b=DBKMCaB6W0E5JfOC/V3P241cEZXfSlgUUKGIi0ZW8F8ctz/KmOV78Rv1smmhoMIpuKOJrUsM+UbhKmywjTkjHpGEVXUehecIedQqBMFdMm/M1HobO/ytBQOBJy7+ASfGNW1oCebzpfwdeF8JxlmD8aYkxI3qFPuXmU/KQS7VuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757293; c=relaxed/simple;
	bh=Viz88h4zEJRYftyYyJ62jZ+LAglqsn/DohKIyPH06Pk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pwNpklfa9dcipppC1tS/bAeJW2v2PvW7bp7eaMtxUvc5Hdx/ppSaujgEzT+cJmQ1POV2gRJEbURADrB3ZL8vEl2wTj0xcdkcxNfKnlOi+BDPmgPHqp614cK3LkyZ1j9gP0t3XuOMBlSHkKSX86NkQ11Q+hFxRWXHuaXahxFcae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xn0/g5oy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xn0/g5oy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso9123389a91.0
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 15:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744757290; x=1745362090; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ9hB+alXHD1d6Ke9vNVXo3tJI/1t2sQ+bdR4rE6Q5g=;
        b=Xn0/g5oyvYTezZGzSVLM7E9Jkygn+h535M1DXH2sRvCEG5y1ms7Jj5f+WYTePvFD2W
         9XsII5YsmmBGsD1HN1UfWhaUyhWTSt+sKm+kuXEMcYaztaC4JnE2ugJPERc5CCgGYPBS
         dGvEEkkLE2CczBlm9+kI4Qo3ruTIUKnr4lgxQgDWXgo+AmI6d/DIut2SLkcD7nUwJ6kJ
         horMD016ld73HwkG1VSnDJqnFWzCBuf/IASzgPkRoCARh1MOpvymc23notNuC0R964EL
         BG24bO/0moQ4iLzMR7czkgb3Avp8Av2rP0pWB+E1GG+ajp0Stg7WPp8xfHELW/EymoEL
         FM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757290; x=1745362090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ9hB+alXHD1d6Ke9vNVXo3tJI/1t2sQ+bdR4rE6Q5g=;
        b=JzcUGkCvVmDqXisMLTRz/22u25d3MYBgBPgFEf1osre/3EjBIGGbdjnv/7MHQHFV+8
         P9sq0slUTxHKoKkroA0Pw00NP//NZL1fA61CSNG5uJnC/HOV1vfEg7YuudJwOn7Jj8dN
         w7r8RFoM6iJtMfS8jC1RBsuMORGu15H3bFZEkfsjgtqk9jktZopRRB++4rHe/yPxRNJb
         gXV34Wcwvxcu7Py3yYXE4PEk60IGd/0J0R0dq8zYg/38K5mrGjqNMU9s3+TWiHUZl9Hi
         iiM+tcOtlNm/3grFyvTHs2rfXpZozvo42HM1wsfqXWf4TBdqaGpzeDLqMKAZe9UD6bDD
         NsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3t+psQnB0t0kdBDarsa2qxeXoyLF0qcvU7K7gxqyoYaoNwsM+d3monhn+aCVdPqlKuMLhyg0ydmMmS5R7DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKnJBQzzddIcWjLGtSl2rJ9IbIyRfBLsGf7U2deCR2DoFniRGK
	zrUu8pGvT/uQgD8bhlX9GTcyU3kSfO3/0dHnbu/NQtzv6JqzD3Mjnf3axSNvuNJM7Uf2GPCAdLJ
	EraRX6ziYFtE8hwksS5mpsg==
X-Google-Smtp-Source: AGHT+IFQKABJXAJLy4yWiWL0Q5/0eudNOIc8vvLgficgkZYgaud9o5UY5XSmsk51FTTmaHMTwXYtudTOkXnI3SzGsQ==
X-Received: from pjbdb11.prod.google.com ([2002:a17:90a:d64b:b0:2ef:d136:17fc])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3cd0:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-3085eeb4945mr1177487a91.13.1744757290348;
 Tue, 15 Apr 2025 15:48:10 -0700 (PDT)
Date: Tue, 15 Apr 2025 22:47:55 +0000
In-Reply-To: <20250415224756.152002-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250415224756.152002-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250415224756.152002-8-almasrymina@google.com>
Subject: [PATCH net-next v8 8/9] net: check for driver support in netmem TX
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
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
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
index 03d20a98f8b7..2f1aa802c819 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3894,12 +3894,42 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
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
index 56502923f885..08a90660ed83 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -973,6 +973,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
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
2.49.0.777.g153de2bbd5-goog

