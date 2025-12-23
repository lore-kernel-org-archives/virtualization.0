Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A534CFB3
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503635; cv=none; b=nj560KIkdINnkTgW2xDyfA8JFi5t3r8y6bSj2gY0xkBgewsmu0Fz4LFvVuuHnZiAD9jKDosZbO/qA3g5qpIoZr4ONFbxjTfjRanzAXv5R3RUKdzT5pLHDjF9zoyUB4Iop2v346qXLnP98Fx5//VDqjKgPwu0yb0xj0Yi03+vvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503635; c=relaxed/simple;
	bh=L0CtNZGdC7XEOtswvmiReCjZIo8GsOvQxUlegVLHBuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roE26j/gRmKWoTnYZbFMtj5woaj7G4qL2ZLy9NRETJdQyNuP0HLGw7/+2sWJjB9wqG3RZCX246dkVyRCGCMDIVxQmcqrhGVIzFrF+v+4ZfM5UMY6X0UGJzlWlhwi7n7Vdg5fBwZ7MKfo0IebgMKQ4cWI4+9e4vzzg1fRicWSrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyfyOlB7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyfyOlB7"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so5567756a91.3
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503633; x=1767108433; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+6D6PVRsFTnS4j3cktmLgH5az1adeAVQEKO6DToWSU=;
        b=FyfyOlB7ea/wopTiG2PzykrxqOLU1E9flxLdYsndHoThFoBfKw1BhGVfVd0sw8KGkv
         fJiCZcXkDVjf9cbkFcfD83r8+FzvkxOyShyIxbWnfRutU/X4I0UP6EmPpglOb+XcKKAP
         Jz/CkvztKi7GqPHIVfCEv/yu3mBis9WMws+sA1dnIsNiZdJxA7J/bB7RLgA/IF0vMBp5
         Tq2XW+WCeCLWPlFb770emnlrqSUF6+0zanfgUS3Gre25keqjpzxkSSapg9k0kOz/Klt1
         QS4CeBrYU5BTu+Vrex8whDAB3dleqY9F9qaPcbJuRBp6pORtKBafj/iMC8xn0qqUPHko
         yB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503633; x=1767108433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+6D6PVRsFTnS4j3cktmLgH5az1adeAVQEKO6DToWSU=;
        b=Ulm2E5fcw2BA9aB1w62SowVNYw6zvJV+T3hg8BHmk75XjYuqAs5aKYH4lIFQYaWDMQ
         kiEElcd0oBOv98Paayuyzc8h+N9+T2YrhgmQOkMfIulW5OHRqz+D3+VoJW4XNClLH+ad
         S35XOK36O6DD0vFIIactGD8a8LTbgx6F7++fWBpiLcaV0CxNUfPDlF/FlBOV9KpiWIen
         yvAJEvITyYkk1YT5J3MgyE3ioc5uB4YhV0pp2+bQtWTYT7dS/FMiSkuIFK7UDmaFkY6l
         dh0mZmgFkAMazg8TCpNJNNzkaZMbYBf8qGOw3GgyNO//B4juV7XA9Go+7MySlBkhAOhW
         Fi9A==
X-Forwarded-Encrypted: i=1; AJvYcCXZJH9sWoEW0JOPN+EqMhHzas07Dmkp9lGDPWTQnpIzxehSQnEuK4O70/zRGl4QnML64U3XYbHY5nCWxYzd5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN9RXEKCtdZzLes36osaeZHr85jIV2y2gK4C1z5TAm+gEztcnm
	0MMYFc2xqblhmFag4l8b+X5/PBbXrSs0xWgNoCEe8vTEjD4W+LYD2vkL
X-Gm-Gg: AY/fxX5efiVIpOw90YknZdX493cm1SkOPI7IRV/8oBq3EgzY78ymz5L/e/XKBTPBu7i
	sYyCwXIbTiup7YYpwCqgT0RaARdYcJSJ07pj3o9GxCo+wPMgjTaAVkomtCEZSo72zLScmL4JUkm
	MYy1EdqNi4ULGKQaUlp+hfpgRlk0qHnNZ9IbGkVQfKi1OFQizK8RGOk1xU7IMFaIa7GCCH5uWXP
	PWtKDIodsQKbYFvHLFYvcZg9sLmSTgpmMhkmgFmz3ryJn6ZYH+7U+eCX7ClcRDH+MBf4AxHFFHJ
	bQMZ0vO0i6AFzKDhx2zyyZk2J638kRmWtSeamiwGsAu6/BvcrVKUjQvSpzPkRPxodg11TUGnE5W
	FcE69vE4LguYDjvZbuo7aUaKIUhNiqOl7M4TDrB+Nyp5ehrG+KCetgQqNoIPFqNWHOVj4N/UACl
	Vlqtsk83Qq3TQCSWdkdvprVNtHHKnhFenaBOs=
X-Google-Smtp-Source: AGHT+IHPZySRpyLioNlkGmfBeBlfCuPepN+ltwQg7UoU9dgxoY0VAt295aBDiCrvyeMv0Apodcz+Pg==
X-Received: by 2002:a17:90b:3c4d:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-34e91f6f93amr11885237a91.0.1766503632955;
        Tue, 23 Dec 2025 07:27:12 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:12 -0800 (PST)
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
Subject: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before enabling refill work
Date: Tue, 23 Dec 2025 22:25:32 +0700
Message-ID: <20251223152533.24364-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223152533.24364-1-minhquangbui99@gmail.com>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. Because the delayed refill work will call napi_disable(), we
must ensure that refill work is only enabled and scheduled after we have
enabled the rx queue's NAPI.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 63126e490bda..8016d2b378cf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
 	int i, err;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		bool schedule_refill = false;
+
+		/* - We must call try_fill_recv before enabling napi of the same
+		 * receive queue so that it doesn't race with the call in
+		 * virtnet_receive.
+		 * - We must enable and schedule delayed refill work only when
+		 * we have enabled all the receive queue's napi. Otherwise, in
+		 * refill_work, we have a deadlock when calling napi_disable on
+		 * an already disabled napi.
+		 */
 		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->rq[i].refill, 0);
+				schedule_refill = true;
 		}
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
+
+		if (i < vi->curr_queue_pairs) {
+			enable_delayed_refill(&vi->rq[i]);
+			if (schedule_refill)
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+		}
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
@@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 	bool running = netif_running(vi->dev);
 	bool schedule_refill = false;
 
+	/* See the comment in virtnet_open for the ordering rule
+	 * of try_fill_recv, receive queue napi_enable and delayed
+	 * refill enable/schedule.
+	 */
 	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_refill = true;
 	if (running)
 		virtnet_napi_enable(rq);
 
+	enable_delayed_refill(rq);
 	if (schedule_refill)
 		schedule_delayed_work(&rq->refill, 0);
 }
@@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
+		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		} else {
+		else
 			__virtnet_rx_resume(vi, &vi->rq[i], false);
-		}
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(rq);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
-- 
2.43.0

