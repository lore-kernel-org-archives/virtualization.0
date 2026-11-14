Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626449;
	b=q3FQBCBy8VDJSTdOZBzYnvoyU4+ECkBQ7nYMZoGYzu4GieROUNerDa12fOsm4g0VEJnR
	 ulJOP86QynaLwuabEYct1Funprqwlht1jXGdn9IfXmPN0n2rJ2f/evggosuMbaujZ2KFN
	 Dc0EUA3RGrOdEAsQ+cbvFFgS2Yzj671U+5DgsF9DfqebwJm1U9POhQ/spAdNczHV0MBZm
	 o7XNRDz0SLXxFynM6dw0+ISC+Y3rKJk8xJ9GF6ifKot9bT0C8u6eUeamDIQjHbTETrNWI
	 lC7lpyoVNdQpEo/3lwG7dttmiQtQ5qDNkg8rJDjU051d8W58ivgNpzT7auFoZvaxOrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626449;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=zCOrRxSnhPYdKP8UmA1kyFhtz8p190b7JdQf3o371/w=;
	b=ld9P4VCvnYHVchSTmGjTyr6Z7olEcjGa34gDR1APz/lL6dQe3Fln6vbasxnqAlZGCFU2
	 StwLXrS3K5FzUK44hhjf5bxH+mMxWnz7kRWB9mwMs1aifSRud5aVRbvFv0cWFxX/xKowW
	 +5P/MGTCw8rJmtjgkODychBJT3wBLdevBNlV1dTIX54pEAcgHS+5wBMY40kIsB0KHsThJ
	 wxyRLFVudV7evoIjYCEBo7iwcNRxpPB5j/7y2/hNWd6cYkM45IP7xrYnkHPxj/LN1MZlp
	 aA+GP6tgAkCfPmHpUF9DmaXkchQGgddbXMJEVc5eqcnmc6hB7nuy9DGHVhc1Qfl8zdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gJcQ88ps;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2C606A33B
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA2C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gJcQ88ps
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22XeZ3157915;
	Fri, 13 Nov 2026 19:20:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=zCOrRxSnhPYdKP8UmA1kyFhtz8p190b7JdQf3
	o371/w=; b=gJcQ88psVOPAebqC1oH2XOba5etrmBuM/k4pCgzPYFYfaZ30pM4ik
	pvPVRmAnlNbsoImgLntQQcoFFRj2E36CvgiWZHaLttdEmGmDvQncMWViarc4StoE
	uJb5JXKEy/Sc3SHQGQS7EoMJuXDWgAJ80MZVzF8Km5UOUAYDbtb7gCJzJN994q5P
	MKQ1tConbe+d8H02TigXmFNW3Ja3QeJqH/A1FSg+MK+tl/TYlODROqJp5VVlCDD8
	I7OIU0PkDCNA9rxJeNy3AYlmA9to6kEfPnIA6BEBmowFLjfj62flgVd95adXUTqH
	CVsLg0yjGZ3zCi6WnVrAqX06Jta5J8JGg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5tf9k-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:26 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:25 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:17 -0800
Subject: [PATCH net-next v6 6/8] vsock/virtio: support guest device network
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
Message-ID: <20261113-vsock-guest-ns-v6-6-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
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
        George Zhang
	<georgezhang@vmware.com>, Andy King <acking@vmware.com>,
        Dmitry Torokhov
	<dtor@vmware.com>, Eric Dumazet <edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Jo2pYliP0EE_CRFPOyEWqtQ84dOsSW3E
