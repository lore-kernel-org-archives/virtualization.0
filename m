Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872831;
	b=2eHJ61Ycb3SvbCoOwRYkeFuW0F4fMCeqkIB+3wqfW0+yPohe8zLrQzaxwxC/DXEYN2Oj
	 OnqpQO/r6eXAEX9oNeilUkjYdY7HQBBmnuYRu/JuTs2Mgur7XzcKb8Plms4ZZFlW+yxkx
	 MgoiONKFAynEBmpMWsjY79tOybu5quQ5ShELMXyvFHs+XN+L+FSVyNj7g6VZW5vuDV6Q3
	 /E1FVN5N8bwIijVZGxHMBUys9SfgK3jy+A4S6jgpNPYXcxeShx1r6uzQze4SfN7xW+0ts
	 8oDQsKkGkZjR/mN00KEcfiBran/OIZWIROJ9EAaS01sqnrDikmWuGylCs7taNVVzIKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872831;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=erW4QNXmLOEoWNGzUnD+FqnM0gfstb4jmRqULXnvHQ8=;
	b=cLfhpQmbgeHYh/27WWu/oSig1VLlplYbItv37CWuOB1BSmzk8T9FUN1DvItwDF0OoaT3
	 L8fWBZ5JhRSN/GUdAMjBY9Nzb2onvd5Rsc+NmXw6yAkTYNLWJ95eyqf/fqjLcBHYAN8y+
	 S7f8YMrMDjmdZTLSOV0QUjQlN0uZsQVJpj0NrI6BmGaRkh7BzcdurSVoijoVD40QvX0TR
	 NNXHS/Yf3fzvficgmQCQXEjYQJBUvXo9/OcLLHEh9zJlmiTggHj7iE9Vf7iNfGH2abXWX
	 w8GynocDh5whrCBfGBxcZUzI7bt+W4e11wPq1vdU19UIBGHKmrCjAFajvJVMQ39K4lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nbMwOWrq;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABD606A32F
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 23:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAABD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nbMwOWrq
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGNOh3p3594659;
	Mon, 16 Nov 2026 15:47:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=erW4QNXmL
	OEoWNGzUnD+FqnM0gfstb4jmRqULXnvHQ8=; b=nbMwOWrq1FCjXpZAMziSKloxO
	zi38uycTZxz4RhG0ErmURTCmDPzlMFUlHF70UfXsSUE8H/AOpDfkshVZ5vh4vNl9
	19O/ae4UZ0O+CW6Fl7uwLAGLEuRDpyhnALi5hdyq8m+7vXE5TS3aBy5ORHktjkf4
	vr6G6M/HiwKmnfoVFWKEym3mkA/PzlOQ7wYJ6RLb29P1earatDEFhj514QAL/wif
	tL7TnS02pBiBeUopsYAtqd/Js/xwL/OioPfb60K8Serwk1cRwNoRUU70WuRDrhK+
	BIveU6pSZF+aME3DVkhV6zhpuqlgmPYEG8N44/w6n3XUm7U0fkOin3ORflIJg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hya99spbp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 Nov 2026 15:47:04 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 16 Nov
 2026 23:47:02 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Mon, 16 Nov 2026 15:46:49 -0800
Subject: [PATCH net] vsock: only deliver taps to namespaces that can reach
 the device
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
Message-ID: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
X-B4-Tracking: v=1; b=H4sIAOmV+2oC/x3MQQqDMBAF0KsMf+1ARqySXKV0EXXaDkKUJIgg3
 l3wHeCdKJpNCwKdyLpbsTUhkDSE6R/TT9lmBELr2l5Eet7LOi1c48ZJK8vofHS+ew2DR0PYsn7
 teL43klZ8rusGdSxwmGQAAAA=
X-Change-ID: 20261116-vsock-tap-net-1b09a0945779
To: Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella
	<sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5NCBTYWx0ZWRfX5OJdBdyViD+U
 5F5qWrd7qt7HJHlgLcOwnoLNFmKtmG14C7DdtKhbqiYTAEl/W0ZljvsQWch9+bnVZ/GJDHMTWi3
 iUAzps/HhAHyCtAsa+HoAxf+wqCUjj0=
X-Proofpoint-ORIG-GUID: gKDNQAj56r8459FNniU9y9-fMq_ecPmD
X-Authority-Analysis: v=2.4 cv=ZuN4uN7G c=1 sm=1 tr=0 ts=6afb95f8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8
 a=SWFGfQgXnGc93N8zE1QA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: gKDNQAj56r8459FNniU9y9-fMq_ecPmD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5NCBTYWx0ZWRfX4CTqCEvwyK4k
 1gKYYYNFViwq/KsAmDiIDlUCOYPpP+uGeKEv6CtdZHnO0TjYuVuEQv+mJG9glxn52sBbSOH8w4H
 3oosVpURYlbLlCHjnqmV1hfrCDBPQQaWSFHy9sJkewGwR/+nEP5MjpsgXoziYWegJad/xGJ/1Ol
 6H1nRgxWdSf8zYKHVJfHU9+AnuDHYXoeJoOPZ6uJwdX5OLXJGhLbKivTVH07gBIbuWLlllqng2F
 F5qyc16f4TqlZ0EsgKPld8ZV5CP5Iwwh6b2tcLAwZ+jvyS8unjNuU2vD0KfaVr/L6w0R/xG9A3A
 krRB7fpzVZVdvYh7W4224s7gqen4uXe0gwljy+u62N4ipijBDD2xamoMv0s4+AVUFJ68TT7W68B
 CVZigCjqRTArHF2nzqFbBfN+ONC6d0u/i8JzYeNWeX7rG9VCmSx7ZzjDOrTZUr7H4IMn86jE03T
 z1ceLjsuI8HmVaCMscg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01

