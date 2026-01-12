Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C56387583
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241848; cv=none; b=HWKLloaOv4TwmYlQNH2fWQo74Yw5ELbHXsXg/kHgR3N4ZUyM5u6fqyq84fKyKG4komBEdCQzXgWV71+ge/J5QAskZ2SgGCoMJXo/tngK0VeuWSaHlNWXxTizeX2SNa3VlPWIZSZMssVVuHLv2XZwlfetVWwQLfCTsbDjZoJZZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241848; c=relaxed/simple;
	bh=qWJ5Z3/L6kl19UBxrsb69Uopbacndrl6TF3JljrMyY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nor5/S49q8+QpQeQO8+vJAgLeI8aUHn6vh1W8SbJScRNFqUSWQmXUuFFAxHrA1+XCPD4oCdXiu/eJtNgb/AF1Ocigw1voQPYo5MwpsXW8kp4Pwj6FVlDzwpppknhgmJAee8elnNU7GTfR//NwAr2NmPs52TZ1uLs2NPCt/0VaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1VliVXy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1VliVXy"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bde0f62464cso2819924a12.2
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241846; x=1768846646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsXS6L+T4eWxoCFRdBnUQMJP/+ral8MRAKD6IFiqy1I=;
        b=f1VliVXyeJA/sV94cYadCm+a2xL7ljrIFBtseKgfBvPGUlHr/KkeCmjLAX6Nw5GAEo
         cIxXujQGg/fo0ApigmiC5YuKkWQuMnQGPRgaLgfZvq+6eeClgUYMTMBXy3ZAOjlK2ooN
         fHA+1jFBXYAfhFp/2l3d/EVChpCC5Alu9ySSmYl/FJ7VVpRk2jrozWBfw2E0xdSZ9qi/
         /ujR2V3yLuFAkOVGi/WQ/HER9EtVGlNj9szkm9PptEJqLbLoxtuJsiXBpef9WJ9orpp2
         qW6c0mq8ANC25QiLqVzIDuQqBFLGmcwOUu3YXG4eNVL6LBk1qPX5com66BQUl9DwaPWj
         DVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241846; x=1768846646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YsXS6L+T4eWxoCFRdBnUQMJP/+ral8MRAKD6IFiqy1I=;
        b=Qf6oI7WRtJiQP34qg4fa16KRgPAr7xnWR5iZ5YngU+WvdIBVxCYvSM+vWFx0Gh+fHL
         oKGC6P1ijHkP4EQIcbU05zr738+d/Vopk4G1YXLcnufUTFreWBNPq9eZneZVLghS25Yq
         MYlnod4dYJnNfD9zz60yv2Xr5By/msFMtZwlr0o3Woed5xTdSYLFCWCvivZMCT8IZLei
         tLM5QWlsGCkPrQd9Hxc6EnpDPYRzfCuWqmSoOm9zkbrmpEHAPTQN0FsnXgA1KeVJLInb
         ZEmDaWrfU4IJxSQpR588LdDuEFFAL3R8WjqPcrDuP4aqnhtgv2JollP1WihCH52N8mPN
         /OGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNvdIbMmkwD4cUaSKigD2TdsObYIzBKFDqjS464vo4HxL+CzEFvgd2pcFKt3jQeBr2kUwr6NcoAxiZQtD5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzC+OG8Ni0bxwj3/OopjCjL/hvkzAh/iaSAK8IZ60qPozy4NuiR
	Fh/45lq6mU3KtdIoSoOg+7XoM4Qt+RB/3uLS7BVrvx6t/oTZIm10/HYB
