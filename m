Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F693803ED
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241873; cv=none; b=c7224CCqsNLkjuPd+r8n8sO6+tRbg03Qmd7Te7aWFOn69rAef1FLm+8/tctrrzv29lF0ERPyi46zZf8vvmjbjRMpvE1qY7XJwbpS8oaiV0kRiwKj+cSl9rolsZcMbe6asoIAhL5P3U52sbg4yARPAa6IMkKv41y4we2p+J6+Xt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241873; c=relaxed/simple;
	bh=7+9/4nymDsorNrdw/Y+cdaz+q2znF/7yqtVvfiRWfiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=analr3qoiUOzklYCV3W3QP6ra/ZUOr0LWA2hZZinsgDUSydyiFqyfhTrcS88IKeXQ6vxyHJGVTVMn05o2iZqMiWGBxJZ/WH/UZGzfpsi+U4eDT3vATm7pA4zPq1KEMXMsyX1n5cEsCvsgNgMR47lIuWNoVslacbViXKpS9hR2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If1Go68w; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If1Go68w"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so5270801a91.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241871; x=1768846671; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iPYz0c2/YOE9HPEJLTZDgF+3tXabqT+BOwl+/nVPFU=;
        b=If1Go68wI9I3xKZD1TcDiFCZKRnAoyWjrrqO6/TRIIn4nfgiSxDuXwBUoKNKk9UtOn
         08hklNH/eQdzUcF5V9OOj4z4HvCJr6hifjmN/TVgmqBaVoj6xYOUxTmEPXxeowvE/p7N
         C3poSEQ7z/3a+3edPbc6nAWgGtBCxNj/scfzkjnd+dOTzMkOjyo9Adkpdo5n+aAD32li
         57YaPD04QqBQLllcCZixhJbGcY4lz3eZjjZ3eUF4rHzBn9LfC0P0zb5HKPogRLRTJgop
         QHuGg6FTbwKEfCRSpSLeNGL/B1i/dq+fSkmfqWV0NTe+8rSq3wat5M3PqDcXmxdKb3r4
         fKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241871; x=1768846671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iPYz0c2/YOE9HPEJLTZDgF+3tXabqT+BOwl+/nVPFU=;
        b=FznLjPCZNEFZlCUyXyAWUNTMjaTCBMsjLOUsmjWZ+QlTOGBcG5oE4d05+2MCvX0q8f
         mJxX3/6Y3EormvzEBd3//X2unMBcERbpZornsyTd2q1ApNNkmQ4LopxBAKi2AynrTaXw
         kkmjrOdcN47wFKRrg2AWiEwPYd0Y/zReAC9wTQPhutzf4dr52j4dU53Vpvql8Ql200tB
         vHobQC8h+iyUp3Hi2aq8mP3Rodtbzk+w1e5XCDevtVQJcHmPVlBSnHUPaWE7KkyJFKrf
         FCjtO8izJtey+bwIbFYXsWSrvaovVmGuxHJlUYpEwPbZ9dCPPSuzoBrlAdhTeErt7Xgz
         ufdg==
X-Forwarded-Encrypted: i=1; AJvYcCUun4ScyeAg0TreXLliR0h2nI4SddruxLxRye9CBVPxT6aYEqiNytRr7GL9iVKx/q+EjKrSwBz2TBe0yTHuzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfOfD7smVtWk/mFj6tZFwlvrothCTIYh7LKYWa3cwvQe1wBUyJ
	MkPgcfLNtMLFTo9p0yxq50t4XBD2wgf82Cp0G4FcuiFQb+MO3VMOsHRv
X-Gm-Gg: AY/fxX6p8vELz/Xy8thvxAMP5i/H3wLaf0m1/xiQo5SP2+7BZJhfMfAN9Y82+ObzdyH
	EpNpO+J6p5RLLn1xt8c0qtjMdZhKG/Vp9OCBxYTi6M5LNzHW2WbrvCxlanct+mcdLid3KFaOVfY
	H5eQbOsNw39/4QaCI699LRJCOvo93x/PfNxBn9KcdDl4jFk651VN+Y0ErPsrAqsELD1yOBJpirg
	gmre87HdSDQYqCmZcQnwMt1VFr1hONKEPXZHw51zHjehuO7C+ptc9du0mfK19Lr1MKIf1WByBON
	5QEZMgSBAvlG1QbmAFqRcoqSHkl8N8/fAz1BXZR+s891XY18cPmfgEA4UFu/9CIK9XZMXykD/bF
	+Ycx5HyaE6wUPvor/oOAEoTGkHlKwTNBP/YjXOxbeUfNpW+FD9u8mFLYUapP0El/edqApnpYWcB
	r45Us7i6uO43fqSZiXatzhqPkgNEh/O8OZzpCsnali6seLPkNegriDz9WOBKF6Jp4z/w==
X-Google-Smtp-Source: AGHT+IFiK1jweRQzBOm3ZEpB+UiR7srhpNL+qg9Y/k0eatbaDQCE66uWR/fEIuhnV//+2MGMla7rxw==
X-Received: by 2002:a17:90b:5628:b0:34a:8c77:d386 with SMTP id 98e67ed59e1d1-34f68c91bbemr16740424a91.9.1768241871384;
        Mon, 12 Jan 2026 10:17:51 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:50 -0800 (PST)
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
Subject: [PATCH net-next v8 6/6] pcnet32: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:26 +0530
Message-ID: <20260112181626.20117-7-viswanathiyyappan@gmail.com>
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
 This is a very weird driver in that it calls pcnet32_load_multicast to set up
 the mc filter registers instead of the set_rx_mode callback in ndo_open.
 I can't find a single other driver that does that.
 
 Apart from that, I don't think it makes sense for the (now) write_rx_mode 
 callback to call netif_wake_queue(). Correct me if I am wrong here.
 
 drivers/net/ethernet/amd/pcnet32.c | 57 ++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 9eaefa0f5e80..8bb0bb3da789 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -314,8 +314,9 @@ static void pcnet32_tx_timeout(struct net_device *dev, unsigned int txqueue);
 static irqreturn_t pcnet32_interrupt(int, void *);
 static int pcnet32_close(struct net_device *);
 static struct net_device_stats *pcnet32_get_stats(struct net_device *);
