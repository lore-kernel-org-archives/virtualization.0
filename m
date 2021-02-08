Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E2CC433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 14:45:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878EA64E6F
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 14:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878EA64E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E73985A0E;
	Mon,  8 Feb 2021 14:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_zkltmdhg_3; Mon,  8 Feb 2021 14:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E13E83608;
	Mon,  8 Feb 2021 14:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E335C0891;
	Mon,  8 Feb 2021 14:45:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7423CC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 14:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5CAE6204F8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 14:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4KAPS5916qKN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 14:45:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 8DC962010B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612795510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wDyz1IFDSEAOIerG7E7i9OIec2MQQzh/7MUoQ35aflI=;
 b=cFb32JV560wVXBz9LG6xx0n0qngVWx8faTQEVacBMhRwbAQiStTiwthcz8gUOzm1wjhDkE
 4VmZ5tkZjhRZtU7fk6Y//c9b2yvE51t++wFDf011Jp+Rdxa91L2Y9UjobBc0AGk5GiBNd0
 3OgtyKFMZhe14vx/ZEXRP8SAXJYvROc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-h0NjNB0VO72XsLi_FX5LlQ-1; Mon, 08 Feb 2021 09:45:08 -0500
X-MC-Unique: h0NjNB0VO72XsLi_FX5LlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC11801975;
 Mon,  8 Feb 2021 14:45:07 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-25.ams2.redhat.com
 [10.36.115.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2FBD5D740;
 Mon,  8 Feb 2021 14:44:55 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: kuba@kernel.org
Subject: [PATCH net] vsock/virtio: update credit only if socket is not closed
Date: Mon,  8 Feb 2021 15:44:54 +0100
Message-Id: <20210208144454.84438-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Asias He <asias@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
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

If the socket is closed or is being released, some resources used by
virtio_transport_space_update() such as 'vsk->trans' may be released.

To avoid a use after free bug we should only update the available credit
when we are sure the socket is still open and we have the lock held.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 5956939eebb7..e4370b1b7494 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1130,8 +1130,6 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	vsk = vsock_sk(sk);
 
-	space_available = virtio_transport_space_update(sk, pkt);
-
 	lock_sock(sk);
 
 	/* Check if sk has been closed before lock_sock */
@@ -1142,6 +1140,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
+	space_available = virtio_transport_space_update(sk, pkt);
+
 	/* Update CID in case it has changed after a transport reset event */
 	vsk->local_addr.svm_cid = dst.svm_cid;
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
