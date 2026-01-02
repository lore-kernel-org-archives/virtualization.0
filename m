Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC6313E2F
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377171; cv=none; b=p0UyKGu9bkIQjOGeHLWsaOL+uTjxkU6lgbRyHFbGIMgk1gkstkZ+WF4T/izaY+XaaqP5HGWgg2ZWF50ZlzZEwbKkVTEsLmfUmUofNl8mmceikGcaqX4r9XG9DZaRcEuXtp0m0nh6xkdO3dK7rsuGcqWWB90EFsKM9sWHiG9kjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377171; c=relaxed/simple;
	bh=oetQtpSM3DjCX3/aeFuWgTQCahQBkDyO/iqkcjjmuuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5iaJKPAz6ZCrDFgUoce7X+XZp/ZFdGz70kwkGqoh/MeuB7MHlLfkHAcBn7e4xvaYKkYc6Egy5gWxPOJATIziN7WlCefF7mjhGD2QtwRLGb02UedQsdt7eQ+C6uam4TGdQ3mzPSrJ/Ulsx9Pw94LPTUbiKL7X+id8SeupE+UmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3MYMK+3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3MYMK+3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0b4320665so190087635ad.1
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767377160; x=1767981960; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfcgCbP6RhhVMiMr9Azv6F2aQ7T6/MJccCOzX/54vEE=;
        b=H3MYMK+3+qj7R3mR0sTsneu8rSSWRrsKYY0jpLycTEWfVGnr8aoL+k5GknL0XqMMLS
         XeEeYyvb7FW47L+67jI7Yq5mcO4hJOp/+P5Ctyz86j5ca053C+d55WhPpigmH0FV6w+W
         hd28BuUrQvzU0WqbsRZbxxUbO4zMXA23JuwkiOhkPovHjveGMd+WoAizUDuFDKe33/3x
         PLBKLh69G6VBh9BQichng4/lItbqc0swB/PuXy2XF0KJSKS+op+MIgbPV6BNQnsD6juU
         OvxEXZKrF3ubC5a3SUPc/NtJ5CNF1AsuI8QwgJjWw0F2lc2PhhJ3ojSQC8Y7lt56efmx
         xaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377160; x=1767981960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfcgCbP6RhhVMiMr9Azv6F2aQ7T6/MJccCOzX/54vEE=;
        b=iAFbe5z1VNYwARYl6X5FLdXmI8vUTvU9QnZLlOqHSVaiVyiFcBFbiJw5+fWSL8Vdw8
         rZCY7Cy4tp7wMYv+z/4xhe8WOhjEjhO0hUptzFcOfyWfjxyzf+Ini7XYWSa8T3fsJkYX
         khB8yhNGP3ySIkYZJw3h8T8KlNC5XwJL2mCxKGSFkaa4IhfN+g5vYXDf8pg+F25rajWn
         T1WaoHswPK6nwoYhpI+MSwtzo43n9jUB6/EqDsUWV+92I3+84kr83H4RBAryMOsV4TdF
         0IHbcf5xLb7u+Q86Zq9Xi1cAPw9onQ9bYwiwHMZ7nmkInN+UDpvV9KATlIKsef1aqIGy
         TLUA==
X-Forwarded-Encrypted: i=1; AJvYcCWdmbeLTNdbIJtYC2LcAIEOJCaoLkX0AJrqBneNrjupXHsrBr2z8zHAk33h88ZfLu1riukUdoETNN7D+bT/yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL5XG54ZzjDVY5+B21p7mUF7DAJZ9rtmv/C9KEU0ijoUAFdpJk
	ZmI8so04WTIY1IIefcrBsxKwo9RxauBPjnBoHnwXAQNkrl4PUIUVekLK
X-Gm-Gg: AY/fxX43EQuVo2pMy7aIT5EeKZGdFlGkaF16kChF7M/jy9gezapjAK1vouH/51bZhJH
	g8xMbuNLoVpaHb3wBtRRX+jBAmXos2TPVTY2oLFkTX9hv99pMm08QIZFPXu67rjmWb20ex7TRcz
	6uM2jRLafMpQLPGXqqF3e9G3ZHQURrSbm0+uY0ea2Zm8dAiXPH0WRCuEztbPmR+9bMR3/8rDDcJ
	CyNC5vso2FOkbVAKMgzK70SUkQwtvnRDqaVvHZeN+E1ynNDBZ4hrVL5PR0gdWn9cS8CwGehLO8N
	pgVp+79wteEQK2N+e5eqDtfJJvAG+eijC5F3xT10wrKjFqiDNn3Q5TGLKi6UAYkAh0X/s7bnItS
	BRb4FyVLKq4ihBxnnGh/wQ8JaS7qRJPF1K221G/C2jr7P3q9x2anW5/p76x8H/OrHd5TbC2v/2z
	QgM0ySz2enniv6wthelRovDVrxr6kDGS1VpsbOm2zNymFQ0w58oAVTy1DwQvB8xRVuUck=
X-Google-Smtp-Source: AGHT+IGlPf0sJytEVblRsx7DE7M/l8a4Fbt7aqtuWECHLRxylpFO/PMXbrQ9354tq/9aQ/e2ZEXM+g==
X-Received: by 2002:a17:902:e74b:b0:299:e215:f61e with SMTP id d9443c01a7336-2a2f2a34fadmr407610955ad.36.1767377159960;
        Fri, 02 Jan 2026 10:05:59 -0800 (PST)
Received: from localhost.localdomain ([223.181.108.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77566sm386297585ad.97.2026.01.02.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:05:59 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v7 2/2] virtio-net: Implement ndo_write_rx_mode callback
Date: Fri,  2 Jan 2026 23:35:30 +0530
Message-ID: <20260102180530.1559514-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ndo_write_rx_mode callback for virtio-net

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/virtio_net.c | 55 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..83d543bf6ae2 100644
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
 
@@ -3866,33 +3863,31 @@ static int virtnet_close(struct net_device *dev)
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
+	int idx;
 	int i;
 
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
@@ -3900,7 +3895,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
+						  NETIF_RX_MODE_CFG_ALLMULTI);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3908,27 +3904,22 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	netif_addr_lock_bh(dev);
-
-	uc_count = netdev_uc_count(dev);
-	mc_count = netdev_mc_count(dev);
+	uc_count = netif_rx_mode_get_uc_count(dev);
+	mc_count = netif_rx_mode_get_mc_count(dev);
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
+	netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[0], mac_data,
 		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
@@ -3938,10 +3929,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	mac_data->entries = cpu_to_virtio32(vi->vdev, mc_count);
 	i = 0;
-	netdev_for_each_mc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
-
-	netif_addr_unlock_bh(dev);
+	netif_rx_mode_for_each_mc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[1], mac_data,
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
@@ -3950,17 +3939,15 @@ static void virtnet_rx_mode_work(struct work_struct *work)
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
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_SET_SKIP, cfg_disabled);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5776,7 +5763,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -6279,6 +6266,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_write_rx_mode   = virtnet_write_rx_mode,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6900,7 +6888,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7205,7 +7192,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.47.3

