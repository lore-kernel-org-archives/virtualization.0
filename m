Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757262;
	b=MIsspvncLLGFs/1CEiz/8O7Z07sbYqkm8yykz/RNWG4Dl7UM+nYFmbG4sPrGOPgO9lo7
	 z1IAi44ZG0c0X8/FYaBTeuO4/N57zjFqnz1higilSVe85t8O6aZwAmQcWxZA5RBetw49Z
	 3i15GPnbioXDGle7fhzKMo344clUohc7E1cRv73qVLHuui8MkN4zzgH4ICbW4W7xlqAZb
	 +KOgKX6uR3K0IUxHWZ/GddDWhDW2vatEVoATpAFzydgTjcnytZwK2VYQlsWGD9tNUN9Jb
	 6Qk8v0y5tSzZlJ32ZIODIM2gqVMQ4h/185e3ZyIhyx55S3Ct8GQxjUhA6ETaoh4z1dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757262;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=UMrTlTbQEQWJPHtpalLZFSJKxO6m/cCb7KtsWW1IBBw=;
	b=nn9AOGOXfbCPxPjWPD/xwWk1EHtgPDSTgTescM9TulCrgHLmEnlvvDrLNeoc6BIJMeFt
	 uWdw1dYpOTzbG5dIRxAFMp7HARAByxCei3OG+ZfnJXW7U1r99Eph64Xc5EPNAVviQFWPW
	 grC248aBXEn4JCHOd0B+BP+gCiH8O3+11OOy1o5qivOPMEM7FUlbM0ZtEV3LqgFaN3Ayw
	 xI0+aBBK4IhT4SuJfLXjpmV3zjRfZCn1iXDJK6k1atmQc4Ndwj6FkLWemuJHf/jsnn2f8
	 3//LL8S6SWOb3lnfvYYoR76OVsfsjLRfXayQ41NLP3X75BPAkMKt2nGDlup15jwMJeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aNQ51ppK;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C6606A328
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 01:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3C6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aNQ51ppK
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40SSQs2932710;
	Tue, 3 Nov 2026 17:54:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=UMrTlTbQEQWJPHtpalLZFSJKxO6m/cCb7KtsW
	W1IBBw=; b=aNQ51ppK8N/80prsAuoC7z27dq0MScQ4sYBhtzW5Mt8lzx0RqJ2fm
	WYv8qKIjJ3klezXGtfuQXMpokAM39sVS3uWC7R4FVADapNLG6XRo9h10Wq1Fm1xX
	JrpIf1jvVGbGcp6Kq7kSivOiRvE3Bx26T+0E3f2i/NapuKUUITgikUBLX8fIyKa3
	xoVTb1yE5mcNWj4JhqTeBRR5xfzELtfggUtNaUZZm9JWJb9WhgA+hM0AiBfkn9Xn
	oPIIPOqjoe7/vNVOLW+3CvK8Y7rnBzceQuOSrykRtOmM+WjFSW/mrypi+EwDhct+
	NtX02sgKVmL2VvLpKZgk4zAGhUqu41c3g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqhrjd2r6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 17:54:07 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 4 Nov
 2026 01:54:05 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 3 Nov 2026 17:53:20 -0800
Subject: [PATCH net-next v5 5/7] vsock/virtio: support guest device network
 namespace
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-vsock-guest-ns-v5-5-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>,
        Eric Dumazet
	<edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX3EsV0qm5pHxk
 8q895hSeOIEhWkd9OLTicPWxzHdaCY73k9910F0+D3fP0S/o1D/13N+PVglVJ74EL9Teee4oLN1
 wZ0BNL85+icgm9PRrMc3brz8Wz61y3I=
X-Proofpoint-ORIG-GUID: g3ip2H_-XqDzqszIV2caht_x3ECz9kfn
X-Proofpoint-GUID: g3ip2H_-XqDzqszIV2caht_x3ECz9kfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfXwYsFBmjE4P+T
 3ci7HOFfwHGed70vl+gurEjCAiQmSxZ1GcA4Zz/zY4Dyl7WrflI38gMUxW2MAJdQuEtdBsH4NCT
 6BN9dtKFZfKyIKIMJ0CjBNYhdB/Yy339mLSjwp8PJ5ALZrvhKpcm0IYVhxjCL0QmQ5BT2dgHaXc
 NFyxgqu1Hm6x70JKI2dIYqUbMoF9ImZNzEpj2uGoU5WPUDbkiplnwI3yyBjDNhz4NFmm3wZUPBc
 msZTL/Fz7xZlzt63TWfwSjzhJrmvgbOeUscpr5tDrb4YebxaTLZLzFP51H3OX+YaxHBryOQeq9x
 EX+jzeZ4qOBIVnD/On6F+ji7rJd+fLQyPRtvjdAXJHdXlWjCn73uLpqIaC0AdKdjJaAHAAR02I5
 EYwIbN/dfByJmrthN28CpoTICCrlcT07l+7TbpBGOZEIPG119pIQ46DM4/QEsrLaRr/kSv1goNJ
 PBM4kV6g9S5dT6EKxPg==
