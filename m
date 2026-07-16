Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B73F65EB
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219876; cv=none; b=Ii/DYIIyyJERFqUAyk/aRngPskkVok8eAEIvMAZQNQeXL8yh/ipVUhPRvBKhLhTLfh4r5DF/BugcZCcAdwS1QbKLEowAau4wYT7XWNbRqRqkZgEOvhOdmj+fs+CQDB9qDl6lEr4vWyg53I5nJiKUY8XxnKxfwRQOlYGc+JtQ0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219876; c=relaxed/simple;
	bh=o/HwCVgYgQFkz0/ODb7pKMxQLGAduLjD199HG59bSMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuVpSumQZv+89Ve/ncWcAcDsGqJ+DaCIu9l+VnSn57AQmeIOU3xfFD9dvrCvqiEgtCSyiKY6HHReA1Ys+ivwjsR+IFmqs8DKhzON2tHQMkF5pNcPRop5CW7LoKIVyC8yOjHGH8fMlM0+u/rJnb1M1In8w6ZAY0a1LYdVXd0tULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB18mtE0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB18mtE0"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so5186316e87.0
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784219862; x=1784824662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CwBdf7YTl0lNtDo3SBe9j9ZzLE2uAoBiUh1WwfPJrk=;
        b=TB18mtE0S4VKHaKDMjOQNulx7semRdyDD0GUGlNXHw27hJ40URWV1A4I0TP4V+7YNH
         aBh0+Ym0V3oFZIdcJghCvlEiEAMzcQ6tPu3aEmjZd9qObcycuBCcFFh6/rLdpXfh2hOo
         p4qrDfMOWGHQm8pCRicTG5XV7MyfEa/TSbBmgFfdMtg2viR6GIzfyfRtI/L6gKP2zNZx
         Z2xC0Ci5una9IInRARD9C/eHApI+NPfAA2Il+kCiBU8oiBdXY8R4QrE9g2EHerdn6P83
         mpaOjLe12u6Q+R2nyDpgQ98z1ARc1MxUh9qtPfH3i9ZLEJn5MEfwZVX/t7N9JMHYfMaG
         xCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784219862; x=1784824662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CwBdf7YTl0lNtDo3SBe9j9ZzLE2uAoBiUh1WwfPJrk=;
        b=leNex91iwUU327Dl7UaUcbOjotMXTVW+vdLNLRK6KGiMFDUObSHlDRDKMvUzflRgbj
         k185Nh7jzFLCHUAAppZnQYCl3sXdoCNCr4j3tDortt8chzapeWfLspJBdD1EfeKd3c4C
         hS1d9yi91hMoDZ+y6WPfEMaNWEeP1p0cCAP7JngDFH2Mo8t7dvWiBCRKAeveldxUuVpb
         /XSxq0elFs5AGD+8eNLvCi24w2dSK64TchfAdc6MewG6pg6sSU0tuZ1L5EGn1LrSOJKi
         9FFaJTGV2Wmb+nhZ9v6FGpFXqkTmmT8Ejm3qoHJtzLwmrJii/XOM4wR9Z0J3pR0a3TuF
         C0+g==
X-Forwarded-Encrypted: i=1; AHgh+RqHnskBm5c8qsGboMdELqZcPdzAxvbQXOVChH6B6Pbn59po5LWPyEPmCxY6q3LtucqTaOyDgQG350Q69DI17A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo7uur+ZjVTfVE5HyGEBNxMj+HCxFS7O5h3JQPsYwPQFxLA4KP
	3/JvIzS1AKBE5CB3IzbGX3yAouut8DlAeac8BnMqX4UO+dM7pwVNN32U
X-Gm-Gg: AfdE7ckdz9Y/q6HAKVTt3QNQ9ITXQUpCnjfk7U8/7mfng3SH/5nbSuukprAzggDZnH/
	ekMjSKH2KTt3Pbsle1YuDN/Z0hqvkjiv8oKyk0tnPj6OkmtQCEZpD13NjCIdiFkEapDiLhDZboR
	d3ddXsKPd875zqgAUbcj5TlJQgm2VyyfeUz8ND2YIVYkB70AO8seZ7Vr7PGe0s1be+t7Oh/5dnr
	Xiq/7CGIdXMAuXRl/6kA1r+sFX729rSTuMb0tVYt0AFaRaeZQuHnIUlYsoKTAxVA9g/yO0CYsZO
	LwCMFKsA3Aq0GkfnoKW9rlfg+En1xcKwWq0jWFU6SgP5DJwF8XB91QtC3ZmM3ruB2EFfn5rjC/9
	L8pHZySNfBuwSrf1CxVubHA/24LSoLxnbX2T/EzHdeaMOt3UoBzxlvdwnJk5FjjfweBCkbKWu9n
	fCSFq1tCga
X-Received: by 2002:a05:6512:3b20:b0:5b0:21e3:672a with SMTP id 2adb3069b0e04-5b159b8b887mr2052865e87.56.1784219862231;
        Thu, 16 Jul 2026 09:37:42 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caaf468sm5164318e87.68.2026.07.16.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:37:40 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: [PATCH 6.12] vsock/virtio: fix zerocopy completion for multi-skb sends
Date: Thu, 16 Jul 2026 19:35:59 +0300
Message-ID: <20260716163600.115458-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

commit ae38d9179190a956e2a87a69ef1dd6f451b51c4d upstream.

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
Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
Reported-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Link: https://patch.msgid.link/20260514092948.268720-1-sgarzare@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-53365
 net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++--------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 95170c7be758..aeb205e84bd3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -72,35 +72,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 	return true;
 }
 
-static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
-					   struct sk_buff *skb,
-					   struct msghdr *msg,
-					   bool zerocopy)
-{
-	struct ubuf_info *uarg;
-
-	if (msg->msg_ubuf) {
-		uarg = msg->msg_ubuf;
-		net_zcopy_get(uarg);
-	} else {
-		struct iov_iter *iter = &msg->msg_iter;
-		struct ubuf_info_msgzc *uarg_zc;
-
-		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    iter->count,
-					    NULL);
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
@@ -321,8 +292,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
+	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
 	bool can_zcopy = false;
+	bool have_uref = false;
 	u32 rest_len;
 	int ret;
 
@@ -364,6 +337,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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
+							    pkt_len, NULL);
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
@@ -382,21 +374,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		/* We process buffer part by part, allocating skb on
-		 * each iteration. If this is last skb for this buffer
-		 * and MSG_ZEROCOPY mode is in use - we must allocate
-		 * completion for the current syscall.
-		 */
-		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
-		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
-			if (virtio_transport_init_zcopy_skb(vsk, skb,
-							    info->msg,
-							    can_zcopy)) {
-				kfree_skb(skb);
-				ret = -ENOMEM;
-				break;
-			}
-		}
+		skb_zcopy_set(skb, uarg, NULL);
 
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
@@ -420,6 +398,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
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
2.43.0

