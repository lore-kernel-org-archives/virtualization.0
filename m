Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD793A6EEB
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750998; cv=none; b=imNeRaA96YE6JqG14C0zkG0bgh8yCV1Tsdef9cZF6xUoQJrQYBt/aqXhvP6K0daNuWtWbm4jtkh0p6hKfPEcptY862sCluFqWsjL3Uumqdk81TY8hKQatO0Xc+4VvjgkvPYX5/9ZdYA/ReTeNTctTAjJ4Pni/gy21/2nrBkwfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750998; c=relaxed/simple;
	bh=giBrJRQN2VMMjCh/yoL5SJRMxEqzegUg6O8u4pivPpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=rLgTvmeyF5YlF2FMQgCftyIND41XENiEixbaCze5oAQTNOP4936yXk+vi0UItG1rapdwn5GrSb5JrDFxubyPgFjLqhHipFRhzc0ojuo7pKIHdlAwNSBomJyWgQ8fgIwRUVLekvt/AAeIwRZuQwucQcVwvgHZvZUSCG3DZwJszlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXR8aNlX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXR8aNlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778750996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X7d0CywKsZQfA/8iHBsstOBzlQ/bG9Xhxh5p1dy0nCs=;
	b=MXR8aNlXDfNLWQsPTiTDnae1nE/9rYrAzRh9/rj26bLTw/0EjcvaB88yHc4OExrNAnto5h
	EzEVcZ7/NN4k8Hbb1JZ+MpieQL7PUwttVU8517PbgA4HvMTxoka9UACxQjpVWQoe4Vexxl
	M+1x9KAKxEzzdFcx/2ejdP59GliDRfQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-VFaU0S8LM0qyvaiCnov48w-1; Thu, 14 May 2026 05:29:53 -0400
X-MC-Unique: VFaU0S8LM0qyvaiCnov48w-1
X-Mimecast-MFC-AGG-ID: VFaU0S8LM0qyvaiCnov48w_1778750992
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fdad6cce4so4332575e9.1
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 02:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750992; x=1779355792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7d0CywKsZQfA/8iHBsstOBzlQ/bG9Xhxh5p1dy0nCs=;
        b=KJISiHpVS5TEeWy7z/BCaEaJTjSI2sEHPdnRAww8s3uoXEXn23HIwZJBHHL5YvIyZ9
         irS9/BIKY94ORySJ7mGaoYLyPcclQk4XuDwrWMiZP1zBkG4Af4Bn7YF/ziqonw22fThf
         tNU1Lbjso9gnHkKOrMHKREoLjR6+he5hwAEjPf0Kiq1Z8b1xfb1LpMLCAGpJ/YiRp2Hq
         XrjLqEsQCRd69EQMLQ72XS59SiDLEjFPwQ3RmQtL+ckAqli3rUy9p4cqRxjMFrQTeQtA
         sd8hRQfBbBVSbS/fa0AP7OT50INarFHu4XDwW2TX+hBEen1ta2fX8qyR8KVi5msDXYmi
         Hmxw==
X-Forwarded-Encrypted: i=1; AFNElJ8mYTTIExF2dKPowGo1P4VFEh+EWnmOvY8bMsYSRuf1ILb62c8qsMDC3r8gAZCCpWA4ip95VWg+7V0xlOvW+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOI4HGJer8f1mmQFtdBFANBYW3jnwg71SbQd22rAhoyTuk75Hc
	M9k1v+vGiNVANRTVv/xVWRacHfdTq5Va5IiqGse92LLZoaVfZ7jRfnC0IuzZASZukmb9B5vdnBG
	NDjJYy5zNvXiw3woZM2gfd8OXrWkuHelGWWBV0TRprfskXo+HMW2jNLQKQ7dFY6qB+gyu
X-Gm-Gg: Acq92OHh7oXIGnp5g6Cjc7XQA1uOWZpiZd1SDGLyhhwr0PkSVKzQhPZLS5yhuHV9vKL
	QOKq1QS5zHllxnioes2J3Ty/Y9I3rErIvvQXDfFt9A89uMuwUoWXYaRyvpvgCg70oLi7xWVREdO
	H2XGGp3YLphZdZYcQJoi+hSHrq13/jE1C9/RTbkVHY4JbcXUg4IKMFW1Kff0oHsQsjAmQ2te1jT
	4XN1DQzJbZhTcN8bCUYNr0EBmTc2TOfHfnW5zlxSdC/Q8NFOy/O8KK1sc0f28nre+DI+I1gpoIw
	maWxdDxlh9BWk7ti5CCRwKHMkjiFL0yOlKK5nua61/6MPOJdadrrp2ZriuqBI7rp0eY3AirpT3N
	TMXNBHqZw5tVvJYw08lF6vLzwPbxMLI0PDuKgX3fZch7evINhOCC2H1qaBYB5pn/qv/Bqxi0=
