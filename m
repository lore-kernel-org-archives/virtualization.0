Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C55267B83
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829841; cv=none; b=laAxGI+nG2tns8T5bzlEniW2PoQkMDHV5xlDKV3SdMyK962gyGNyRttsFrYUa4H8yTabadVKQTruQDWkRNfjBxZewkn6fbsM9tE3UWxDJDfCxoeXRdgnfg3tnUMs8m5bykSZuk03cI7acshj8AxP1MBFCq7UDIIX3trySeBs34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829841; c=relaxed/simple;
	bh=CfktD8zgoXzFHpGPN33h183DcOy5eNSJ26il1oP9PIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YWoP2ip8NEGhXIViAYJg9Bgtqtb4UPxuTtB0OUmMy7NwL2wvfwXscrkVGkGmsumw4rBpUbuWJO9Z08J/cSgqdHZu2Of3KwI/pl5ml2ALXAYa0NEtLKHJ7X6ks38lvAlnWHtvPz8cGxN8bFmryvtRBm+PJFyRWcRKpzsxtTtC8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sb/zGD9i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sb/zGD9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747829838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=koXbHLCrgYB2PDtOqNQzcLGwc+0kyTs5q0PGoBFShLg=;
	b=Sb/zGD9ibWhk9xoBVHe9q8HWY1CUi8x6KwdztL+Cg6pRDX0j1XHfIIJWXQvEK/en81W9Ky
	N99GmGhQnMW8RdLE8nEorMib5O/lo+/UL6I1yxxCnt2k6C1O3X47DiFsEi7TZkusz+Z49+
	jfvJVHuLnvW+hoClzdn+K5MVhqTbHWo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-OXvRZ1OCPmu-vYfwZcbEsw-1; Wed, 21 May 2025 08:17:17 -0400
X-MC-Unique: OXvRZ1OCPmu-vYfwZcbEsw-1
X-Mimecast-MFC-AGG-ID: OXvRZ1OCPmu-vYfwZcbEsw_1747829836
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60214f89ce0so1391654a12.3
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 05:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747829836; x=1748434636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koXbHLCrgYB2PDtOqNQzcLGwc+0kyTs5q0PGoBFShLg=;
        b=AViQ5uEyZZp/DeL6IPxPTsDUmj1GQy1taUkDVMn7i+iYd5BJqIRVJbXXQ3wVsFS4K2
         Jk1JHSYs3haB4z3acPWavy3TrIg5OgmeGAKrEQ4QxBKomLs7pEQLoSJRzPm3aNycMRiJ
         fcAlpNubFCLKeMUINMI8gTRb3aZa1tkaZQmTzv8lUVjZKBZya9As+1MCGUhOt2SrkNut
         c0PqdMYHfi3SHSI1UpuvfREL8z30khhDCRwHGuIcksx/6K8S4Bsei50AJTGHZEZmDMCv
         GAbvxFMeJAjrb+qVw2KevjI+pf3E1xW1z+9i4+jEkTBWA+nMRs5XnquGHHGW1qn7jlGT
         D7gw==
X-Gm-Message-State: AOJu0Yxp6zJVaserPJLEGd2cJsHrmsg0ZqnsloJFQ/KFdn+2TXpySP8x
	+xR/8mGQoRJ0OEVdZ1Din88XCvfeYAoh7sPRw7hcjFqeF++TCK47+V5XXTh1Yd4Zt9edyFf+RSB
	1NNtRGD6LrWsULZl4swblFBVUW3gbj6ppafIL8zys7sifIoSu0hn90s1I/Rj67cNJYkAW
X-Gm-Gg: ASbGncvn18BBbUJ9/xR1uqpKbv6iKWYNHIBdUt9aruU2IK3JFWQ2tZ08J2fh0LiVPpb
	H2M8KBkrYGhwqOn4Oa9R/lOd3kfbK8gYBL0obREgmHQ6bVBc6n6QMmUIVVO/M6OgEAu+i1nbeUM
	S7xfKkEei/i7gYPFd9PYT4N+ubbwtLk2jgbWKLdqy9j1CKmU4fUhay+EeQRz2tB5PHKW3Wn4tsB
	GMYaLE6XYzra2xU1g64bmmzejSDctpnepEQq+o0McKJqBaIgmKcdX8m9NaNWLxcMtkDwK1X5BMX
	N9s20dxirnhym08qe20rb0SoPmxBtdev3iGm8BQPPktEqE6ZnT5RDYh3i2/TnklW9zeg
X-Received: by 2002:a05:6402:50c9:b0:601:a681:4d5c with SMTP id 4fb4d7f45d1cf-601a6814f05mr12934883a12.32.1747829836030;
        Wed, 21 May 2025 05:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4cgb/1piVsTbjdMMKwjk3dNR8qjrtqCCwZsJc1XfaRl4HuQDjqQbxQefkqEDzpnU155bKIg==
