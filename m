Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D61C433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 11:07:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D762B6135F
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 11:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D762B6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D902402DC;
	Tue, 20 Apr 2021 11:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8r_wwmgcx50f; Tue, 20 Apr 2021 11:07:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2371840214;
	Tue, 20 Apr 2021 11:07:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B162C000E;
	Tue, 20 Apr 2021 11:07:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9FCC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FCDC40214
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:07:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26P-2p0XPJ8h
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:07:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C1194022C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618916859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1FXQjKbNaNL0tsKFqOzmlYeQlOg2nURcqX1NM0c2SiM=;
 b=jUTSPo4pUabSt4+pdBHlE83t0z41jz1IQs4c1PMsldmUBMvr3uluOUz9WrS8R59kXPplGt
 2rKgXiA34E3qswxnJS6tLlNc8IhkdIJQs4hofkqapxNonmjP10xMWG3iuVT/8tZPgdFzLI
 fL9XO/EekWOATPJwUm8AB0IVVLqpKqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-x_2yPielOtq0wODMkkYNBA-1; Tue, 20 Apr 2021 07:07:35 -0400
X-MC-Unique: x_2yPielOtq0wODMkkYNBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B7028189D2;
 Tue, 20 Apr 2021 11:07:34 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-240.ams2.redhat.com
 [10.36.113.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3BA11002EF0;
 Tue, 20 Apr 2021 11:07:28 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] vsock/virtio: free queued packets when closing socket
Date: Tue, 20 Apr 2021 13:07:27 +0200
Message-Id: <20210420110727.139945-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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

As reported by syzbot [1], there is a memory leak while closing the
socket. We partially solved this issue with commit ac03046ece2b
("vsock/virtio: free packets during the socket release"), but we
forgot to drain the RX queue when the socket is definitely closed by
the scheduled work.

To avoid future issues, let's use the new virtio_transport_remove_sock()
to drain the RX queue before removing the socket from the af_vsock lists
calling vsock_remove_sock().

[1] https://syzkaller.appspot.com/bug?extid=24452624fc4c571eedd9

Fixes: ac03046ece2b ("vsock/virtio: free packets during the socket release")
Reported-and-tested-by: syzbot+24452624fc4c571eedd9@syzkaller.appspotmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++--------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e4370b1b7494..902cb6dd710b 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -733,6 +733,23 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	return t->send_pkt(reply);
 }
 
+/* This function should be called with sk_lock held and SOCK_DONE set */
+static void virtio_transport_remove_sock(struct vsock_sock *vsk)
+{
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	struct virtio_vsock_pkt *pkt, *tmp;
+
+	/* We don't need to take rx_lock, as the socket is closing and we are
+	 * removing it.
+	 */
+	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
+		list_del(&pkt->list);
+		virtio_transport_free_pkt(pkt);
+	}
+
+	vsock_remove_sock(vsk);
+}
+
 static void virtio_transport_wait_close(struct sock *sk, long timeout)
 {
 	if (timeout) {
@@ -765,7 +782,7 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
 		vsk->close_work_scheduled = false;
 
-		vsock_remove_sock(vsk);
+		virtio_transport_remove_sock(vsk);
 
 		/* Release refcnt obtained when we scheduled the timeout */
 		sock_put(sk);
@@ -828,22 +845,15 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
 
 void virtio_transport_release(struct vsock_sock *vsk)
 {
-	struct virtio_vsock_sock *vvs = vsk->trans;
-	struct virtio_vsock_pkt *pkt, *tmp;
 	struct sock *sk = &vsk->sk;
 	bool remove_sock = true;
 
 	if (sk->sk_type == SOCK_STREAM)
 		remove_sock = virtio_transport_close(vsk);
 
-	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
-
 	if (remove_sock) {
 		sock_set_flag(sk, SOCK_DONE);
-		vsock_remove_sock(vsk);
+		virtio_transport_remove_sock(vsk);
 	}
 }
 EXPORT_SYMBOL_GPL(virtio_transport_release);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