X-Received: by 2002:a05:600c:a305:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe24960bemr2343655e9.13.1778750991761;
        Thu, 14 May 2026 02:29:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a305:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe24960bemr2343285e9.13.1778750991254;
        Thu, 14 May 2026 02:29:51 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd7672ae9sm19873735e9.6.2026.05.14.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:29:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb sends
Date: Thu, 14 May 2026 11:29:48 +0200
Message-ID: <20260514092948.268720-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w6A1ZXtcNTLdpSsMyvvmPtMokmSqPMPA-391EJtRUjE_1778750992
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When a large message is fragmented into multiple skbs, the zerocopy
uarg is only allocated and attached to the last skb in the loop.
Non-final skbs carry pinned user pages with no completion tracking,
so the kernel has no way to notify userspace when those pages are safe
to reuse. If the loop breaks early the uarg is never allocated at all,
leaking pinned pages with no completion notification.

Fix this by following the approach used by TCP: allocate the zerocopy
uarg (if not provided by the caller) before the send loop and attach
it to every skb via skb_zcopy_set(), which takes a reference per skb.
Each skb's completion properly decrements the refcount, and the
notification only fires after the last skb is freed.
On failure, if no data was sent, the uarg is cleanly aborted via
net_zcopy_put_abort().

This issue was initially discovered by sashiko while reviewing commit
1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
but was pre-existing.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
Reported-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 989cc252d3d3..1e3409d28164 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 	return true;
 }
 
-static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
-					   struct sk_buff *skb,
-					   struct msghdr *msg,
-					   size_t pkt_len,
-					   bool zerocopy)
-{
-	struct ubuf_info *uarg;
-
-	if (msg->msg_ubuf) {
-		uarg = msg->msg_ubuf;
-		net_zcopy_get(uarg);
-	} else {
-		struct ubuf_info_msgzc *uarg_zc;
-
-		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    pkt_len, NULL, false);
-		if (!uarg)
-			return -1;
-
-		uarg_zc = uarg_to_msgzc(uarg);
-		uarg_zc->zerocopy = zerocopy ? 1 : 0;
-	}
-
-	skb_zcopy_init(skb, uarg);
-
-	return 0;
-}
-
 static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     struct virtio_vsock_pkt_info *info,
 				     size_t len,
@@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
+	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
 	bool can_zcopy = false;
+	bool have_uref = false;
 	u32 rest_len;
 	int ret;
 
@@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
 					    (MAX_SKB_FRAGS * PAGE_SIZE));
+
+		if (info->msg->msg_flags & MSG_ZEROCOPY &&
+		    info->op == VIRTIO_VSOCK_OP_RW) {
+			uarg = info->msg->msg_ubuf;
+
+			if (!uarg) {
+				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
+							    pkt_len, NULL, false);
+				if (!uarg) {
+					virtio_transport_put_credit(vvs, pkt_len);
+					return -ENOMEM;
+				}
+
+				if (!can_zcopy)
+					uarg_to_msgzc(uarg)->zerocopy = 0;
+
+				have_uref = true;
+			}
+		}
 	}
 
 	rest_len = pkt_len;
@@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		/* We process buffer part by part, allocating skb on
-		 * each iteration. If this is last skb for this buffer
-		 * and MSG_ZEROCOPY mode is in use - we must allocate
-		 * completion for the current syscall.
-		 *
-		 * Pass pkt_len because msg iter is already consumed
-		 * by virtio_transport_fill_skb(), so iter->count
-		 * can not be used for RLIMIT_MEMLOCK pinned-pages
-		 * accounting done by msg_zerocopy_realloc().
-		 */
-		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
-		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
-			if (virtio_transport_init_zcopy_skb(vsk, skb,
-							    info->msg,
-							    pkt_len,
-							    can_zcopy)) {
-				kfree_skb(skb);
-				ret = -ENOMEM;
-				break;
-			}
-		}
+		skb_zcopy_set(skb, uarg, NULL);
 
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
@@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	virtio_transport_put_credit(vvs, rest_len);
 
+	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
+	 * skb_zcopy_set() increases it for each skb, so we can drop that
+	 * initial reference to keep it balanced.
+	 */
+	if (have_uref) {
+		if (rest_len == pkt_len)
+			/* No data sent, abort the notification. */
+			net_zcopy_put_abort(uarg, true);
+		else
+			net_zcopy_put(uarg);
+	}
+
 	/* Return number of bytes, if any data has been sent. */
 	if (rest_len != pkt_len)
 		ret = pkt_len - rest_len;
-- 
2.54.0

