Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31F4D90C4
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660882; cv=none; b=IuPNwXlp4WUSj/BvJjpBCNB8r5cIZBZON9VjBVK8UtNM5GNrU7+hthz0Of+1L54QvGrKgODvf8eIFoiAUsfm3d2w1O5MxmODQlVL9K2SW/A6bOcZ4WxMTEe7df/ToaU0SKp5jMWelRzI386DmU/AZ83ppOY2YqPuQ98899Abmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660882; c=relaxed/simple;
	bh=mVQZ3Z5gP/h9nfdD+wZ39ygVu8JFQL3b7h/XBXivkrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QR3chf84Kh1WpB1nwRZ0ulWd/8uO5FJ7PM/wHc6Zsv7byqPljYCk/UsxNSsOImYM0aTm2O+t1ms997IlRdNgBaCgFDNDzAkOCCyR3lunnNXx3ATDXB9Hih3ADV5ElnnE2+W6Dzb/Nt7g3pLV0m0SEXGV2nhuFPGnEh+rYCt3NwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=gX8dz6Jy; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="gX8dz6Jy"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BCC680C2A
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 12:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vamluJRNzRdH for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Jun 2026 12:01:19 +0000 (UTC)
X-Greylist: delayed 449 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 05 Jun 2026 12:01:17 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B504A80C25
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B504A80C25
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rulkc.org header.i=@rulkc.org header.a=rsa-sha256 header.s=dkim header.b=gX8dz6Jy
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=155.212.184.193; helo=mail.rulkc.org; envelope-from=avkrasnov@rulkc.org; receiver=<UNKNOWN> 
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B504A80C25
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 12:01:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D416C100036;
	Fri,  5 Jun 2026 14:53:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1780660424; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=6iwVaCXRpwiv+vZVNr+kltBX5rtqh1FPWM+jo4bxm3Q=;
	b=gX8dz6Jy2eSO7V4psvQMSFoBw/4WKMZBqGzngW/t9BLUC/h/82UuA5cn2TwlKfyC4GknqM
	kern3R9VYAm4U+wajP55edgXl3yrBlzhHreotpUzjYknFHOmqvcdAFSeJb8ZjpyhzoppGH
	2VeobGTX7wtgg6SE/4R7ammAm7GpKCtVxXO3m2htivJ5Vj94+TbxyuMnWkA8KQkillrTZe
	pGRCKij7eOAR+yaM+G201q/S7ktlWQ8n7C6KG/Xj0s3IepcdHbRkUzgzX0vpYy9G06Tvjf
	yLDjlPB1KgilNNxdGgbNYx47Eh36yvhoncwYMysg3hCSq9U0lTHrwJfd2PSBJA==
From: Arseniy Krasnov <avkrasnov@rulkc.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oxffffaa@gmail.com,
	rulkc@linuxtesting.org,
	Arseniy Krasnov <avkrasnov@rulkc.org>
Subject: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Date: Fri,  5 Jun 2026 14:53:14 +0300
Message-ID: <20260605115314.552321-1-avkrasnov@rulkc.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Logically it was based on TCP implementation, so to make further
support easier, rewrite it in the TCP way.

Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 2fd9eaaf5ca6..00caeeaa5590 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     struct virtio_vsock_pkt_info *info,
 				     size_t len,
-				     bool zcopy)
+				     bool zcopy, struct ubuf_info *uarg)
 {
 	struct msghdr *msg = info->msg;
 
+	/* We have completion - attach it to 'skb'. */
+	skb_zcopy_set(skb, uarg, NULL);
+
 	if (zcopy)
 		return __zerocopy_sg_from_iter(msg, NULL, skb,
 					       &msg->msg_iter, len, NULL);
@@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 						  u32 src_cid,
 						  u32 src_port,
 						  u32 dst_cid,
-						  u32 dst_port)
+						  u32 dst_port,
+						  struct ubuf_info *uarg)
 {
 	struct vsock_sock *vsk;
 	struct sk_buff *skb;
@@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (info->msg && payload_len > 0) {
 		int err;
 
-		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
+		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy, uarg);
 		if (err)
 			goto out;
 
@@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
 		return pkt_len;
 
-	if (info->msg) {
-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
-		 * there is no MSG_ZEROCOPY flag set.
+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
+		 * handling from 'tcp_sendmsg_locked()'.
 		 */
-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
+		if (info->msg->msg_ubuf) {
+			uarg = info->msg->msg_ubuf;
+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
+						    NULL, false);
+			if (!uarg) {
+				virtio_transport_put_credit(vvs, pkt_len);
+				return -ENOMEM;
+			}
 
-		if (info->msg->msg_flags & MSG_ZEROCOPY)
 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
 
+			if (!can_zcopy)
+				uarg_to_msgzc(uarg)->zerocopy = 0;
+
+			have_uref = true;
+		}
+
+		/* 'can_zcopy' means that this transmission will be
+		 * in zerocopy way (e.g. using 'frags' array).
+		 */
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
 					    (MAX_SKB_FRAGS * PAGE_SIZE));
-
-		if (info->msg->msg_flags & MSG_ZEROCOPY &&
-		    info->op == VIRTIO_VSOCK_OP_RW) {
-			uarg = info->msg->msg_ubuf;
-
-			if (!uarg) {
-				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-							    pkt_len, NULL, false);
-				if (!uarg) {
-					virtio_transport_put_credit(vvs, pkt_len);
-					return -ENOMEM;
-				}
-
-				if (!can_zcopy)
-					uarg_to_msgzc(uarg)->zerocopy = 0;
-
-				have_uref = true;
-			}
-		}
 	}
 
 	rest_len = pkt_len;
@@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
 						 src_cid, src_port,
-						 dst_cid, dst_port);
+						 dst_cid, dst_port, uarg);
 		if (!skb) {
 			ret = -ENOMEM;
 			break;
 		}
 
-		skb_zcopy_set(skb, uarg, NULL);
-
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
@@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 					   le64_to_cpu(hdr->dst_cid),
 					   le32_to_cpu(hdr->dst_port),
 					   le64_to_cpu(hdr->src_cid),
-					   le32_to_cpu(hdr->src_port));
+					   le32_to_cpu(hdr->src_port), NULL);
 	if (!reply)
 		return -ENOMEM;
 
-- 
2.25.1

