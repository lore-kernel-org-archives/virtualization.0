Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457B4B44B8
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873118; cv=none; b=Op1Xyf2g3NE+xtnQKqqniVSvikNMfKqO28gp67M7aolvy3QLuONtu+63/1ivbpPZf0gVsY+cQbDsULKmFKZ/JdvTHl8NrQjlWRvOqREfzjh65hCBpclh3sVb5754VPdYCwdphgqi7BYq412ZCB4lo0fW6JvY6zgnWASSLMK0t8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873118; c=relaxed/simple;
	bh=0uBgMAQMHXcorqrxHFsITJ0ZDqPnG8HgNidfOb7/ZR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwyBcdLBLT6Q6mICpK7B9NcztTHKveHChIPFctnMeDa6o4BI3Xofq3Ux8rCHCBSs/1GtR3L5nu+YHqUmQjW+etwYSv1/940OW5WpfS4jAA9ty8KbYl2q6hYiiEGQ8mM7f/1+XFS94ARER8Tg4fovszagY8WF8bwk8m527Q2RczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xet3ZFeG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xet3ZFeG"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1668588a91.3
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791873117; x=1792477917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iimPMoXoI9ZvlUcJ/3lMBuWNgxTQiG3KDDBReIs2QAY=;
        b=Xet3ZFeGyD26OhHEFjBZDq+MxoAZwjxUTiM8K+eb8z4f2j9cl1ORclEdA09LbwtU5D
         dAEAK52VUdsHtJy4cyQ6xmrwVLWJE91zjkBQWu1gIdz11H2EbSDwEWNlpYILSTw5Tb5U
         cqBvgc8w6115WaZZTyfvC34nLi0O32JDJxgfZejGgXMBxIGuVdQcC1jCRV86XRC7Xph/
         InGNSC24TWm0KAkX38w7p7pYITFGdlFCcrp/+1J+TZhtrMVLYwdf7/s/XFfuZIq+JM2j
         H3Fv+0TBzYIAHTuIgy9lJl2DQCsm4y0uHqn2u2CsYcRWoHn/1WP23LX569wKjDTZ3Y5y
         pl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873117; x=1792477917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iimPMoXoI9ZvlUcJ/3lMBuWNgxTQiG3KDDBReIs2QAY=;
        b=rhxqpxXoy7pmNL3LSHyVI3VMfgAhHgep8wPY/F9++Bg5lym86RevCoakgXc3XZrreP
         gW2OmswnxOyvcSTJTsKCkHBiHO0ILxr/BOqI2UAGYRjrItUv3iIDcnP83gKkmNJfVyLq
         jMnPOwL4Lg5D7ZnnXqvhAheVPJPlFz+dik9ShAZCa+viIcm6s/BLNZ/XYImv5QnWZtUr
         Sv9KVkjAGHXMhwllOP3+/f4yW2QJqPaVNE63qadjXyC2F76ca70iXWir5k9ZmhEaQWge
         oOJy5SjVth62SQ5sKBRuDsih1XZQ3unNRNJiAtISFb79uryINC5gmI7tKOH9fwIjPAat
         b+7A==
X-Forwarded-Encrypted: i=1; AKwUvBxaAPUptumgs+NqTjZ06tI5VhqqJanmlne+mBAtHPTy3WmMqQPhb27rkQBWzmAgDU4cTYSEaFTvkyYm70hgsw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ6exUH3t06VFL26eJ14/WzYvYLR7MfbIbE+2OlDddpTfhcHwRP
	dSW7udEJAPZMcKJdcfGvmJ6BbXlbbSEyuxh24+JKRS8thvm55VjXGgp2
X-Gm-Gg: AYBFou0X4rZ/7Nerex4KUttyGfVkM8K7ryEm45fUTW3dXaFeghPgNJf5w+RJGUHCDSL
	Me8nHqblbBssaI8E6y2C72tvaLj9YzsVj+gKZ17MTeFzMI4FHCEXkgT6jDnP1X/HdfiGpvGTdBE
	B6m/1AexqAW3SqeWMlRfGH/yiQCuPQ21sJkeSYF5oak4TiaoduUnAgXLoSh1558pKRYJUh+eheS
	jvNTCr99NsiYfouBvysjHhRi6LKl9lSbQTUnlHEI3c3dAeK42T8w3j3UDHY3UcQWFqJbuzYKYvc
	sz3c53y1tLT6/2rMR0nfk4LjBLS9PlgTvLSyqNV0FX7UrPwwlr03AdReXhkuZ8WNfRwDyLXUwqO
	AAEDKhsCE5dw+9sSFx9DD2y/UqgGI/94iFo1nxbXsmcww0rZUc1ggIIvA9LLeBDJD2a2qBuFFbf
	PdNNSsNl8InF/s6Twp98/f6p9gw2xamHaTBlTHUM6DSORUbzmPyyyYF5MLVflLGWVitM69iPI=
