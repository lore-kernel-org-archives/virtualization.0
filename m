Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4422B8B6
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512970; cv=none; b=DzZWe8WBTFOgqJXSYzvg+m8AFIXxjIEzmLtegGVsIHVMn1orUoZQuNke8irjyxJMEB7Sviif0eYYgyzynln2twbg535s8uOoqfZsJqwY0VEax6hbQ+XnHbBoArVoaTBEQCV3XBdCvqVqje51b8vrMBp0nryYeub5AYNR8GgFhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512970; c=relaxed/simple;
	bh=QLZYYEoj+5kLfwWS2IqKub9BTqN23yPeZ2bW6yAB0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRkkifSJ0ngaFxf630E+LX0QiwLCNbZ4sapHTWtAX5SHVTT4DlmX8XJqPAo2yJSWqpoz2RBIHnw096CaHJ48T88RHX30imTHw+Fkf1ev3CJJpebL2rKQJMc2ydCz0r0neUXiuJBIaKLpAappryLw/QyOw/thTSMP2SYM2wxmmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccSnKWmk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccSnKWmk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae4e538abdso36152425ad.3
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512969; x=1774117769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB6x/lr1ek9kI9gI1prPQzKFPvlqHQ7Z+jL2sCBy488=;
        b=ccSnKWmk0MUaONKSXgs9A6/XD6SEe1uptlRCnTpmHBj4HCWoungKYWZPPTIxJQT/7R
         f/JVMNannnjoTr6zgprmW/be4SKmwS+W7/k9hTj12Snyr0j+Ek587Y1oAhX+FbuMhRLA
         VoiT8rh+W/xVJES+bMzOj0W/Q+3DKAWbi/TLBJ7IibeXWLCJrDxs6YKwPr1KRrK7YM8w
         AHow7O+v+Q9idjYN1Dty9wh3rIiYD+47/ntcJIX6WfL5RpAmEC0Ks+8UPQ2xD3Dx5Iwh
         VLnHnq2SoS5lObAuVaym3aiMz19CvTMlJUDQIM55bWht3m2q02DtJMimypzc+moILSvo
         jtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512969; x=1774117769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IB6x/lr1ek9kI9gI1prPQzKFPvlqHQ7Z+jL2sCBy488=;
        b=eWYM6Sq0rV9nJCWL7EQS2jXF3wbBrKBEvzuQxUKZOqyjxgP5l4ZZ+5hcch8dVyvnN4
         t4ksnHmQ/gkGmTfNAiUQwWntCOsmqmG1tEbB1Jd1A9Jtfn+LzGcoTK2hdpw5x7yG7PJV
         ljFpYNLt9lfCxxvwPcPFMnvU8XYnUZOgenc2Y6wDsJpgG744R0fNb30foax+jIdtxM/t
         Zow4EJTl0CLpIUe73ykzv6XM/utBUEWsxa3hdQMUxZaEgqN55gJ/C86JJopuwmNBFMJ2
         sdl4K3UuhVMAlYWkD4tZ1O2/XUDqKlugsfZEGUXoqGQ1M3sC6vddIAuoMEPOJh2Un+y1
         VJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCWxTlA4mDtJruhv1TKd7lv9uZuZU8W6UQHPSGvYBp78slb5DkrJ78cl0SmB1ThBwKV3OtNfc5nbkVGstRf7KQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmnhd/6nG2/kPK02axY2x765mLsNY+Nqj1pAr03eUhL5EaFB46
	F9LqrCmbyi4c2+rbFvjmlGW/rcYHopZsEZGbvq0diuS8sa/QMxrt+THd
X-Gm-Gg: ATEYQzxzuZAEKU7D35RnDccP0RVe1DadiAC+PBFG7Ps3emtf5KVs7zK1/28GyMWXp+M
	aiKCFAk+J0MtqeIKVb1OjAd+dsN8im4gJCMU9BuT4oPl9jgh6j/ufeoJI/QPonkJ57BmJcaiftx
	WHZ+f4SwqMJv35t2hpkJRaVmGAd+0LDBLWlA2w9YIr4vJQIi92r3G+a1EC+5YXR6P0kZInJOHTK
	nlu3BLicwTdDyyreqE3mSyIsi+TLNF+foFZeL4uxXcIOVCs6tjKvKaSQl3Hw0fMkOf2olRDYXyk
	u2u4x3OApxrBSdyuYKH7wELSApnmMf+oCeCYB3U77lB8jL1TGNKaY2NKaIGo17pQMH3qWXOBt9B
	5QT62guf14y1rhlvXwqmFK9WKpGF0JKuEr5GY0Ail+nodWaIbIXmja2Q6H4ZFfZZe5FwBJVhXf7
	JTOcIQ/tg1nzzNysAZqYK8sjO5CF81oSyF3305DT9vb6XLgHjpDsJep8oGKbwC8Le9cE+wrNKDE
	igBKg==
X-Received: by 2002:a17:902:d592:b0:2ae:5ec4:2f78 with SMTP id d9443c01a7336-2aecaaa860dmr85707515ad.33.1773512968776;
        Sat, 14 Mar 2026 11:29:28 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:27 -0700 (PDT)
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
Subject: [PATCH net-next v9 5/7] 8139cp: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:07 +0530
Message-ID: <20260314182809.362808-6-viswanathiyyappan@gmail.com>
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
 
Call paths involving netif_set_rx_mode in 8139cp

