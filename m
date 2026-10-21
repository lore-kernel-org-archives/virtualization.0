Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545336;
	b=NMIHqTHGoaQsbcmfSMCxa+zLLo6/xZ6lPK9yseZ0rH+gl0qYg9lLnQR7P9y67corjcXh
	 SFO7VtlbxywEn2N284JBnrYhmjeDZ+BVQ7en+VympPDLfwlcqAz1QKt5YY4n+Gnzd7kFO
	 pOJqg5F0fBu7V26lV7yf4PNrVhUiGjb6HanOLpLGwQ33EMyXOVzHcHbg3uEALYrjKFNOg
	 466IA0rlhc/dqR+0CHvmj6LYE3LsJs8DGhnPOs6ejl5RwI7wBD5MsxCW2DFBekUxV8Mxp
	 B6ql3AtWqpuEJwYlBzj0iMKvxkJEu5ldotPHQqB8nFYTgLdbhg9zCvU09xpsJOO1Duw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=eqVaVaagKgEs0jIkag12M2KWvIYEqugr9URWOwreLcI=;
	b=2Kmqoznz369rJobzbUEvVcLv3VTqWFvivos8e0yq1FVjuKJmyiG0ZssEPMwB36BzUh8E
	 g51RuRdLLi7kDw2n238kcgvW7YduY0xuvXAH4AVcaZZCs/riitD40dHkuKRFxldj66jcH
	 NRpLLIAdbjdsTNjhCeC9Ce57/elJDhNCpnp2E0IKkMiUjTIOg6eEDWI3lvEsK7Yj6SFLv
	 IR3nadP/QPHdxHX+mjPIf26M6znExyn1oAPsFZI8tP/Iuj7mpGZJGGYy+oYjC2RsfyEmx
	 gYfWhLW51gNZfsbt5B0cmxxs24CbJAvj2hwEJYTINGu8mh+KBUq/P0UmFhm/cUR2PsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=bn5KVOj8;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B789606A31B
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B789606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=bn5KVOj8
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KNFmtG885087;
	Tue, 20 Oct 2026 18:15:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=eqVaVaagKgEs0jIkag12M2KWvIYEqugr9URWO
	wreLcI=; b=bn5KVOj8PlXY6IhCEtcnm4jpV30I2Nfno56haB0raZkbsHjAIhw67
	uw7gLE2SZNd5J+A4u9pteBkhQD7rAhsBM49h8UU2yvEossMLwlm4DaZlV1CxmyKL
	mG9AmMWnA4EhiusmODeqyHNkZHJNAkJAfN2xtIHq4zS3teir4YdkHJ9lTIRnenXg
	MNwexAFlB/7mzQXyTSsF1I83hSXTGkqeW2BsZ9XkgQaa4km+eTv1IsxCpbNz4BuO
	el58Xfwmzqeuu3cHXvIr1O4SGR3msiGmjAQNJ+yF+Qo0gSQN8Jidcbl8AdEwReg3
	+jLS6M5HHr8p6M8J+YMhn/N32ypgrOxCg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw52r0mj-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Oct 2026 18:15:21 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 21 Oct
 2026 01:15:20 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 20 Oct 2026 18:15:08 -0700
Subject: [PATCH net-next v4 5/7] vsock/virtio: support guest device network
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
Message-ID: <20261020-vsock-guest-ns-v4-5-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfXzAWkgvOS96oy
 dnW/q6CJrC+SNtNBgRDpHRqD2OZiMx0qkb3BUq/ouNXxstflONK3Mtj8wT0BV3BeekojrxnTqQy
 AwzwhwaxJ4au7t1X86W4PBVj8kIHskykgdwb+ViuFefRvIJDam6pRsRnKZDjXo9BcdkBxBKQbAo
 IabEUOu2E2/UT+0wQ1SN7IU7EPS7Pu4OjYAxp3Sz1UTE4AQ5ln9neeZULu7NkofIe9LCbnxwBp/
 6kZBI5VJga3fjgzf47wWma2+d2WLmYnlE4fll2Dj95ppRrhIith3mLmPikUfF40PCDkhxoxMINg
 1vcN9badd8l+lo+ZM+bRDRh6oQo7GPzWmzUKtRdzJPR0/pcs5LnqSEqZdLIzz5BjcjmF5UywP9q
 UQOzEdnylBmMiSrCZ8LLYAElhzY5YM5BSEhBfUyGUDN1QBfuPSOPMS2cvlCw/wta/5GMA9fWbBf
 4sNgiUYyfTJDqewppHQ==
X-Proofpoint-ORIG-GUID: 4mIzvfxxQ8hLZoBkn_JqXXhvJ5csCgEh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX2EF29FPKPfCq
 myhFuNttzlv5CJCLI+/PRrfHpLUSW2ll+XXRbVuvvuCijCX4PnreK2KJkpjQFw6AhJ8CeI9vUT2
 /tSDT+NQGBZLPSEmVsbHzXfe0XB3uNY=
X-Proofpoint-GUID: 4mIzvfxxQ8hLZoBkn_JqXXhvJ5csCgEh
X-Authority-Analysis: v=2.4 cv=BqEIUoX5 c=1 sm=1 tr=0 ts=6ad81229 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8
 a=Q26mkz6o2AEWOQ6HvkAA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01

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
 net/vmw_vsock/virtio_transport.c        | 32 +++++++++++++++++++++++++++-----
 net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++-----
 2 files changed, 40 insertions(+), 10 deletions(-)

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
index 1e762a480df4..0c864db2bc65 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1478,9 +1478,13 @@ virtio_transport_recv_connecting(struct sock *sk,
 
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
@@ -1736,8 +1740,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
-	child->sk_state = TCP_ESTABLISHED;
-
 	vchild = vsock_sk(child);
 	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
@@ -1758,7 +1760,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
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