X-Gm-Gg: AY/fxX7ZFJ9f82dGqj5DhEhIw47SFITAvmtm9vYA4nloSVaPw8Smx4efKHZ3ZB6HF5z
	RhsQOcXOdqSrOIxdmOvR8ATfRaX3z5GSRriS70gntDIPeh5dMY61lB+VFVdupxPHs9pDcYDe+Xa
	uvRxieLkxNbh2HZeUZtfZ/gECQplR9ZlouBAIE0dKWwanP7PfL5sQ8LBXblXWdERCovJAv3aKmk
	woHYq0deu7r92mGR6ak9xqiFqmjcGj1rjp2zCOXR4cruDvFuwTvf/P6ROlmvZoD99r51RQNyZ26
	5jIZbGcWVdSe5lHCxFTX2i90i9kNCs+Re49foqZcckPSlrOwDHUEA3/njKLDmDSvdnvprf2JF/n
	i8GBd8888cbid+UtbhhFfbOk7q0GLb/QORaHM409IiLKhmxyCTLyC+KxMDsbj0zoubYw0fMH9Ac
	v0sbv0Sut1x02WNkp0dJqrF0j5wIUg5ieryUo5RxUbXmUNX1Up1KYkZDHusKZ5QIJ8yw==
X-Google-Smtp-Source: AGHT+IGuIkRrAnjG6E/2zRE+ar/qUHm3eneYw8JDZqcsw4DJueiT7pf+BtL7KohCktRxTsjaNEWUXg==
X-Received: by 2002:a17:90b:4c09:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-34f68c281a5mr14987512a91.32.1768241845853;
        Mon, 12 Jan 2026 10:17:25 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:25 -0800 (PST)
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
Subject: [PATCH net-next v8 3/6] e1000: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:23 +0530
Message-ID: <20260112181626.20117-4-viswanathiyyappan@gmail.com>
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
 The suspend callback was calling the set_rx_mode ndo even when the netif was down.
 Since that wouldn't make sense in the new model, Now, It does that only if netif 
 is not down. Correct me if this is a mistake
 
 drivers/net/ethernet/intel/e1000/e1000_main.c | 59 ++++++++++++-------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 7f078ec9c14c..3b0260d502d4 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -99,6 +99,7 @@ static void e1000_clean_tx_ring(struct e1000_adapter *adapter,
 static void e1000_clean_rx_ring(struct e1000_adapter *adapter,
 				struct e1000_rx_ring *rx_ring);
 static void e1000_set_rx_mode(struct net_device *netdev);
+static void e1000_write_rx_mode(struct net_device *netdev);
 static void e1000_update_phy_info_task(struct work_struct *work);
 static void e1000_watchdog(struct work_struct *work);
 static void e1000_82547_tx_fifo_stall_task(struct work_struct *work);
@@ -359,7 +360,7 @@ static void e1000_configure(struct e1000_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	e1000_set_rx_mode(netdev);
+	netif_schedule_rx_mode_work(netdev);
 
 	e1000_restore_vlan(adapter);
 	e1000_init_manageability(adapter);
@@ -823,6 +824,7 @@ static const struct net_device_ops e1000_netdev_ops = {
 	.ndo_stop		= e1000_close,
 	.ndo_start_xmit		= e1000_xmit_frame,
 	.ndo_set_rx_mode	= e1000_set_rx_mode,
+	.ndo_write_rx_mode	= e1000_write_rx_mode,
 	.ndo_set_mac_address	= e1000_set_mac,
 	.ndo_tx_timeout		= e1000_tx_timeout,
 	.ndo_change_mtu		= e1000_change_mtu,
@@ -1827,7 +1829,7 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 	/* This is useful for sniffing bad packets. */
 	if (adapter->netdev->features & NETIF_F_RXALL) {
 		/* UPE and MPE will be handled by normal PROMISC logic
-		 * in e1000e_set_rx_mode
+		 * in e1000_write_rx_mode
 		 */
 		rctl |= (E1000_RCTL_SBP | /* Receive bad packets */
 			 E1000_RCTL_BAM | /* RX All Bcast Pkts */
@@ -2222,26 +2224,39 @@ static int e1000_set_mac(struct net_device *netdev, void *p)
 	return 0;
 }
 
+static void e1000_set_rx_mode(struct net_device *netdev)
+{
+	struct e1000_adapter *adapter = netdev_priv(netdev);
+
+	bool allmulti = !!(netdev->flags & IFF_ALLMULTI);
+	bool promisc = !!(netdev->flags & IFF_PROMISC);
+	bool vlan = e1000_vlan_used(adapter);
+
+	netif_rx_mode_set_flag(netdev, NETIF_RX_MODE_UC_SKIP, promisc);
+
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_VLAN, vlan);
+}
+
 /**
- * e1000_set_rx_mode - Secondary Unicast, Multicast and Promiscuous mode set
+ * e1000_write_rx_mode - Secondary Unicast, Multicast and Promiscuous mode set
  * @netdev: network interface device structure
  *
- * The set_rx_mode entry point is called whenever the unicast or multicast
- * address lists or the network interface flags are updated. This routine is
- * responsible for configuring the hardware for proper unicast, multicast,
- * promiscuous mode, and all-multi behavior.
+ * This routine is responsible for configuring the hardware for proper unicast,
+ * multicast, promiscuous mode, and all-multi behavior.
  **/
-static void e1000_set_rx_mode(struct net_device *netdev)
+static void e1000_write_rx_mode(struct net_device *netdev)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	struct netdev_hw_addr *ha;
 	bool use_uc = false;
 	u32 rctl;
 	u32 hash_value;
-	int i, rar_entries = E1000_RAR_ENTRIES;
+	int i, rar_entries = E1000_RAR_ENTRIES, ni;
 	int mta_reg_count = E1000_NUM_MTA_REGISTERS;
 	u32 *mcarray = kcalloc(mta_reg_count, sizeof(u32), GFP_ATOMIC);
+	char *ha_addr;
 
 	if (!mcarray)
 		return;
@@ -2250,22 +2265,22 @@ static void e1000_set_rx_mode(struct net_device *netdev)
 
 	rctl = er32(RCTL);
 
-	if (netdev->flags & IFF_PROMISC) {
+	if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		rctl |= (E1000_RCTL_UPE | E1000_RCTL_MPE);
 		rctl &= ~E1000_RCTL_VFE;
 	} else {
-		if (netdev->flags & IFF_ALLMULTI)
+		if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI))
 			rctl |= E1000_RCTL_MPE;
 		else
 			rctl &= ~E1000_RCTL_MPE;
 		/* Enable VLAN filter if there is a VLAN */
-		if (e1000_vlan_used(adapter))
+		if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_VLAN))
 			rctl |= E1000_RCTL_VFE;
 	}
 
