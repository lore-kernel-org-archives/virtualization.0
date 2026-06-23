Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78352EBB8C
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jun 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229128; cv=none; b=AU8oWufuNmP6ejcuJ4D/3oG1jR1G/y2Td1/rGDK5oXL/GGu2bUj4e3VmRzVLUu3Nbzam38N6+zmoqOIYfsGnvYOdoXPBLkegAHeSV3VVWVFsAdjReShjdxLzVktZqBFBRM5ml/fJR/SIbC7AITqX2aLVvA4RQTuBZcqbbYoLEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229128; c=relaxed/simple;
	bh=0kvOTvkPfdgHJq48ZLpEUHjQXNHEN0MuEIkkH+qd6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfLgfYUd09juCb+M/q2wQqXMAkKC2Rxf2+M6OIVbRPfYVUAxydZL7nKUPjB/5Guf7HB9awLVSJMHD7p/IZqQ10JG7DMCCrhG9HCcU/SL7+zs/xe6XpCJ/qaK5Vx3+EAkqbc39Cv/cEiFyQdI9TZQpP8PBXXwcgNgVuLQGeEgYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=A3wBmxCL; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="A3wBmxCL"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FCB18174F
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jun 2026 15:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XaKVmzxhwQs6 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jun 2026 15:38:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=155.212.184.193; helo=mail.rulkc.org; envelope-from=avkrasnov@rulkc.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9CFB7814C9
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CFB7814C9
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rulkc.org header.i=@rulkc.org header.a=rsa-sha256 header.s=dkim header.b=A3wBmxCL
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9CFB7814C9
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jun 2026 15:38:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54D711004A8;
	Tue, 23 Jun 2026 18:38:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1782229119; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=PfEenKZjBI4EpzXWng3bhv/OXzG/I245ZxmhnzWWya8=;
	b=A3wBmxCLsQbFz4BH6RjoZQqyB5LquYDs7fZl1lx9k5t459RxcsQcc+Ldn22kH3gT4nN2WP
	JScLTH5CSh/dUBHIL3w4X9dpUcHmbe3oBF/wqagRmDsvpsb13ouf4JiKu8etTClasb6ZCM
	0FlJpWmoA6RQ/GeODFQvinjHFvC/MBVzgrEROAIJgCorJkj/a1CtVgqlRzUkxR9VV6bQMR
	kxedfUiNKAlv/zfbVrjdLqnTpuj05AwQM5sX7nyHNfa9K5d/yeC60RWqfvUmNEcHYclci/
	ZzauI6oajl91xYXskJC+azl/KK9jeIYR/4qOuas4TgmqPlTjKs0FNWU2ktDJ2A==
From: Arseniy Krasnov <avkrasnov@rulkc.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
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
Subject: [PATCH net-next v3] vsock/virtio: rewrite MSG_ZEROCOPY flag handling
Date: Tue, 23 Jun 2026 18:38:19 +0300
Message-ID: <20260623153819.697635-1-avkrasnov@rulkc.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Logically it was based on TCP implementation, so to make further support
easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). This
patch only rewrites flag handling (e.g. it doesn't change logic).

Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 Changelog v1->v2:
 * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
   already added.
 Changelog v2->v3:
 * Update commit message.
 * Remove one empty line.

 net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 09475007165b..41c2a0b82a8e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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
-- 
2.25.1

