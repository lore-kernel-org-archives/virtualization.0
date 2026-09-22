Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D673655F3
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039916; cv=none; b=N8edE/HXOgLyuRx/B8bZlUlZwU0lsOYjE3Ys9BvRzBZhrb7iTSM+vPTf6JKAhmYl5XOucQxEGBo/805gAKQNaWJhVGaCIeAi8iewjckD0GGJmh+szvANnTiTsBOfcidi/aROQNYzLNhO1Jx7G0MNuSMphRNHgDN8rMXoQt3ZSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039916; c=relaxed/simple;
	bh=Nlv14tlU9uNpBq5PQObxLvoOri0Y3sW5xPbKOk7Qmhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h6P3KLKu2mAk+3dDr4o1xL7ylC/rOg6EYeZEwkBv6cpP6DFX0SGzjhuNGgl93modIG60sUxyjAEJyVAKYK2MQpg7UJebWLBIR5PbSMOnjhrk2cSojERk2GgU/J7dLg02qzLv2lF6Ht62C5Czmozij3qR6R+y/zZEf7yVuGHqcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMaZRBQe; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMaZRBQe"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6f1635so1226658eaf.0
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039911; x=1790644711; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjGK+4py2zVYb4dYSS+MAdawD9WQdT1El8lmBwvFvgc=;
        b=pMaZRBQeKVzNWcQKZgzncrfBSzYIzfTRBV0So+g/UG49widF5z6nDn1KydnwalCJdO
         4DGJbAT5iUdC5HWElVVQgaba69uqpBrUVbWDvVg/+Q1LiqByRQV8mIyQoRzX/0YNAYeZ
         N1aCOg6twTF9Sll3DCT+6g2BMrjIxTwuLRlKwc2WDIYWTkkiSlougl9ALslFxhZb0x3H
         JxQ/v8PWoruDDrMbjKausQ0Cqsg6mFOz3xXT1uqqI0cyl4Ybw+oO0NGv4Tlp+HKiJHTL
         bYR/q2If5oBUURi1vxBWdR7xckduyiTXbHkzzCUG1WnBtsmz3vBxk6PFC1PDL/6A5n7H
         Fm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039911; x=1790644711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjGK+4py2zVYb4dYSS+MAdawD9WQdT1El8lmBwvFvgc=;
        b=HrAv/RI77OnMqEnpo+Q7rQaj6tlHE3K3o88XIPMQp6Xf5EojTpyWvjK8AW1E9MzijJ
         j6CktCe2n1PWavHssks4/61PaXf+Dv3ewHX1ZxDDtBzUh7jOfQYr8+hMsG8BL8B3Rgc6
         s1qVZ8f89bXNdQWioiisJMlE0X/Y07Ua1JqkDrUCEMnzex50PjLwqUXRofY76XPEt1H4
         Hb5azJGuZhqnwqC0R00tX6Ul8LP85AZ5So+qvCgY7NqtNgIjm3/bOGXjQAVZzr0/nh4Q
         2YeMNMdLaLEHKKofyuLO181he9eNdBetzOuaDBfcss/8Ng0c1OPaOphwBzb7iCzkvdR+
         lC0A==
X-Gm-Message-State: AFuF++kS7zFfMXjpvEpS9HI4mikN7Zjs+tFzqqv3LtPN+K75KklGTlZi
	ZKxxfwSIbdnMm7r417aPB45e4CVr+dz+/I4wQG7yHWwE1C8x6p3SgI3D
X-Gm-Gg: AYBFou3TCG3JLbFgg/pVHrWHJ0c3iTWMJtDg6dvKNQ1oC3Qnf6+rFR4dMX+oFIZUfNH
	V0hswt4cMHB8ut75j3MGO4Uh1bVp9NBBfn/6G+nLlsM7efIOcDshRNuDlwtEdfO7rq11apSYMna
	z5Fo2p+W+o/JWA+TY5SICAw5RU/4KkmxYvWPvWhCD62bc/7BdQ2T7pPmYTWBIKEv4AP05SOAd6W
	koGbEKbrRQXg4T+YcpHB24eQMURdG1vTJ10SnokzAduASet4UwfQWDb2dULwJZoIV0Aiqwa/qpS
	ReI+b+5KUVXD9GrPgmTXEJeIh3RI0o17xakvJBoqj+0tg3g3Dedr+vqQi68FQCqBQ9d1i4RETFb
	rg/wny3We6rEa3BwmiK7RvwdqAK8Vj8KP5FhzjKxeed+QlE6BRs0OSExDg4zy/YKc8UUIyW39Mi
	PzbfPwawdeQnAjV16QF5BEFKSr/3R7kyy7CbFU93bfq7CE8zxLM7SRaYmxjiPgKd9WdTaj8bJ0Q
	F1Z+g==
X-Received: by 2002:a05:6820:4c14:b0:6b7:46e9:9700 with SMTP id 006d021491bc7-6ca9c84db7emr10939338eaf.48.1790039911395;
        Mon, 21 Sep 2026 18:18:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48fbcb5a9afsm93283fac.1.2026.09.21.18.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:07 -0700
Subject: [PATCH net-next v2 4/6] vsock/virtio: support guest device network
 namespace
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-4-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

virtio-vsock did not have namespace support (the device was always
accessible to any global namespace).

Make the virtio-vsock device assignable to a namespace and initialize it
to init_net. Because virtio-vsock and init_net are both hardcoded to
global mode, nothing changes until the assign command is issued.