vsock_deliver_tap() clones every packet to every vsockmon device on the
system. Creating one needs only CAP_NET_ADMIN in the owning user
namespace, so an unprivileged user can capture the traffic of local mode
namespaces.

Pass the packet's netns to vsock_deliver_tap() and only deliver to
devices that pass vsock_net_check_mode(), the same rule socket lookups
use. vhost passes the vhost_vsock netns, loopback the sending socket's
netns, and virtio-vsock NULL (global mode).

Fixes: a69686327e42 ("vsock: add netns support to virtio transports")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/vhost/vsock.c                   |  4 ++--
 include/linux/virtio_vsock.h            |  2 +-
 include/net/af_vsock.h                  |  3 ++-
 net/vmw_vsock/af_vsock_tap.c            | 10 +++++++---
 net/vmw_vsock/virtio_transport.c        |  4 ++--
 net/vmw_vsock/virtio_transport_common.c |  4 ++--
 net/vmw_vsock/vsock_loopback.c          |  2 +-
 7 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 88a310390eb0..3de1f1920717 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -229,7 +229,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		/* Deliver to monitoring devices all packets that we
 		 * will transmit.
 		 */
-		virtio_transport_deliver_tap_pkt(skb);
+		virtio_transport_deliver_tap_pkt(skb, vsock->net);
 
 		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
 		added = true;
@@ -567,7 +567,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
-		virtio_transport_deliver_tap_pkt(skb);
+		virtio_transport_deliver_tap_pkt(skb, vsock->net);
 
 		hdr = virtio_vsock_hdr(skb);
 
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..46058d354940 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -285,7 +285,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
-void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
+void virtio_transport_deliver_tap_pkt(struct sk_buff *skb, struct net *net);
 int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
 int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
 int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e8481f12312e..3e28865578eb 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -250,7 +250,8 @@ struct vsock_tap {
 
 int vsock_add_tap(struct vsock_tap *vt);
 int vsock_remove_tap(struct vsock_tap *vt);
-void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
+void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque,
+		       struct net *net);
 int __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 				int flags);
 int vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
diff --git a/net/vmw_vsock/af_vsock_tap.c b/net/vmw_vsock/af_vsock_tap.c
index 7c5cdceabb2a..4c8821835251 100644
--- a/net/vmw_vsock/af_vsock_tap.c
+++ b/net/vmw_vsock/af_vsock_tap.c
@@ -73,19 +73,23 @@ static int __vsock_deliver_tap_skb(struct sk_buff *skb,
 	return ret;
 }
 
-static void __vsock_deliver_tap(struct sk_buff *skb)
+static void __vsock_deliver_tap(struct sk_buff *skb, struct net *net)
 {
 	int ret;
 	struct vsock_tap *tmp;
 
 	list_for_each_entry_rcu(tmp, &vsock_tap_all, list) {
+		if (!vsock_net_check_mode(dev_net(tmp->dev), net))
+			continue;
+
 		ret = __vsock_deliver_tap_skb(skb, tmp->dev);
 		if (unlikely(ret))
 			break;
 	}
 }
 
-void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque)
+void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque,
+		       struct net *net)
 {
 	struct sk_buff *skb;
 
@@ -96,7 +100,7 @@ void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque)
 
 	skb = build_skb(opaque);
 	if (skb) {
-		__vsock_deliver_tap(skb);
+		__vsock_deliver_tap(skb, net);
 		consume_skb(skb);
 	}
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index cf63bc99f3cc..b39c001260a9 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -150,7 +150,7 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
 	if (ret < 0)
 		return ret;
 
-	virtio_transport_deliver_tap_pkt(skb);
+	virtio_transport_deliver_tap_pkt(skb, NULL);
 	return 0;
 }
 
@@ -680,7 +680,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
-			virtio_transport_deliver_tap_pkt(skb);
+			virtio_transport_deliver_tap_pkt(skb, NULL);
 
 			/* Force virtio-transport into global mode since it
 			 * does not yet support local-mode namespacing.
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..027fe41c676a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -190,12 +190,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	return skb;
 }
 
-void virtio_transport_deliver_tap_pkt(struct sk_buff *skb)
+void virtio_transport_deliver_tap_pkt(struct sk_buff *skb, struct net *net)
 {
 	if (virtio_vsock_skb_tap_delivered(skb))
 		return;
 
-	vsock_deliver_tap(virtio_transport_build_skb, skb);
+	vsock_deliver_tap(virtio_transport_build_skb, skb, net);
 	virtio_vsock_skb_set_tap_delivered(skb);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 8068d1b6e851..cacd313a454b 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -138,7 +138,7 @@ static void vsock_loopback_work(struct work_struct *work)
 		 * It is freed by the receiver.
 		 */
 		virtio_transport_consume_skb_sent(skb, false);
-		virtio_transport_deliver_tap_pkt(skb);
+		virtio_transport_deliver_tap_pkt(skb, sock_net(skb->sk));
 		virtio_transport_recv_pkt(&loopback_transport, skb,
 					  sock_net(skb->sk));
 	}

---
base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
change-id: 20261116-vsock-tap-net-1b09a0945779

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

