Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA39215055
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241863; cv=none; b=L0u4Sj8n4nE1X7sDNj5qkcH+AKFbqY+Rj1u/OYJedERO6QWg/ryKi7kCpV63ZEeYSXtzJt7stpouYh3bPk59CRSegFtVMeh+Ad1GePn8wSUPVfvI/o7KcftVBIVtL6436TeVVHtuW1awNaIL1T9JqY4XhqEGFKhQkBf/vlUMOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241863; c=relaxed/simple;
	bh=2Sqpis1K0LSL/WFSvtY09l86+t1Bt2h1wW9J0JxvOs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkHGrRtbv2fwd2LCZHhr8aLfXnyq0G4z/d5HOIJr2DVo+2D74IAo3/BWcVv+XaDLYTliCWzTAPNSTHvtsMkE7nOqYG/1bhiYGiowr7+PNWZ8/y18Gdiaxm8iZJmNHvQqDQiUIms3kBwjUQnw1qx8A4Sqh7b2AOSfMNm9S/TWCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byWX5keH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byWX5keH"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so5614727a91.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241862; x=1768846662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el5UxGKyuVvQQYU13vsmsSfuItrkm2KM2pfP5FWsHjg=;
        b=byWX5keHXKzWA/jPYYAoRGHoGZKcJiHQ0UEE5wJ3HOT+ZoWHLgNBnJE82Gd+OJLmfi
         Msmo2agIz3Q7FEPhaiKpzX3QSjx6l/vccH3rZRWnlnKbwEwowwgfbx3mC6lQUHUNdBL9
         b71xo9GpHZeuHEOJv04D7LNN4ybr+TejHN8F82lYhE6/eaYqOTaH9C5VGSppcesEqYyK
         BxLhsqpWPcb7yVeCjcyU7vt0BJZF+R46yrqv/9EeygKCKkklpB1qBXYwLjg5eS5O7AwK
         8pfmLR0+zijlDinooJ5yxKmzLA2SlDEygy+OvdbwzO0TYZQNblB0QZDzPCJGp0ZgLdBK
         ydnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241862; x=1768846662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=el5UxGKyuVvQQYU13vsmsSfuItrkm2KM2pfP5FWsHjg=;
        b=cpQqhhuN/YprMtkmNoQq/uXkloQHihP20dBP75xnXMhCUFhYuo8XtSOpdFpjEqEvgf
         YiMhDbf5Vw9KLhJd5X4Gh7tgDAAme/apju61ylwpAssD9ouR5t3DZFDk2HDfBz8b1gVc
         /FBWTBwa+CV2q3k2hoZcUMIb7c/OanGrcBVElpVvwnDcSdZj9Zns/5RkB/8pwcUSPcec
         qdg8GG8L9YWtlfVVGaVePmNanHuMQcDH+z/Y+4v0FElv8MI6vrtv9/IWfr5PXMZB8/BP
         HFSBuCS+KFWc9Fe0wYOH1SLJqCWKSGputyGOexSkd3L9AERSHBS0zHwCGli5IvpVsR9z
         8ohA==
X-Forwarded-Encrypted: i=1; AJvYcCWejeONlBh+B816VjioDgcVE5wOYuKaz44c4UtqQ33ZbfaP4NKfTdiduAfWcukgfB7d3xQd8t9UH4JxD+QLkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFTyDFmJ9JSfXr99wml7SctB4ULI3soqBWZzOyf1JUnxVo/9l5
	/4PICJibHw0GSyHa5jgb/q8GMm2YLstsgtp1LKzSu4+DShRfA04/9nQR
X-Gm-Gg: AY/fxX5xj87RJQ8ITJLunQutYoFJnPi5e9/5LvYebfLkDs6impngLJ1m+KX/pppIJGI
	HgQBSD15V093kOa894n3HJbjBBGRW+lXScwwTgZgteUHZJZfEycBqJVKHfdplYEHaaM4/yolGPD
	EgqUh10RXx2vNhQkAx8Q0y0MW2UsRqYeNPPjjFoNUMdNFtGQ/x+64BsNiGtLsLrBEwo28iUIyie
	utWAMpbBXqt0Ezx0QJyusECyRAF0Q/66ZBQZoeeVQj9gFtTXm15jMEGT3eTvwLGB2Y1CYB6WEt2
	jWnoUc03EI/vXkbtZEuEkDPPPCX7k5x5PGppFUyItYWAq9hCbStD5hZ9qdHYRXFlWwsOG51RRe0
	RPOcVAgToIBaE5ZNuIHREoCcSpWEuM4JGoSGHguP27iz71WmKj8445+sZw4yTjVdPTCYEckVNpX
	mH3VF8R/05Mrx0AwL9+jmSQnO55wKxfEuBBAYV7Sh+S9dPkDGqDgbJmX2CWNpW9/xbdtmMeO2xf
	gyh
