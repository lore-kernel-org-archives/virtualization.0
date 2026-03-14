Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBE334C28
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512941; cv=none; b=QRRSzPXrEL6kvJQlO7NHviWlqqVbmV2fLjqcfr342OXf5Q5YJe1uNUOIIxdiy1+pKV+/irs8xIIIxferneptecHRhembI95F7qV5ZYVsSqy44LTAmdOO65fTpC59PZeSw0EuDzbY/oOMLA15YtpK5uZN+/j4TxL/Re6tZ+iPDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512941; c=relaxed/simple;
	bh=e0azMONBUhPqODHGElI9gDKQUWDLTjuAbw7z9MqCdJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFd8wKM9TSEaXot5VUysyJyGbIwlH2g+Onnkg2j60nMXrov0AwcLKBsjk+ZS9/CkvCuKRxRH1/TcfpqMVYUlDwUTWgD8X5xwZ4ConBdj+g1qTUyQnp7JH7lzNZ0DRmGzVAjEUTHCaXrkqRhvv3FAuLAwCui/jyHWp7H+tjFDpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InZ/kt9q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InZ/kt9q"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b048527825so2246715ad.3
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512939; x=1774117739; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTvcRjBg7RZQjPVbwsm/XKOCF/7oOgDehhwAe6xkRiI=;
        b=InZ/kt9q/imXkDfBFlSFsu2ihDR0LObebvDGmclUR2/1yAV0EdU7fRz3ncnxLwonpm
         DL2Yi6X1aWOep8EhCCee56kxTUVpPy9ZIxCK/XA2jZQ/lJodkOn6LvHywCx3sqZ6pyb4
         wMxTRkIDUsPmSCui6k1GUL2FH+TQ7QwQr9NbP0Cq5gW3Fpe4k5igpAOfIXPI69ir5p/7
         FAY6wkzhTL1ZC7ChK+qJ3Z5WRSVtSttPbWWS1X3+M1mt5E7Vrg+ykjj3yIVyQMHUDz8L
         /+XiEVQTDymcwKBMuSHy4C/8p5F/eawzXZ8VLfES72s0oFX0zyP80wF+JewZjoIupRus
         t9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512939; x=1774117739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTvcRjBg7RZQjPVbwsm/XKOCF/7oOgDehhwAe6xkRiI=;
        b=AnSH3T05tDMB0sZD2wloy0AcltjjlcnTUwBBSLgiJDboa4P2IBRNUPYrh9FRxH3gUH
         QK47S2NWNJk/D2GtZHf+WtlnF2BKNRTb9bmKCNmPGiDIZyiAmG7VVXhlxCMfa6CpS8Pc
         q1d+wttvQD9DSequ8qklUeQj4Eftwgl90iIxgwr4tUy16CWC4yxQq56WVMQf+T3w3CqW
         KFbxgwzwpFn2Xom7MPRroLu/DWxKKYH4mJ+QHXfFflwGuinhLTuVXYl60xk58d9QptKE
         8QJkHfAV/eGL7YFgneyceertzIUldEHnXflwHNer0ZHBu8NVUCUp3ODqdnjCmiHuPpP+
         3vUw==
X-Forwarded-Encrypted: i=1; AJvYcCWL0iT1jw7i26TE7XDH2kiauy0LDJc1V2WozdeKlK5lmK1+Db6O50G2ti/g7lf/8DH1nwe0YgQ6cNDx3ZRwYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKTSTDjPdsMzBv/2RD960jIp0pb2IRFTcnkbDyz3BitRQ5G+0Z
	FIBJR+lkf6dlPMHv0BqeY53Uq5I2Qw0pu/OyzvjjOR/HOdQeTASqWfYI
X-Gm-Gg: ATEYQzxcDtnh8aeubNmFcZYWbZDjWhU9e0kIi2EI8VDrTDlYWtVQz/tyjjl2s9DNW5M
	w1cqcMUFehe4WqyTdXNhHTwNL7aAU5tonhttzRDhcPtqm7xccW0T8ETnHpzd6uX/F/xHm/OINCt
	cWLoQOGSfCTX/dBzg5Us8nRXlWlCI/mbinWN2mIXIAgLx13dOxomZGnk2wqShVFp3t41KeySRS2
	UvAe7B0dlmgVVW8691J5FSofNdrgJ1+ogHdYSi4tIVl2YSthwcQggb11s8VtxKMhL1x55mjwv7V
	kEAP2avEGCTM6/59qMyRVeZe9YfZnXKrgiM+HhBsiA897EAvuFFuie2UKL3Q2484zQiJhYfDKVg
	58A7BwyjY4rHy6GGNcf+kiRV3LZ2OXxMip8iMS5X1pvH3M6EnwO4nGWQHiCWfzTSABxcATPx5Ca
	r965jKJCC1362wIEZAX7qojLZsDtShNWYY1MqGl9kxtC4eutLUDbCEiwSZU7ifQMuYnBszGBQf8
	JMZt3pg5+6atYCI
