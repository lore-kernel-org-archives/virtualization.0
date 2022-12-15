Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8B1C4332F
	for <virtualization@archiver.kernel.org>; Thu, 15 Dec 2022 03:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC94781FB5;
	Thu, 15 Dec 2022 03:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC94781FB5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OkxoJDg1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bC_zoB_u5DiM; Thu, 15 Dec 2022 03:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B0B7B81FAD;
	Thu, 15 Dec 2022 03:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0B7B81FAD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79E1BC0032;
	Thu, 15 Dec 2022 03:27:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10ED2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 03:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC53341881
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 03:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC53341881
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OkxoJDg1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOO4Ij6-DfI5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 03:27:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 546B64006C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 546B64006C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 03:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671074855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PymI4q7qNfGWX3YIwL6NoS6LPNMzpnl2I9EurJsvLII=;
 b=OkxoJDg19C+J0xqjjUAD4LFSlCwHy718gVr2UeXgFpEwrU+0Y1hEJGLTSSVCSklxXuLQq2
 oSqGCQ5i4WYnDMlAgaSXEOA5aoZYjCVkXctAgYKKHc+cIQXixEacRBeCvPuDA3jbptlMTl
 6nQquf2ACxjNFV/Ex87jg4TbKmTm8no=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-kma6sXGIOKKmlWPHWJxdxw-1; Wed, 14 Dec 2022 22:27:32 -0500
X-MC-Unique: kma6sXGIOKKmlWPHWJxdxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47D081C02D47;
 Thu, 15 Dec 2022 03:27:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-112.pek2.redhat.com
 [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18DC1C15BA0;
 Thu, 15 Dec 2022 03:27:21 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: [PATCH net V2] virtio-net: correctly enable callback during start_xmit
Date: Thu, 15 Dec 2022 11:27:19 +0800
Message-Id: <20221215032719.72294-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
virtqueue callback via the following statement:

        do {
           ......
	} while (use_napi && kick &&
               unlikely(!virtqueue_enable_cb_delayed(sq->vq)));

When NAPI is used and kick is false, the callback won't be enabled
here. And when the virtqueue is about to be full, the tx will be
disabled, but we still don't enable tx interrupt which will cause a TX
hang. This could be observed when using pktgen with burst enabled.

Fixing this by trying to enable tx interrupt after we disable TX when
we're not using napi or kick is false.

Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
The patch is needed for -stable.
Changes since V1:
- enable tx interrupt after we disable tx
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 86e52454b5b5..dcf3a536d78a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
 		netif_stop_subqueue(dev, qnum);
-		if (!use_napi &&
+		if ((!use_napi || !kick) &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
 			free_old_xmit_skbs(sq, false);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
