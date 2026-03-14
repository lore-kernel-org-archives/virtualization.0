Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA7261B71
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512980; cv=none; b=Sf5+IBkJwbsH/2yY6YAHQ7IGrtty138bygvN0/D6RaxU3swOOCwDUSlFzWeQCfyXH8F6A23DdXHnMroWGE3vpZ6UzidMAX2NcnrC2tCbmd0/6k/JSvwv/5GTNcMFrH9x4b51ZOESIr+Ph2I+qmPah61WkBhC0iCn1jhxdusR7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512980; c=relaxed/simple;
	bh=U3vvmkXelI8LTz8QU0K42inS4TOguEVJt/CLkeFByIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0KZQJLSylCFsrmnPkZvUh2H/+gKTDF0Gms7ZFfvb33l+pWaIWDU0JFNuNHicTDUtTu14XFjQ4LicjGqlXljRkBMlTSd2e0P54g+AvYhwCKdT0AQL2296lhjW5x2zk/LFXk0Uvn5u8Gm1MoVBnb7wzd5IeQJ4JFsTI+8mjj1jGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddY4pb0c; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddY4pb0c"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7393536e53so1275423a12.2
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512979; x=1774117779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uJuhFREF46e+3OIYgkRDThTE1W9t/zG8t/Q5Vop1iU=;
        b=ddY4pb0c380IOysTSlFeE3UQVxBUm3kOKUia9X2JyjLRkQacU0Uy0XolC7GUJmqvve
         ZB1OqIOkAwL6bl0PB+2xmX6AcXDGZyQBV/1HtYYAvlKdJZl+UD1Vb4robSQMw+wnd49f
         cexVCusU+zArtBzlh9p7mUWdMJye1UcriKwHHxG936IMLdBmv5ykjiIWHFb3VkVbsqox
         kJXN3aH8da2b6l2f2FvILTm1Yu9TOeGpWRzpdsLG2ohTztEDzAV3OjNjQuCriENPIxw5
         d5Q/8RpGgXhRnTAxHuI9CMXlRAlzOIglQzf5JjQDE+uqnCAO/EHoUPjywSfmbfXVH4R7
         aa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512979; x=1774117779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uJuhFREF46e+3OIYgkRDThTE1W9t/zG8t/Q5Vop1iU=;
        b=GR1urjoHNZyjD0Zwxag60VzLeE9C0CWJEq04L44HjBXhBQMisvq1NdZ+A+NM96wlGk
         1iyf28fXfGCP9KxrCDvpKvziRz7mCmReFZso5BfdwlErkShi42lEozoBc3UzXBfQwHYM
         pnB27pyhFCreP1h/eHcPPPnDMGNwXhEaS6CJFBq+lILkb2WvAMP0HviXu1EkJLvaZTyG
         gRd/hPK9n0VFbanBgtsmIfezT3I9fKr19te9PBw3VbC+mKMn4eT8QoLRbrYEgVspXsrW
         x47tNFeIm0albs08/z1sJWmRWGQ/aJJuBpnL15lfGYlO4E075SojI+DHGJ/xwI4LPNMA
         gAyA==
X-Forwarded-Encrypted: i=1; AJvYcCWvMh2T2ursudWaMobxaCE7ECPdTqJpW2hFB7T4inmiTfyQIIHmiosD89hBhf61YkGBPVllafgrsn3GenF5Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yytwx0OYOPVLgS6XKQZXHulMhn7r2CydGa06oY2WuSM+afryHzf
	xRM89grdniWp45z/yLhs67TauWJWvN4qSRNfmMuw8YXP+6vag+TWHQG4
X-Gm-Gg: ATEYQzwrAL0KHFbEIZM66rLd+Us0Y5ivaSFLjUNzRU9GdWag4MkvbRn0/zOCeJ7gtaI
	DYaA1anwR3gSrsM5aMG1P6MuhGBexa1MS4zI583Cd5IJfO908q064UjE95kLhPyoaUHX0/frkjI
	7wuBDu0Yl+p3bly1Kach+8VQ2wkXssffpFkudmjDT8j8Ro0nqrSRrVxRdlxiNtW4BeBicd0qsGb
	n3eXMsc+Nrq6mPug6eAiwfr64jxtEydc1MdOQkmiEJv3YutoH992FvBh0sNaRq00sY3mvck9twL
	yKr5Fq8pL/i2FIb8ANcxl2kCQIOaZzpcuzz9ptgA/Ux8Rg+CIvHjS7ZnPzjhPSDEAg/2quQDKxl
	fQpZOYOSwDwuetDRCeS6ca1RNqiLTyg8sR1coHCHQqNUFOoSBXvItStTp9SuTtLQC1trnSxwf+y
	buw2pZS/xL1WeCYWVj68bqP3ftmoqsUlkupkVJQSIxFBBF2jiuoErNdhHEv8wLX/dQ/oSV9U5h9
	ff8BA==