-static void pcnet32_load_multicast(struct net_device *dev);
+static void pcnet32_load_multicast(struct net_device *dev, bool is_open);
 static void pcnet32_set_multicast_list(struct net_device *);
+static void pcnet32_write_multicast_list(struct net_device *);
 static int pcnet32_ioctl(struct net_device *, struct ifreq *, int);
 static void pcnet32_watchdog(struct timer_list *);
 static int mdio_read(struct net_device *dev, int phy_id, int reg_num);
@@ -1580,6 +1581,7 @@ static const struct net_device_ops pcnet32_netdev_ops = {
 	.ndo_tx_timeout		= pcnet32_tx_timeout,
 	.ndo_get_stats		= pcnet32_get_stats,
 	.ndo_set_rx_mode	= pcnet32_set_multicast_list,
+	.ndo_write_rx_mode	= pcnet32_write_multicast_list,
 	.ndo_eth_ioctl		= pcnet32_ioctl,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
@@ -2264,7 +2266,7 @@ static int pcnet32_open(struct net_device *dev)
 
 	lp->init_block->mode =
 	    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
-	pcnet32_load_multicast(dev);
+	pcnet32_load_multicast(dev, true);
 
 	if (pcnet32_init_ring(dev)) {
 		rc = -ENOMEM;
@@ -2680,18 +2682,26 @@ static struct net_device_stats *pcnet32_get_stats(struct net_device *dev)
 }
 
 /* taken from the sunlance driver, which it took from the depca driver */
-static void pcnet32_load_multicast(struct net_device *dev)
+static void pcnet32_load_multicast(struct net_device *dev, bool is_open)
 {
 	struct pcnet32_private *lp = netdev_priv(dev);
 	volatile struct pcnet32_init_block *ib = lp->init_block;
 	volatile __le16 *mcast_table = (__le16 *)ib->filter;
 	struct netdev_hw_addr *ha;
+	char *ha_addr;
+	bool allmulti;
 	unsigned long ioaddr = dev->base_addr;
-	int i;
+	int i, ni;
 	u32 crc;
 
+	if (is_open)
+		allmulti = dev->flags & IFF_ALLMULTI;
+	else
+		allmulti = netif_rx_mode_get_cfg(dev,
+						 NETIF_RX_MODE_CFG_ALLMULTI);
+
 	/* set all multicast bits */
-	if (dev->flags & IFF_ALLMULTI) {
+	if (allmulti) {
 		ib->filter[0] = cpu_to_le32(~0U);
 		ib->filter[1] = cpu_to_le32(~0U);
 		lp->a->write_csr(ioaddr, PCNET32_MC_FILTER, 0xffff);
@@ -2705,20 +2715,40 @@ static void pcnet32_load_multicast(struct net_device *dev)
 	ib->filter[1] = 0;
 
 	/* Add addresses */
-	netdev_for_each_mc_addr(ha, dev) {
-		crc = ether_crc_le(6, ha->addr);
-		crc = crc >> 26;
-		mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
-	}
+	if (is_open)
+		netdev_for_each_mc_addr(ha, dev) {
+			crc = ether_crc_le(6, ha->addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
+	else
+		netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni) {
+			crc = ether_crc_le(6, ha_addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
+
 	for (i = 0; i < 4; i++)
 		lp->a->write_csr(ioaddr, PCNET32_MC_FILTER + i,
 				le16_to_cpu(mcast_table[i]));
 }
 
+static void pcnet32_set_multicast_list(struct net_device *dev)
+{
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
+
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+}
+
 /*
  * Set or clear the multicast filter for this adaptor.
  */
-static void pcnet32_set_multicast_list(struct net_device *dev)
+static void pcnet32_write_multicast_list(struct net_device *dev)
 {
 	unsigned long ioaddr = dev->base_addr, flags;
 	struct pcnet32_private *lp = netdev_priv(dev);
@@ -2727,7 +2757,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 	spin_lock_irqsave(&lp->lock, flags);
 	suspended = pcnet32_suspend(dev, &flags, 0);
 	csr15 = lp->a->read_csr(ioaddr, CSR15);
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_rx_mode_get_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Log any net taps. */
 		netif_info(lp, hw, dev, "Promiscuous mode enabled\n");
 		lp->init_block->mode =
@@ -2738,7 +2768,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 		lp->init_block->mode =
 		    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
 		lp->a->write_csr(ioaddr, CSR15, csr15 & 0x7fff);
-		pcnet32_load_multicast(dev);
+		pcnet32_load_multicast(dev, false);
 	}
 
 	if (suspended) {
@@ -2746,7 +2776,6 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 	} else {
 		lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);
 		pcnet32_restart(dev, CSR0_NORMAL);
-		netif_wake_queue(dev);
 	}
 
 	spin_unlock_irqrestore(&lp->lock, flags);
-- 
2.47.3