X-Received: by 2002:a17:90b:4a8f:b0:3a7:9a7f:7ef2 with SMTP id 98e67ed59e1d1-3ab3a3a0ba8mr10672730a91.3.1791873116458;
        Mon, 12 Oct 2026 23:31:56 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0daesm19728980a91.5.2026.10.12.23.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:31:56 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/4] vsock/virtio: coalesce RX write-space notifications in lock batches
Date: Tue, 13 Oct 2026 14:31:11 +0800
Message-Id: <20261013063112.168321-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013063112.168321-1-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each received packet updates peer credit and calls sk_write_space() when
send space is available. A writer cannot use the newly advertised credit
until the socket lock is released, so repeated callbacks within one lock
batch cannot let it make progress sooner.

For the callback installed by sock_init_data(), record one pending
write-space notification and deliver it through the saved default callback
before release_sock(). Save that callback when the AF_VSOCK socket is
created because it is not visible to virtio_transport_common when built as
a module.

Keep only sockets using the saved callback eligible for batching. Sockets
whose callback has been replaced, including sockmap sockets, retain their
existing per-packet notification behavior. The psock marker checked by the
batch admission path also excludes a socket before sockmap replaces this
callback.

Set the batch socket before processing its first packet so a batch ending
on that packet cannot lose the notification.

Packets outside the eligible STREAM/RW batch path retain per-packet
notification behavior. The 64-packet and 64KB limits cap the packets whose
notifications can be coalesced.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  2 ++
 net/vmw_vsock/af_vsock.c                |  1 +
 net/vmw_vsock/virtio_transport_common.c | 42 ++++++++++++++++++-------
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 26dde6909c4ed..bf077ee0ded88 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
+	bool write_space_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6b..9d8ae62209eda 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,8 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	/* Initial callback, used to identify replacements. */
+	void (*default_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 44cee74519555..fe7f49da6c4bc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->default_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index bfe40ecf0b2f0..d6ebfde880db6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
 	return sk->sk_state == TCP_ESTABLISHED &&
 	       sk->sk_type == SOCK_STREAM &&
 	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
 	       !sock_flag(sk, SOCK_DONE) &&
 	       vsk->transport == &t->transport &&
 	       vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
@@ -1836,7 +1837,8 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 				 struct sk_buff *skb, struct sock *sk,
 				 const struct sockaddr_vm *src,
 				 const struct sockaddr_vm *dst,
-				 struct net *net, bool *batchable)
+				 struct net *net, bool *batchable,
+				 struct virtio_transport_rx_batch *batch)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 	bool space_available;
@@ -1860,8 +1862,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
 		vsk->local_addr.svm_cid = dst->svm_cid;
 
-	if (space_available)
-		sk->sk_write_space(sk);
+	if (space_available) {
+		if (batch)
+			batch->write_space_pending = true;
+		else
+			sk->sk_write_space(sk);
+	}
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
@@ -1929,7 +1935,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &src, &dst,
-						    net, NULL);
+						    net, NULL, NULL);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
@@ -1954,15 +1960,20 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
  */
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
+	bool write_space_pending = batch->write_space_pending;
 	struct sock *sk = batch->sk;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
+	batch->write_space_pending = false;
 
 	if (!sk)
 		return;
 
+	if (write_space_pending)
+		vsock_sk(sk)->default_write_space(sk);
+
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2018,7 +2029,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
 								    &src, &dst,
 								    net,
-								    &batchable);
+								    &batchable,
+								    batch);
 			if (!batchable)
 				virtio_transport_rx_batch_finish(batch);
 			if (free_pkt)
@@ -2044,24 +2056,32 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 	lock_sock(sk);
 	/*
-	 * Sockmap removal restores the native protocol under sk_callback_lock.
-	 * Serialize this initial eligibility check with that update.
+	 * Sockmap teardown restores callbacks under sk_callback_lock. Keep the
+	 * initial eligibility check consistent with that update.
 	 */
 	read_lock_bh(&sk->sk_callback_lock);
 	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
 	read_unlock_bh(&sk->sk_callback_lock);
 
+	if (start_batch)
+		batch->sk = sk;
+
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &src, &dst,
 						    net,
-						    start_batch ? &batchable : NULL);
+						    start_batch ? &batchable : NULL,
+						    start_batch ? batch : NULL);
 	if (start_batch && batchable) {
 		/* Keep the lookup reference until the batch is released. */
-		batch->sk = sk;
 		return;
 	}
 
-	release_sock(sk);
-	sock_put(sk);
+	if (start_batch) {
+		virtio_transport_rx_batch_finish(batch);
+	} else {
+		release_sock(sk);
+		sock_put(sk);
+	}
+
 	if (free_pkt)
 		kfree_skb(skb);
 }
-- 
2.53.0

