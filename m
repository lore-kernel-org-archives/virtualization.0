Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D426D5B7
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682248; cv=none; b=C2WqqQTvynplJGQdG3uQ5H36oWrnZmYlHraQor7f9x3TonmFcvBZstgI9tZDdxiM+pBC1mxcIyOWxRV3tEkgLwOAyaxwbYGYdlDiYm8vo+uejcE1mr5ftG6zKNF1qU5mVZhIjuflWIUh9abfSsUCIEMxz2XnNsZSSkT5IM+mW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682248; c=relaxed/simple;
	bh=ruLhp//Dblw3Q1cnTDsehC77vyCvqCtIvwsJ3QV+GLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAJC11byd9C+V6elcn7h4SoBC8epYQ+wt8Ko7e31ZhbvYLRvQj19WNAo2d0ZvahxkzCXKkkqwD1oA1dZaTJ6cWqWK1eNU5Ew5EpQGGc9Dz1rne4ih+Dkdl0+NIepHSDyCU6zr7fP/w1sfzGIk2hxYiY7bevxlB2sNopLef53Lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DRFhDcFX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DRFhDcFX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22113560c57so26036715ad.2
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682245; x=1741287045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urTnWtLOZR1ii67wvyGmGFIgFDC5fRLxfMV5fbOG6tQ=;
        b=DRFhDcFXy3iXK6ZDqESzfzCP50KW1LZt5EWdb5yC58Y0qVwva2o006OehyqyNtGSpf
         pCQdWX6zBbvjf9mzDjRXfihae3AeDaRW27UzLuMSZZKUguDWj7prllbQIIvr6G2xWn6/
         YiGD1/BIWxaT9KnPMq5lU+m9ksjFq/lCmWUFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682245; x=1741287045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urTnWtLOZR1ii67wvyGmGFIgFDC5fRLxfMV5fbOG6tQ=;
        b=cOsaxpctTHRO/TnKnMUqzGW7g6nV/fzuhAUKG4Ovy5P9rC+pFbyEbnYsl2vobnRcgg
         9+UFDA06CABmj+Q5X6/ZhZHaQfjHy2uQaIOZ8179tg+CDUGYEbV5yH8bTqp5qF8ltd6X
         CV3PWcpZXJKkA0J93axMIPqNqyi5wKNUlrIZyGKYEp5LuNCAO/kb/h7t0AeOlAN4vAz0
         DMdGCu45eFNgZlvUbpUJd97D3OkdXcVSJ1hXoXcTEGcRjBOYCOkXNtezKYxsnbN9Hp0s
         RnF8vSxLH2Tk6fPTtjcnmdwVoFB9Z9a2vgTIvQEbwaS8HgwokUA5nRqdh8L5iGsx9Nt/
         /euw==
X-Forwarded-Encrypted: i=1; AJvYcCUHlwO7oEBFAsPBnR98Vb5svBdcStrVHFF9G5xN4imoUMVkSNkgMeuJI38LW8hUARxcO7GXYfIFS0SFLubZ7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAH9f/rDMCdWTfXDKeNItXqU3rLnygTJNzWnD49XV14xEUv94E
	7cpcno7KBKi3qubF4MN4V1Brc9I4D1DQk9bWaBZw9QCvNGFbWfk6LE5lYygJVXI=
X-Gm-Gg: ASbGncsJWWHuK+fhL98+sBFpDVt6Easqo8/cYKOLMOlAhsLUGqkaBUAuMeiszWfiR6v
	f9UrqiWNT89Cz5zuGFIrVk/+aCRhEdd7GMU6MXF0f+r3+n3hIecp+2KGgUaJr4DgDqmzTng0Zpk
	pqqIANkosE3dneRI9MNhBXOIfPaGiJVEeViMCyLtrYOhHlrkhFZFVnRUwIwyQTqvtlZTVx9LL6D
	XjaMXhzAIvRCmK6zc22H3mJfEnu0u0o1Qmit2CW4yBUfNzOc/qj+d7DkKD+plXEpE5eNfatMBQL
	QgxDcPFYF1RXBCDJxcVqOEpAzOKGtF+q/A==
X-Google-Smtp-Source: AGHT+IHu5hlvHH5LXXz1OMUSyDQuYBfGMEi0ghDf4USSKQwpy74Ccia4YTH/3ePDByGZSW6VYZTrMg==
X-Received: by 2002:a17:903:32cf:b0:223:6744:bfb7 with SMTP id d9443c01a7336-22368f732c9mr3587465ad.8.1740682245661;
        Thu, 27 Feb 2025 10:50:45 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:45 -0800 (PST)
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
Subject: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Date: Thu, 27 Feb 2025 18:50:13 +0000
Message-ID: <20250227185017.206785-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
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
  - refill_work, which has been updated to hold RTNL.

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
 drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e578885c1093..76dcd65ec0f2 100644
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
 
@@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
+		rtnl_lock();
 		virtnet_napi_disable(rq);
+		rtnl_unlock();
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
+
+		rtnl_lock();
 		virtnet_napi_enable(rq);
+		rtnl_unlock();
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -5650,8 +5669,11 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
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
@@ -5671,7 +5693,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
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

