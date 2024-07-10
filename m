Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB2160884
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646769; cv=none; b=kEBK89pfqpHRrtpf5Zx2QvPoB7s/Kqq1UMyHW6W+pKnWgJGTBNAjjEMXAaKmjZqmG6qZl9tpMp1pFynu/wHTw2SSpURap9MriaT4ocQbKogFr6QOQQAHuhauX10eAli34AcNPUEvMJAZv5IFAkDJy04hOdwEZsuo/4W4Lh5Hn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646769; c=relaxed/simple;
	bh=zERDNd9JCYNnr+ycpOsWDKndLRgVVm/OgVyL7VGJ4wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNr3AtWp3PRLA41IbL4E9gzfb0Mpp3mDiUWzvtmEkjZAHiphAGy0aKnQyTD8HAKJwZiZnueWu76S81oZHC/NbMSqxqZ6U1ItG0XdVcGZRwwBcj7OZ8qZ6mjY+ZAKjQtsDFYzlQlQFImvsYVCt/iAoZHN4cbh2C+Qrs5+s29eEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6b4cs/H; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6b4cs/H"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1184640BB7
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQXJRTE0adqQ for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EE93D40B8F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE93D40B8F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E6b4cs/H
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE93D40B8F
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:05 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-64f4fb6ce65so1995487b3.2
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646765; x=1721251565; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN+GRSmx+rskTAQOVFYDHoKP/o7w51RMiYsLeysrnrY=;
        b=E6b4cs/Hskh6CNmw8QwyGaV1GLrJhkh79TbJI3hMGscCQaH346p+xoObYfBPv0FhtW
         3fgzGt5olr3QkdOneknk0bgmYtWcLa3tR3Chq/a0+BUqU/z38p2coUXNbLXDQR3aRPzZ
         V+oOONoHOVKfNFkjn4MrPc6KoZdzpcxeWG4n9BJj1C1aT9L53Q/D7ltTnlh2zSHxL5nv
         XHBQX1sB0ne983iPeGnwL229p8rQ6aZDs7WXnr9FCMeC0zO7CriTvdmZ6+c0fUwiFlRv
         kxd7UexLJMdwWEf8GLJWTUmSfNpYv53CIYXCqRF3MfwxN3wJfMddoPE+7NCU4fwIWyza
         jriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646765; x=1721251565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN+GRSmx+rskTAQOVFYDHoKP/o7w51RMiYsLeysrnrY=;
        b=WZa0+piBNorD+2cwNrrjA4QhVMyoPPi9TfUZ7I5N7lOjtfBJS6lJoCvkOktkgpXlV2
         1lWQAvqgwHP6XM9AeJMgtikGFzyAIm401lrHJS/f7ZgCXFB/gbilhUNWYFW6I5OvF6t3
         uqXVX4v8Y0fxWCZh29hjj2A6GaFGAScNhauAI8tE0iorCTMhqd3Rt4SWyUEXFAyARts2
         TNTVL28kahdWtr8PNZzmy04c1npYO1dqxh41NyvURLWYBYL6Mz9e3WjPwMfe58H42A/Y
         AnU2SWsKJt/IHltV2bPru6olSzm9pFtFLvDpr2myFJkfZivX+EuLsaOXXMymkAPddiGF
         Jikg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/aaQsQEtHqNaWcP42eMlvG/9xIu7ZOjx7hijvVC2ynwUdcT11aTvRlIQeUIAyAPT0HkvbGgZO4sZWw30timyIPA1HpCErHjYLmoUJfZLCd3xbAP10JIHSA==
X-Gm-Message-State: AOJu0Yz3m3IQtvUM85eF++Jdw65mSFukVoDLEUt0OdhYPxCsxty5Yd+B
	Y7Hqr7jTyG4YJn9JM9rDu2KNg7JUpUOinv1AsjXBveGVYuJqBQHz
X-Google-Smtp-Source: AGHT+IFdDJbzk9Eahvtm1VoZEbVdPnTfeK7msIL9TKHGtqINukZ8lIPGu27MsG6zHof1X+d3FW8ZCw==
X-Received: by 2002:a05:690c:4d82:b0:650:f7a4:c70d with SMTP id 00721157ae682-658f02f55edmr94195357b3.41.1720646764730;
        Wed, 10 Jul 2024 14:26:04 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:04 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com
