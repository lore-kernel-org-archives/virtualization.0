Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F2199B8
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449113; cv=none; b=oWS4d8gbnzqNWPIlgxtiNo2YHmbUVdrl/YN1h+HRn8MHU/W0Fh9iK77lEnppfJpBvJ8r//KVkSkpBQWqml6fQlYkTUQkBD1slWs/LmdQk0YqbueffVlip9glEwICY39bD8CexbAM3EYeUG/JMpVb0QkVoL3rCXVxAUsvnsGmsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449113; c=relaxed/simple;
	bh=O1/087om4F0aQVS80+qWqW7HTYSlWzFCPffyQOL+39g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns2t9I8Y5jsUdW7x8Rof+bINB22TwTcNqLHD/yUYTzAINgCmEzk4lRXdqfJa11IkCdZDObjT/qzIlwH0du5FgmJZm2oMFN9HR871Gxq12Zks8xpr1FGGIMm3dwRMo3TVWYSMzHb1H8EaEuh+L/JFqkn7V1uqOUC/6/jHvnQXHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jWwGanD6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jWwGanD6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2210d92292eso294775ad.1
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 18:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449112; x=1741053912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrU/GLtdg0ptzOcVYQYyLKXFl5BzTzzKA9LeyaGSuBE=;
        b=jWwGanD632/QRJQ+7wlx5NvPWrU63pONw4hi3WdGNhmz6Gr2tGzkPfN7o1Bj9QySap
         FLu/Ws/zUTRiegTU8TBhx5r9CSq8l62g1NAeO0KlNAlMe3OPgQ0i624dFGQ7qiCI0Iw6
         61LgaJlg9G05L0i8ovX7cL5TfypRbpqcS87Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449112; x=1741053912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrU/GLtdg0ptzOcVYQYyLKXFl5BzTzzKA9LeyaGSuBE=;
        b=rKu4QpK+5WfYrDLdIZqW86dvc55jnDWi07OcLs9LXUkPOWhviERGN98g51QywGg9GR
         npm2wTwk6Mosmp5bPAQJYjzepLv2q64kTVEMVbpc5sb/+sualB/JBagFXFFwKWreueaq
         kjJbYymlWeeSfWlFohfSIWhXOXIVTpn6dLSIcJgyHVZYfrzd4/z7Y4JhUecfqJxMR1JJ
         5MTODrHvtGik6Zr/McmuZ7Ap5MMzhY9mSyi6m6QYmFk6x/u+EkzPhex537UzDxeH0lP5
         s2bfuQ91cBWZw72or/nyq3Ii1WmBX4LA8sMkeWbO9Gp9Yui7uWXiga7FeTvONtZngonQ
         /Jmw==
X-Forwarded-Encrypted: i=1; AJvYcCUstjAuf9/uXHefC5MLxzBY8PsLwS/poTdn4vh0FVtAfyvESRIK+V+P42tddx9iwocCqPtIwNpItduVjZvUZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH8ShWyEaxAGApXi6TnelSrTGwcgqu79I+23XVHXrr/sG6YHyJ
	zKluP/Nrum/8CCERGnRfCD3x0w69Y8+T5x1FZ3hQwjEYAaxLAq4M3okwvTYuZGs=
X-Gm-Gg: ASbGnctlG5dO/sEyR4THVFPuBDUTdbjx6OGfW3JdX0UTedbhKqxI/ICxrkDdpQwc5Er
	YheAFhKevLJpv2Oh9nN5OjjMP006P2SuqQk/h1K6O7iZk7E0j5FZ6bVPXi8tTfFn/seJaGr0v/y
	VdLQNauM5k73CHLVMC1UWJ1rzRImPXLBiwV3s6eXur7IkBVwiqrVVqp2stEHc/EPzXjAOCqHS/+
	4JtOEHfQRY3rWiH9wX1IUy5d/9YzkAx/YK4w9AenIeOADcHjcqcNBIsJLL4iWPG+g9wmlG4Do9d
	2vYwvWYRZppK9aqEnKahLjIQWZ9M3/QYMw==
X-Google-Smtp-Source: AGHT+IHY8lwN0JrUuvEAmWjnsdHLEwnDxmgRP+MXId726hvqxCaVfFz4XoQuZ4YlYhDmAgxBLFzirg==
X-Received: by 2002:a17:902:ced0:b0:220:e792:8456 with SMTP id d9443c01a7336-2219ff311c3mr267682865ad.11.1740449111274;
        Mon, 24 Feb 2025 18:05:11 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:10 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 1/4] virtio-net: Refactor napi_enable paths
Date: Tue, 25 Feb 2025 02:04:48 +0000
Message-ID: <20250225020455.212895-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
References: <20250225020455.212895-1-jdamato@fastly.com>
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