X-Received: by 2002:a17:902:ce92:b0:2ae:41d1:344b with SMTP id d9443c01a7336-2aeca967ad1mr74232365ad.6.1773512938770;
        Sat, 14 Mar 2026 11:28:58 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:28:58 -0700 (PDT)
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
Subject: [PATCH net-next v9 2/7] net: core: Introduce callback ndo_set_rx_mode_async
Date: Sat, 14 Mar 2026 23:58:04 +0530
Message-ID: <20260314182809.362808-3-viswanathiyyappan@gmail.com>
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

The set_rx_mode callback is invoked under the addr_lock spinlock which
makes it illegal to sleep. This means set_rx_mode is prone to
sleep-in-atomic bugs as drivers have a tendency to do the I/O directly
in the callback.

This problem can be avoided if set_rx_mode were done in 2 stages: snapshot
and commit. A handful of drivers implement this idea by implementing the
rx_mode update as work and scheduling it in the set_rx_mode callback.

Implement this idea in net/core as this is not driver specific. To
facilitate this transition, a new async callback set_rx_mode_async
is introduced.

When this callback is provided, the set_rx_mode callback customizes
the snapshot creation and the work behaviour as required while the
set_rx_mode_async callback is run async as work and commits the
prepared snapshot.

Apart from this, the drivers need to be updated to have all the RX mode
updates pass through the netif_set_rx_mode helper to ensure correctness.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 include/linux/netdevice.h |  94 +++++++++++++-
 include/net/netdev_lock.h |   8 ++
 net/core/dev.c            | 251 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 347 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 6d426dc66af9..a69377068f4a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1068,7 +1068,36 @@ enum netif_async_state {
 	NETIF_ASYNC_INACTIVE
 };
 
+enum netif_rx_mode_cfg {
+	NETIF_RX_MODE_CFG_ALLMULTI,
+	NETIF_RX_MODE_CFG_PROMISC,
+	NETIF_RX_MODE_CFG_BROADCAST
+};
+
+enum netif_rx_mode_flags {
+	NETIF_RX_MODE_READY,
+	NETIF_RX_MODE_UC_SKIP,
+	NETIF_RX_MODE_MC_SKIP
+};
+
+struct netif_rx_mode_config {
+	char    *uc_addrs;
+	char    *mc_addrs;
+	int     uc_count;
+	int     mc_count;
+	int     cfg;
+};
+
+struct netif_rx_mode_work {
+	struct netif_rx_mode_config *pending;
+	struct netif_rx_mode_config *ready;
+	struct work_struct work;
+	struct net_device *dev;
+	int flags;
+};
+
 struct netif_async_ctx {
+	struct netif_rx_mode_work *rx_mode_work;
 	enum netif_async_state state;
 };
 
@@ -1124,9 +1153,15 @@ struct netif_async_ctx {
  *	changes to configuration when multicast or promiscuous is enabled.
  *
  * void (*ndo_set_rx_mode)(struct net_device *dev);
- *	This function is called device changes address list filtering.
+ *	This function is called when device changes address list filtering.
  *	If driver handles unicast address filtering, it should set
- *	IFF_UNICAST_FLT in its priv_flags.
+ *	IFF_UNICAST_FLT in its priv_flags. If the ndo_set_rx_mode_async
+ *	callback is provided, This would be used to set up the
+ *	rx mode snapshot that will be committed by ndo_set_rx_mode_async.
+ *
+ * void (*ndo_set_rx_mode_async)(struct net_device *dev);
+ *	This function will be scheduled by dev_set_rx_mode and is
+ *	responsible for committing the rx_mode snapshot to the hardware.
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1447,6 +1482,7 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_set_rx_mode_async)(struct net_device *dev);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -3405,6 +3441,60 @@ netif_get_async_state(struct net_device *dev)
 	return dev->async_ctx->state;
 }
 