X-Proofpoint-GUID: Jo2pYliP0EE_CRFPOyEWqtQ84dOsSW3E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX48fr4OCs1cnk
 TO4EX/xBK+FJIhEwpPpU2FxD/XTn13IDz6EveScalzOQHYymDm9DNGoX6V/FsRD69l4x21s9VgN
 AuE8xSvdILFYgLkaRSIOD7BKbAfdFMM=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af7d37a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8
 a=cDCjuCh_hbpvLbohWgEA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX4XJSSBgDcKji
 JSqqu8Co9Ysiq/ZHqIwcoN/sHj54E1HSkuyt2FBzMz5MjY9By/zvu4F05zYK1HHcGcFqPN640In
 uk05EqKaAWXEoQx27h8J7FzSvRXeRqpPRtNIdczqnZ2f/01Dt3VJnWcIbBCXmOBhB954sNjYn7t
 zerrEseTcvq94HSFTkQO+p75ZAiP2nOclV3ancV/WP0Eb3MGh2IJIImJwgvxbjm2XFs5EvpUJk7
 4l2kTyyDH1LisPUSs9/dJZd+T7uytcClGgnvdUB3gYDjh1aO+xJzUcBWy7s+GEZ1sJgaP78Oo7A
 6HLJ86sEdP/z42H3TPtCuwUhGh3Nws6ka+s2ULb54C/p6eAaO0K5YVZThdPV7hEpultSzNUlARL
 0NsAatjLFG/4EZhAoUoCyRXyVWp2F+doVuTaD4c+9OySc4XF8PnK5Q9Sr3yUcBNjcwOryTi3/4/
 LDoXlrfOj7L3J4OxZsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

virtio-vsock did not have namespace support (the device was always
accessible to any global namespace).

Make the virtio-vsock device assignable to a namespace by setting
.netns_assign_allow, and allow stream and seqpacket sockets from any
netns that can reach the device rather than only from global-mode ones.
The device starts out assigned to init_net, and because virtio-vsock and
init_net are both hardcoded to global mode, nothing changes until the
assign command is issued.

An assign can land while virtio_transport_rx_work() is draining a
batch, so the assigned namespace is re-read per packet rather than once
per batch. Matching the rest of the batch against the namespace the
device has left would reset connections that belong to the new one.

When the device is assigned, VSOCK_CMD_DEV_NETNS_SET closes every
connected socket that can no longer reach it. A socket that completes
its handshake at the same time must not slip into the connected table
behind that sweep, so the listen and connecting receive paths now call
vsock_maybe_set_connected(), which checks reachability and inserts the
socket under the lock the sweep walks the table with. If the check
fails, the handshake is aborted and the host is sent a RST.

A socket closed by an assign can still try to send, e.g. a credit
update from setsockopt(SO_RCVLOWAT) or a shutdown. To stop that,
virtio_transport_send_pkt_info() now returns -ENETUNREACH without
sending when the socket's netns cannot reach the device. RSTs sent by
virtio_transport_reset_no_sock(), such as the one above, do not go
through it and still reach the host.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v6:
- Move the reachability check from virtio_transport_send_pkt() to
  virtio_transport_send_pkt_info(), so RSTs sent by
  virtio_transport_reset_no_sock() still reach the host after an assign
  (Paolo, Sashiko)
- Revert the v5 change that sent the recv_listen()/recv_connecting()
  RSTs to the netns the packet arrived on; sock_net(sk) works again now
  that those RSTs skip the check
- Export vsock_g2h_reachable_sk() for virtio_transport_send_pkt_info()
- Rewrite the commit message: drop what the previous patch already does
  and describe the virtio_transport_send_pkt_info() check (Paolo)

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
 include/net/af_vsock.h                  |  1 +
 net/vmw_vsock/af_vsock.c                |  6 +++++-
 net/vmw_vsock/virtio_transport.c        | 23 +++++++++++++++-----
 net/vmw_vsock/virtio_transport_common.c | 37 ++++++++++++++++++++++++++-------
 4 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index a35ab9e41bbb..fa025dd754a1 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -249,6 +249,7 @@ void vsock_linger(struct sock *sk);
 struct net *vsock_g2h_net_get(netns_tracker *tracker);
 bool vsock_g2h_net_eq(const struct net *net);
 bool vsock_g2h_net_reachable(struct net *net);
+bool vsock_g2h_reachable_sk(struct vsock_sock *vsk);
 bool vsock_maybe_set_connected(struct vsock_sock *vsk);
 
 /**** TAP ****/
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d4d88c8cf142..3bc9eee8ad9d 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -921,13 +921,17 @@ bool vsock_g2h_net_reachable(struct net *net)
 }
 EXPORT_SYMBOL_GPL(vsock_g2h_net_reachable);
 
