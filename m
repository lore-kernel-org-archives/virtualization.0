Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9A5C3DA78
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 03:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAB2B40BD3;
	Tue, 17 Jan 2023 03:47:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAB2B40BD3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U8flMJLa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jsic_qVlMfGj; Tue, 17 Jan 2023 03:47:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D357403E5;
	Tue, 17 Jan 2023 03:47:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D357403E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49CF4C0033;
	Tue, 17 Jan 2023 03:47:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09F38C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFF6F81FBB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:47:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFF6F81FBB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U8flMJLa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXwcwWFFgBuG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:47:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22F9081FB2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22F9081FB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673927247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=90WVwCZHiyeI3L+ZIDFVaep8HNaYc9xGptfBX2i+B+U=;
 b=U8flMJLaM8v04ZBr3YlsiBu7j1/ra/EY2YBOb7A6Roj3SWcA/lG+oR24cnf2UWDTLnRbsk
 TuV8ekThbXqjEiFEbb1EuV+He9GV6Ox4disz8Y5S5vAfOnczfzEPb/lw5VL/QrM5EaR6r0
 Sm9GU0k7D2QjF85nzCkyLs/9Dh8uxwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-Xfu7N253NMu8rBvYODjSUw-1; Mon, 16 Jan 2023 22:47:17 -0500
X-MC-Unique: Xfu7N253NMu8rBvYODjSUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4452B858F09;
 Tue, 17 Jan 2023 03:47:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-215.pek2.redhat.com
 [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 571522166B26;
 Tue, 17 Jan 2023 03:47:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH net V3] virtio-net: correctly enable callback during start_xmit
Date: Tue, 17 Jan 2023 11:47:07 +0800
Message-Id: <20230117034707.52356-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: lvivier@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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
		if (use_napi)
			virtqueue_disable_cb(sq->vq);

		free_old_xmit_skbs(sq, false);

	} while (use_napi && kick &&
               unlikely(!virtqueue_enable_cb_delayed(sq->vq)));

When NAPI is used and kick is false, the callback won't be enabled
here. And when the virtqueue is about to be full, the tx will be
disabled, but we still don't enable tx interrupt which will cause a TX
hang. This could be observed when using pktgen with burst enabled.

TO be consistent with the logic that tries to disable cb only for
NAPI, fixing this by trying to enable delayed callback only when NAPI
is enabled when the queue is about to be full.

Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
The patch is needed for -stable.
Changes since V2:
- try to enabled delayed callback and schedule NAPI instead of try to
  poll as when TX NAPI is disabled
Changes since V1:
- enable tx interrupt after we disable TX
---
 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8e..18b3de854aeb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1877,8 +1877,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
 		netif_stop_subqueue(dev, qnum);
-		if (!use_napi &&
-		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
+		if (use_napi) {
+			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
+				virtqueue_napi_schedule(&sq->napi, sq->vq);
+		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
 			free_old_xmit_skbs(sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
