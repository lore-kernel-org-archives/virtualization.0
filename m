Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852BC314D37
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512951; cv=none; b=VCYdJGMQxsM8ovrMtKXGHKJtG0dkz6OezRx+m4TPV8PR7vdTSqLKzNgMVcb1pKadqdF8ifJMISE/EBEHKtnC8jukM7lxL8ujcuByePpdTMAe5dZl5nCkJ2jZw0DRVqTsHOc6IZvzOOgyhxBrdX87c20qodyJP5e3o/CvtykPXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512951; c=relaxed/simple;
	bh=VSzdK6fFXXfUKXv/QSuO1q2/KGkkuP3m3IoNyvnhahY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdi6zef7k0SeA/p4oTCgtRWZF0B/2soM6AxrJgCX+B1OwMnwLh4fQG2VB9IcTYwyMgYuWLi3QjMonZJ3kz0J8Id63BHkyrfo4ix4WQADrtXyYHL0Fvg//K74ihxj5jpV9Do04uQZAP7Wys41lTebIK0sXSJNxVtp5mRDIYllbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im338OdA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im338OdA"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so2122648a12.2
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512950; x=1774117750; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPjyZJZYcHWPj/blRqGZlp+ucpD5kzaKMmjNcDwFvP0=;
        b=Im338OdAKHdNPlBcqKapE4ptK6rap3pbyBZUPI84BTeMAqwkNlaTWqXgeXjia9s6j1
         ZGwP4oYH0IFKHHQYnigi+K0jsV5a04ZeQTqshzJgiZR0AffLneRfI9gDwBOnnfXY14Kj
         q3Ne/YzfUvW3toKKEe6NJMZj8UteQfBtnQdOCEF4jHE8ifhkPwNmQGJ4NXxD2T6ZzLIe
         aRrG5NV0TswY2NLGS0X02tzj25zrb1ihw/Tn1XEEx06z4C8ZCjpLbgHqMMlOLPrDTOQm
         f6coYvUf4NpmF7nLbx8OiXU/+cemka+XnV+yQdI5jFAA6ntlSM9whfLWijnH7h9hGZzo
         jC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512950; x=1774117750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPjyZJZYcHWPj/blRqGZlp+ucpD5kzaKMmjNcDwFvP0=;
        b=RYxJYw96rlNXIxgK177VR7j1glc40nRMou7Vl61YXIlfEoffDTD4FRHUCXnd33cHtB
         BKsJqqnkJ8Pa7TD3VrUUvKgb6eOevtSSz3+TTmzR5mIL62SLaUo503gGKmjxo1Pm+6GY
         2YgizjYq8ROyRTbxnSlNO6Wr2s68+TL8zr1pc/eoG99ev5eqIr29MgvlbegizUxSKKPS
         xV9MAIfzmAyxefXhcGHXpyXuKa+owcMBnwlQsiE+pBoaq7fp0RxKcqf+GX9K8GT+QRmk
         CBBTkBxkshC5IdEGtYGNXTvOjq7QNtYvVpiPjYRtKJ2hGnIeO31KjtkRINL+Ul2zFMQx
         2zUw==
X-Forwarded-Encrypted: i=1; AJvYcCXYRF2NFefP7tKe4exxPwJ6yR25NNtb3rFLRDEsqZM8roFBYkCjc/jSOtjQwtgYfcRGiTsOTPkuPB7wXJZhiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw10gUTKogc9EOVCBxq8vMXtka2ejMH9f0BGb8NEzELMQKmLYAm
	RgTsjoTPWmQqQrwHPHKurAGwhRRgY/DM6bhFudqYSob+p9IKahc98X0K
X-Gm-Gg: ATEYQzwVrUUipQhuXDJE9hgiScuRhUEzdJvgRGDNlxvFX380EnWb2DpyH0VcmrC6vNc
	vdMS3N9xWpKT+4kL6o7XFI8xmsUkWmpcGkuBNrjB86rLjBT5gBlCgZ9vjwit9OM8/TTNfm6O7rZ
	xR8PFoZ6s7yjYH8sSvRAjKZaL4XYmmkMq2+ofLBU+7NjzCmz7gHhU2kXN8OW4f2UJcwmm1puLJQ
	Vx4Tqox1sZ3dkvWJ9D6IL1UNwdOg9dArj841ZLxGyJrZN7pjpJTHXffkao3xfsguw1RR6esC9fc
	Fomzje3DpzXlLezuvydTDdzsBXu3tb2kV3yVC68qU5+xrWeha+t0kq4ADIPUYBQrd7yhmFbsxTg
	Ca4wU5GKfqo3yeIn62Xy989OLkScZWwhX9XGS6JWGauM6RDy+0WXnDXfbqPIH99T7nn1vWTr38N
	t0zs9ixewa8xWNuM17M7pCHVnzoH73QTE1ZD4TK86DyOdnALzqvX1BJlwZv+XYPIDPSJ0NUT36d
	+LdOA==