X-Authority-Analysis: v=2.4 cv=IICXmQvG c=1 sm=1 tr=0 ts=6aea903f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8
 a=0Wy0JZZX8GSs-a8CyA8A:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01

virtio-vsock did not have namespace support (the device was always
accessible to any global namespace).

Make the virtio-vsock device assignable to a namespace and initialize it
to init_net. Because virtio-vsock and init_net are both hardcoded to
global mode, nothing changes until the assign command is issued.

An assign can land while virtio_transport_rx_work() is draining a
batch, so the assigned namespace is re-read per packet rather than once
per batch. Matching the rest of the batch against the namespace the
device has left would reset connections that belong to the new one.

When a device is assigned to a namespace, every already established
vsock socket that is no longer able to reach the device is forcibly
closed. For that reason, adding new sockets to the connected table must
be performed atomically with regards to namespace assignment. This
ensures that when the socket is added to the connected table that it
actually passes the new reachability conditions set by ns assignment. If
it wins the race to the table and does NOT pass the reachability tests,
then it will be reset. This is the purpose of the new helper
'vsock_maybe_set_connected()'.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v5:
- Send the RSTs in virtio_transport_recv_listen() and
  virtio_transport_recv_connecting() to the netns the packet arrived on,
  not the socket's: after an assign the socket's netns may no longer
  reach the device, so the RST would be dropped by the reachability
  check this patch adds to virtio_transport_send_pkt() (Stefano, Sashiko)

Changes in v4:
- Drop packets in virtio_transport_send_pkt() from a netns that cannot
  reach the device, e.g. shutdown() or credit updates on a swept socket
  (Sashiko)

Changes in v3:
- Re-read the assigned netns per packet in virtio_transport_rx_work()
  rather than once per batch, so a mid-batch assign cannot reset the new
  namespace's connections (Sashiko)
- Drop the NULL netns reset in virtio_transport_rx_work(), the assigned
  netns is now pinned
- Drop the .reset op and the virtio_transport_reset{,_no_sock}() exports,
  the sweep no longer sends a RST (Sashiko)

Changes in v2:
- Export virtio_transport_reset(), wire it to the new .reset op (Stefano)
- netns_assign_allow is now a bool (Stefano)
- Pass NULL, not &init_net, in virtio_transport_rx_work(), and
  comment why (Stefano)
- Drop the if (net) guard around put_net() (Stefano)
- Drop the comments at the vsock_maybe_set_connected() call sites,
  the commit msg seems sufficient
---
 net/vmw_vsock/virtio_transport.c        | 32 +++++++++++++++++++++-----
 net/vmw_vsock/virtio_transport_common.c | 40 ++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index eced6929405d..06df82b130cf 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -256,6 +256,15 @@ virtio_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		goto out_rcu;
 	}
 
