Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E0175A9F
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jun 2026 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782670885; cv=none; b=TKU4T9GXTNKe7enCt3D9YZ4brRoO5oHPGaAZqsfNaUyg7vlkh0Er3mbrJQjZYgbZiYk6nwbzELSlhyae0vgeq8n+EpdsE5SROodkdQW3ZP06mQ1p2t2wwGdrJ7xXVV4f76FkaCwlRN9DqvMaP+K+on3YCN9KT/KWNjd5UzgnOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782670885; c=relaxed/simple;
	bh=6ecvcZZwIGW0WNu/LrNgER3uaYd3SAlzeBRoHgs8h/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+8Az8Oj3tQgBa+9wEMMS0o229h1eIATOr773cvt7mNuZkyHxJUMJ8fOz53AoaPaELq2WvSywZBukmb0I18ONyhvV6jeRwY4k99HTH1LqU7IPJQ0eaoZ4fWlUwvFsllrdsdu9iLVy/VegtrQSccgZdjPKT+71yKPXpvwIPj3kEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=JOsp50a1; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="JOsp50a1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1FB1740063
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jun 2026 18:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ovf-ON_pe2dm for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jun 2026 18:21:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=155.212.184.193; helo=mail.rulkc.org; envelope-from=avkrasnov@rulkc.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6DAE640050
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DAE640050
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rulkc.org header.i=@rulkc.org header.a=rsa-sha256 header.s=dkim header.b=JOsp50a1
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DAE640050
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jun 2026 18:21:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0396510046F;
	Sun, 28 Jun 2026 21:21:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1782670875; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ybx06QVngD4wXg30CBktfaC6csvkv2GtKhVcyiALC80=;
	b=JOsp50a1CfK0tIu32RlCpNbhKSHUAEX4Qgt6xM9TUtrxWmIRE+1Pza+t/J2T5YzYVvEXVL
	d7iV7YGmPdQ26f7NhV+ASX+F7V7dCQ3aXEDFZolYadcjNzeWB9swYY+LpVbZ2TXeGoF90O
	PoszX9e5GtAuMja7xYHTwksaTlza2eOfrN5b38A3yQxoNQvXjDI3wz3bxCQijWFmZSJJNj
	BqkrbKQoS+44R1HkHlDUVrtXgkJ0BJvUXLc3AJzbQnSq2XNXvdmkwgcTCZymd55zZsCrwE
	YO8FMzzfF/C9EUW/WL9vQJeE8pufrThJX5KA1VxuaCUShYmmhWrIc4GSDzI0kQ==
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
Subject: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag handling
Date: Sun, 28 Jun 2026 21:20:52 +0300
Message-ID: <20260628182052.951760-1-avkrasnov@rulkc.org>
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
easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
this way, patch also adds handling case when 'msg_ubuf' is already set.

Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 Changelog v1->v2:
 * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
   already added.
 Changelog v2->v3:
 * Update commit message.
 * Remove one empty line.
 Changelog v3->v4:
 * Update commit message.

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