+void netif_set_rx_mode(struct net_device *dev);
+
+/* Helpers to be used in the set_rx_mode callback */
+static inline void netif_set_rx_mode_cfg(struct net_device *dev, int b,
+					 bool val)
+{
+	if (val)
+		dev->async_ctx->rx_mode_work->pending->cfg |= BIT(b);
+	else
+		dev->async_ctx->rx_mode_work->pending->cfg &= ~BIT(b);
+}
+
+static inline void netif_set_rx_mode_flag(struct net_device *dev, int b,
+					  bool val)
+{
+	if (val)
+		dev->async_ctx->rx_mode_work->flags |= BIT(b);
+	else
+		dev->async_ctx->rx_mode_work->flags &= ~BIT(b);
+}
+
+/* Helpers to be used in the set_rx_mode_async callback */
+static inline bool netif_get_rx_mode_cfg(struct net_device *dev, int b)
+{
+	return !!(dev->async_ctx->rx_mode_work->ready->cfg & BIT(b));
+}
+
+static inline bool netif_get_rx_mode_flag(struct net_device *dev, int b)
+{
+	return !!(dev->async_ctx->rx_mode_work->flags & BIT(b));
+}
+
+static inline int netif_rx_mode_uc_count(struct net_device *dev)
+{
+	return dev->async_ctx->rx_mode_work->ready->uc_count;
+}
+
+static inline int netif_rx_mode_mc_count(struct net_device *dev)
+{
+	return dev->async_ctx->rx_mode_work->ready->mc_count;
+}
+
+#define netif_rx_mode_for_each_uc_addr(ha_addr, dev, __i) \
+	for (__i = 0, \
+	     ha_addr = (dev)->async_ctx->rx_mode_work->ready->uc_addrs; \
+	     __i < (dev)->async_ctx->rx_mode_work->ready->uc_count; \
+	     __i++, ha_addr += (dev)->addr_len)
+
+#define netif_rx_mode_for_each_mc_addr(ha_addr, dev, __i) \
+	for (__i = 0, \
+	     ha_addr = (dev)->async_ctx->rx_mode_work->ready->mc_addrs; \
+	     __i < (dev)->async_ctx->rx_mode_work->ready->mc_count; \
+	     __i++, ha_addr += (dev)->addr_len)
+
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 3d3aef80beac..118fa89232a0 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -80,6 +80,14 @@ netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
 		netdev_ops_assert_locked(dev);
 }
 
+static inline bool netdev_trylock_ops_compat(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		return netdev_trylock(dev);
+	else
+		return rtnl_trylock();
+}
+
 static inline void netdev_lock_ops_compat(struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
diff --git a/net/core/dev.c b/net/core/dev.c
index b1797bd28a6b..acf46a304d62 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1664,6 +1664,92 @@ static int napi_kthread_create(struct napi_struct *n)
 	return err;
 }
 
