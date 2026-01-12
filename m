Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE62387599
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241839; cv=none; b=GPWpsZgfLrRLFDLfnecVf8a97TxFQaVJO4NlT3rh+S8F64yXnlmeX5po7zkO1onhiBgUpa/SduwiOa3BqUDXE/MMafUWuiQadzfSBlsDh3k4nPMtphRqCJiTmRRyvVIGJv4+iR7L8pYrBssEqg3PnGA9XvNLysuprV4uaolnQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241839; c=relaxed/simple;
	bh=YeEECS+9gv6pPb+XI2q4y6WMjTCq42i43DPhJPeCZkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU392o+o3wnf3N75bjSJcMKHhdPmTjtEyrfa6IpT/0/1hGBIEkeweNp1OOUaZ0h81vlRuHmMDXmiEGLvH51S5XRUpSUs057JCiccm6g1Islr48E5FArP2Of7ID5Kaq5+HYnucfGFdvddsFfLp0J8S2MID+nlWgjSm6a/xoLKOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN5Z5utn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN5Z5utn"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2802269a12.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241836; x=1768846636; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqJBVDW73KCgBwgVWk5qYLsHzLDdObx2o+GjzAsqssQ=;
        b=YN5Z5utnG0Y95syhQl7p6BuIBjo1fxX9uUixFgeejrpvkslRgBUPnmQxApd+bPsKsW
         HzItw6c+z7U2xVoAO1NQ8xY3vOq+DCn6R34mxlvaxAhOC+aaemqbJjlit2JxbvuEKO4b
         lFIqOOsQcNWi34HvFD1Hu1130//YACH+RrF3/GPf2ZXUP0FRToMH73Us/TdBvAKHTZ0w
         mw31mP2I2GxV0Ir9m5x54GhSii2UJX5bOaUJW6+p7pM7fHEVvCzQkv9Mqpq0yPvQire6
         gQBtPjwAj7c2DtzuljYSy8yj78Al464dRxuwsXhnruQzQuX9OQbezuiBI8zXLVL5JVAl
         fn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241836; x=1768846636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqJBVDW73KCgBwgVWk5qYLsHzLDdObx2o+GjzAsqssQ=;
        b=h71oWPzoHbZmk+8Gstvoxkj4KTIOrYLY9dSY0AAOVcf2mMcl16I+iDwsQuKgPASl2g
         1Gj4Dd8HKe1UPCu5EQP9s+Pq4FeLbyeDciltPiH1hEvzoXMnAn0Ja8oxqtgOpatkgwcO
         iqaM5EdSCQlQQ2clet46Gi5PNK5HYhgRltQi329iDlJlypyLkVA+0NBkWvbwO6Pz7ZA2
         RBeAfp8h8rz/47l7ffGU4TmaFe1aeNO36xjgPY0n0DVq8fXY9JHsTgFkD072FNghPUKb
         CFvw+A+pj7K8d8dsZGfyjhuTRpv9CqWnzC/nKJNS86KQLeXFea4FIwrh2vHm47OEdXgI
         g2bw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ifTzGYVEEkD0LWGr2Co9/m51SR22EKJ25SCSrE5969W92KbKtpKQUTaVfqSNq1mna9E9iBa+9sj7eR/MDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKbP3yfMbXls+h9APjIOuR7F6BsbPLXcjHEcQaUVuAPanR3MNi
	NhOyNRMUHMfpZ4Qfjse01O8mfQPVvS9dGBo7BIttDgndBwtLN7xHDam1
X-Gm-Gg: AY/fxX7bAINAz98ABAzJzqlmYk3HdPpV+gt/FjsBpVT+zqVB4/LT+31gSII+o5clXiH
	GEfscdIo2C9BbPT27NQ0l+HUSt8lOOWix6zGIzuqaAnqSVxLotl7D7HM1fXTJTelfA3N4ENp2QT
	VV/MLIPQxPFNiRe6YW7UGNtP/Yybsc/hHONkYtDcVmD2+DIQR4+bFql5EE5xdq+l/J5kqwiay9S
	Th/3ciA+yjzG8zQusYOUSiY1uQtGm5NvSc/ObdZYcoYotL4hOFolQqMep2j7pY8d3YTvZhy4NDe
	6CP3KLb7YCeXIEGJSLUoBZqVGX+/f3Y2VgIN7IdXG3zxzG87Li3Ul5dVCCeQY2SKf1A2rnZSuuP
	nb/nzkpmR3IvSKwqhGhtsWflkMOxppUlyWTOCDloRlEECgMuLFx40Eu5/UDWvhS6iOX6VHsr2v1
	fHx35bP3PYuLac3AuMPohkppmAbjsxB8884/b0VLq13cs3naMQy1KkHxgkU5ZJPuKb6Q==
