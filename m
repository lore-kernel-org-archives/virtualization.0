Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDA36A016
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484254; cv=none; b=BUdjVubG4kF0MW6DMHYXweXiUtt3YUVSOmjDiZmhoUzwbAIZWsUIxmsNEETmjFvIkckNYZQx4hySp1bc6/tdCK34j+YCtDudRwGxGW9lw853ZWdPE1ZWa2dViF1KJw1NvDHT1OLno7zCF5kO1BpjuNrTUHoh8ZGH+MFuEBMh80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484254; c=relaxed/simple;
	bh=0FQ386+g3fJmb2sXgWLF41NLQyulgHxdCvrCfZwHMVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coHCpceg5zv247xha0BUJ6lC0XrEqtjXPXjJuaOFvrDo4ohha4iuKiRgECEaYekgXLdLUQhcPIRPc1DhZFNVsucZ+10Y+5awNY2VMOOy/3OyuATxv8BfGwItE8Zft/oDEIBvr0LZeMZ6PB75N+rsyweQoipEId+ljk0Rr+mgyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKSSxrNK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKSSxrNK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297f35be2ffso79884615ad.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763484251; x=1764089051; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwmtgOlhlWBYCrE1LogTIJtjLPIo0fBin+YkiTpkdPg=;
        b=cKSSxrNKklyDTuGsr5Cw4FL1QrEqmzfK1D9Fo0qxUkEeUHWQPn+9Q8nBuZnNsrYjWz
         Xr+MamMZtRwUdgPddIFSPWoFxwzyAhZzz/oDIFGkTji0Q9+ZTfIVudx9nxjzViaYJfDi
         5ZMFqE37Idi2uQ4kiBIudGL5YycQH0+7rA90ex+GoA2o5XM0+j/p1ycmWSzAvJAllop+
         oYf/Y3AqYFr40y4L9xBWtHTJ8lrsAsPR/R93lmh7brK294jfM82xOnD27ZgINHGCTeze
         ySnYgqfmilNrOINBQJa5mQl7Zaan1MCPkHPJ+iCVuMqTn5e2xFst8seoYvmgEbx+Pf4C
         Aj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763484251; x=1764089051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwmtgOlhlWBYCrE1LogTIJtjLPIo0fBin+YkiTpkdPg=;
        b=B8EF8w7AmlmriaAXJ0sdvXFGQ7Z4fGZXuDgmnmgrSkachSHLYC55aUL83H7OOmOV2g
         oviSNE/zXr6R9eEbZKlw9wcyN+BjfOozVmf1LxftSkyHlqsc0UepoV4PEkqtDq7Uwm5/
         NjLpdrLCeZVmNtapXVZy7HRhSMbcR6OQ/RDb1wSGBNPlO5J1t3zSLDDF30X5rcC18pCu
         1pYYtK3TtIPWd4GY/yNZd6EA0WEBxjMbvVTubWhV7HU6gOPtqCU6DUov9Y7u0JRlHGNE
         edQK7VjuYzlNW503iL1o4UZapzg7qKStUxxHvbm7fruCIUoQQAwHmhQQpbozafyO7SPW
         Kvlw==
X-Gm-Message-State: AOJu0YyvWJec2y87aTZ+XW8r/CmYBUlOg+3kWkO3Y4Q2O8mpTcr83acV
	ASstLmUVX6sC7+RS1QODu0QOO+kdUvrBtJbCAsh3H1keSRzRkBY5ghVu
X-Gm-Gg: ASbGnctVWbLRr/4IqrVlNnDoBrsGiMkGrcbBXSV4nJ/6YBbepqDKZqb6e06bT71YKMM
	DiE4YLLzPHfnRGnCZg+xFK/qzHn7co5rQhXssQjfuSRdRk1tmu4alnTlm4ixk1de/b48ubFzm7+
	kvLyY5ngoA8fmTQTiUwCSuSXMYpwnX5sLHnOa9hMtLbvVeil546ClVLJMn8yX8084Yew+GMuYOR
	ePirZVTYyMZJLqCYIKYOsKxXMuHUi18V+fX6xUfDMdayYSCrSUDmMeeFlkZ92lk0KnyJINh/ADl
	SqYJfq3jJqfCBXzP+UNq/Awh7YoNV18nv0snYC3bMqVoJH9nxaYBzOatT2q2BLuxCzpXscPuMI2
	Za/HQAUpdaYZgmcDn/yqPNVAUFEYohTiX+v1yZbskNap01yHzsgfYjJAzDcBr5vO1bIIb4K7r+8
	QbbyJA9EXqpnvh3IsaPxL2HctNGlLSyk9SoaaoUqRYW69CH0qRT/qo0Q==
X-Google-Smtp-Source: AGHT+IGP4POJh+nQC68ptxHo+oArpwmANuGeak47u/8AJD4JE1aggtVetdUtI5VFttSw6IUoTGKYcw==
X-Received: by 2002:a17:90b:4b49:b0:340:f009:ca89 with SMTP id 98e67ed59e1d1-343fa62fabemr18013927a91.22.1763484250931;
        Tue, 18 Nov 2025 08:44:10 -0800 (PST)
Received: from COB-LTR7HP24-497.domain.name ([223.185.135.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513f162sm13544843a91.8.2025.11.18.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:44:10 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFT net-next v4 2/2] virtio-net: Implement ndO_write_rx_mode callback
Date: Tue, 18 Nov 2025 22:13:33 +0530
Message-Id: <20251118164333.24842-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
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
 drivers/net/virtio_net.c | 56 +++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cfa006b88688..20494ed5a0f6 100644
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
 
@@ -3857,18 +3854,17 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
-static void virtnet_rx_mode_work(struct work_struct *work)
+static void virtnet_write_rx_mode(struct net_device *dev)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, rx_mode_work);
+	struct virtnet_info *vi = netif_rx_mode_get_priv_ptr(dev);
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
@@ -3881,9 +3877,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		return;
 	}
 
-	rtnl_lock();
-
-	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
+	*promisc_allmulti = netif_rx_mode_get_bit(dev,
+						  NETIF_RX_MODE_PROM_EN);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3891,7 +3886,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_bit(dev,
+						  NETIF_RX_MODE_ALLMULTI_EN);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3899,27 +3895,24 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	netif_addr_lock_bh(dev);
+	uc_count = netif_rx_mode_get_uc_count(dev);
+	mc_count = netif_rx_mode_get_mc_count(dev);
 
-	uc_count = netdev_uc_count(dev);
-	mc_count = netdev_mc_count(dev);
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
+
+	netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[0], mac_data,
 		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
@@ -3929,10 +3922,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
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
@@ -3941,17 +3932,18 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
-	rtnl_unlock();
-
 	kfree(buf);
 }
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	char cfg_disabled;
+
+	cfg_disabled = !vi->rx_mode_work_enabled;
+	netif_rx_mode_set_bit(dev, NETIF_RX_MODE_SET_DIS, cfg_disabled);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_rx_mode_set_priv_ptr(dev, vi);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5767,7 +5759,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_rx_mode_flush_work(vi->dev);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -6270,6 +6262,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_write_rx_mode   = virtnet_write_rx_mode,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6891,7 +6884,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7196,7 +7188,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_rx_mode_flush_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.34.1