netif_set_rx_mode
|-- cp_init_hw
|   |-- cp_open (ndo_open, takes lock)
|   |   `-- cp_change_mtu (ndo_change_mtu, takes lock)
|   |
|   `-- cp_resume (lock added)
|
`-- cp_tx_timeout (ndo_tx_timeout, takes lock)

 drivers/net/ethernet/realtek/8139cp.c | 49 ++++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..9651a0d9d8f0 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -372,7 +372,6 @@ struct cp_private {
 	} while (0)
 
 
-static void __cp_set_rx_mode (struct net_device *dev);
 static void cp_tx (struct cp_private *cp);
 static void cp_clean_rings (struct cp_private *cp);
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -885,30 +884,31 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
 /* Set or clear the multicast filter for this adaptor.
    This routine is not state sensitive and need not be SMP locked. */
 
-static void __cp_set_rx_mode (struct net_device *dev)
+static void cp_set_rx_mode_async(struct net_device *dev)
 {
 	struct cp_private *cp = netdev_priv(dev);
 	u32 mc_filter[2];	/* Multicast hash filter */
+	char *ha_addr;
 	int rx_mode;
+	int ni;
 
 	/* Note: do not reorder, GCC is clever about common statements. */
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_get_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Unconditionally log net taps. */
 		rx_mode =
 		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
 		    AcceptAllPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
-		   (dev->flags & IFF_ALLMULTI)) {
+	} else if ((netif_rx_mode_mc_count(dev) > multicast_filter_limit) ||
+		   netif_get_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI)) {
 		/* Too many to filter perfectly -- accept all multicasts. */
 		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
 	} else {
-		struct netdev_hw_addr *ha;
 		rx_mode = AcceptBroadcast | AcceptMyPhys;
 		mc_filter[1] = mc_filter[0] = 0;
-		netdev_for_each_mc_addr(ha, dev) {
-			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
+		netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni) {
+			int bit_nr = ether_crc(ETH_ALEN, ha_addr) >> 26;
 
 			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
 			rx_mode |= AcceptMulticast;
@@ -925,12 +925,14 @@ static void __cp_set_rx_mode (struct net_device *dev)
 
 static void cp_set_rx_mode (struct net_device *dev)
 {
-	unsigned long flags;
-	struct cp_private *cp = netdev_priv(dev);
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
 
-	spin_lock_irqsave (&cp->lock, flags);
-	__cp_set_rx_mode(dev);
-	spin_unlock_irqrestore (&cp->lock, flags);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static void __cp_get_stats(struct cp_private *cp)
@@ -1040,7 +1042,7 @@ static void cp_init_hw (struct cp_private *cp)
 	cp_start_hw(cp);
 	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
 
-	__cp_set_rx_mode(dev);
+	netif_set_rx_mode(dev);
 	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
@@ -1262,7 +1264,7 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	cp_clean_rings(cp);
 	cp_init_rings(cp);
 	cp_start_hw(cp);
-	__cp_set_rx_mode(dev);
+	netif_set_rx_mode(dev);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
 
 	netif_wake_queue(dev);
@@ -1870,6 +1872,7 @@ static const struct net_device_ops cp_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address 	= cp_set_mac_address,
 	.ndo_set_rx_mode	= cp_set_rx_mode,
+	.ndo_set_rx_mode_async	= cp_set_rx_mode_async,
 	.ndo_get_stats		= cp_get_stats,
 	.ndo_eth_ioctl		= cp_ioctl,
 	.ndo_start_xmit		= cp_start_xmit,
@@ -2071,7 +2074,7 @@ static int __maybe_unused cp_suspend(struct device *device)
 	spin_unlock_irqrestore (&cp->lock, flags);
 
 	device_set_wakeup_enable(device, cp->wol_enabled);
-
+	netif_disable_async_ops(dev);
 	return 0;
 }
 
@@ -2081,6 +2084,8 @@ static int __maybe_unused cp_resume(struct device *device)
 	struct cp_private *cp = netdev_priv(dev);
 	unsigned long flags;
 
+	netif_enable_async_ops(dev);
+
 	if (!netif_running(dev))
 		return 0;
 
@@ -2088,7 +2093,11 @@ static int __maybe_unused cp_resume(struct device *device)
 
 	/* FIXME: sh*t may happen if the Rx ring buffer is depleted */
 	cp_init_rings_index (cp);
+
+	rtnl_lock();
 	cp_init_hw (cp);
+	rtnl_unlock();
+
 	cp_enable_irq(cp);
 	netif_start_queue (dev);
 
@@ -2101,6 +2110,13 @@ static int __maybe_unused cp_resume(struct device *device)
 	return 0;
 }
 
+static void cp_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	netif_disable_async_ops(dev);
+}
+
 static const struct pci_device_id cp_pci_tbl[] = {
         { PCI_DEVICE(PCI_VENDOR_ID_REALTEK,     PCI_DEVICE_ID_REALTEK_8139), },
         { PCI_DEVICE(PCI_VENDOR_ID_TTTECH,      PCI_DEVICE_ID_TTTECH_MC322), },
@@ -2116,6 +2132,7 @@ static struct pci_driver cp_driver = {
 	.probe        =	cp_init_one,
 	.remove       = cp_remove_one,
 	.driver.pm    = &cp_pm_ops,
+	.shutdown     = &cp_shutdown
 };
 
 module_pci_driver(cp_driver);
-- 
2.47.3