X-Google-Smtp-Source: AGHT+IFz60SshqGbcLnvzcM3MjSw6gKXYr6Y8WSw1HT0006/my+JtsdMnEbYpRT5lPUoqFpp4CsP0A==
X-Received: by 2002:a17:90b:3c45:b0:339:eff5:ef26 with SMTP id 98e67ed59e1d1-34f68cb94f4mr16313803a91.30.1768241836105;
        Mon, 12 Jan 2026 10:17:16 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:15 -0800 (PST)
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
Subject: [PATCH net-next v8 2/6] virtio-net: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:22 +0530
Message-ID: <20260112181626.20117-3-viswanathiyyappan@gmail.com>
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
 drivers/net/virtio_net.c | 61 +++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 22d894101c01..1d0e5f6ceb88 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -460,9 +460,6 @@ struct virtnet_info {
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
-	/* Work struct for setting rx mode */
-	struct work_struct rx_mode_work;
-
 	/* OK to queue work setting RX mode? */
 	bool rx_mode_work_enabled;
 
@@ -3866,33 +3863,30 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
-static void virtnet_rx_mode_work(struct work_struct *work)
+static void virtnet_write_rx_mode(struct net_device *dev)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, rx_mode_work);
+	struct virtnet_info *vi = netdev_priv(dev);
 	u8 *promisc_allmulti  __free(kfree) = NULL;
-	struct net_device *dev = vi->dev;
 	struct scatterlist sg[2];
 	struct virtio_net_ctrl_mac *mac_data;
-	struct netdev_hw_addr *ha;
+	char *ha_addr;
 	int uc_count;
 	int mc_count;
 	void *buf;
-	int i;
+	int i, ni;
 
 	/* We can't dynamically set ndo_set_rx_mode, so return gracefully */
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
+	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
 	if (!promisc_allmulti) {
 		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
 		return;
 	}
 
-	rtnl_lock();
-
-	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
+	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
+						  NETIF_RX_MODE_CFG_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3900,7 +3894,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
+						  NETIF_RX_MODE_CFG_ALLMULTI);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3908,27 +3903,22 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	netif_addr_lock_bh(dev);
-
-	uc_count = netdev_uc_count(dev);
-	mc_count = netdev_mc_count(dev);
+	uc_count = netif_rx_mode_uc_count(dev);
+	mc_count = netif_rx_mode_mc_count(dev);
 	/* MAC filter - use one buffer for both lists */
 	buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
 		      (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
 	mac_data = buf;
-	if (!buf) {
-		netif_addr_unlock_bh(dev);
-		rtnl_unlock();
+	if (!buf)
 		return;
-	}
 
 	sg_init_table(sg, 2);
 
 	/* Store the unicast list and count in the front of the buffer */
 	mac_data->entries = cpu_to_virtio32(vi->vdev, uc_count);
 	i = 0;
-	netdev_for_each_uc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
+	netif_rx_mode_for_each_uc_addr(ha_addr, dev, ni)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[0], mac_data,
 		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
@@ -3938,10 +3928,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	mac_data->entries = cpu_to_virtio32(vi->vdev, mc_count);
 	i = 0;
-	netdev_for_each_mc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
-
-	netif_addr_unlock_bh(dev);
+	netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[1], mac_data,
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
@@ -3950,17 +3938,20 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
-	rtnl_unlock();
-
 	kfree(buf);
 }
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	char cfg_disabled = !vi->rx_mode_work_enabled;
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
+
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_SET_SKIP, cfg_disabled);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5776,7 +5767,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -6279,6 +6270,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_write_rx_mode   = virtnet_write_rx_mode,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6900,7 +6892,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7205,7 +7196,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.47.3