X-Google-Smtp-Source: AGHT+IGw8c/ge0kogLSvooJ8T05HpwWG8XaZIOQXBwEzKsqUzkn4DfT0BloqE2l57lQqyy6/HPMuNg==
X-Received: by 2002:a17:90b:2692:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-34f68c30794mr16139992a91.2.1768241861645;
        Mon, 12 Jan 2026 10:17:41 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:41 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	intel-wired-lan@lists.osuosl.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v8 5/6] vmxnet3: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:25 +0530
Message-ID: <20260112181626.20117-6-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
References: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add callback and update the code to use the rx_mode snapshot and
deferred write model

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 38 ++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0572f6a9bdb6..fe76f6a2afea 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2775,18 +2775,18 @@ static u8 *
 vmxnet3_copy_mc(struct net_device *netdev)
 {
 	u8 *buf = NULL;
-	u32 sz = netdev_mc_count(netdev) * ETH_ALEN;
+	u32 sz = netif_rx_mode_mc_count(netdev) * ETH_ALEN;
+	char *ha_addr;
+	int ni;
 
 	/* struct Vmxnet3_RxFilterConf.mfTableLen is u16. */
 	if (sz <= 0xffff) {
 		/* We may be called with BH disabled */
 		buf = kmalloc(sz, GFP_ATOMIC);
 		if (buf) {
-			struct netdev_hw_addr *ha;
 			int i = 0;
-
-			netdev_for_each_mc_addr(ha, netdev)
-				memcpy(buf + i++ * ETH_ALEN, ha->addr,
+			netif_rx_mode_for_each_mc_addr(ha_addr, netdev, ni)
+				memcpy(buf + i++ * ETH_ALEN, ha_addr,
 				       ETH_ALEN);
 		}
 	}
@@ -2796,8 +2796,23 @@ vmxnet3_copy_mc(struct net_device *netdev)
 
 static void
 vmxnet3_set_mc(struct net_device *netdev)
+{
+	bool allmulti = !!(netdev->flags & IFF_ALLMULTI);
+	bool promisc = !!(netdev->flags & IFF_PROMISC);
+	bool broadcast = !!(netdev->flags & IFF_BROADCAST);
+
+	netif_rx_mode_set_flag(netdev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_rx_mode_set_flag(netdev, NETIF_RX_MODE_MC_SKIP, allmulti);
+
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST, broadcast);
+}
+
+static void vmxnet3_write_mc(struct net_device *netdev)
 {
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
+	int mc_count = netif_rx_mode_mc_count(netdev);
 	unsigned long flags;
 	struct Vmxnet3_RxFilterConf *rxConf =
 					&adapter->shared->devRead.rxFilterConf;
@@ -2806,7 +2821,7 @@ vmxnet3_set_mc(struct net_device *netdev)
 	bool new_table_pa_valid = false;
 	u32 new_mode = VMXNET3_RXM_UCAST;
 
-	if (netdev->flags & IFF_PROMISC) {
+	if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		u32 *vfTable = adapter->shared->devRead.rxFilterConf.vfTable;
 		memset(vfTable, 0, VMXNET3_VFT_SIZE * sizeof(*vfTable));
 
@@ -2815,16 +2830,16 @@ vmxnet3_set_mc(struct net_device *netdev)
 		vmxnet3_restore_vlan(adapter);
 	}
 
-	if (netdev->flags & IFF_BROADCAST)
+	if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST))
 		new_mode |= VMXNET3_RXM_BCAST;
 
-	if (netdev->flags & IFF_ALLMULTI)
+	if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI))
 		new_mode |= VMXNET3_RXM_ALL_MULTI;
 	else
-		if (!netdev_mc_empty(netdev)) {
+		if (mc_count) {
 			new_table = vmxnet3_copy_mc(netdev);
 			if (new_table) {
-				size_t sz = netdev_mc_count(netdev) * ETH_ALEN;
+				size_t sz = mc_count * ETH_ALEN;
 
 				rxConf->mfTableLen = cpu_to_le16(sz);
 				new_table_pa = dma_map_single(
@@ -3213,7 +3228,7 @@ vmxnet3_activate_dev(struct vmxnet3_adapter *adapter)
 	}
 
 	/* Apply the rx filter settins last. */
-	vmxnet3_set_mc(adapter->netdev);
+	netif_schedule_rx_mode_work(adapter->netdev);
 
 	/*
 	 * Check link state when first activating device. It will start the
@@ -3977,6 +3992,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 		.ndo_get_stats64 = vmxnet3_get_stats64,
 		.ndo_tx_timeout = vmxnet3_tx_timeout,
 		.ndo_set_rx_mode = vmxnet3_set_mc,
+		.ndo_write_rx_mode = vmxnet3_write_mc,
 		.ndo_vlan_rx_add_vid = vmxnet3_vlan_rx_add_vid,
 		.ndo_vlan_rx_kill_vid = vmxnet3_vlan_rx_kill_vid,
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.47.3

