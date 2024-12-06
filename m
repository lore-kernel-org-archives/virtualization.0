Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81A14E2C2
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447528; cv=none; b=T0bDZEWEzSUgGmqI87YdLwi2QnTj2/b/542C4vPO0udaecqKyBGKeOirom1+ov434GmBQzwRw76OCmqnTS19qiq6WNGrlEJusj/HkiOAr9Sr25a1uZ8zsqvcWHgZ33B+uMl2Vjm1iQ/hv/+Bmm1RqwLvU5qScOlvxTImW/lUsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447528; c=relaxed/simple;
	bh=PA8/nHkFzKyb0DBtcvKTmZDujViTonA6IYtFxIJd3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUYrd9w/2HO1Rcxx4ww6bDqclTcFtBz6HQJ9ApZe8fdiP5PbiSjiWafU+60BtQO3BKduw+r6FbgQSAYpyYe0D3sWwfLQKpjLdbUbCI83lrdQwBRjpL0M7B5RmgLS2WWzjEI3P5zVKvMlRLqrv7lXSIHR/Jy+osmgCQ/+tpBBzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=l/yVU6w1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l/yVU6w1"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2AEEB3F766
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 01:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447525;
	bh=EaIKOfv6bk/O45LzQBb832X2umTA/PIxnCqcZGBeU+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=l/yVU6w11FDOMqRQ1wLUuzQkU9eIAke4cOcu7aAfY0zO284S4bwgnFkpvM+ydjfKQ
	 CROonq1ulX377Qz4Hx//Y+Owp7LJXgtmSyLxzlCUAXTElUshJVwF0ns0JBfAOebyaM
	 tq5j9n9/y1TTkESpC9rHH7w1DKLyabVFRRAHRavU5dBLiNiKIAXEXnCYD0y3UqJs66
	 kJA5jInFSHcQ3KMG022klc7KJMnKkXn977tLk1WxDniXzvWCLKXp8g3E8sn/GDUe1O
	 AnX5IetN6yhJTm7L3i6YotdHDwcgx+Dg9zxoU+royLnBGRVvYbdnrZynoplerCMD1d
	 PPFgJJB0aHAjA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-215576aca41so20874715ad.0
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 17:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447523; x=1734052323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaIKOfv6bk/O45LzQBb832X2umTA/PIxnCqcZGBeU+M=;
        b=jIzxaadU3KCrnPBIGPSfjAGCctobGeWj0d3mklct24nKMTTt4zC0JTxmXkOPLklJ4X
         LqGuvJ68/V3VbHmWe+UcpE66QiVQyIqOoziPg0J9r59wfcXGiZ2UVE9dxzQhet35y/5K
         3M9ZJOjVj6UcfqIuGUA3yG4wBY3hTJvsL2sVUN7IR1AQLs6gLtSCm3kRHAqf6DVfQIeo
         5In6EF/3MLo2X6z1ajxrekM6L/f134LolF4pjGgv5a7bK7q3bYdD82nESoCLkDYu67M/
         v4eoLEo3XpHgGa5tVBidaMQra8GBWYwZWLepNXaXT8zOgQiIcIIv34NCw9XGigIfdCop
         MgDw==
X-Gm-Message-State: AOJu0YwamI47L9WI0yeOA3zgJpD4Wrz9YXyaOhDHDKKby1SyMXFjYcRq
	US7BBsXG9ey42w/XaHhQCDeGW23XUHV6jktHMOnV4TdRnKmvy7tivddCxGU9BJy/OxC/4WSgLzA
	jdDsTBtlWj/Q0ivrDNl3jRNBzSZa8VnYqHspN7OqNxmPcn3c9vKq8dvnoAbR8gqj6QDzwCw0+vn
	9MzqwHsNuivB6m
X-Gm-Gg: ASbGncuH3Ew1bWmDGPf6vnvTlK6TlLMZkm4HfaWMv694HuB50yBDAvHMb3PnYLHIfPe
	V+diuRSiF4cGuUcp//LeUo1gaC4WlbWXPzrYiFa7qgtMRTF4vNQ2GsbkzYoBu7U9XQsR9Kr4o6E
	V55yw6wIm2+X5QqDwJ9K54GvOSE1XdQql+YBf6yzoA3sAdpOCAf/8kMVVyW2rOXgiFDofUksXzV
	YgJs3Yf6k0CJpdf1dEBNqoIQZDzMcV9P3ol0L6UvO1u+cUcT7I=
X-Received: by 2002:a17:902:d2c3:b0:215:5a82:3f8c with SMTP id d9443c01a7336-215f3ce4fa4mr81930385ad.20.1733447523065;
        Thu, 05 Dec 2024 17:12:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXqJiZIYbDQc+sRm11CP5WOXPhB8Q1WFXfqgl8yxVSWKPwnlYc7wDaqcK9TVVx9Gd1p79dsg==
X-Received: by 2002:a17:902:d2c3:b0:215:5a82:3f8c with SMTP id d9443c01a7336-215f3ce4fa4mr81929985ad.20.1733447522743;
        Thu, 05 Dec 2024 17:12:02 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:12:02 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 5/6] virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
Date: Fri,  6 Dec 2024 10:10:46 +0900
Message-ID: <20241206011047.923923-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtqueue_reset() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new function argument
'recycle_done', which is invoked when it really occurs.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 4 ++--
 drivers/virtio/virtio_ring.c | 6 +++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3a0341cc6085..5cf4b2b20431 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5711,7 +5711,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
+	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -5740,7 +5740,7 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6af8cf6a619e..fdd2d2b07b5a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2827,6 +2827,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
  * @recycle: callback to recycle unused buffers
+ * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
@@ -2838,7 +2839,8 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2846,6 +2848,8 @@ int virtqueue_reset(struct virtqueue *_vq,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	if (recycle_done)
+		recycle_done(_vq);
 
 	if (vq->packed_ring)
 		virtqueue_reinit_packed(vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 0aa7df4ed5ca..dd88682e27e3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -112,7 +112,8 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf),
 		     void (*recycle_done)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq));
 
 struct virtio_admin_cmd {
 	__le16 opcode;
-- 
2.43.0

