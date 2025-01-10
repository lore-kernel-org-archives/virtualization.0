Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA127216608
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540785; cv=none; b=g/MT5UTSTqoJ1rxPo1F5g4CjqvILzJgjINFagA3GjVg4+6GxpOJaa/BlrLxV3oTH4IrNnQ+hfCl1PrHcd/+C9JtMDK3pZRyCJSzH62rbRgZUYJZfd9fsWT80uQiZ7dFAtTiKLN4QGLXAd8Aa9g80R5RVIuGb70ccUH8ZSQmUUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540785; c=relaxed/simple;
	bh=z8f+xuxsM4TN11cQa7K629H96IgZ46RfWlBQbRy438c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0ycFORZ6aDFpHNbf0f555oeNJ/e37et9ydkZrU+3PjRJk3PLvSjUEVBPE0fjrYTs6pzN1AAK9Tp7ZcOQ51A7JFNGCNr93nOrNrTktm2mnadc/B9zSSTTiZf+/25QQr7OtEvR14ZkZ/kosJWYGVacT57J1H33HX0hkrKcfGKd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rUxOBwqo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rUxOBwqo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so3366714a91.0
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540783; x=1737145583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ik/OAXhd/zh+RJRbmUQzcFN2s3YuP0CmCWofX99x/A=;
        b=rUxOBwqoP04BktvVS3g4AxxGRsvWB/8Ya9AzZL1IBslcaMCmoH7gLZS6cRfqEYzcTq
         TmjlSHmFFPxrb5R5BJHRZxCJKRNQX7DqgpjvxBNsW0VXvlIGQuApeI4oMPua0m7gQ5mQ
         HMJL8/FVD+DJlM898SiHkUZ7KFcSZ0WFhU7EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540783; x=1737145583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ik/OAXhd/zh+RJRbmUQzcFN2s3YuP0CmCWofX99x/A=;
        b=jqqCXEaw0UpNktDOmjpxpLHZlrFld9ThrlDw4gHlWKSyL1bFj0O+EYGZNA5QK5Ie0j
         c/gW6jHAXCQDDwaUVwJzaiTpSBkM5/gE7qwe/ZES+xouDUZsUUwUjmXDAiKqSv977G7b
         l+kOGc54gQS42yDNNKCqUkQez8tOkfnThMk3IaAyv5/ub3RV3Lq2wFnsIbruBk1SS1Jm
         k6wz6+6RKV1VRjeLzYA1qVYxplqlZzv3uzlIwJB0r2tzWFCZrLWjFbiPNXoAh3H3OKJM
         IIahmF2fSd6kY7She7T0ETf/WMr1brcNWHOz809MBnwMtMHgRIabp4gYk7OruujSk31N
         koPg==
X-Forwarded-Encrypted: i=1; AJvYcCXgI/Jhv4WTNPv/mZX6J8j/g2rV1rzJ4eaWEkY36Wy34HTJcIVGb4Gd/Q2yBlkQTiWbKhUKiROkHzzVRkn3gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwM8YrchWZgAp+VrLa0y3DIAYc3ZEVKe1ToUkKqEg7hxekXhFp4
	b+yRtxMmzm0EYnTEe3vRwQkR1Dulf70ced/Lrr7DRkhfDbKAgTs4sxiNkdvR5qg=
X-Gm-Gg: ASbGncsTOTX0oOvTqrAxoriD9/ootp56MZ6u5kP7JS+8/khtFrH/UiTMzukxjqHrz+Q
	RJ5fCz4GssqGUoxL6YyUTDutN1DShWPzKaGEriI6RMRvAvPdoBDVZXa0b7viqnbTylfdFUQ6DJF
	empUgvY5Sgr8gw2aIWTjW959Tlx92wNioN9Ns9hxp1tVs/3jbNnc8aopNdfKDZLkZ2Mw+ePr3Q8
	z6sTin5eypLu9Shgn3n0uaKT+JsmknTx+++iSxChmrwTTPrK0aAFSFrQvllKL2i
X-Google-Smtp-Source: AGHT+IGukifaC2WcNQEFeWzn03HlxqND0jHU8i/CmAXEOKXmIs5P2HeRfZRbh+3c5FScxgk06QKRWg==
X-Received: by 2002:a17:90b:6d0:b0:2ee:889b:b11e with SMTP id 98e67ed59e1d1-2f5490bd257mr17730230a91.30.1736540781585;
        Fri, 10 Jan 2025 12:26:21 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:21 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/3] virtio_net: Hold RTNL for NAPI to queue mapping
Date: Fri, 10 Jan 2025 20:26:03 +0000
Message-Id: <20250110202605.429475-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
References: <20250110202605.429475-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for NAPI to queue mapping by holding RTNL in code paths where
NAPIs will be mapped to queue IDs and RTNL is not currently held.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cff18c66b54a..4e88d352d3eb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2803,11 +2803,17 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 	local_bh_enable();
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_enable_lock(struct virtqueue *vq,
+				     struct napi_struct *napi)
 {
 	virtnet_napi_do_enable(vq, napi);
 }
 
+static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+{
+	virtnet_napi_enable_lock(vq, napi);
+}
+
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 				   struct virtqueue *vq,
 				   struct napi_struct *napi)
@@ -2844,7 +2850,7 @@ static void refill_work(struct work_struct *work)
 
 		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable_lock(rq->vq, &rq->napi);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -5621,8 +5627,11 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
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
@@ -5642,7 +5651,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
+		rtnl_lock();
 		err = virtnet_open(vi->dev);
+		rtnl_unlock();
 		if (err)
 			return err;
 	}
-- 
2.25.1

