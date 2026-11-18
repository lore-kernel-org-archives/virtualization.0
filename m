Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966922;
	b=Vks+4SwH3UtzL2M8e1iC4OEpky8hKNeLjA67UhCQollBtd1yVs+NDliRW0wC2dsx70U4
	 vyatAx0oydlNxO5ZpbdqkED9XA4CTqR8ejT3wK+lMKpf7u6pi1zo2neT9+Vg0zOHKkC6u
	 5hbcEpBkbiD70WNucYgMr3F+h+k4Tvn9DUhZwzBY3w3PtKchnMjQ3qVtlbbWHZPleWQbT
	 /+EMV9GcmK3gEGejoF+jOPJgFkYWzBnUGTA0+5ithN027v7HrKobIVg6beC4ZbJyhn1kF
	 i/mFAwY+lLciP1mEvo9m3zZ7HNU9AMT0BdvlW9hUmHh4m3OZY5Rh+6mfD0d9W2TroRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966922;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=9JUsSU/RE0kWWq5dRPxNckF6Lzz2dBkuaWrDrNZqnZ0=;
	b=NJqXojQPu0kyHBATwmqtvpvdFQZLxUyxPt/lNL5BVup8ffWkYp051iojdcdU1Z4aV7Ce
	 P2U6gXFqL9oWHz4uZvJt/0YBHcX0zpFjUrq8ZZ/gRmj5CvXoRAzVVCfhgi5JFhrqkMKTm
	 0LA2rebyDEI/x9ruB+5gWv0Ni5nDAhQQ1FaHf1fMGZHY3UjgQfljGitp4HNzFTNDwA3O+
	 mgSsBq7ZScR6et9ZYO5QJikgkFRxKYuEtASrRtnsXR00qyMib13PZPAVXnrEFvM6VXfHU
	 HBaX6kiFAFPvGuLTdyqdOIlcc2nEQMM85aIloMGuXgLdK0OfjOemFsvej765Vs1NrMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PwPkW6hX;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80A606A325
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E80A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PwPkW6hX
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI11rvV1516366;
	Tue, 17 Nov 2026 17:55:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=9JUsSU/RE0kWWq5dRPxNckF6Lzz2dBkuaWrDr
	NZqnZ0=; b=PwPkW6hX3kLRz5ai6HT8JJ+yzQB+rbuR0eNhtFW1No14hp49gj+0x
	G5SNcQoYhrh54vWVq5xDQg1t4Iwr3Au2uFvnNTMFYb8RJwUdCqiJtAEHdWfSP/JC
	L5Ell8QpJ1FWNvXFypzkYgbLJAtMEcPVQGD1MLy/2BqRtigRM1BBU4xTEGr3QQKC
	bblfhBiqg0zh94zEEg976hTuxh1wWWkZN3c9/bcUCuyOZNS5MsIDvKgCzpONQUK1
	HvnQMhP/QJyxzBT7kZa3PJ2GyDCPYiikoJZNlzdAoPX7ivnvMdmGVMHSO/2wPw5x
	LmH0JLTvN5XMumd2BThL2N7LojXpMZ8+A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu61by0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 17:55:07 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 18 Nov
 2026 01:55:06 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 17 Nov 2026 17:54:48 -0800
Subject: [PATCH net-next v7 5/7] vsock/virtio: support guest device network
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
Message-ID: <20261117-vsock-guest-ns-v7-5-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX8+LqJPbwJDLj
 IhKTnrWH+yccWsYzYS2Taw1IbxoTyi4jd19PuTmNGQkeSjCsHXqpa5YH9U6DMnyVh2y8HA2/kd9
 2iWsIhfv+Ru5gbzPxVvX3bZqklRtOuPKIsu1xrm0DaS++mVLza5Znjhg0Z8xktEasl/sfYQ65tF
 3q5+/1nLkabAr4N4hKbZ+ZNYP983DLufX4ZC8LbNY+67Ei5zEJuDI3YUNuxVAKm6WHsN/M88LVv
 JU4fcBctGcsbECTbK4AFkOYJ5VmXk9npxh0j4P4U8Crp7rC4Y3lf7x/uStNDVvLD8bdN7DYZOL5
 BXl8k7GrG0h3JDH1x5g12V2edqchw7NxraLoJbfVFCbUqEMS82DHNC76LqlZwOWAwS0e2nt7SnS
 tbvKIZ9nfLiGLdAKTzicQDVofzPQUcEoz5HyQ+12mKAgBZgQQQ9DsqclJuH2yq2J/tQyHVzqaJ6
 fbSTufME1BLKJWEhMng==
