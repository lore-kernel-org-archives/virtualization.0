Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122673A901C
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792237381; cv=none; b=C/USmUgYrjoCaXB1U+wGO/dvI9r8RrmZpAkqYKgv6U2z9GF2L0YJaSajq4cddYK84ligWE8pptFI7rhUQvHPCesvVEj9zyYcSY2QRr+3O5uqfqol1DnsnYyyHEjyBk35UBwsRrlpdCpA1rWWdmy3UZHYjQrNXN/nkV2eGUklhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792237381; c=relaxed/simple;
	bh=J8Cw60wlKHa0M+RZVGRfThuU+pMFQ4l3jfsZspjxnx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orKLUlVyrFvGk/LXSJ+ugsC3zNPoJ6OWIFTcKN1ogq/GiXK8j1zb77ex2r7n7RFqgCl3b795ZAMjpbdCh0l6KM3WN0snzZFeMHXXs82/e4WYvQgyoSrIu/h5t8GcOFXhD8kOQrJRDziDjXqG5Psx1LEhvOKFxhrJnqYXu5tCrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHpPtaoR; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHpPtaoR"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1517bda04a0so577796c88.0
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792237379; x=1792842179; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/NEtd/XspvBJIHQm0kcPRGhqlPpCGmhp+4zMFyvkec0=;
        b=sHpPtaoR8ObfymChnOvO1jmkYw8U0zbVOZq1p5VbZZis/GlG44FJTBhiQwIMyD3iiX
         QaehaK+7bsJxYvkbAV/GEneKB0rnxlOEyKdOKJTKwdJaihmS2/YtQJo0OuLw38dPa5yM
         bgi8UlGRwWPiqw7+F/Q7RNFjS67zI6HaLZjZSj+cPoV5aOOpk0ES6jU4bZL+E4xL0702
         Iu2ObwRyqh0p4bpA6szzF9uF5tQ4ffSNe5RKuc+Xuzb9S2nQ8psef6gD3qMTqVoARqzX
         0U1B7a6qZQh4iLPGnROhkh7Q1qW7WIo+FCBAmRX0jywY6DHa08ZRYDxZJkiePh9AGo5q
         e7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792237379; x=1792842179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NEtd/XspvBJIHQm0kcPRGhqlPpCGmhp+4zMFyvkec0=;
        b=00F8nPpcYF9qG07OyXr4f5Was9j5Avis+NGkh9w+YOwL2CCAotycGhxL4Vj+dclg55
         Cif3tVZIbo2ty0w/crdxb8BZ26guDpZu5CbnG9libAzvl18+GgGdW5Tq25XEKga0FeR0
         E0NKgCfaCt9gHjDD3npMiMPCLQ6NYjA2ZajzQTAdeWBNpN974rQkmfeyWz0FYo8e2UFT
         GLhVhYDHBgmHLncnBx59nD1nEbBv2IxqC9cCSrGx063XduN6P8P7KHO9cCnirPXDQar8
         C7TRxNxV+hP0CVHwuFyOF7OQY9DWBOUn4/ysUZrY6omxD+od1xmmIINV+MkjM9pxrr8z
         Dfag==
X-Forwarded-Encrypted: i=1; AKwUvBzd75BD1omIkEPPLh8i8mK/YC3M02ZieCJHLJtVIDfhD0ppGGkV3ZeTPhwLjKRjidFXVKa1j9ReYK44hb03vQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJR66XsmhVTWSXYZal1supd5Oz0hPNZ1udlMLfxkJhyElcsF05I
	D84fNPtd3cH5gAGGlnLRbWCv3Eck1mxa8PCjPLABWzZvuHhqd2+/mu/C
X-Gm-Gg: AYBFou3e3dQw3e0zZIegaE4VCVAiQbucPOaALAjFceMI1vUxS+nvlu4TaQ8n/03XuN/
	xcC5QBMn0baQ1CbSJ7Zk2fSbA8hWvp0Ent4n6+tSgRlbAw6C3+SKy/4KYjTEK+L70j7QiIiUU5X
	jwTKqHkjIdY7lLMwaVf2L5NAK01+9bh0tN3G1gcww/pISHUjAZdbXgyUjSahlzNpKZIrWStV30u
	wS6AbqHDEyf3sufqle0buVjogs21sAnd+rcM9qxVPQAAH/GzvXSmmdo6/vAy5KilNPt7aNMwo3H
	SPzKLua94ywdUQUopA1xgRJD5WJLt7BhUka+p0IeF5R9Wya3KPXgEzKo8DeP6kfCk72m+8cMKcT
	eJDIfwNuJ7ZjtP5vfBjn1UymmcGdpAdAwAdlIQQJQEOZon382VIGzCSbB1GjDAa1FzuWNRY5sIy
	P2+G23L0/aN+Mk2gcooacKC1rN3WXEkVpuyZPFJXLObj5+6qYE/hjnwLhFRx3mmhnOgXmDl1SuL
	0nckq+ilHIqhpyxQWVyWC+KiiArf2HdUeqzaz+ZhK+gS0U=