X-Received: by 2002:a05:6402:50c9:b0:601:a681:4d5c with SMTP id 4fb4d7f45d1cf-601a6814f05mr12934847a12.32.1747829835404;
        Wed, 21 May 2025 05:17:15 -0700 (PDT)
Received: from localhost.localdomain (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3918esm8725254a12.68.2025.05.21.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:17:14 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuewei Niu <niuxuewei97@gmail.com>,
	Krasnov Arseniy <Oxffffaa@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
Date: Wed, 21 May 2025 14:17:05 +0200
Message-ID: <20250521121705.196379-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -_bSJ3pcvzSnjUBZGl79STuZ0RggpDnrtCdOhcSpWbk_1747829836
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

In `struct virtio_vsock_sock`, we maintain two counters:
- `rx_bytes`: used internally to track how many bytes have been read.
  This supports mechanisms like .stream_has_data() and sock_rcvlowat().
- `fwd_cnt`: used for the credit mechanism to inform available receive
  buffer space to the remote peer.

These counters are updated via virtio_transport_inc_rx_pkt() and
virtio_transport_dec_rx_pkt().

Since the beginning with commit 06a8fc78367d ("VSOCK: Introduce
virtio_vsock_common.ko"), we call virtio_transport_dec_rx_pkt() in
virtio_transport_stream_do_dequeue() only when we consume the entire
packet, so partial reads, do not update `rx_bytes` and `fwd_cnt`.

This is fine for `fwd_cnt`, because we still have space used for the
entire packet, and we don't want to update the credit for the other
peer until we free the space of the entire packet. However, this
causes `rx_bytes` to be stale on partial reads.

Previously, this didn’t cause issues because `rx_bytes` was used only by
.stream_has_data(), and any unread portion of a packet implied data was
still available. However, since commit 93b808876682
("virtio/vsock: fix logic which reduces credit update messages"), we now
rely on `rx_bytes` to determine if a credit update should be sent when
the data in the RX queue drops below SO_RCVLOWAT value.

This patch fixes the accounting by updating `rx_bytes` with the number
of bytes actually read, even on partial reads, while leaving `fwd_cnt`
untouched until the packet is fully consumed. Also introduce a new
`buf_used` counter to check that the remote peer is honoring the given
credit; this was previously done via `rx_bytes`.

Fixes: 93b808876682 ("virtio/vsock: fix logic which reduces credit update messages")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 26 +++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0387d64e2c66..36fb3edfa403 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -140,6 +140,7 @@ struct virtio_vsock_sock {
 	u32 last_fwd_cnt;
 	u32 rx_bytes;
 	u32 buf_alloc;
+	u32 buf_used;
 	struct sk_buff_head rx_queue;
 	u32 msg_count;
 };
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d88096..2c9b1011cdcc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -441,18 +441,20 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->rx_bytes + len > vvs->buf_alloc)
+	if (vvs->buf_used + len > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;
+	vvs->buf_used += len;
 	return true;
 }
 
 static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
-					u32 len)
+					u32 bytes_read, u32 bytes_dequeued)
 {
-	vvs->rx_bytes -= len;
-	vvs->fwd_cnt += len;
+	vvs->rx_bytes -= bytes_read;
+	vvs->buf_used -= bytes_dequeued;
+	vvs->fwd_cnt += bytes_dequeued;
 }
 
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
@@ -581,11 +583,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 				   size_t len)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	size_t bytes, total = 0;
 	struct sk_buff *skb;
 	u32 fwd_cnt_delta;
 	bool low_rx_bytes;
 	int err = -EFAULT;
+	size_t total = 0;
 	u32 free_space;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -597,6 +599,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
+		size_t bytes, dequeued = 0;
+
 		skb = skb_peek(&vvs->rx_queue);
 
 		bytes = min_t(size_t, len - total,
@@ -620,12 +624,12 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 		VIRTIO_VSOCK_SKB_CB(skb)->offset += bytes;
 
 		if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->offset) {
-			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
-
-			virtio_transport_dec_rx_pkt(vvs, pkt_len);
+			dequeued = le32_to_cpu(virtio_vsock_hdr(skb)->len);
 			__skb_unlink(skb, &vvs->rx_queue);
 			consume_skb(skb);
 		}
+
+		virtio_transport_dec_rx_pkt(vvs, bytes, dequeued);
 	}
 
 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
@@ -781,7 +785,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 				msg->msg_flags |= MSG_EOR;
 		}
 
-		virtio_transport_dec_rx_pkt(vvs, pkt_len);
+		virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
 		kfree_skb(skb);
 	}
 
@@ -1735,6 +1739,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
+	u32 pkt_len;
 	int off = 0;
 	int err;
 
@@ -1752,7 +1757,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count--;
 
-	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
+	pkt_len = le32_to_cpu(hdr->len);
+	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
 	spin_unlock_bh(&vvs->rx_lock);
 
 	virtio_transport_send_credit_update(vsk);
-- 
2.49.0

