Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8E3002C8
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845378; cv=none; b=Pjfmddq0k5RFL5mR7pp1TS//WD6myqG3kLkWl97KgsIlkH3QjHUIEjrS+ImvG+pYmuSau1kM3Wp+x/lMMzDsEhp/xspxTJPuRUoUmlhE0/N28tFby+sUZdLWXWar5JGVIY8N1kCONVJon9oR9s9Cgo0HT293YOEQ11/lWgaxYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845378; c=relaxed/simple;
	bh=oDsbgNiHxRfMf5Kmi+XCdkX4Vvv5n8CHNNPXUx/LHp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MRL1HkcFepZcj3bg1qqUIkFTJoWLxserhWFWhEH4pdDs4aSm5y1QbIAqo5KGoG408bo8LPyEhy0L445Z3Uq2KEaNsHBYfZDctzNZrLBHg37d6OqWPuJx8S2/c56MMT0ZqznsA7UdSBFCNjN5KOjLw0TTSpyWiq6NvwYt6L7IQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cXyyjGlQ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cXyyjGlQ"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJOhFR1060277;
	Mon, 12 Oct 2026 15:49:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=qzXezAhtvNXgdPBx5Td9kyxiAsCDPxgcz496J
	1uZpDY=; b=cXyyjGlQwR91Vy38em3jgFDiU7frNKkBfIPYW17Kd5X9d3iUGwAwV
	jyxjjBRczbDw7BNoYA4nCNalkFEAHdsJujbjYc4OkO8rIfAJEJgm3Ol25RCL6jYo
	B/R4zvd6VXVIU0B3+EhbtSIfrm7suV2iA9NyuVvxYWtLu8mJeVBiHZl3Frkj1Req
	J6mUx5dNxYJUgvzSc08XXCzxprHOuER7mL8SPkgaH5vBgaiXGKDdko0Q3F4xs9hD
	F6wS7HpEgLdwwDnCtnjDyFGjd2mCDvYa+yCEMSO9qyinFTLNeDm6zRRFmrlGRDO0
	8KKlvsSX/hkIvnknadNDa37MUSqmTCvEw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h7k208a4p-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 15:49:22 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 22:49:20 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Mon, 12 Oct 2026 15:48:36 -0700
Subject: [PATCH net-next v3 5/7] vsock/virtio: support guest device network
 namespace
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-vsock-guest-ns-v3-5-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX9UIkuKv09P3q
 HCGfijQrDaynxblfoYGYeFj5+nxQHV1j3/H14ejQJseIWPKMeBjzbdKQFvb88uy8ON/2jm3X/4U
 Xk8fe+MaxWrf+HEL5fWosyo3gAQfrH0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX6iLH/lPKFWok
 r+UctP4Jcc4J7Kt4aPW9lL1Y6udsaW6HmjZE6QUuEB9siTjuY718fN6lCB5rsx+dd52GMBstAmf
 C8cFRWQ02Nhz4ezxMNntTE6Tn7PD4YWs1zULCpnfurFFdWDeZM+Gf5HumjOkvY0H2KGGkPaDOQJ
 4kSj7MP2UTyUK1yegmR4rVZOFm3V8AMuIRdry2s3SgpFrgoNqU0EFxokGKikgMmdeNwjX84nnFX
 jJDI0Ph0e7SG90/bgfslQMrCyHRVAtTreASKFqN2+ujyu7bLrL27bJyMQg6I2W+BK/NzEo9z+9H
 x4ZTLDfM2+QSx+k9B52c3gpzB7r4x38Ivr3B1GKXc36ScQ1QdZGWizSHEE6gpgVSUIHtrVahYWR
 wQ7BFBuviXLZNcfByhufsSKmewHAd0iznJi3PXy1Ukg5m1KQZWraEKA9P66gmw866CGIIFgMG9l
 OVXcLzVAAyeAtkKLdFw==
X-Proofpoint-ORIG-GUID: YavKoxWTlBjiotusArlnJKSQZXjR8ZHs
X-Authority-Analysis: v=2.4 cv=Z/V5j3RA c=1 sm=1 tr=0 ts=6acd63f2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8
 a=Q26mkz6o2AEWOQ6HvkAA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: YavKoxWTlBjiotusArlnJKSQZXjR8ZHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01

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
 net/vmw_vsock/virtio_transport.c        | 23 ++++++++++++++++++-----
 net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++-----
 2 files changed, 31 insertions(+), 10 deletions(-)

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
index f225f53ed4ba..0234379c14a1 100644
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

