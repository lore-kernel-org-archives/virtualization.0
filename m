Return-Path: <SRS0=8XPq=E2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FE9C56202
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 10:47:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79332206FB
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 10:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXkKSbgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79332206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B6E6386D7D;
	Fri, 20 Nov 2020 10:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eQE7FdeqCJIH; Fri, 20 Nov 2020 10:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1FE7586D65;
	Fri, 20 Nov 2020 10:47:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00275C163C;
	Fri, 20 Nov 2020 10:47:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79017C0891
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 10:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5ADFA86FA5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 10:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nHxszFk64pGc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 10:47:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2B91E86FA2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605869270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FWeqzBmZlLWAnJm9w9KD07ccv+2odS4qEQoYooXswuk=;
 b=cXkKSbgmjG6ii2sVCxbDNQVsJWAsKtm6eOOIpyMOq67WZVdsP4BhDJnPw+blN0ZLQZ+ld0
 bMawmSVwXYWNiomh7rt25XLZ5MIM9ej86nOpPhppKvJP1AW8OYFz+WTSb00O+XtJfynKtd
 94JUYi9jX50rJVOFim6PHR2jBMvR7dM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-z5gMOlHWMvOuFb6u_w9ZmA-1; Fri, 20 Nov 2020 05:47:47 -0500
X-MC-Unique: z5gMOlHWMvOuFb6u_w9ZmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA5A9801B1C;
 Fri, 20 Nov 2020 10:47:45 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-22.ams2.redhat.com
 [10.36.114.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0495F1F0;
 Fri, 20 Nov 2020 10:47:36 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] vsock/virtio: discard packets only when socket is really
 closed
Date: Fri, 20 Nov 2020 11:47:36 +0100
Message-Id: <20201120104736.73749-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jia He <justin.he@arm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Starting from commit 8692cefc433f ("virtio_vsock: Fix race condition
in virtio_transport_recv_pkt"), we discard packets in
virtio_transport_recv_pkt() if the socket has been released.

When the socket is connected, we schedule a delayed work to wait the
RST packet from the other peer, also if SHUTDOWN_MASK is set in
sk->sk_shutdown.
This is done to complete the virtio-vsock shutdown algorithm, releasing
the port assigned to the socket definitively only when the other peer
has consumed all the packets.

If we discard the RST packet received, the socket will be closed only
when the VSOCK_CLOSE_TIMEOUT is reached.

Sergio discovered the issue while running ab(1) HTTP benchmark using
libkrun [1] and observing a latency increase with that commit.

To avoid this issue, we discard packet only if the socket is really
closed (SOCK_DONE flag is set).
We also set SOCK_DONE in virtio_transport_release() when we don't need
to wait any packets from the other peer (we didn't schedule the delayed
work). In this case we remove the socket from the vsock lists, releasing
the port assigned.

[1] https://github.com/containers/libkrun

Fixes: 8692cefc433f ("virtio_vsock: Fix race condition in virtio_transport_recv_pkt")
Cc: justin.he@arm.com
Reported-by: Sergio Lopez <slp@redhat.com>
Tested-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 0edda1edf988..5956939eebb7 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -841,8 +841,10 @@ void virtio_transport_release(struct vsock_sock *vsk)
 		virtio_transport_free_pkt(pkt);
 	}
 
-	if (remove_sock)
+	if (remove_sock) {
+		sock_set_flag(sk, SOCK_DONE);
 		vsock_remove_sock(vsk);
+	}
 }
 EXPORT_SYMBOL_GPL(virtio_transport_release);
 
@@ -1132,8 +1134,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been released before lock_sock */
-	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+	/* Check if sk has been closed before lock_sock */
+	if (sock_flag(sk, SOCK_DONE)) {
 		(void)virtio_transport_reset_no_sock(t, pkt);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
