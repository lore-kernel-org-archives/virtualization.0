Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30EC48BE8
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 13:36:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAA2613FB
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 13:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAA2613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 477FD83BF0;
	Fri, 18 Jun 2021 13:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0sARG2pOMsP1; Fri, 18 Jun 2021 13:36:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EAB6583B89;
	Fri, 18 Jun 2021 13:36:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C235EC000D;
	Fri, 18 Jun 2021 13:36:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB1FFC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A69E4020E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E9hgnRmugwl2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:36:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E93B8401EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624023358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFwIb7IPOZRbP1IQ9mV70O4nT0A/GjnYdmBaTej5bMs=;
 b=RaRIQ3UCXtS9EM0rBCx5X/A/jead77kOXkU2ocQwROOktwYZix3fLpnTIDjp4zMG1t9FeU
 H+tU3fW5czb1MRjHgMm7whhqlUfuxfTkhrSfQ31zyxZMjIjbnsa6dhPuuCphoWei0Ay+XA
 k++SlRSC74v4x5twNpQMJlOmDFhgufQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-12QN6s9jMYqyi6bKQyOXnw-1; Fri, 18 Jun 2021 09:35:55 -0400
X-MC-Unique: 12QN6s9jMYqyi6bKQyOXnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B98A8100C666;
 Fri, 18 Jun 2021 13:35:53 +0000 (UTC)
Received: from steredhat.lan (ovpn-115-127.ams2.redhat.com [10.36.115.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B17261000324;
 Fri, 18 Jun 2021 13:35:47 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] vsock/virtio: remove redundant `copy_failed`
 variable
Date: Fri, 18 Jun 2021 15:35:26 +0200
Message-Id: <20210618133526.300347-4-sgarzare@redhat.com>
In-Reply-To: <20210618133526.300347-1-sgarzare@redhat.com>
References: <20210618133526.300347-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
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

When memcpy_to_msg() fails in virtio_transport_seqpacket_do_dequeue(),
we already set `dequeued_len` with the negative error value returned
by memcpy_to_msg().

So we can directly check `dequeued_len` value instead of using a
dedicated flag variable to skip the copy path for the rest of
fragments.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 23704a6bc437..f014ccfdd9c2 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -413,7 +413,6 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 	struct virtio_vsock_pkt *pkt;
 	int dequeued_len = 0;
 	size_t user_buf_len = msg_data_left(msg);
-	bool copy_failed = false;
 	bool msg_ready = false;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -426,7 +425,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 	while (!msg_ready) {
 		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
 
-		if (!copy_failed) {
+		if (dequeued_len >= 0) {
 			size_t pkt_len;
 			size_t bytes_to_copy;
 
@@ -443,11 +442,9 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 
 				err = memcpy_to_msg(msg, pkt->buf, bytes_to_copy);
 				if (err) {
-					/* Copy of message failed, set flag to skip
-					 * copy path for rest of fragments. Rest of
+					/* Copy of message failed. Rest of
 					 * fragments will be freed without copy.
 					 */
-					copy_failed = true;
 					dequeued_len = err;
 				} else {
 					user_buf_len -= bytes_to_copy;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
