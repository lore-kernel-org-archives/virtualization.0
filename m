Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894D15442A
	for <virtualization@lists.linux.dev>; Fri,  7 Mar 2025 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309947; cv=none; b=q5xv7ngPDcBtrwgmwMMkwnDG9gBCIdsINNCf5zxX8G5J5MtIkhd2gmxRsceSGxscfqu0ClvJE9pj2ToXY0DI/kRU6VerhD/qF3GOaQJwQo9vEoSL8bODhDFhBrGbSClGoX1h/531289p/EBwOSc0pmqh01YmyakJa9dEO/JiZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309947; c=relaxed/simple;
	bh=O43CjekhpNhqU5hy99CW3Pg6sV7P2M0U4HkhUdlpIoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yui0lo3TK6fDnTDrP894FI4TuLv4umkLoCIU3sVMtoEgMYJz5yMg/uAwmpweGdJGFNezelznjJz23bY2fHW7qdlz4nKnb3fhyUKa4ggeWdqW9f6jSieRZXwXSLgBM2iNMXW4zfn6W6EwVdtoeU8ir9YWRuSsILXjRGDrKTLdBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Iwam7Cs/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Iwam7Cs/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22356471820so22014605ad.0
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 17:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309945; x=1741914745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kov/5Qi5/eXa3sZew7Uff/swL40CZY7WdNdYduRpGtQ=;
        b=Iwam7Cs/o5pFYcSLINw3BISKkXu+fn6th4lJxrL9sMceEsEQeOe+OoHIMFtd/T1q0I
         Ou4f92n0U+R22GvuZiGumZpYBEJgO4mGDsVyFhGOrkMiLgFyYLU5QIpc+Hsta9c8ffu8
         UPxVcLR3ZdpmORISB5Ph65g7BbyjGYvE+OLUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309945; x=1741914745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kov/5Qi5/eXa3sZew7Uff/swL40CZY7WdNdYduRpGtQ=;
        b=lsd7BDbYUnuSDv1YYCNLPFmnihg7xPHGoEmejgmLi5I4Ivj9xG1vN3kqA+sifRHxqZ
         XY1nYPcVWTS8E0Exre+9lcc6CK2czzBt0xgv7sb4ZVbLRnfeG49F7BYRMgopKp/T7SfR
         Z6UsDfeo9Eq7FYslo8hRjqhzkt2KoXvN0HVmOdfPeJHJha9p8uDLhfEB9360KYAolKbf
         j8VUkqgOGzMzWXmJQXFW+jDiSYXQOO29VqMIYcl3Sm9WEh6BRbWjgL2+Dc5vVxg6YeMB
         AFhWhYkBzwohibSMl6/goEeKIoTgDyP33/ZmLwT1hqox+sgQVbZcpA7aZKLetw5Y59IF
         RbIA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXJXMxxSzj+OhLaICCHS497jItB+lphS8j9AnMG5wXu5fmA/FmmZP1Xw4ZVZJcZIFh3hdL2Tu/9GdD0I8AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuRXysMQwnuVbQgdB/SKWdvvKw4fNk34LM1l6TyBhp3IoUptka
	S52NmpG6aO6PegPzb9FKdpv449oW3XJjZMafMrPXmGOt3E97dwO6pR3F5KYULzo=
X-Gm-Gg: ASbGncvu33Dq0Feh70zo36AxyuVGvluG6Osx3MeNHiexhm7B9NhSBHcK+CVTetvCIC5
	K13eZpPsXh4o+zeoHnTLgiHRiWCyo5+394U6DkSFlhgGfOJzZP6+ei+Uu/Z9MQotQOdPurGHlsp
	ol2DGJCLZfX2zi6+csK4HSTGiZyhSvA3vtIOgT6AJNbSGTlCFjxgCkjtjcBsGpfZ4JZt+tHkddj
	AomMupCSv+Y0Sf5Tw60ZBjkEcXaKjNkcqnkfJfx+DNXWkqgyvEiBIbnzQg79kE2XNlCdqV8OBTU
	cU03IQLVkvDxKyTcza2ftfFsnGEVdv4KXZdfC6rTlFEQAOPgkIPc
X-Google-Smtp-Source: AGHT+IHk3rKIVw3xzN+NcT/1jnN7TTEd2BEkiVLbP8IFN0cXRTvNB5nEIsZoYv+ZdmtXYxpnfUvrZA==
X-Received: by 2002:a17:903:1cf:b0:223:2630:6b82 with SMTP id d9443c01a7336-2242887fe22mr25579105ad.10.1741309945056;
        Thu, 06 Mar 2025 17:12:25 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:24 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 3/4] virtio-net: Map NAPIs to queues
Date: Fri,  7 Mar 2025 01:12:11 +0000
Message-ID: <20250307011215.266806-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
References: <20250307011215.266806-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps. Note that the netif_queue_set_napi
currently requires RTNL, so care must be taken to ensure RTNL is held on
paths where this API might be reached.

The paths in the driver where this API can be reached appear to be:

  - ndo_open, ndo_close, which hold RTNL so no driver change is needed.
  - rx_pause, rx_resume, tx_pause, tx_resume are reached either via
    an ethtool ioctl or via XSK - neither path requires a driver change.
  - power management paths (which call open and close), which have been
    updated to hold/release RTNL.

$ ethtool -i ens4 | grep driver
driver: virtio_net

$ sudo ethtool -L ens4 combined 4

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
the lack of 'napi-id' in the above output is expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e578885c1093..7bd63a677123 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2823,13 +2823,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 
 static void virtnet_napi_enable(struct receive_queue *rq)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	int qidx = vq2rxq(rq->vq);
+
 	virtnet_napi_do_enable(rq->vq, &rq->napi);
+	netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, &rq->napi);
 }
 
 static void virtnet_napi_tx_enable(struct send_queue *sq)
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
 	if (!napi->weight)
 		return;
@@ -2843,20 +2848,28 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	}
 
 	virtnet_napi_do_enable(sq->vq, napi);
+	netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, napi);
 }
 
 static void virtnet_napi_tx_disable(struct send_queue *sq)
 {
+	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
-	if (napi->weight)
+	if (napi->weight) {
+		netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, NULL);
 		napi_disable(napi);
+	}
 }
 
 static void virtnet_napi_disable(struct receive_queue *rq)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct napi_struct *napi = &rq->napi;
+	int qidx = vq2rxq(rq->vq);
 
+	netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable(napi);
 }
 
@@ -2870,9 +2883,23 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		virtnet_napi_disable(rq);
+		/*
+		 * When queue API support is added in the future and the call
+		 * below becomes napi_disable_locked, this driver will need to
+		 * be refactored.
+		 *
+		 * One possible solution would be to:
+		 *   - cancel refill_work with cancel_delayed_work (note:
+		 *     non-sync)
+		 *   - cancel refill_work with cancel_delayed_work_sync in
+		 *     virtnet_remove after the netdev is unregistered
+		 *   - wrap all of the work in a lock (perhaps the netdev
+		 *     instance lock)
+		 *   - check netif_running() and return early to avoid a race
+		 */
+		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq);
+		virtnet_napi_do_enable(rq->vq, &rq->napi);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -5650,8 +5677,11 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
-	if (netif_running(vi->dev))
+	if (netif_running(vi->dev)) {
+		rtnl_lock();
 		virtnet_close(vi->dev);
+		rtnl_unlock();
+	}
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5671,7 +5701,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
+		rtnl_lock();
 		err = virtnet_open(vi->dev);
+		rtnl_unlock();
 		if (err)
 			return err;
 	}
-- 
2.45.2