-	if (netdev_uc_count(netdev) > rar_entries - 1) {
+	if (netif_rx_mode_uc_count(netdev) > rar_entries - 1) {
 		rctl |= E1000_RCTL_UPE;
-	} else if (!(netdev->flags & IFF_PROMISC)) {
+	} else if (!netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		rctl &= ~E1000_RCTL_UPE;
 		use_uc = true;
 	}
@@ -2286,23 +2301,23 @@ static void e1000_set_rx_mode(struct net_device *netdev)
 	 */
 	i = 1;
 	if (use_uc)
-		netdev_for_each_uc_addr(ha, netdev) {
+		netif_rx_mode_for_each_uc_addr(ha_addr, netdev, ni) {
 			if (i == rar_entries)
 				break;
-			e1000_rar_set(hw, ha->addr, i++);
+			e1000_rar_set(hw, ha_addr, i++);
 		}
 
-	netdev_for_each_mc_addr(ha, netdev) {
+	netif_rx_mode_for_each_mc_addr(ha_addr, netdev, ni) {
 		if (i == rar_entries) {
 			/* load any remaining addresses into the hash table */
 			u32 hash_reg, hash_bit, mta;
-			hash_value = e1000_hash_mc_addr(hw, ha->addr);
+			hash_value = e1000_hash_mc_addr(hw, ha_addr);
 			hash_reg = (hash_value >> 5) & 0x7F;
 			hash_bit = hash_value & 0x1F;
 			mta = (1 << hash_bit);
 			mcarray[hash_reg] |= mta;
 		} else {
-			e1000_rar_set(hw, ha->addr, i++);
+			e1000_rar_set(hw, ha_addr, i++);
 		}
 	}
 
@@ -5094,7 +5109,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 
 	if (wufc) {
 		e1000_setup_rctl(adapter);
-		e1000_set_rx_mode(netdev);
+
+		if (netif_running(netdev))
+			netif_schedule_rx_mode_work(netdev);
 
 		rctl = er32(RCTL);
 
-- 
2.47.3

