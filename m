Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B7456DFA
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390089; cv=none; b=twbQfqIkcxBFjLsCe3LanwTTTN1cDy6s4LEgYYbLRwBVdfc1FVh3dD10xS0hdGpsP+XhTeK0cfN/UIfZxHFisvI0GHoGYDhGVvdPgmwvtHAnEGyj1KWD/1Y8kMySWe/7xUTajYMDuLxlZwOQc8qF1pfAfj2MaagXRnEvAyoM9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390089; c=relaxed/simple;
	bh=5V1mBK4+6n/Zucyqo2XDfm7ZN3GwgggVQjapNBOVBBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ji3OIHuTOkrSKV1vd81wIofLsxZVwP7aLDLTSrJqfNcXMsCDki4SKeiPbVZ8CLgBNqdr6MG8XYhhBKyWDW++WyEk18VEdgMis0BD4CeCk/IKJqIOdsXFW+iZSwYbVxhcCEu+WhEtDJVCLbf6xnSx65t7TRulIMFiRcOBmQOftXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXfyrrnl; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXfyrrnl"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-467cefc56d2so1249041fac.0
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390078; x=1788994878; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64gotFInHj04XMQZ+QbhT+/KY6QtyB9D0mjA1FukM2E=;
        b=HXfyrrnlx+8f66JI+p6A0TLIzfrv1zUxAwvG6twoWW0xrE/f+KjrrM95grAbg31len
         /JR2qQe6yk2nq3DBN+gphnl3HZarEVce3er84YReZNU5RfIUUwuWokjLyywZZE/iB6x+
         ITdFh6kpbaP5ZrXJ7hvssirD2VLXKkVVEcmpuOU1wFO8x1Mm/lx92vaxcpgXw0powRyB
         aFarbgvnVWkqSwHHKGeUDOuV4oKRNalFVl73uI2C5P+g2l+YkjLj0t7L9HKiXSoOREB8
         k6Ffri+TMmc+EscIMjQYJCIkxeLuGMqb+GkxO2C8ou51c94rvh1IgRjk4Q6mlp7QJGb4
         NElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390078; x=1788994878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64gotFInHj04XMQZ+QbhT+/KY6QtyB9D0mjA1FukM2E=;
        b=jxI5YaD7eKdRz0MFTfU6jaI7c/UNCJCBmjmDlGTczBp4LgLZJFHlgoNpv23spI7chP
         YTVuRiXdJi3TrOxVODnXF8I/N3fytLtQWZz/M+1ooAbOJQLMrvIqsTVW5eDKE0xjSN+y
         sZssbEEKPrA8V1tH1t+KS920rExh1oCu+p4NqV2RVJVOKf+XFeNU0pWJJA6k/xI9fdrV
         meNxmcSJmQH1F2TfmqKa+5ZK3T2yE0YXaDDWbUl/JiTB3e5ZIeCWNOhvi9+F1o3AgAxh
         r6rW2n9CyqHei8jk2usN/2OGc3Zoef/MhbEQcjBfLrXRVV5Ni+iNil++A5bbjlKwMTEJ
         f/qQ==
X-Gm-Message-State: AFuF++k5/up1phFOOdGg/CweLobhi+EKkFTULFDYjlldwGda0O4zj6q9
	wdankiKqdLWUy66F91wKrQ29iBXnx3TKBG1VFe8OHuIBbzkN5Kes+mky
X-Gm-Gg: AYBFou0+bSrUTJUR4KxsEzcFKRYT0XnaIlHzcVJhRqUh/kWVcjMeIYDJzLTfdoDrITV
	PxdLokNT5NZDBZyRUB2hG4TY6yTS1Zu9q4lpaW8KdWdmq4Pnuh/YeMNfwxar0jsY9ilBVz5kD+Z
	96iI55X2T6hYx/FI9ZrOYnTxXFGCRMoEj2hK2lZmdSyixiYdIm7SngN8syAdsB5rdVt/GXhPOWj
	wCRfs1Y8kEViC92ohSvFQDZ4LKGHJYLP/s/pVnZyJrVBV6SuiUd9E1CbvdyPs/PyKMwYvW/LXc3
	VN2LvJ0ziyRXkGdMBtLlfXrpPEXSt9YCzWOcdwnbPjmVa1NSA8dtaluIA2Sy2y0iOSUiWgocxGc
	U3MhddPnOIzEKPXrPnfZd6HMR6ervczxdWlZHKiB9CpkDb3FsSWpofjN48wGk6nAj3Ewxl1A3HJ
	Okxe3EBEH3hGm4Nc6axrRn4X5zXEigWMIRB21uGvdQTtIXQdjugfipDLsUPIfP3HN6tloQbg==