+	/* A socket reset by an assign can still send credit updates from
+	 * recvmsg() and setsockopt(SO_RCVLOWAT).
+	 */
+	if (!vsock_g2h_net_reachable(net)) {
+		kfree_skb(skb);
+		len = -ENETUNREACH;
+		goto out_rcu;
+	}
+
 	/* If send_pkt_queue is empty, we can safely bypass this queue
 	 * because packet order is maintained and (try) to put the packet
 	 * on the virtqueue using virtio_transport_send_skb_fast_path.
@@ -542,7 +551,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 
 bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return vsock_net_mode_global(vsk);
+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
 }
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
@@ -587,6 +596,7 @@ static struct virtio_transport virtio_transport = {
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
 
 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
+		.netns_assign_allow       = true,
 
 		.notify_poll_in           = virtio_transport_notify_poll_in,
 		.notify_poll_out          = virtio_transport_notify_poll_out,
@@ -616,7 +626,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
 
-	if (!vsock_net_mode_global(vsk))
+	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
 		return false;
 
 	seqpacket_allow = false;
@@ -633,7 +643,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
+	struct virtio_transport *t = &virtio_transport;
+	netns_tracker ns_tracker;
 	struct virtqueue *vq;
+	struct net *net;
+
+	net = vsock_g2h_net_get(&ns_tracker);
 
 	mutex_lock(&vsock->rx_lock);
 
@@ -682,10 +697,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
 			virtio_transport_deliver_tap_pkt(skb);
 
-			/* Force virtio-transport into global mode since it
-			 * does not yet support local-mode namespacing.
+			/* Only grab a reference if the net changes underneath
+			 * us.
 			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			if (unlikely(!vsock_g2h_net_eq(net))) {
+				put_net_track(net, &ns_tracker);
+				net = vsock_g2h_net_get(&ns_tracker);
+			}
+
+			virtio_transport_recv_pkt(t, skb, net);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
@@ -694,6 +714,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
 	mutex_unlock(&vsock->rx_lock);
+
+	put_net_track(net, &ns_tracker);
 }
 
 static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..7efcbdc7e04f 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1468,8 +1468,8 @@ void virtio_transport_release(struct vsock_sock *vsk)
 EXPORT_SYMBOL_GPL(virtio_transport_release);
 
 static int
-virtio_transport_recv_connecting(struct sock *sk,
-				 struct sk_buff *skb)
+virtio_transport_recv_connecting(struct sock *sk, struct sk_buff *skb,
+				 struct virtio_transport *t, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1478,9 +1478,14 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RESPONSE:
-		sk->sk_state = TCP_ESTABLISHED;
+		if (!vsock_maybe_set_connected(vsk)) {
+			virtio_transport_reset_no_sock(t, skb, net);
+			skerr = ECONNRESET;
+			err = -ENETUNREACH;
+			goto close;
+		}
+
 		sk->sk_socket->state = SS_CONNECTED;
-		vsock_insert_connected(vsk);
 		sk->sk_state_change(sk);
 		break;
 	case VIRTIO_VSOCK_OP_INVALID:
@@ -1498,6 +1503,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 destroy:
 	virtio_transport_reset(vsk, skb);
+close:
 	sk->sk_state = TCP_CLOSE;
 	sk->sk_err = skerr;
 	sk_error_report(sk);
@@ -1702,7 +1708,7 @@ static bool virtio_transport_space_update(struct sock *sk,
 /* Handle server socket */
 static int
 virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
-			     struct virtio_transport *t)
+			     struct virtio_transport *t, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1711,12 +1717,12 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	int ret;
 
 	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
-		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		virtio_transport_reset_no_sock(t, skb, net);
 		return -EINVAL;
 	}
 
 	if (sk_acceptq_is_full(sk)) {
-		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		virtio_transport_reset_no_sock(t, skb, net);
 		return -ENOMEM;
 	}
 
@@ -1724,20 +1730,18 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 * Subsequent enqueues would lead to a memory leak.
 	 */
 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
-		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		virtio_transport_reset_no_sock(t, skb, net);
 		return -ESHUTDOWN;
 	}
 
 	child = vsock_create_connected(sk);
 	if (!child) {
-		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		virtio_transport_reset_no_sock(t, skb, net);
 		return -ENOMEM;
 	}
 
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
-	child->sk_state = TCP_ESTABLISHED;
-
 	vchild = vsock_sk(child);
 	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
@@ -1750,7 +1754,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
-		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		virtio_transport_reset_no_sock(t, skb, net);
 		sock_put(child);
 		return ret;
 	}
@@ -1758,7 +1762,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-	vsock_insert_connected(vchild);
+	if (!vsock_maybe_set_connected(vchild)) {
+		release_sock(child);
+		virtio_transport_reset_no_sock(t, skb, net);
+		sock_put(child);
+		return -ENETUNREACH;
+	}
+
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, skb);
 
@@ -1855,11 +1865,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
-		virtio_transport_recv_listen(sk, skb, t);
+		virtio_transport_recv_listen(sk, skb, t, net);
 		kfree_skb(skb);
 		break;
 	case TCP_SYN_SENT:
-		virtio_transport_recv_connecting(sk, skb);
+		virtio_transport_recv_connecting(sk, skb, t, net);
 		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:

-- 
2.53.0-Meta