X-Received: by 2002:a17:902:f70a:b0:2ae:5044:8dd4 with SMTP id d9443c01a7336-2aeca960929mr72806085ad.19.1773512978654;
        Sat, 14 Mar 2026 11:29:38 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:38 -0700 (PDT)
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
Subject: [PATCH net-next v9 6/7] vmxnet3: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:08 +0530
Message-ID: <20260314182809.362808-7-viswanathiyyappan@gmail.com>
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

Implement the ndo_set_rx_mode_async callback and update
the driver to use the snapshot/commit model for RX mode update.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 
Call paths involving netif_set_rx_mode in vmxnet3

netif_set_rx_mode
`-- vmxnet3_activate_dev
    |-- vmxnet3_open (ndo_open, takes lock)
    |-- vmxnet3_change_mtu (ndo_change_mtu, takes lock)
    |-- vmxnet3_reset_work (takes lock)
    |-- vmxnet3_resume (lock added)
    |-- vmxnet3_set_ringparam (ethtool callback, takes lock)
    `-- vmxnet3_xdp_set
        `-- vmxnet3_xdp (ndo_bpf, takes lock)

 drivers/net/vmxnet3/vmxnet3_drv.c | 46 +++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 40522afc0532..350e44286c00 100644
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
+	netif_set_rx_mode_flag(netdev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_set_rx_mode_flag(netdev, NETIF_RX_MODE_MC_SKIP, allmulti);
+
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST, broadcast);
+}
+
+static void vmxnet3_set_mc_async(struct net_device *netdev)
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
+	if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		u32 *vfTable = adapter->shared->devRead.rxFilterConf.vfTable;
 		memset(vfTable, 0, VMXNET3_VFT_SIZE * sizeof(*vfTable));
 
@@ -2815,16 +2830,16 @@ vmxnet3_set_mc(struct net_device *netdev)
 		vmxnet3_restore_vlan(adapter);
 	}
 
-	if (netdev->flags & IFF_BROADCAST)
+	if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST))
 		new_mode |= VMXNET3_RXM_BCAST;
 
-	if (netdev->flags & IFF_ALLMULTI)
+	if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI))
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
+	netif_set_rx_mode(adapter->netdev);
 
 	/*
 	 * Check link state when first activating device. It will start the
@@ -3977,6 +3992,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 		.ndo_get_stats64 = vmxnet3_get_stats64,
 		.ndo_tx_timeout = vmxnet3_tx_timeout,
 		.ndo_set_rx_mode = vmxnet3_set_mc,
+		.ndo_set_rx_mode_async = vmxnet3_set_mc_async,
 		.ndo_vlan_rx_add_vid = vmxnet3_vlan_rx_add_vid,
 		.ndo_vlan_rx_kill_vid = vmxnet3_vlan_rx_kill_vid,
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -4400,6 +4416,7 @@ static void vmxnet3_shutdown_device(struct pci_dev *pdev)
 	vmxnet3_disable_all_intrs(adapter);
 
 	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
+	netif_disable_async_ops(netdev);
 }
 
 
@@ -4518,6 +4535,7 @@ vmxnet3_suspend(struct device *device)
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, pci_choose_state(pdev, PMSG_SUSPEND));
 
+	netif_disable_async_ops(netdev);
 	return 0;
 }
 
@@ -4531,6 +4549,8 @@ vmxnet3_resume(struct device *device)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 
+	netif_enable_async_ops(netdev);
+
 	if (!netif_running(netdev))
 		return 0;
 
@@ -4559,7 +4579,11 @@ vmxnet3_resume(struct device *device)
 	vmxnet3_rq_cleanup_all(adapter);
 
 	vmxnet3_reset_dev(adapter);
+
+	rtnl_lock();
 	err = vmxnet3_activate_dev(adapter);
+	rtnl_unlock();
+
 	if (err != 0) {
 		netdev_err(netdev,
 			   "failed to re-activate on resume, error: %d", err);
-- 
2.47.3