X-Received: by 2002:a17:903:1210:b0:2ae:b9cd:d2df with SMTP id d9443c01a7336-2aecab1f32bmr78786355ad.34.1773512949621;
        Sat, 14 Mar 2026 11:29:09 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:09 -0700 (PDT)
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
Subject: [PATCH net-next v9 3/7] virtio-net: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:05 +0530
Message-ID: <20260314182809.362808-4-viswanathiyyappan@gmail.com>
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
 
  There are no calls to netif_set_rx_mode in virtio-net
 
 drivers/net/virtio_net.c | 85 ++++++++++++----------------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 811b90da15a9..70255d09401c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -448,12 +448,6 @@ struct virtnet_info {
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
-	/* Work struct for setting rx mode */
-	struct work_struct rx_mode_work;
-
-	/* OK to queue work setting RX mode? */
-	bool rx_mode_work_enabled;
-
 	/* Does the affinity hint is set for virtqueues? */
 	bool affinity_hint_set;
 
@@ -717,20 +711,6 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_rx_mode_work(struct virtnet_info *vi)
-{
-	rtnl_lock();
-	vi->rx_mode_work_enabled = true;
-	rtnl_unlock();
-}
-
-static void disable_rx_mode_work(struct virtnet_info *vi)
-{
-	rtnl_lock();
-	vi->rx_mode_work_enabled = false;
-	rtnl_unlock();
-}
-
 static void virtqueue_napi_schedule(struct napi_struct *napi,
 				    struct virtqueue *vq)
 {
@@ -3802,33 +3782,30 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
-static void virtnet_rx_mode_work(struct work_struct *work)
+static void virtnet_set_rx_mode_async(struct net_device *dev)
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
 
-	/* We can't dynamically set ndo_set_rx_mode, so return gracefully */
+	/* We can't dynamically set rx_mode, so return gracefully */
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	promisc_allmulti = kzalloc_obj(*promisc_allmulti);
+	promisc_allmulti = kzalloc_obj(*promisc_allmulti, GFP_ATOMIC);
 	if (!promisc_allmulti) {
 		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
 		return;
 	}
 
-	rtnl_lock();
-
-	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
+	*promisc_allmulti = netif_get_rx_mode_cfg(dev,
+						  NETIF_RX_MODE_CFG_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3836,7 +3813,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_get_rx_mode_cfg(dev,
+						  NETIF_RX_MODE_CFG_ALLMULTI);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3844,27 +3822,22 @@ static void virtnet_rx_mode_work(struct work_struct *work)
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
@@ -3874,10 +3847,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
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
@@ -3886,17 +3857,16 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
-	rtnl_unlock();
-
 	kfree(buf);
 }
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
-	struct virtnet_info *vi = netdev_priv(dev);
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5711,8 +5681,6 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
-	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -5738,8 +5706,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_rx_mode_work(vi);
-
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		err = virtnet_open(vi->dev);
@@ -6214,6 +6180,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_set_rx_mode_async  = virtnet_set_rx_mode_async,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6834,7 +6801,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -6986,8 +6952,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
-	enable_rx_mode_work(vi);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -7136,8 +7100,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
-	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	virtnet_free_irq_moder(vi);
 
@@ -7158,6 +7120,7 @@ static __maybe_unused int virtnet_freeze(struct virtio_device *vdev)
 	virtnet_freeze_down(vdev);
 	remove_vq_common(vi);
 
+	netif_disable_async_ops(vi->dev);
 	return 0;
 }
 
@@ -7166,6 +7129,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 	struct virtnet_info *vi = vdev->priv;
 	int err;
 
+	netif_enable_async_ops(vi->dev);
 	err = virtnet_restore_up(vdev);
 	if (err)
 		return err;
@@ -7175,6 +7139,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 	if (err) {
 		virtnet_freeze_down(vdev);
 		remove_vq_common(vi);
+		netif_disable_async_ops(vi->dev);
 		return err;
 	}
 
-- 
2.47.3