X-Proofpoint-ORIG-GUID: Gv8z5UM4pTrD-rR2cRtFtrHHkcTMI6hS
X-Authority-Analysis: v=2.4 cv=DrnDa2/+ c=1 sm=1 tr=0 ts=6afd057b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8
 a=J5Rx3YFY5MJ4in-ODIoA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX+gN8HnSHWruL
 1r0DykYBHfPD396uevrrdpx7gWCWSuAuUvDZ6gWXwxcwlzriCEd/Jbd/FlKkKygP5aBWhHHys4Y
 CTqjlyK46NZEQ7io47xiJUOZaKhOhG0=
X-Proofpoint-GUID: Gv8z5UM4pTrD-rR2cRtFtrHHkcTMI6hS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

virtio-vsock did not have namespace support (the device was always
accessible to any global namespace).

Make the virtio-vsock device assignable to a namespace by setting
.netns_assign_allow, and allow stream and seqpacket sockets from any
netns that can reach the device rather than only from global-mode ones.
The device starts out assigned to init_net, which is hardcoded to global
mode, so global namespaces see no change until the assign command is
issued. Local namespaces still cannot use the device.

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
Changes in v7:
- Tap with the assigned netns, add vsock_g2h_net_rcu() (Paolo, Sashiko)
- Fix stale comment and commit message (Sashiko)

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
 include/net/af_vsock.h                  |  2 ++
 net/vmw_vsock/af_vsock.c                | 14 +++++++++++--
 net/vmw_vsock/virtio_transport.c        | 30 +++++++++++++++++++-------
 net/vmw_vsock/virtio_transport_common.c | 37 ++++++++++++++++++++++++++-------
 4 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index ce945a83a919..7765fc3ee6ca 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -249,7 +249,9 @@ bool __vsock_find_cid(struct net *net, unsigned int cid);
 void vsock_linger(struct sock *sk);
 struct net *vsock_g2h_net_get(netns_tracker *tracker);
 bool vsock_g2h_net_eq(const struct net *net);
+struct net *vsock_g2h_net_rcu(void);
 bool vsock_g2h_net_reachable(struct net *net);
+bool vsock_g2h_reachable_sk(struct vsock_sock *vsk);
 bool vsock_maybe_set_connected(struct vsock_sock *vsk);
 
 /**** TAP ****/
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index dcd39ad43eec..33b1902f2637 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -128,7 +128,7 @@
  *       error that propagates to the user (as there is for connection attempts)
  *       because it is possible for some packet to reach this socket from
  *       a different transport that *does* support local mode. For
- *       example, virtio-vsock may not support local mode, but the socket
+ *       example, hyperv-vsock does not support local mode, but the socket
  *       may still accept a connection from vhost-vsock which does.
  *
  * - A guest has a single vsock device, owned by the guest->host transport.
@@ -914,6 +914,12 @@ bool vsock_g2h_net_eq(const struct net *net)
 }
 EXPORT_SYMBOL_GPL(vsock_g2h_net_eq);
 
+struct net *vsock_g2h_net_rcu(void)
+{
+	return rcu_dereference(vsock_g2h_net);
+}
+EXPORT_SYMBOL_GPL(vsock_g2h_net_rcu);
+
 bool vsock_g2h_net_reachable(struct net *net)
 {
 	bool reachable;
@@ -926,13 +932,17 @@ bool vsock_g2h_net_reachable(struct net *net)
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
index 1ddb6839a8fb..ba9081536212 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -150,7 +150,9 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
 	if (ret < 0)
 		return ret;
 
-	virtio_transport_deliver_tap_pkt(skb, NULL);
+	rcu_read_lock();
+	virtio_transport_deliver_tap_pkt(skb, vsock_g2h_net_rcu());
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -542,7 +544,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 
 bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 {
-	return vsock_net_mode_global(vsk);
+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
 }
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
@@ -587,6 +589,7 @@ static struct virtio_transport virtio_transport = {
 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
 
 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
+		.netns_assign_allow       = true,
 
 		.notify_poll_in           = virtio_transport_notify_poll_in,
 		.notify_poll_out          = virtio_transport_notify_poll_out,
@@ -616,7 +619,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
 
-	if (!vsock_net_mode_global(vsk))
+	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
 		return false;
 
 	seqpacket_allow = false;
@@ -633,7 +636,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
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
 
@@ -680,12 +688,16 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
-			virtio_transport_deliver_tap_pkt(skb, NULL);
-
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
+			virtio_transport_deliver_tap_pkt(skb, net);
+			virtio_transport_recv_pkt(t, skb, net);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
@@ -694,6 +706,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
 	mutex_unlock(&vsock->rx_lock);
+
+	put_net_track(net, &ns_tracker);
 }
 
 static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 027fe41c676a..c8049dd80cbc 100644
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

