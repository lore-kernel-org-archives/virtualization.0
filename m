Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CA21FF3B
	for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857404; cv=none; b=JyWaDrjOKXAyAJycjMPdLxWsKiPD6WR526E0vVTDrxw8oRDC7Pfx931d9ouuo961eZa9v28qSLEJEZb7I7ZoUl31AykpFF8opBLIFDbXd2VgUVkmdr5baCo9tKINFjyFQoSPK1QIuTdBIVo0V8gMAD5KCSKSZsiawWA3V74I1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857404; c=relaxed/simple;
	bh=6pvkrFkXV0ZCgb0+nVWualYwUjlv8Z4QFgD69EoVGbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnNbHRwZGDggE46DNwRNYJr0JQA7Y/7KteFZJ00oj2yIQzmTyBl1XtqTGY3G6YI0DTJdMmAhXwFuyNIBoXgyZp0N06TFJDujYqHw0vGnadrvFCNYK0pB1kJP/CTSa6pN0m480+KR5nteoo4HLNj4zWnp7lblTDbXCYvP1eI1tu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g79bYnDc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g79bYnDc"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so8700700a91.3
        for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 09:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766857402; x=1767462202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSaQldGw/Y1Ma9OvlXjySOvj53Quv/UmpFvqZ6pZiR4=;
        b=g79bYnDcMMxgk4B2bRoMdwdMiwvCX9iXy0Jwjn3hLG6e/FmWU8eLvnHZd+FfLz3G7d
         etgYuTBf2IKntdZ8JrCzAXeMLCVALVymWKPZA3XcDnI99GKeIxFDgBYHECll4voYvCwg
         jn7N7OMvCb8PgHSeSYvABh75of6BzjuJRCHhLwcZGu8HSzpc4C5nKiq6QCrNeBJEh6f6
         tm8VvTnGZBa6xj7iiUS/zqX4SS8/c62HDeaasKnjFlDYNhNzUSnYXzxHBAiRl5GakwPG
         v68x/oCz1Rp5qC+L1OJRdIx8AlsTfFhDi6QVcJH8B5RRIbEddF+xLBeEhAb6W+BRHJKN
         skLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766857402; x=1767462202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LSaQldGw/Y1Ma9OvlXjySOvj53Quv/UmpFvqZ6pZiR4=;
        b=irmqhXy4Y2HWhST8ezG5vsrhdO5RIbe1BkUmCipBTn1Bx9XSQjVGTgZ9GB26wRuTfK
         j3Bj5NpzeGfGY53SlJw9GYSTpiYg0sMjhpPNeWS5VypBg37ibn34fpOqrK5Cf/neRH04
         OoR8qBzV7zFUPIiNrJ6ILDzaFh2Orsw/4OigXGNwbunBo1a/MGZ6Gl8BadU1iwy/aqHj
         TREbQd0TRxU3Vsj8C6okF/wEwpMyJJrGYo8UdRP6efxmQ1LqyczDisXiPEhEd+ZfmDvI
         wNmW/HMJA1mAFy2r7kmsDOjViYfgejkRqBOrCY/4JN/9WskdZXkeVcVbFFEZ935nN94t
         lxUg==
X-Forwarded-Encrypted: i=1; AJvYcCX16gOMcz+oSZ9x1NYeZ75zOww/fvzlIL24N3uQO12PTMO/5PEp2a3MVvjxzAMcmrFoq7FMMj0xCCeCdmxg6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLcSGaiLF2UBMDgHl/YGLQKhMVbVf9olqca9W+nlX7D3iA+eSr
	FOeZGaoj4wwAaNqEugpnVfky1MKPAIcPjiG6bXX4WjS8ZpPpy/LKRgdQ
X-Gm-Gg: AY/fxX6nZRRxO/mj2cyarALmKdh8dWUBSkv8ZBOwzWW8ArFOe0y4xW26aDNufxMmF0y
	ytmD756n5rmGNSK1tLMgVLVWm3txDQAC+TAZKuJ8MpKoQtaGntUUI/gJRjRUsATuaH0YtFVnmPA
	SsMhlxmt7KPmM9nUkFxdVOPa3hqbQaM/EkIIGdrHwx+xv7nKr2YiihR0Q7U897/GPtMMLRTDpst
	ylutZ3XIAu3W4aRHwwahIVht8O/UemNRpIPVKSM1wKBlIpnMNSguZZ8OPZLq/69HZobdon/Rwcj
	jLzv2gcCgZhDPv1GBfM7/beqsRWlneQns1hC8HreXmXCZKtazCjEFPNTRj1h6IFAsE5e/suEmgm
	S88HmyLvgQ1dmBvW5o+/r6eOKBkYsFDOiofUZ0Y/MBvfS48d0DGXPvKOKgIjKzUckV5ntTqHE1O
	yIVj7YumuwL3q6TRJJCxRyKrusAAnEeDKCZdXWj0Un0YIKBICL00XSgbqjWAcWn9WX
X-Google-Smtp-Source: AGHT+IGsxHJ3qlkBFY6LlEDovJZo3ksqIikwpRQUhTFYsTT1rV54HIV8Bd+jeIN258sgwZh9UeW+BA==
X-Received: by 2002:a17:90b:35ca:b0:341:88c9:6eb2 with SMTP id 98e67ed59e1d1-34e92121d86mr20593864a91.1.1766857401838;
        Sat, 27 Dec 2025 09:43:21 -0800 (PST)
Received: from localhost.localdomain ([223.181.117.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223ae29sm23274975a91.16.2025.12.27.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:43:21 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	xuanzhuo@linux.alibaba.com,
	mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v6 2/2] virtio-net: Implement ndo_write_rx_mode callback
Date: Sat, 27 Dec 2025 23:12:25 +0530
Message-ID: <20251227174225.699975-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
References: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
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
index 1bb3aeca66c6..165e5943dedf 100644
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
+	*promisc_allmulti = netif_rx_mode_get_cfg_bit(dev,
+						      NETIF_RX_MODE_CFG_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3900,7 +3895,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_cfg_bit(dev,
+						      NETIF_RX_MODE_CFG_ALLMULTI);
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
+	netif_rx_mode_set_ctrl_bit(dev, NETIF_RX_MODE_SET_SKIP, cfg_disabled);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5776,7 +5763,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_rx_mode_flush_work(vi->dev);
 
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
+	netif_rx_mode_flush_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.47.3