-static bool vsock_g2h_reachable_sk(struct vsock_sock *vsk)
+/* True if @vsk can reach the g2h device, or its transport ignores namespace
+ * assignment.
+ */
+bool vsock_g2h_reachable_sk(struct vsock_sock *vsk)
 {
 	if (!vsock_net_assignable(vsk->transport))
 		return true;
 
 	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
 }
+EXPORT_SYMBOL_GPL(vsock_g2h_reachable_sk);
 
 /* Move @vsk to TCP_ESTABLISHED and into the connected table, unless the device
  * has moved to a namespace @vsk cannot reach. Returns false without doing
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index eced6929405d..4123924536dd 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -542,7 +542,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 
 bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return vsock_net_mode_global(vsk);
+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
 }
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
@@ -587,6 +587,7 @@ static struct virtio_transport virtio_transport = {
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
 
 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
+		.netns_assign_allow       = true,
 
 		.notify_poll_in           = virtio_transport_notify_poll_in,
 		.notify_poll_out          = virtio_transport_notify_poll_out,
@@ -616,7 +617,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
 
-	if (!vsock_net_mode_global(vsk))
+	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
 		return false;
 
 	seqpacket_allow = false;
@@ -633,7 +634,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
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
 
@@ -682,10 +688,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
 
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
 
@@ -694,6 +705,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
 	mutex_unlock(&vsock->rx_lock);
+
+	put_net_track(net, &ns_tracker);
 }
 
 static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..c1cbe834e4f5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -295,6 +295,9 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
  * since a socket assigned to a transport is required.
  *
  * Do not use on listener sockets!
+ *
+ * This checks that the socket can reach the g2h device, so device-only replies
+ * such as virtio_transport_reset_no_sock() must keep not using this path.
  */
 static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 					  struct virtio_vsock_pkt_info *info)
@@ -317,6 +320,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (unlikely(!t_ops))
 		return -EFAULT;
 
+	if (!vsock_g2h_reachable_sk(vsk))
+		return -ENETUNREACH;
+
 	src_cid = t_ops->transport.get_local_cid();
 	src_port = vsk->local_addr.svm_port;
 	if (!info->remote_cid) {
@@ -1468,8 +1474,8 @@ void virtio_transport_release(struct vsock_sock *vsk)
 EXPORT_SYMBOL_GPL(virtio_transport_release);
 
 static int
-virtio_transport_recv_connecting(struct sock *sk,
-				 struct sk_buff *skb)
+virtio_transport_recv_connecting(struct sock *sk, struct sk_buff *skb,
+				 struct virtio_transport *t)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1478,9 +1484,18 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RESPONSE:
-		sk->sk_state = TCP_ESTABLISHED;
+		if (!vsock_maybe_set_connected(vsk)) {
+			/* The net arg is required but unused: only g2h can fail
+			 * vsock_maybe_set_connected(), and g2h
+			 * virtio_transport_reset_no_sock() ignores the net arg.
+			 */
+			virtio_transport_reset_no_sock(t, skb, sock_net(sk));
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
@@ -1498,6 +1513,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 destroy:
 	virtio_transport_reset(vsk, skb);
+close:
 	sk->sk_state = TCP_CLOSE;
 	sk->sk_err = skerr;
 	sk_error_report(sk);
@@ -1736,8 +1752,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
-	child->sk_state = TCP_ESTABLISHED;
-
 	vchild = vsock_sk(child);
 	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
@@ -1758,7 +1772,14 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-	vsock_insert_connected(vchild);
+	if (!vsock_maybe_set_connected(vchild)) {
+		release_sock(child);
+		/* Only reached for g2h, whose send_pkt() ignores the netns. */
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		sock_put(child);
+		return -ENETUNREACH;
+	}
+
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, skb);
 
@@ -1859,7 +1880,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	case TCP_SYN_SENT:
-		virtio_transport_recv_connecting(sk, skb);
+		virtio_transport_recv_connecting(sk, skb, t);
 		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:

-- 
2.53.1-Meta