When the device's local-mode namespace is being destroyed, received
packets are reset until a new valid namespace has been assigned and/or
automatically returned to, and the next RX batch begins (in
virtio_transport_rx_work). They are reset rather than dropped because
vsock does not retransmit, so a silent drop would leave the host waiting
for a timeout, and a connection request arriving in that window has no
socket whose teardown would tell it otherwise. This requires making
virtio_transport_reset_no_sock() available outside of the common code.

When a device is assigned to a namespace, every already established
vsock socket that is no longer able to reach the device is forcibly
reset. For that reason, adding new sockets to the connected table must
be performed atomically with regards to namespace assignment. This
ensures that when the socket is added to the connected table that it
actually passes the new reachability conditions set by ns assignment. If
it wins the race to the table and does NOT pass the reachability tests,
then it will be reset. This is the purpose of the new helper
'vsock_maybe_set_connected()'.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Export virtio_transport_reset(), wire it to the new .reset op (Stefano)
- netns_assign_allow is now a bool (Stefano)
- Pass NULL, not &init_net, in virtio_transport_rx_work(), and
  comment why (Stefano)
- Drop the if (net) guard around put_net() (Stefano)
- Drop the comments at the vsock_maybe_set_connected() call sites,
  the commit msg seems sufficient
---
 include/linux/virtio_vsock.h            |  3 +++
 net/vmw_vsock/virtio_transport.c        | 24 ++++++++++++++++++------
 net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++---------
 3 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..5d15b6d6bdf7 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -286,6 +286,9 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
 void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
+int virtio_transport_reset(struct vsock_sock *vsk, struct sk_buff *skb);
+int virtio_transport_reset_no_sock(const struct virtio_transport *t,
+				   struct sk_buff *skb, struct net *net);
 int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
 int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
 int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..5ad93af4bd2b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -542,7 +542,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 
 bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return vsock_net_mode_global(vsk);
+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
 }
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
@@ -587,6 +587,8 @@ static struct virtio_transport virtio_transport = {
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
 
 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
+		.netns_assign_allow       = true,
+		.reset                    = virtio_transport_reset,
 
 		.notify_poll_in           = virtio_transport_notify_poll_in,
 		.notify_poll_out          = virtio_transport_notify_poll_out,
@@ -616,7 +618,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
 
-	if (!vsock_net_mode_global(vsk))
+	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
 		return false;
 
 	seqpacket_allow = false;
@@ -633,7 +635,11 @@ static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
+	struct virtio_transport *t = &virtio_transport;
 	struct virtqueue *vq;
+	struct net *net;
+
+	net = vsock_g2h_net_get();
 
 	mutex_lock(&vsock->rx_lock);
 
@@ -682,10 +688,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
 			virtio_transport_deliver_tap_pkt(skb);
 
-			/* Force virtio-transport into global mode since it
-			 * does not yet support local-mode namespacing.
-			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			/* The virtio send path does not use @net. */
+			if (unlikely(!net)) {
+				virtio_transport_reset_no_sock(t, skb, NULL);
+				kfree_skb(skb);
+				continue;
+			}
+
+			virtio_transport_recv_pkt(t, skb, net);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
@@ -694,6 +704,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
 	mutex_unlock(&vsock->rx_lock);
+
+	put_net(net);
 }
 
 static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4ba..c24049b2a386 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1291,8 +1291,7 @@ ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_unsent_bytes);
 
-static int virtio_transport_reset(struct vsock_sock *vsk,
-				  struct sk_buff *skb)
+int virtio_transport_reset(struct vsock_sock *vsk, struct sk_buff *skb)
 {
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_RST,
@@ -1307,6 +1306,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 
 	return virtio_transport_send_pkt_info(vsk, &info);
 }
+EXPORT_SYMBOL_GPL(virtio_transport_reset);
 
 /* Normally packets are associated with a socket.  There may be no socket if an
  * attempt was made to connect to a socket that does not exist.
@@ -1315,8 +1315,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
  * loopback, this is the namespace of the socket. For vhost, this is the
  * namespace of the VM (i.e., vhost_vsock).
  */
-static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
-					  struct sk_buff *skb, struct net *net)
+int virtio_transport_reset_no_sock(const struct virtio_transport *t,
+				   struct sk_buff *skb, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct virtio_vsock_pkt_info info = {
@@ -1355,6 +1355,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 
 	return t->send_pkt(reply, net);
 }
+EXPORT_SYMBOL_GPL(virtio_transport_reset_no_sock);
 
 /* This function should be called with sk_lock held and SOCK_DONE set */
 static void virtio_transport_remove_sock(struct vsock_sock *vsk)
@@ -1478,9 +1479,13 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RESPONSE:
-		sk->sk_state = TCP_ESTABLISHED;
+		if (!vsock_maybe_set_connected(vsk)) {
+			skerr = ECONNRESET;
+			err = -ENETUNREACH;
+			goto destroy;
+		}
+
 		sk->sk_socket->state = SS_CONNECTED;
-		vsock_insert_connected(vsk);
 		sk->sk_state_change(sk);
 		break;
 	case VIRTIO_VSOCK_OP_INVALID:
@@ -1736,8 +1741,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
-	child->sk_state = TCP_ESTABLISHED;
-
 	vchild = vsock_sk(child);
 	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
@@ -1758,7 +1761,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-	vsock_insert_connected(vchild);
+	if (!vsock_maybe_set_connected(vchild)) {
+		release_sock(child);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		sock_put(child);
+		return -ENETUNREACH;
+	}
+
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, skb);
 

-- 
2.53.0-Meta