+static void dev_set_rx_mode_async(struct work_struct *param)
+{
+	struct netif_rx_mode_work *ctx;
+	struct net_device *dev;
+
+	ctx = container_of(param, struct netif_rx_mode_work, work);
+	dev = ctx->dev;
+
+	/* This handler requires the instance lock and we cancel this work
+	 * in dev_close where it is already held, resulting in a deadlock.
+	 * Avoid that scenario by trying to acquire the lock and bailing
+	 * out when we are in teardown.
+	 */
+	while (!netdev_trylock_ops_compat(dev)) {
+		if (netif_get_async_state(dev) == NETIF_ASYNC_DOWN)
+			return;
+
+		msleep(20);
+	}
+
+	/* We could introduce a new lock for this but reusing the addr
+	 * lock works well enough
+	 */
+	netif_addr_lock_bh(dev);
+	if (!netif_get_rx_mode_flag(dev, NETIF_RX_MODE_READY)) {
+		netif_addr_unlock_bh(dev);
+		goto out;
+	}
+	swap(ctx->ready, ctx->pending);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_READY, false);
+	netif_addr_unlock_bh(dev);
+
+	dev->netdev_ops->ndo_set_rx_mode_async(dev);
+out:
+	netdev_unlock_ops_compat(dev);
+}
+
+static int netif_alloc_rx_mode_ctx(struct net_device *dev)
+{
+	struct netif_rx_mode_work *rx_mode_work;
+
+	rx_mode_work = kzalloc_obj(*rx_mode_work);
+	if (!rx_mode_work)
+		goto fail;
+
+	rx_mode_work->ready = kzalloc_obj(*rx_mode_work->ready);
+	if (!rx_mode_work->ready)
+		goto fail_ready;
+
+	rx_mode_work->pending = kzalloc_obj(*rx_mode_work->pending);
+	if (!rx_mode_work->pending)
+		goto fail_pending;
+
+	INIT_WORK(&rx_mode_work->work, dev_set_rx_mode_async);
+	rx_mode_work->dev = dev;
+
+	dev->async_ctx->rx_mode_work = rx_mode_work;
+	return 0;
+
+fail_pending:
+	kfree(rx_mode_work->ready);
+fail_ready:
+	kfree(rx_mode_work);
+fail:
+	return -ENOMEM;
+}
+
+static void netif_free_rx_mode_ctx(struct net_device *dev)
+{
+	if (!dev->async_ctx->rx_mode_work)
+		return;
+
+	cancel_work_sync(&dev->async_ctx->rx_mode_work->work);
+
+	kfree(dev->async_ctx->rx_mode_work->ready->uc_addrs);
+	kfree(dev->async_ctx->rx_mode_work->ready->mc_addrs);
+	kfree(dev->async_ctx->rx_mode_work->ready);
+
+	kfree(dev->async_ctx->rx_mode_work->pending->uc_addrs);
+	kfree(dev->async_ctx->rx_mode_work->pending->mc_addrs);
+	kfree(dev->async_ctx->rx_mode_work->pending);
+
+	kfree(dev->async_ctx->rx_mode_work);
+	dev->async_ctx->rx_mode_work = NULL;
+}
+
 static int __netif_alloc_async_ctx(struct net_device *dev)
 {
 	dev->async_ctx = kzalloc_obj(*dev->async_ctx);
@@ -1676,17 +1762,27 @@ static int __netif_alloc_async_ctx(struct net_device *dev)
 
 static int netif_alloc_async_ctx(struct net_device *dev)
 {
+	const struct net_device_ops *ops = dev->netdev_ops;
 	int ret;
 
 	ret = __netif_alloc_async_ctx(dev);
+
+	if (!ret && ops->ndo_set_rx_mode_async)
+		ret = netif_alloc_rx_mode_ctx(dev);
+
 	return ret;
 }
 
 static void netif_free_async_ctx(struct net_device *dev)
 {
+	const struct net_device_ops *ops = dev->netdev_ops;
+
 	if (!dev->async_ctx)
 		return;
 
+	if (ops->ndo_set_rx_mode_async)
+		netif_free_rx_mode_ctx(dev);
+
 	kfree(dev->async_ctx);
 	dev->async_ctx = NULL;
 }
@@ -1868,6 +1964,8 @@ EXPORT_SYMBOL(netif_close);
  */
 void netif_disable_async_ops(struct net_device *dev)
 {
+	const struct net_device_ops *ops = dev->netdev_ops;
+
 	netdev_lock_ops_compat(dev);
 
 	if (!dev->needs_async_ctx || !netif_running(dev)) {
@@ -1877,6 +1975,9 @@ void netif_disable_async_ops(struct net_device *dev)
 
 	netif_set_async_state(dev, NETIF_ASYNC_INACTIVE);
 	netdev_unlock_ops_compat(dev);
+
+	if (ops->ndo_set_rx_mode_async)
+		cancel_work_sync(&dev->async_ctx->rx_mode_work->work);
 }
 EXPORT_SYMBOL(netif_disable_async_ops);
 
@@ -9749,6 +9850,88 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+static int __netif_prepare_rx_mode(struct net_device *dev)
+{
+	bool skip_uc = false, skip_mc = false;
+	struct netif_rx_mode_config *pending;
+	int uc_count = 0, mc_count = 0;
+	struct netdev_hw_addr *ha;
+	char *tmp;
+	int i;
+
+	pending = dev->async_ctx->rx_mode_work->pending;
+
+	skip_uc = netif_get_rx_mode_flag(dev, NETIF_RX_MODE_UC_SKIP);
+	skip_mc = netif_get_rx_mode_flag(dev, NETIF_RX_MODE_MC_SKIP);
+
+	/* The allocations need to be atomic since this will be called under
+	 * netif_addr_lock_bh()
+	 */
+	if (!skip_uc) {
+		uc_count = netdev_uc_count(dev);
+		tmp = krealloc(pending->uc_addrs, uc_count * dev->addr_len,
+			       GFP_ATOMIC);
+		if (!tmp)
+			return -ENOMEM;
+
+		i = 0;
+		pending->uc_addrs = tmp;
+		pending->uc_count = uc_count;
+		netdev_for_each_uc_addr(ha, dev)
+			memcpy(pending->uc_addrs + (i++) * dev->addr_len,
+			       ha->addr, dev->addr_len);
+	}
+
+	if (!skip_mc) {
+		mc_count = netdev_mc_count(dev);
+		tmp = krealloc(pending->mc_addrs, mc_count * dev->addr_len,
+			       GFP_ATOMIC);
+		if (!tmp)
+			return -ENOMEM;
+
+		i = 0;
+		pending->mc_addrs = tmp;
+		pending->mc_count = mc_count;
+		netdev_for_each_mc_addr(ha, dev)
+			memcpy(pending->mc_addrs + (i++) * dev->addr_len,
+			       ha->addr, dev->addr_len);
+	}
+
+	return 0;
+}
+
+/* Attempt to prepare the rx_mode snapshot and if successful,
+ * signal that it's ready.
+ */
+static int netif_prepare_rx_mode(struct net_device *dev)
+{
+	int rc;
+
+	lockdep_assert_held(&dev->addr_list_lock);
+	rc = __netif_prepare_rx_mode(dev);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_READY, (rc == 0));
+	return rc;
+}
+
+static void netif_schedule_rx_mode_work(struct net_device *dev)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (ops->ndo_set_rx_mode)
+		ops->ndo_set_rx_mode(dev);
+
+	if (!ops->ndo_set_rx_mode_async)
+		return;
+
+	if (netif_get_async_state(dev) == NETIF_ASYNC_INACTIVE)
+		return;
+
+	if (netif_prepare_rx_mode(dev))
+		return;
+
+	schedule_work(&dev->async_ctx->rx_mode_work->work);
+}
+
 /*
  *	Upload unicast and multicast address lists to device and
  *	configure RX filtering. When the device doesn't support unicast
@@ -9757,8 +9940,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9779,8 +9960,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	netif_schedule_rx_mode_work(dev);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
@@ -9790,6 +9970,66 @@ void dev_set_rx_mode(struct net_device *dev)
 	netif_addr_unlock_bh(dev);
 }
 
+/* netif_set_rx_mode() - Helper to centralize RX mode requests in core.
+ *
+ * If ndo_set_rx_mode_async is provided, perform the required
+ * setup and invoke ndo_set_rx_mode_async callback. Otherwise this is the
+ * same as invoking the ndo_set_rx_mode callback.
+ *
+ * If ndo_set_rx_mode_async is implemented, the driver must perform all
+ * RX mode updates via this function and invoking the set_rx_mode callback
+ * directly is a bug.
+ */
+void netif_set_rx_mode(struct net_device *dev)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	struct netif_rx_mode_work *ctx;
+	bool netif_down;
+	int rc = 0;
+
+	if (WARN_ON(!ops->ndo_set_rx_mode))
+		return;
+
+	if (!ops->ndo_set_rx_mode_async) {
+		ops->ndo_set_rx_mode(dev);
+		return;
+	}
+
+	netdev_ops_assert_locked(dev);
+
+	netif_down = !netif_running(dev);
+	if (netif_down) {
+		rc = __netif_alloc_async_ctx(dev);
+		if (!rc)
+			rc = netif_alloc_rx_mode_ctx(dev);
+		if (rc)
+			goto out;
+	}
+
+	netif_addr_lock_bh(dev);
+	ops->ndo_set_rx_mode(dev);
+	rc = netif_prepare_rx_mode(dev);
+	if (rc) {
+		netif_addr_unlock_bh(dev);
+		goto out;
+	}
+
+	/* There might be a work scheduled by dev_set_rx_mode before
+	 * this function's execution that could be using outdated
+	 * config. Clear the ready bit to prevent that work's execution.
+	 */
+	ctx = dev->async_ctx->rx_mode_work;
+	swap(ctx->ready, ctx->pending);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_READY, false);
+	netif_addr_unlock_bh(dev);
+
+	ops->ndo_set_rx_mode_async(dev);
+out:
+	if (netif_down)
+		netif_free_async_ctx(dev);
+}
+EXPORT_SYMBOL(netif_set_rx_mode);
+
 /**
  * netif_get_flags() - get flags reported to userspace
  * @dev: device
@@ -11451,6 +11691,9 @@ int register_netdevice(struct net_device *dev)
 		}
 	}
 
+	if (dev->netdev_ops->ndo_set_rx_mode_async)
+		dev->needs_async_ctx = true;
+
 	if (((dev->hw_features | dev->features) &
 	     NETIF_F_HW_VLAN_CTAG_FILTER) &&
 	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
-- 
2.47.3

