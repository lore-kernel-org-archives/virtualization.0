Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE3283CBF
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512930; cv=none; b=s2YAmHZzAOxPMSfxBjlgePAFfuQkgZF9jl9laY5/FVUX2MCbP+yXut5MGWUsZRHI1WVeZvUOS8iwefCjawrBfjpX8K9IpvPcqdGN4ucD3gx84Bf1tqpehPFyzxYAIb/r+IAEyev5W2Qp84n6wSusiJOLEc928Qcav+hDEakdNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512930; c=relaxed/simple;
	bh=bPSZT7dVTriF4TZgmZTUAw22Sgou+Fmk1o1FCPOSVME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxWjtGj/eldov03e6tGc5BZkb/x0kzYT+OS96DozEbkAeMF1bpiqi24kpcSwHe5ITqUmw6qwUc9cC0LsluQllYV/Z5VUmi/pfGGujvVnENMUC9KnAbiBdyck+ShuKCy5wYnPiIxBISH56l4Ml7AV/PXuaT3jXZVmifAjngU+z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dV9lipRc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV9lipRc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4988e039so28342725ad.1
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512929; x=1774117729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KgmmudIxXUanwK3aFbv0ip54pwkZrkMg6RJuyR+qxA=;
        b=dV9lipRcjbXRPW1RmU43Hrs7orWSEfqoYhEcmAcEChH5SmJAUVUnkIqxoTW77uxC/T
         IfETUefYHPjnmfyJQ+/2vfIqo8mxb1RaEcAP8+oxvb6bjNdN4Og8s/MlCLKkbeipZGRX
         5YaoxNnLcu7SjKpMpcRDuuEZ8CqUVJff0RLKso17R9gXDs6nLoOkLlWO78E84V90f0jz
         8dwi1tM1hdYlVKF4AVJ2QxVgs0e4pqjGH8ATPoArBftDjPZwEa3SZEBXBfvFTfOD44Fh
         9ynrYJhVBSpEAiI3dZ+LmTDOwH4gASCNKZ8mZetmlTDBEKKrwy4TxqEEINZrJ4hk/tgZ
         WKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512929; x=1774117729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KgmmudIxXUanwK3aFbv0ip54pwkZrkMg6RJuyR+qxA=;
        b=bJTpRG1VQ22K3Tb/h9tbU8A0MLTsW/bJXWHt/2wwrdma6uuch0gFeSq1jD0P96ML6C
         nFO581TBZcE08aB7QBPCjLUPIhNa6NZINQT8k3WEwuRT7EQjyKxYKK1wQujDqd5ZBlG7
         H4HhzgQoe2OOAmDC7TtsncTUTOHyDuChFZMZ6kuaoFpjExhkMOAayQVocXtlzYA6yZzR
         zKoS+mWMPrJpiQSFiT8ilMgb+vcvODpf94xIMN2VNVLq0goSv0AjiTs7g7dYRCirrgLj
         KCJwqdCaQl6kPO+QIbXIGfORU2dmrWiUenlDXyITyo/T/5nvLGwm4DRy10LmIadeTvFM
         QczA==
X-Forwarded-Encrypted: i=1; AJvYcCVNBYdwlVhdPqJ/VLS/rlEv0Lu5b8PV2JT2TCVBk977dbMVRAjikpaUdcVepLtREskztNqPkPsa3vmn/KofsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCcI57raJQK+an/TPMnpJ2o7IEaco2QGOH2Vvn2272JCg/zGsf
	ULhpTrD7PN+iHEdazCwXT5CjdvvWxopk0pWwFpO/9vFIlk9cCJS0Ffe9
