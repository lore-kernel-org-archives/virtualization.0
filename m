Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C0261B71
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512990; cv=none; b=hKSpPXN3F+fSfhxC5LDuM7oBzjekUh7QDTeEpN8TeSr1eh6HT4mRmofHAqrrAefmaThvdP09Jobhxa6O05hEj5j3XbC2axIwJaCTZuPMOZbvTMelZQnfXyr6IjmYeh2/iAwVhV4hmuKhyUOo7CWjEjoCTh68WXcV0/uPMOFImBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512990; c=relaxed/simple;
	bh=1tG9qcJg/ScoAbc2s3rBPup6tclQThm8ZNIWVQwHMpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXoMmr8Tj5HnXdsPS0c+GqlxRwmNQ16dkMZa7wPnlAls8vMmgcuZoLyMMORYPhDLK5BfAg28vorm9re0lf5j87BICLyqSrwCSlsIioxzxTR2IF6wsUTC9eb56NNtYi0w50AdrtCravVsLMovXZ9IbMYP6VMmL3DHEVfNKlYUqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4A8mLYE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4A8mLYE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so40184575ad.2
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512988; x=1774117788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JSH/0/b9giaRQVQnVF9Hnbf5bM9rYVcnC9nwZ0R2/U=;
        b=f4A8mLYEGKBRwil65vnB4CSr+38jg/GSQy+rzSEAOKPa9YK/IManO6xlJTud5+UOEc
         vGxJx0opqUBkEW3o51qIK3CLVbH45ZsfoBCG90AtOTh8lP/gEwBs9V+ujNLQ+EUkLRu8
         fejKATwrSdXMwwvZU7WDNPxAvDMTACsA+hmZyEjHlvqQDeCyQzAT8KWOyvl7Xe/wQaS7
         /YqzcOjq/CPiZIswJSpSs8kBaPFPuiDZmsez8ddyshZ3nDhXdCCYqkDqW8nCDgN46L+d
         2BshCVeSK2EC3wu8Ga0MKnF+RaRqUyQ8LwE+1TJcSHWSG71teNy4sfptGIJ4S9HKPmpb
         WS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512988; x=1774117788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JSH/0/b9giaRQVQnVF9Hnbf5bM9rYVcnC9nwZ0R2/U=;
        b=dPF4AXu19cZbZNmAb8BMY8j6sUq5lTlS+1mWwOTuaOh/sx9/cyKFhHcDFZP+Ad09Mr
         5s4B6b6Sjfb4yc3GRwJMOu/qJuL2jGGdwcfgwcW5N0Pta26OJjJmJP1IPBUBUAXW1EbN
         +f95BUAq8J2KIbK8PkoThJ9VC+llPnq3jMi9FVCD30y3lyWHHQvtvevgyigNC6fqqHGP
         sSLj7Nowb0/+NHiiVrXLftg19xqB9/5K2031dq8eg7HE1HNwqKT5zf0RZOt/h9ZoNptd
         xz1m5W9FukEvoMLi0Wfbh8KPVQ8K5m2wlhmlwzlMHE3qKTlE40yNAvDC7nmec3Y3+ETM
         y74g==
X-Forwarded-Encrypted: i=1; AJvYcCUNplx/hvGOkjRHz0IyKLV6TrGLeIiyYdKoNK7GW52ZBhRJ+56pqo20SsBoq1RJBjjp73oS26+cCsyutjx0Uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBsqLSIazShV/z6za/XeElN53uQW2vVOApdolE2fO58qMsH/Nv
	hFxzgG3fPSg09k+I7vThbseeKxcUrEyV0Sk1qo4sbnBpuLqlYEyPYB1U
X-Gm-Gg: ATEYQzzBsto7TUde/EQh4oiLMRlCnLOglpuF4wPrFmbTDttBoyN1QidRxIhP0D2KwHh
	H0wu/uIlVliKQU/CvQeu4nvRql/g4HTygH6kc4KwFYZhQlvuXxQeKqF3fIhElw9AlJCdLCZxtuS
	SEaj+6bMJPGFVfuBAvoxvIM1eLXf8MUZwxYT2Am0z7Os3/Wp8LMBG0w+0kxmErORo7ymfFH2Hm4
	BmeSREZuWRD5pylFkEc8JCZUEyJFyKhZLwvW3qf3r0dQkCweXmGnzaVsj3wqBp+TBMpJjqz3UmN
	5wy3vmU98QbTaXo1b/VIB+oyT7QW4XPWIzdspUMdufnN3EdzkTGJpRK02EtWZUnNbeVvR1P/Y0C
	EX3Unq/nVslhB+2/FboxdtJFL5uIyz7y5GLsQt4vmzeOcNje2OsmZvkc1/d56xYnBTXxfYUYCti
	6C+x1GDRJw14Vz7mEO+Q6ZUSVsKfyxjZvNBQkbPriyWgyOnxsAu1mBIEZO+/R9gV8Rhyw3qxGXw
	KtFIQ==
X-Received: by 2002:a17:903:90f:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2aeca999738mr72086855ad.19.1773512988217;
        Sat, 14 Mar 2026 11:29:48 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:47 -0700 (PDT)
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
Subject: [PATCH net-next v9 7/7] pcnet32: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:09 +0530
Message-ID: <20260314182809.362808-8-viswanathiyyappan@gmail.com>
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
 
