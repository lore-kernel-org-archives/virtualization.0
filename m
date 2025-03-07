Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698213D89D
	for <virtualization@lists.linux.dev>; Fri,  7 Mar 2025 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309944; cv=none; b=Xv9gtSThhQ9r10+6QB7xyTmvftb3XNmQN1fAELh8h843Y3EAovgzyFXIfThvHzeQ28vWZ1YPNnXwoASUIgaUdnajKXT3XQ7QQpLPo8D3NQe4s9xvDxKRnathnDxrgYv28JwjdCyhmAZGCOfBLP+QzKfliVUpqYGYiOW8xE9UMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309944; c=relaxed/simple;
	bh=oZEKZBNyzTFUQoyDm8VLIwp8l+Uss/+aDmlef+L4zKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLAUgl6ao8A4wn/eFx772TUuoQ9iOfIVV3CvaFRdvM2fgg9H/akyIL8SZTjEFsgxUTn7cxVuIyV9nTMQTPhkwR1CpUiqst0r18trx+tv699233d7wlJ3cd76CcIwbbMUIyTAhLuGwinb6FcifhgnvBUCfFlEaYVPd3hA670BjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WlEy5jO4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WlEy5jO4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2232aead377so25712925ad.0
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 17:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309941; x=1741914741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=WlEy5jO4O3o8C+58sN131xEvaSXT3YZIpbc4VCVMXsigtAnlL0o25VT7FKoMaHoKLt
         lp2tQjt72oUTvyquJ/DGHswLutCI0tivLBewYCK9uQJu2urwvOV2Ds3LfwrQhA8BXP/a
         cqulb7QLxRc3n/RTjKsD1m9qGwGhmYPXk/7xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309941; x=1741914741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=YiMbdVbD6QFmV14SQb9CGEX+QlzSic3sPtTKsglGhhLVrx6qyW6x9qPCI/7P50i48z
         dKmnAs3DP0nVpqtByFKiENJYX8UL9g1HaLTXXkc4PAiaduyBobGbh7nZw6mVcxWShMyW
         OmFtOvJCb/2PWmoVvb/KefJFiMukpF3w5dpV+WfATo+4cAqPI8+n+danYxg720PjGB5K
         6LX3QKh+3hLuxtGvvetp1IABhPBXyiM4WAC75tom2mH8utiW+YTlECxeUxV0I+zJs0fu
         ZG2td4XpQI6DzICWYjGM2HvtyOr6Kn3kem42C8W8hRQhxmCwsGZQvz///Iso8f+4f2Yl
         0I3A==
X-Forwarded-Encrypted: i=1; AJvYcCXBn1/7BAuwwiM+77q80bcZCvQqqYLKKBodsDz1/PhSJSgYymeg0zkq8sXTi45PDS14kmMLtwSvZkwoQCUFgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmdMax7Fb/Axo6dMeMvBCtyTcqU16jfqsw6osXaK01xtuAc8sz
	S9P3aFymKM6rylt+7WiHpADR8rAzduAdeu6igltboeIFmdCLvast4txJxJACUgA=
X-Gm-Gg: ASbGncuCFPuYOoOMr//nt4+GveF1KWXxrXeIuKne3ZseebM2I5ybHm8FIswI50+ULjq
	cMZkGiYJLOYm8Y6KLoKDC/1RCsl19GkGF32TM+MJu71sB9CN0OfWy28p02YwDS5tWlVqN3dorBx
	wU8RCo4KOItx1agfjoQGzysELTXHYcxeJZZytYAHvLlRKf84wX8oeC1sB+N+hRfXWkmhlQQNtyJ
	Ru+IEmj/fOpLntrNoG1/KEB5UCGLX9euYsuZDAzMmWCpnL1wCqQUES5I1BnHzJSXqheH505sO4O
	oKSqUNcnm0kB9qeiBEP5txenUyBBT8oLL8S8FoXLg6VZ9As0xeoI
X-Google-Smtp-Source: AGHT+IGKhqwe2JpllICnS8YtflWUc4MgBo06dsvavfBwoHtdqy1vxCbTRe3YRbrAw0m3enhzIMPo2g==
X-Received: by 2002:a17:902:ce0a:b0:224:584:6f05 with SMTP id d9443c01a7336-22428bdecdemr26052505ad.41.1741309941695;
        Thu, 06 Mar 2025 17:12:21 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:21 -0800 (PST)
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
Subject: [PATCH net-next v6 1/4] virtio-net: Refactor napi_enable paths
Date: Fri,  7 Mar 2025 01:12:09 +0000
Message-ID: <20250307011215.266806-2-jdamato@fastly.com>
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

Refactor virtnet_napi_enable and virtnet_napi_tx_enable to take a struct
receive_queue. Create a helper, virtnet_napi_do_enable, which contains
the logic to enable a NAPI.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac26a6201c44..133b004c7a9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2807,7 +2807,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2820,10 +2821,16 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
-static void virtnet_napi_tx_enable(struct virtnet_info *vi,
-				   struct virtqueue *vq,
-				   struct napi_struct *napi)
+static void virtnet_napi_enable(struct receive_queue *rq)
 {
+	virtnet_napi_do_enable(rq->vq, &rq->napi);
+}
+
+static void virtnet_napi_tx_enable(struct send_queue *sq)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct napi_struct *napi = &sq->napi;
+
 	if (!napi->weight)
 		return;
 
@@ -2835,7 +2842,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(sq->vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
@@ -2856,7 +2863,7 @@ static void refill_work(struct work_struct *work)
 
 		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3073,8 +3080,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
-	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
+	virtnet_napi_enable(&vi->rq[qp_index]);
+	virtnet_napi_tx_enable(&vi->sq[qp_index]);
 
 	return 0;
 
@@ -3339,7 +3346,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3402,7 +3409,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
 	__netif_tx_unlock_bh(txq);
 
 	if (running)
-		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+		virtnet_napi_tx_enable(sq);
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
@@ -5983,9 +5990,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 
@@ -6000,9 +6006,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 	if (prog)
-- 
2.45.2