X-Gm-Gg: ATEYQzyvgIyCsCPPHfekma70z/GT9wjld+WEDIw3dh3EbEsJ8IBlqkk+bnX3PjUNVyi
	66Px3FRNtnjZ28QJTFNbCTk9xnmkvoZGFxVRt0IYKvlyI4V37xd2M8QDIk/mphzBnp+08iTLxJK
	UHsSkHzDpwdDBsK8PQ9/WFyEA12HZMvYZO7lYt/C41RuIzJrl9wD+w/5ZximGEi83cEIBd3m/el
	vHWeeNe83K/pmjcljSzrn12ofRpG9Z07Exd5zbdJevpbupqeHa/ODJILLfYU+Fuk/SHwsGVN1cy
	RyKysW8ZRR4uJMUUOOrD8O67rDNei7OhVVD6raoLc8xaKDwA/IcF5++8ofHl2pPQcN9t8f+/Ci1
	dlQ0TKa6xx06PCAd7WuMq54pSaTj2I83Ru7U0hR5r3I4AiHV+Q0KovNR8z49MA6bKwfb24wqcR4
	h3WrI/pkR+9+F86dBtiFNfFIlVVKSbfMQA81Ps01JyXLwkQTXa6SR3JXYpHdJHAZi4pB2BgVvXn
	f9Pzw==
X-Received: by 2002:a17:902:ea09:b0:2b0:4cbe:fbea with SMTP id d9443c01a7336-2b04cbf0114mr7880195ad.25.1773512928560;
        Sat, 14 Mar 2026 11:28:48 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:28:47 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: stfomichev@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	mst@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v9 1/7] net: core: Add state tracking for async netdev ops
Date: Sat, 14 Mar 2026 23:58:03 +0530
Message-ID: <20260314182809.362808-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Async netdev ops are tricky because of the following problems:

1) Freeing the context associated with async netdev ops might require
   waiting for completion of the associated work which might require the
   rtnl lock or the instance lock. However this will deadlock in
   __dev_close_many as the cleanup is done with those locks already held.

2) We need a way to enable/disable async netdev ops depending on the PM
   state to allow/prevent hardware access as appropriate.

We solve these problems by introducing a state variable to track
the current state of netdev. This can take the following values:
- ACTIVE (up and normal operation)
- DOWN (down)
- INACTIVE (in suspend/shutdown)

To solve 1, we set the state to down in __dev_close_many. In the
associated op handler, we check for the current state and return if
the netdev is down.

To solve 2, the commit introduces the following functions:
- netif_enable_async_ops  -> sets state to ACTIVE
- netif_disable_async_ops -> sets state to INACTIVE and cancels any
			     pending work as required.

