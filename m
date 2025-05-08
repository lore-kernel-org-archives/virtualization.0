Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737320C012
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665330; cv=none; b=koOU6LyzypvbuxZuoTSqyQukCe8gmTF44c0W99RJfM1eLj1wpKpZKybCG3LQPrRAIAa4dGLTxS3X0mo5FQLEB+W2vtYhn6Zh3VZWYYAsyFZkYkWQ8cDtcJmG+Tt1IOK8PNg0tfFuMPZRptgYY/qLPZ8AJ71l8JZg+1CN31/aCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665330; c=relaxed/simple;
	bh=zg9Rkm5Rd/pxyMldLbCuJVxRyReKQYCARla2xRFaE4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFKBvqAp+EDl0l6YpqPtRMrbMA51HfkxuBgOks7qelg3Mr+zRP2f3aPKnspfnxheNDNOCcaqntkjJD7Ji8PJE0DKLm9ny+liMtblOVnQFerahfiNdXOIfQPoZMeFR1zvPSQqPVdR5kysbE6TPRzyEoZ4r/Sz/cXfmTkYDLEejig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxowGNyC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxowGNyC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1442e039eeso240098a12.0
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 17:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746665326; x=1747270126; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRQpiGR/r2itY1yVFt2brbtkiyu8Qr5YSZ2xQPEtLk8=;
        b=DxowGNyCjoMRB22XyLn9jreB0qIMfC4zQlWda/4rw3rS+cnqIt1gZHTL9HEjOA30De
         H8aFGNDFZPf56j8i8PGjxY/aR+GHLseJ9hOe7V1ekO7moJlV9csZFFtae5J3QkRjY1la
         7MpauJs+VZHdydlriFz8K0KtOVumz4PzSoT8hQpSkd8a0m9+NfqKpzKXxcP2exdRwHnR
         KL1yJb6f2Qz/JC7SnHb6EFXdcEHOgUXaYsVN5SpNsHyzfIjx/tf6QvETiDbP0BUIFSij
         Alq/s68KKyza6m5LVIiAaDIlWlB+BD8eL5owseJxoNCUSboezB5q3z7vy5pdJSc37Qdp
         9CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746665326; x=1747270126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRQpiGR/r2itY1yVFt2brbtkiyu8Qr5YSZ2xQPEtLk8=;
        b=uNMJUspRRDwsr7EGtTXkxC/ZbcJ+UhPJ4OYS3heWP2612cMZvCR+gNRBTKrPQrefxP
         /zPQox3xriATfCNKXpz3YAiX7e6I+/53C0hGjiF6xSpGaJJGt9wvoQ2L4zi9eo7frDhd
         NjgPRLJRnfMzicNVFB9AdUEpDJ+BB0F95SbwDDVliA3OWK/daZrzrpSN9tuojeGviBUi
         nnGwrVH6JYc5GKkg3aAdPGaiTkKyJUDCGrGNNsOSxOPFdwl8tNsIkkj3O7t4zDU9Sm8P
         xr7P2IO8wYqBiXS2Hd9pW5WnP4gNyM7aUddzJxGNJUP+FCEra9uWeCDyfBYPrfESHii3
         BnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSnZ+3TDJBmfgyRWNreT4ng427X97PbNUR3vHidt9yEEpUE2btPip1yAVUfX8a9fpDg7k+v+rNh/a7vLAfog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0S98i3S/TKu2qDm5DSsDF6e2BmnV8rciDFyiN+BO02IhlocHr
	TjvVF0YKlBGrP5bSCvopsEezvArv/bhj15Dkx6pTT+rNEay7zWHmSUxb6PfduWpd/0WlXWcfDZ8
	XwkvvyszC1UQDo8DuuPxjVw==
X-Google-Smtp-Source: AGHT+IGhjTnOjMf66q5GRLN7o3kPdXc5ugSakFVD8NvLlbxj/qj/8pIAYtJwk9yvsEzJbeqhMvo4EOvXKdcyY7FMGg==
X-Received: from pjbqc5.prod.google.com ([2002:a17:90b:2885:b0:30a:9cb5:7622])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3dcd:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-30b3a6e7b5amr2083733a91.33.1746665326146;
 Wed, 07 May 2025 17:48:46 -0700 (PDT)
Date: Thu,  8 May 2025 00:48:28 +0000
In-Reply-To: <20250508004830.4100853-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250508004830.4100853-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250508004830.4100853-9-almasrymina@google.com>
Subject: [PATCH net-next v14 8/9] net: check for driver support in netmem TX
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
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
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
index db0e9a6a4badc..119f4fbc0c944 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -982,6 +982,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
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
2.49.0.987.g0cc8ee98dc-goog