There are no calls to netif_set_rx_mode in pcnet32
 
 drivers/net/ethernet/amd/pcnet32.c | 65 ++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 911808ab13a7..d5ad96985d68 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -314,8 +314,9 @@ static void pcnet32_tx_timeout(struct net_device *dev, unsigned int txqueue);
 static irqreturn_t pcnet32_interrupt(int, void *);
 static int pcnet32_close(struct net_device *);
 static struct net_device_stats *pcnet32_get_stats(struct net_device *);
-static void pcnet32_load_multicast(struct net_device *dev);
+static void pcnet32_load_multicast(struct net_device *dev, bool is_open);
 static void pcnet32_set_multicast_list(struct net_device *);
+static void pcnet32_set_multicast_list_async(struct net_device *);
 static int pcnet32_ioctl(struct net_device *, struct ifreq *, int);
 static void pcnet32_watchdog(struct timer_list *);
 static int mdio_read(struct net_device *dev, int phy_id, int reg_num);
@@ -1580,6 +1581,7 @@ static const struct net_device_ops pcnet32_netdev_ops = {
 	.ndo_tx_timeout		= pcnet32_tx_timeout,
 	.ndo_get_stats		= pcnet32_get_stats,
 	.ndo_set_rx_mode	= pcnet32_set_multicast_list,
+	.ndo_set_rx_mode_async	= pcnet32_set_multicast_list_async,
 	.ndo_eth_ioctl		= pcnet32_ioctl,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
@@ -2260,7 +2262,7 @@ static int pcnet32_open(struct net_device *dev)
 
 	lp->init_block->mode =
 	    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
-	pcnet32_load_multicast(dev);
+	pcnet32_load_multicast(dev, true);
 
 	if (pcnet32_init_ring(dev)) {
 		rc = -ENOMEM;
@@ -2676,18 +2678,26 @@ static struct net_device_stats *pcnet32_get_stats(struct net_device *dev)
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
+		allmulti = netif_get_rx_mode_cfg(dev,
+						 NETIF_RX_MODE_CFG_ALLMULTI);
+
 	/* set all multicast bits */
-	if (dev->flags & IFF_ALLMULTI) {
+	if (allmulti) {
 		ib->filter[0] = cpu_to_le32(~0U);
 		ib->filter[1] = cpu_to_le32(~0U);
 		lp->a->write_csr(ioaddr, PCNET32_MC_FILTER, 0xffff);
@@ -2701,20 +2711,41 @@ static void pcnet32_load_multicast(struct net_device *dev)
 	ib->filter[1] = 0;
 
 	/* Add addresses */
-	netdev_for_each_mc_addr(ha, dev) {
-		crc = ether_crc_le(6, ha->addr);
-		crc = crc >> 26;
-		mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+	if (is_open) {
+		netdev_for_each_mc_addr(ha, dev) {
+			crc = ether_crc_le(6, ha->addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
+	} else {
+		netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni) {
+			crc = ether_crc_le(6, ha_addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
 	}
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
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+}
+
 /*
  * Set or clear the multicast filter for this adaptor.
  */
-static void pcnet32_set_multicast_list(struct net_device *dev)
+static void pcnet32_set_multicast_list_async(struct net_device *dev)
 {
 	unsigned long ioaddr = dev->base_addr, flags;
 	struct pcnet32_private *lp = netdev_priv(dev);
@@ -2723,7 +2754,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 	spin_lock_irqsave(&lp->lock, flags);
 	suspended = pcnet32_suspend(dev, &flags, 0);
 	csr15 = lp->a->read_csr(ioaddr, CSR15);
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_get_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Log any net taps. */
 		netif_info(lp, hw, dev, "Promiscuous mode enabled\n");
 		lp->init_block->mode =
@@ -2734,7 +2765,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 		lp->init_block->mode =
 		    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
 		lp->a->write_csr(ioaddr, CSR15, csr15 & 0x7fff);
-		pcnet32_load_multicast(dev);
+		pcnet32_load_multicast(dev, false);
 	}
 
 	if (suspended) {
@@ -2922,6 +2953,7 @@ static int __maybe_unused pcnet32_pm_suspend(struct device *device_d)
 		pcnet32_close(dev);
 	}
 
+	netif_disable_async_ops(dev);
 	return 0;
 }
 
@@ -2929,6 +2961,7 @@ static int __maybe_unused pcnet32_pm_resume(struct device *device_d)
 {
 	struct net_device *dev = dev_get_drvdata(device_d);
 
+	netif_enable_async_ops(dev);
 	if (netif_running(dev)) {
 		pcnet32_open(dev);
 		netif_device_attach(dev);
@@ -2937,6 +2970,13 @@ static int __maybe_unused pcnet32_pm_resume(struct device *device_d)
 	return 0;
 }
 
+static void pcnet32_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	netif_disable_async_ops(dev);
+}
+
 static void pcnet32_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -2964,6 +3004,7 @@ static struct pci_driver pcnet32_driver = {
 	.driver = {
 		.pm = &pcnet32_pm_ops,
 	},
+	.shutdown = pcnet32_shutdown,
 };
 
 /* An additional parameter that may be passed in... */
-- 
2.47.3