The op implementation can use the state information to do the required
processing.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 include/linux/netdevice.h | 29 ++++++++++++++
 net/core/dev.c            | 84 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae269a2e7f4d..6d426dc66af9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,6 +1062,16 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+enum netif_async_state {
+	NETIF_ASYNC_ACTIVE,
+	NETIF_ASYNC_DOWN,
+	NETIF_ASYNC_INACTIVE
+};
+
+struct netif_async_ctx {
+	enum netif_async_state state;
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -2027,6 +2037,8 @@ enum netdev_reg_state {
  *	@sfp_bus:	attached &struct sfp_bus structure.
  *
  *	@qdisc_tx_busylock: lockdep class annotating Qdisc->busylock spinlock
+ *	@async_ctx	  : Context required for async ops
+ *	@needs_async_ctx  : Does dev need async op context?
  *
  *	@proto_down:	protocol port state information can be sent to the
  *			switch driver and used to set the phys state of the
@@ -2454,6 +2466,8 @@ struct net_device {
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
+	struct netif_async_ctx  *async_ctx;
+	bool			needs_async_ctx;
 	bool			proto_down;
 	bool			irq_affinity_auto;
 	bool			rx_cpu_rmap_auto;
@@ -3376,6 +3390,21 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
 
+void netif_disable_async_ops(struct net_device *dev);
+void netif_enable_async_ops(struct net_device *dev);
+
+static inline void netif_set_async_state(struct net_device *dev,
+					 enum netif_async_state state)
+{
+	dev->async_ctx->state = state;
+}
+
+static inline enum netif_async_state
+netif_get_async_state(struct net_device *dev)
+{
+	return dev->async_ctx->state;
+}
+
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 200d44883fc1..b1797bd28a6b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1664,6 +1664,33 @@ static int napi_kthread_create(struct napi_struct *n)
 	return err;
 }
 
+static int __netif_alloc_async_ctx(struct net_device *dev)
+{
+	dev->async_ctx = kzalloc_obj(*dev->async_ctx);
+	if (!dev->async_ctx)
+		return -ENOMEM;
+
+	netif_set_async_state(dev, NETIF_ASYNC_ACTIVE);
+	return 0;
+}
+
+static int netif_alloc_async_ctx(struct net_device *dev)
+{
+	int ret;
+
+	ret = __netif_alloc_async_ctx(dev);
+	return ret;
+}
+
+static void netif_free_async_ctx(struct net_device *dev)
+{
+	if (!dev->async_ctx)
+		return;
+
+	kfree(dev->async_ctx);
+	dev->async_ctx = NULL;
+}
+
 static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -1698,14 +1725,18 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
 
+	if (!ret && dev->needs_async_ctx)
+		ret = netif_alloc_async_ctx(dev);
+
 	if (!ret && ops->ndo_open)
 		ret = ops->ndo_open(dev);
 
 	netpoll_poll_enable(dev);
 
-	if (ret)
+	if (ret) {
 		clear_bit(__LINK_STATE_START, &dev->state);
-	else {
+		netif_free_async_ctx(dev);
+	} else {
 		netif_set_up(dev, true);
 		dev_set_rx_mode(dev);
 		dev_activate(dev);
@@ -1772,6 +1803,11 @@ static void __dev_close_many(struct list_head *head)
 
 		netdev_ops_assert_locked(dev);
 
+		if (dev->needs_async_ctx) {
+			netif_set_async_state(dev, NETIF_ASYNC_DOWN);
+			netif_free_async_ctx(dev);
+		}
+
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
@@ -1821,6 +1857,50 @@ void netif_close(struct net_device *dev)
 }
 EXPORT_SYMBOL(netif_close);
 
+/* netif_disable_async_ops - disable execution of async NDOs.
+ *
+ * To be used in cases of the device shutting down, suspending or
+ * failing to resume.
+ *
+ * Should be called in the shutdown callback and in the PM suspend
+ * callbacks: @suspend(), @freeze(), @poweroff() and in the error
+ * path of PM resume callbacks.
+ */
+void netif_disable_async_ops(struct net_device *dev)
+{
+	netdev_lock_ops_compat(dev);
+
+	if (!dev->needs_async_ctx || !netif_running(dev)) {
+		netdev_unlock_ops_compat(dev);
+		return;
+	}
+
+	netif_set_async_state(dev, NETIF_ASYNC_INACTIVE);
+	netdev_unlock_ops_compat(dev);
+}
+EXPORT_SYMBOL(netif_disable_async_ops);
+
+/* netif_enable_async_ops - enable execution of async NDOs.
+ *
+ * To be used when the device attempts to resume or fails to suspend.
+ *
+ * Should be called in the PM resume callbacks: @resume(), @thaw(),
+ * @restore() and in the error path of PM suspend callbacks.
+ */
+void netif_enable_async_ops(struct net_device *dev)
+{
+	netdev_lock_ops_compat(dev);
+
+	if (!dev->needs_async_ctx || !netif_running(dev)) {
+		netdev_unlock_ops_compat(dev);
+		return;
+	}
+
+	netif_set_async_state(dev, NETIF_ASYNC_ACTIVE);
+	netdev_unlock_ops_compat(dev);
+}
+EXPORT_SYMBOL(netif_enable_async_ops);
+
 void netif_disable_lro(struct net_device *dev)
 {
 	struct net_device *lower_dev;
-- 
2.47.3

