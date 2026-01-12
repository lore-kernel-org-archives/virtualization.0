Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE53803ED
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241856; cv=none; b=EmCOgWj6CEAGM3oCR/ZkiA63OFREFMpvjCFLDY1+hVISgWhxM/aWUECbZLlEbpGp0if0psTmz8CQlsQAqe5ZWI3tLMW8XREN1BAusChtRDYOuAhjh9ctM15H8ONwAy78gfs4etllT66Ue6+50JMJF026pD0MyNSX1GTTIQAo3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241856; c=relaxed/simple;
	bh=zUlknjpr6NS/41pV6wwhH8kUJOwAMPCghxbyamS0MmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjDXaSllHJWPxac/xZ9dpp1O1hBpN6IdpFzpZis6LcO2ggSYQcVbxUUDA9YGdtaHYpW7Kspp2YIZ/vkDJh4ucjRmI5uE4RbsBKvITZNsU1PN7OhdX89hnFg5ksGGwGMIoDJaOFsBRgD9Vo9fijCwlQVkDViwBvZUVrrt9MhCps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzqnFECo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzqnFECo"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c026e074373so3174986a12.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241854; x=1768846654; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaMWg4vSUFgDqiP4zZzxboikLWW6MxJC8CsR8zCkSA4=;
        b=kzqnFECo81QUoYMP1c8u3dSONyK1KJR+pW4CcgXP53eb91sWxPCezDzgRKA86GxtuE
         jy2jZJlV7evnOtLjg4a4mih4zDeQn+ynji0DwubmoiEoIaaFqeVPf+frc480MYVOYtcx
         5aK5oPPEIbjWMlI+Hx2Vlw9ejbZCwSt6mXZHkO/hDqsIS06Db6BpnYENVLXsfXc7rV92
         zCpxFe/EGPDmXZzn38kblJedHZimndbU6/ADgoDbFxVB9WgIXi/fKpaDLWAeWxoqdYna
         VMBxVfcKLIYtPWv2Fti2fNld5NM3EOToPKyqIfYoXwcLLS2sOD//enE8me3Am7CeHT2M
         ytRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241854; x=1768846654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UaMWg4vSUFgDqiP4zZzxboikLWW6MxJC8CsR8zCkSA4=;
        b=FA+h0rn9N+9A7hilkeZ8hkwQuBRQ+4GPspJ1vqSXGFFPTY0GXqN2YqX7DAFqoSvzi5
         5cQhcvD+1HGpmHSG49sma72rgO9B1Dxv/GqrHM7gH/tZ0lMz1Cs3s1f6DhHVm1Fa4pk4
         UtxdpafkgCUemE1UJLI1zf5DsMEJwrkDn5Ck7NVR4Ybk02E16VO5iMhbevAA5wcyZaPU
         PBQSwqLsj9zqdBBIi+hK51epk9taw0DZHjBIunj1m4jPcr6B/BzGG+0XDrwoG2PaD8OV
         gtMH46qBw3e+T1JHfN3dt5BNTNKY+vQTidxDwHA84n0Yv9almLuLeFiREUIt/R+NtVTQ
         Jc8A==
X-Forwarded-Encrypted: i=1; AJvYcCWlUQJbWLJ3uj5NW9ZsCVnSsakrZSfEZ98S97BFy5oFOdGhWqGfClOHxpKn5NQBMQtPEBFI8kd9Ygd5vVJRZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6gEW+SGORai4B1e15dyWU+2XFYr7l1AFOFiPkBkN2iSlvKOkM
	EXOwHvg+1VkOvFKobjgvpSGNx/995t75LhE7TEUHQS68hj1M1x7qJ0yed6Lr3w==
X-Gm-Gg: AY/fxX6TuwTm+1Fl+jydK/1DL2Wl2yoLX5xEu2MCsfvGJQpIQCdtfOVAx4kuythXOV/
	CMdYvkip46GA7RvGV8nBkfmH1ZNfVSF8cQsR+t0giXqa5Q9Hnq6JMiF3I01n0tCdDoGVK+4qZhh
	K0EsUcuJbqlxkdheXFwZg0vJffr4YRDq/ynjgUZYfUc5e6HUYuJdNlWIWtwG/bEH5JWXHXZZ2lh
	Io3+OtvEG0yNGR3JwbOKqUsjs2CoPaR4haRLrtx8/IGuGenHtlIv+b5yppcwAGUn43R8BGFTgg6
	QK8Sh7Td815+0/N23iqHLZekMn81/S38qL4Gyt57bOKFgL5Tzwt2o6Aa/2/YZW/Horccyz/QiZt
	XNLxd+plAjosPuqqaGY/8ilQzyolcZhNwXnH66by+l5Z0r/2iOFf3FAQspJpvnVsS4qvuyGDKyd
	JR0LqKnenjdt4q487qa5QTY8AHWRucOF8f/8gnJnOGaiOzWkMEmwBEiV6h5LZg9PDdJg==
X-Google-Smtp-Source: AGHT+IHoeAxVt0AuWhhUsDTjmxXGaTHs8ySg3i9SS+DIkrhT+vbgKe7J+QXpC64qK2Vzx3i2dgGt/Q==
X-Received: by 2002:a17:90b:4acb:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-34f68b4ce84mr16936898a91.8.1768241854053;
        Mon, 12 Jan 2026 10:17:34 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:33 -0800 (PST)
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
Subject: [PATCH net-next v8 4/6] 8139cp: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:24 +0530
Message-ID: <20260112181626.20117-5-viswanathiyyappan@gmail.com>
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
 In the old cp_set_rx_mode, cp->lock was protecting access to registers
 at addresses RxConfig, MAR0 and MAR0+4. The lock was probably meant to 
 provide synchronization for cp_set_rx_mode as these registers were 
 accessed exclusively by __cp_set_rx_mode.
 
 drivers/net/ethernet/realtek/8139cp.c | 33 +++++++++++++++------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..ab0395640305 100644
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
+static void cp_write_rx_mode(struct net_device *dev)
 {
 	struct cp_private *cp = netdev_priv(dev);
 	u32 mc_filter[2];	/* Multicast hash filter */
+	char *ha_addr;
 	int rx_mode;
+	int ni;
 
 	/* Note: do not reorder, GCC is clever about common statements. */
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_rx_mode_get_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Unconditionally log net taps. */
 		rx_mode =
 		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
 		    AcceptAllPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
-		   (dev->flags & IFF_ALLMULTI)) {
+	} else if ((netif_rx_mode_mc_count(dev) > multicast_filter_limit) ||
+		   netif_rx_mode_get_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI)) {
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
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static void __cp_get_stats(struct cp_private *cp)
@@ -1040,7 +1042,7 @@ static void cp_init_hw (struct cp_private *cp)
 	cp_start_hw(cp);
 	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
 
-	__cp_set_rx_mode(dev);
+	netif_schedule_rx_mode_work(dev);
 	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
@@ -1262,7 +1264,7 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	cp_clean_rings(cp);
 	cp_init_rings(cp);
 	cp_start_hw(cp);
-	__cp_set_rx_mode(dev);
+	netif_schedule_rx_mode_work(dev);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
 
 	netif_wake_queue(dev);
@@ -1870,6 +1872,7 @@ static const struct net_device_ops cp_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address 	= cp_set_mac_address,
 	.ndo_set_rx_mode	= cp_set_rx_mode,
+	.ndo_write_rx_mode	= cp_write_rx_mode,
 	.ndo_get_stats		= cp_get_stats,
 	.ndo_eth_ioctl		= cp_ioctl,
 	.ndo_start_xmit		= cp_start_xmit,
-- 
2.47.3