Cc: dan.carpenter@linaro.org,
	simon.horman@corigine.com,
	oxffffaa@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	bobby.eshleman@bytedance.com,
	jiang.wang@bytedance.com,
	amery.hung@bytedance.com,
	ameryhung@gmail.com,
	xiyou.wangcong@gmail.com
Subject: [RFC PATCH net-next v6 11/14] vhost/vsock: implement datagram support
Date: Wed, 10 Jul 2024 21:25:52 +0000
Message-Id: <20240710212555.1617795-12-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

This commit implements datagram support for vhost/vsock by teaching
vhost to use the common virtio transport datagram functions.

If the virtio RX buffer is too small, then the transmission is
abandoned, the packet dropped, and EHOSTUNREACH is added to the socket's
error queue.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 drivers/vhost/vsock.c    | 60 ++++++++++++++++++++++++++++++++++++++--
 net/vmw_vsock/af_vsock.c |  2 +-
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index fa1aefb78016..13c3cbff21da 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -8,6 +8,7 @@
  */
 #include <linux/miscdevice.h>
 #include <linux/atomic.h>
+#include <linux/errqueue.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/vmalloc.h>
@@ -32,7 +33,8 @@
 enum {
 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
 			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET) |
+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
 };
 
 enum {
@@ -56,6 +58,7 @@ struct vhost_vsock {
 	atomic_t queued_replies;
 
 	u32 guest_cid;
+	bool dgram_allow;
 	bool seqpacket_allow;
 };
 
@@ -86,6 +89,32 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 	return NULL;
 }
 
+/* Claims ownership of the skb, do not free the skb after calling! */
+static void
+vhost_transport_error(struct sk_buff *skb, int err)
+{
+	struct sock_exterr_skb *serr;
+	struct sock *sk = skb->sk;
+	struct sk_buff *clone;
+
+	serr = SKB_EXT_ERR(skb);
+	memset(serr, 0, sizeof(*serr));
+	serr->ee.ee_errno = err;
+	serr->ee.ee_origin = SO_EE_ORIGIN_NONE;
+
+	clone = skb_clone(skb, GFP_KERNEL);
+	if (!clone)
+		goto out;
+
+	if (sock_queue_err_skb(sk, clone))
+		kfree_skb(clone);
+
+	sk->sk_err = err;
+	sk_error_report(sk);
+out:
+	kfree_skb(skb);
+}
+
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
@@ -162,9 +191,15 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		hdr = virtio_vsock_hdr(skb);
 
 		/* If the packet is greater than the space available in the
-		 * buffer, we split it using multiple buffers.
+		 * buffer, we split it using multiple buffers for connectible
+		 * sockets and drop the packet for datagram sockets.
 		 */
 		if (payload_len > iov_len - sizeof(*hdr)) {
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
+				vhost_transport_error(skb, EHOSTUNREACH);
+				continue;
+			}
+
 			payload_len = iov_len - sizeof(*hdr);
 
 			/* As we are copying pieces of large packet's buffer to
@@ -403,6 +438,22 @@ static bool vhost_transport_msgzerocopy_allow(void)
 	return true;
 }
 
+static bool vhost_transport_dgram_allow(u32 cid, u32 port)
+{
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static bool vhost_transport_seqpacket_allow(u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
@@ -419,7 +470,7 @@ static struct virtio_transport vhost_transport = {
 		.cancel_pkt               = vhost_transport_cancel_pkt,
 
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -811,6 +862,9 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (features & (1ULL << VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
 		mutex_lock(&vq->mutex);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f0e5db0eb43a..344db0f3a602 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1463,7 +1463,7 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 		return prot->recvmsg(sk, msg, len, flags, NULL);
 #endif
 
-	if (flags & MSG_OOB || flags & MSG_ERRQUEUE)
+	if (unlikely(flags & MSG_OOB))
 		return -EOPNOTSUPP;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
-- 
2.20.1

