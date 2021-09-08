Return-Path: <SRS0=3jI9=N6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7BDC433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Sep 2021 11:42:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D7360F92
	for <virtualization@archiver.kernel.org>; Wed,  8 Sep 2021 11:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5D7360F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BABB82F37;
	Wed,  8 Sep 2021 11:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jqcgxcexzHUv; Wed,  8 Sep 2021 11:42:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F9B382A29;
	Wed,  8 Sep 2021 11:42:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC711C0011;
	Wed,  8 Sep 2021 11:42:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7026BC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 11:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 590E240204
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 11:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYeTZ_k5j6tD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 11:42:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50B27400CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631101357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0OKWbveyBp4LK+jfSbX2BcrMPG8lLWS9NwmPSKg8Irs=;
 b=WHnhxyLvxvvemgHKtBLFfJesmYwdrYUyxEas9UCehtO5JbJ6vNHu4E8gxza5Z4kKeoD+lB
 92WFq9nAi3100p/fMADPdBj+7Nz8wGIc++E3S2ptJzPayT6A+H8w4ZdeIZy0FEHISG7U7d
 GohDU6R8dN2Qo6UKRIsSfXLcEA+qADg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-20EbSMTJPlid_wF6ZA4jZg-1; Wed, 08 Sep 2021 07:42:35 -0400
X-MC-Unique: 20EbSMTJPlid_wF6ZA4jZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCCF8835DE0;
 Wed,  8 Sep 2021 11:42:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC24560C17;
 Wed,  8 Sep 2021 11:42:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH] vhost_net: fix OoB on sendmsg() failure.
Date: Wed,  8 Sep 2021 13:42:09 +0200
Message-Id: <463c1b02ca6f65fc1183431d8d85ec8154a2c28e.1631090797.git.pabeni@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

If the sendmsg() call in vhost_tx_batch() fails, both the 'batched_xdp'
and 'done_idx' indexes are left unchanged. If such failure happens
when batched_xdp == VHOST_NET_BATCH, the next call to
vhost_net_build_xdp() will access and write memory outside the xdp
buffers area.

Since sendmsg() can only error with EBADFD, this change addresses the
issue explicitly freeing the XDP buffers batch on error.

Fixes: 0a0be13b8fe2 ("vhost_net: batch submitting XDP buffers to underlayer sockets")
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: my understanding is that this should go through MST's tree, please
educate me otherwise, thanks!
---
 drivers/vhost/net.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3a249ee7e144..28ef323882fb 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -467,7 +467,7 @@ static void vhost_tx_batch(struct vhost_net *net,
 		.num = nvq->batched_xdp,
 		.ptr = nvq->xdp,
 	};
-	int err;
+	int i, err;
 
 	if (nvq->batched_xdp == 0)
 		goto signal_used;
@@ -476,6 +476,15 @@ static void vhost_tx_batch(struct vhost_net *net,
 	err = sock->ops->sendmsg(sock, msghdr, 0);
 	if (unlikely(err < 0)) {
 		vq_err(&nvq->vq, "Fail to batch sending packets\n");
+
+		/* free pages owned by XDP; since this is an unlikely error path,
+		 * keep it simple and avoid more complex bulk update for the
+		 * used pages
+		 */
+		for (i = 0; i < nvq->batched_xdp; ++i)
+			put_page(virt_to_head_page(nvq->xdp[i].data));
+		nvq->batched_xdp = 0;
+		nvq->done_idx = 0;
 		return;
 	}
 
-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