X-Received: by 2002:a05:6870:1b8b:b0:448:a3d6:c2d2 with SMTP id 586e51a60fabf-46f8a4343eemr7642312fac.10.1788390077649;
        Wed, 02 Sep 2026 16:01:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f30baa0d4sm5546944fac.6.2026.09.02.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:49 -0700
Subject: [PATCH net-next 3/6] vsock/virtio: support guest device network
 namespace
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-3-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

virtio-vsock did not have namespace support (the device was always
accessible to any global namespace).

Make the virtio-vsock device assignable to a namespace and initialize it
to init_net. Because virtio-vsock and init_net are both hardcoded to
global mode, nothing changes until the assign ioctl is issued.

When the device's local-mode namespace is being destroyed, received
packets are reset until new valid a namespace has been assigned and/or
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
then the reset sweep will correctly catch it. This is the purpose
of the new helper 'vsock_maybe_set_connected()'.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  2 ++
 net/vmw_vsock/virtio_transport.c        | 28 ++++++++++++++++++++++------
 net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++-------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..9c68ce1d7fb4 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -286,6 +286,8 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
 void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
+int virtio_transport_reset_no_sock(const struct virtio_transport *t,
+				   struct sk_buff *skb, struct net *net);
 int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
 int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
 int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..a453a4f828dc 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -540,9 +540,14 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
+static bool virtio_transport_netns_assign_allow(void)
+{
+	return true;
+}
+
 bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return vsock_net_mode_global(vsk);
+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
 }
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
@@ -587,6 +592,7 @@ static struct virtio_transport virtio_transport = {
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
 
 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
+		.netns_assign_allow       = virtio_transport_netns_assign_allow,
 
 		.notify_poll_in           = virtio_transport_notify_poll_in,
 		.notify_poll_out          = virtio_transport_notify_poll_out,
@@ -616,7 +622,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
 
-	if (!vsock_net_mode_global(vsk))
+	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
 		return false;
 
 	seqpacket_allow = false;
@@ -634,6 +640,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
+	struct net *net;
+
+	net = vsock_g2h_net_get();
 
 	mutex_lock(&vsock->rx_lock);
 
@@ -682,10 +691,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
 			virtio_transport_deliver_tap_pkt(skb);
 
-			/* Force virtio-transport into global mode since it
-			 * does not yet support local-mode namespacing.
-			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			if (unlikely(!net)) {
+				virtio_transport_reset_no_sock(
+					&virtio_transport, skb, &init_net);
+				kfree_skb(skb);
+				continue;
+			}
+
+			virtio_transport_recv_pkt(&virtio_transport, skb, net);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
@@ -694,6 +707,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
 	mutex_unlock(&vsock->rx_lock);
+
+	if (net)
+		put_net(net);
 }
 
 static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 88df82364f77..313ef263fd2d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
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
@@ -1478,9 +1479,14 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RESPONSE:
-		sk->sk_state = TCP_ESTABLISHED;
+		/* An assign cannot see a socket that is not connected yet. */
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
@@ -1736,8 +1742,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
-	child->sk_state = TCP_ESTABLISHED;
-
 	vchild = vsock_sk(child);
 	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
@@ -1758,7 +1762,17 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-	vsock_insert_connected(vchild);
+	/* An assign cannot see a socket that is not connected yet, and the
+	 * check in vsock_assign_transport() above has since dropped
+	 * vsock_register_mutex.
+	 */
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

