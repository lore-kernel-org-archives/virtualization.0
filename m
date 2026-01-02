Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72692459E5
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367259; cv=none; b=adoO/hUMRecNtr4Y7piVATyNzR/WULFlOC0TFX+9/gHvehcC0D4ZPl1o76aCRnlUqjF2hvF/Ob5u6Ut6VcOqJ2t1STEy3kYjcvvLAGAcUqqMqLcFyo4O6KJZrdPfaaaB5Rt9FdQR4GoZeWwKUE4MyQzb2cK3lpTIGo2UupDllMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367259; c=relaxed/simple;
	bh=IhIOm/waVwb/Npd7naFhHnteaL1RMxK1LRiQGSxMRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH7VauSs1GpIx/n68O2az9eBOJV4mHUKIErTiVL4a4TL4WxKpolo0zCqritHH6g9OkRBXJ//ePbEOSsrum4sykRqPmVYbWremLTG29WECF0bOpgCavNbReR8HWzima6X6RThrl3gXBIFfLI/WxZfiWPMEsLtYBKkHyMC0i4bMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQGfSVRc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQGfSVRc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so13777093b3a.1
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 07:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367255; x=1767972055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p9926v+j8hRdiPJTHDEVVkAKp32Z3dkDYChWeFnkTc=;
        b=CQGfSVRc88m0WeaTqZGSaQEtpKAelLoXuud0q+8ZVNIh4r2Yu3q07w8GG9F1B1XEFl
         TR2byCH57KBQjqUQSP09wBcxJaEuLuh7rKNxLacszRfwO1syIjfYmz/gwwKNHkyp+BGw
         VNSOBupc8frd6YKJzEFSckPBgkKNvuGtyZvl5/3Ye7RtBByhGQJpW/d4hWY4bZejQEqZ
         bB57T0VPlHxKGQlsfKEF/DDauGtAz/XjZtpwfDCa0YWepcVkJsLAqivPjt0ox57JDQ30
         8syKsb/cc4hv2R/Y9tvQHCjqUvoGNNtXceoscYCgUjePyqJ9FQmNjw2pb29lSlQsrFnk
         dl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367255; x=1767972055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6p9926v+j8hRdiPJTHDEVVkAKp32Z3dkDYChWeFnkTc=;
        b=KYcXfIluEu8gXF+ecj1uFIMWRDwWFiEO8q/Vjg5e6L9dtaoaaWh/LI0e0/dFwNCa1I
         mb2Jlx1bibv2iU6sA4gKHizIy3UfgD2bz9Eq1a8JuB/xhH9VkaD5hrtx3qCW4aRdOXIM
         aX4ehlbRv4Q8lqvbEYfaFnvv7gmpScSeO2wGsk+q9wof+CC8u4stXxckVSrT+0A2aSe7
         fDtRkUS0zfXyCfFprYGbuOmWR4ryA9G3TEp51HzuRFkKivHV308xqMLd0jW0ye61rTzx
         RZn/l7bo+N7SHlFWFBnxB1rSEziOa3nv0sbvNtHS/ttx/dZmwZnHocCFk4dMrzaQ7Gu8
         PyNA==
X-Forwarded-Encrypted: i=1; AJvYcCWH7DwICiuOqed1ok899UowH588QJQckSbQYbnoRB4nFT+mQurv8+gdLnlcR3sq9MbiyHXa+KBcHm1xmUFN2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy04gKy/LWamAc+6fj2ZfQxBjnXwwNg/NiZd+gT/B19ClxgBiqS
	CCKvAsTWa2BwXaselMybTIO24jTsJ/T+7gB8CR/ii5GgZ94p0SjYTWY3