X-Received: by 2002:a05:701b:4559:20b0:144:eb46:c31 with SMTP id a92af1059eb24-185120abebbmr3391009c88.17.1792237378928;
        Sat, 17 Oct 2026 04:42:58 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831996071csm13759881c88.9.2026.10.17.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:42:57 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <sln@onemain.com>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+d17c2bc750a9cbbb@bugs.sh
Subject: [PATCH net] virtio_net: atomically disable rx mode work
Date: Sat, 17 Oct 2026 04:42:38 -0700
Message-ID: <20261017114237.2786302-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio-net uses a boolean to gate rx_mode_work during device teardown.
The flag is changed under RTNL, but ndo_set_rx_mode checks it under the
address-list lock. A callback can therefore pass the check and enqueue work
after teardown has flushed it. The work is also enabled before late
probe operations that can fail, allowing probe unwind to free the netdev
with work still queued.

KASAN reports the worker using a virtqueue that probe unwind already freed:

  BUG: KASAN: slab-use-after-free in virtqueue_add_split
  Workqueue: events virtnet_rx_mode_work
  Call Trace:
   virtqueue_add_split (drivers/virtio/virtio_ring.c:706)
   virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2839)
   virtnet_send_command_reply (drivers/net/virtio_net.c:3565)
   virtnet_rx_mode_work (drivers/net/virtio_net.c:3833)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3405)
  Freed by task 119:
   kfree (mm/slub.c:6625)
   vp_del_vq.isra.0 (drivers/virtio/virtio_pci_common.c:259)
   vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
   virtnet_probe (drivers/net/virtio_net.c:7129)

Use the workqueue disable mechanism to atomically reject new queue attempts
and drain running work. Keep work disabled until probe succeeds or restore
has reattached the netdev, then enable it and replay receive-mode state for
a running interface. Disable it before resource teardown in freeze and
remove.

Fixes: b9f7425239a0 ("virtio-net: convert rx mode setting to use workqueue")
Cc: stable@vger.kernel.org
Reported-by: <co+d17c2bc750a9cbbb@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/virtio_net.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d2eeb9b122667..6fa4b7219aa5ac 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,9 +441,6 @@ struct virtnet_info {
 	/* Work struct for setting rx mode */
 	struct work_struct rx_mode_work;
 
-	/* OK to queue work setting RX mode? */
-	bool rx_mode_work_enabled;
-
 	/* Does the affinity hint is set for virtqueues? */
 	bool affinity_hint_set;
 
@@ -710,16 +707,13 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
-	rtnl_lock();
-	vi->rx_mode_work_enabled = true;
-	rtnl_unlock();
+	if (enable_work(&vi->rx_mode_work) && netif_running(vi->dev))
+		schedule_work(&vi->rx_mode_work);
 }
 
 static void disable_rx_mode_work(struct virtnet_info *vi)
 {
-	rtnl_lock();
-	vi->rx_mode_work_enabled = false;
-	rtnl_unlock();
+	disable_work_sync(&vi->rx_mode_work);
 }
 
 static void virtqueue_napi_schedule(struct napi_struct *napi,
@@ -3894,8 +3888,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	schedule_work(&vi->rx_mode_work);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5711,7 +5704,6 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -5741,8 +5733,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_rx_mode_work(vi);
-
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		err = virtnet_open(vi->dev);
@@ -5754,6 +5744,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	enable_rx_mode_work(vi);
 	return 0;
 
 err_destroy_pools:
@@ -6849,6 +6841,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
+	disable_work(&vi->rx_mode_work);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7007,8 +7000,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
-	enable_rx_mode_work(vi);
-
 	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++) {
 		unsigned int fbit;
 
@@ -7112,6 +7103,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
+	enable_rx_mode_work(vi);
+
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
@@ -7164,7 +7157,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.55.0