X-Gm-Gg: AY/fxX5IdZ9lMBNqc1CNGGe+vGMz+sIqkV/Lamheoh83NXat7DBx9OKdoeToUmqWMvS
	2zuqZTKDd12ywUT0K05kiqovFNDTUOPa4xhXPqko2S4R8tjST5nlNqB7Kkm7NNwmng4RqmtxmNj
	XMjSPZF4dyAMASLt0ZxwAx2bZ8qjcv4L4mkkJNCRkzi539Bm/BaOZHlpVIsxYFETbxJAL0i3Y1/
	FkF4JZZryxZv+H6NCQeXP71/QvFgTGlT0Bv/50jECmRLLoFt7OtsLghWz5KatF6AOByO9l2tGZG
	luoI1K+Ks1Q2yZ3moWranE4OdDGA2m9+lN6PlqTv9bOl+hNouRPPcDz4LIAZgs2//dhpiTR1ZTs
	9HMAPuf2yq4dTvRJ4lkACwrx6ruEN4bU7ohp73cnvRe/yIiw+EUVcGY/s0tGdzIFirFF23XA1j/
	mc2lWLsJtC78Gt8KCHxaIomVA=
X-Google-Smtp-Source: AGHT+IG6Z89asELtZL25bqp1wItzqCcfh/QFAyUyxW2i4m6A92FWF0k6z8ouT/hhDGRbNkmbOPf90w==
X-Received: by 2002:a05:6a20:431a:b0:35d:5d40:6d86 with SMTP id adf61e73a8af0-376a9de51cbmr41286930637.40.1767367254850;
        Fri, 02 Jan 2026 07:20:54 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:53 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 2/3] virtio-net: remove unused delayed refill worker
Date: Fri,  2 Jan 2026 22:20:22 +0700
Message-ID: <20260102152023.10773-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we change to retry refilling receive buffer in NAPI poll instead
of delayed worker, remove all unused delayed refill worker code.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 86 ----------------------------------------
 1 file changed, 86 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac514c9383ae..7e77a05b5662 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,9 +441,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
 	/* UDP tunnel support */
 	bool tx_tnl;
 
@@ -451,12 +448,6 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -720,20 +711,6 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = true;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
-static void disable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = false;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
 	rtnl_lock();
@@ -2948,42 +2925,6 @@ static void virtnet_napi_disable(struct receive_queue *rq)
 	napi_disable(napi);
 }
 
-static void refill_work(struct work_struct *work)
-{
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, refill.work);
-	bool still_empty;
-	int i;
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
-
-		/*
-		 * When queue API support is added in the future and the call
-		 * below becomes napi_disable_locked, this driver will need to
-		 * be refactored.
-		 *
-		 * One possible solution would be to:
-		 *   - cancel refill_work with cancel_delayed_work (note:
-		 *     non-sync)
-		 *   - cancel refill_work with cancel_delayed_work_sync in
-		 *     virtnet_remove after the netdev is unregistered
-		 *   - wrap all of the work in a lock (perhaps the netdev
-		 *     instance lock)
-		 *   - check netif_running() and return early to avoid a race
-		 */
-		napi_disable(&rq->napi);
-		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_do_enable(rq->vq, &rq->napi);
-
-		/* In theory, this can happen: if we don't get any buffers in
-		 * we will *never* try to fill again.
-		 */
-		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
-	}
-}
-
 static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
 				    struct receive_queue *rq,
 				    int budget,
@@ -3222,8 +3163,6 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* If this fails, we will retry later in
@@ -3249,9 +3188,6 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-
 	for (i--; i >= 0; i--) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
@@ -3445,24 +3381,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 {
 	int i;
 
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		__virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	__virtnet_rx_pause(vi, rq);
 }
 
@@ -3486,7 +3410,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
@@ -3497,7 +3420,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
@@ -3848,10 +3770,6 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
-	/* Make sure NAPI doesn't schedule refill work */
-	disable_delayed_refill(vi);
-	/* Make sure refill_work doesn't re-enable napi! */
-	cancel_delayed_work_sync(&vi->refill);
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -5807,7 +5725,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
@@ -6564,7 +6481,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
-	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -6906,7 +6822,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
-	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7170,7 +7085,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	net_failover_destroy(vi->failover);
 free_vqs:
 	virtio_reset_device(vdev);
-	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:
-- 
2.43.0

