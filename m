Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15601C4332F
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 07:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94D6F40382;
	Mon, 26 Dec 2022 07:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94D6F40382
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DBzRbco0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iiMFvcYSKx-9; Mon, 26 Dec 2022 07:49:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6B344035B;
	Mon, 26 Dec 2022 07:49:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6B344035B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1847C0035;
	Mon, 26 Dec 2022 07:49:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E633C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF2044035B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF2044035B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mCepnsysfP0d
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0502D40360
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0502D40360
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672040972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35zLZwgpZzPWsmc0E40bJzgqya6RhlIevYxkApG1GCU=;
 b=DBzRbco0EgAM90xjs1JiGkmIIcnWSJPsm1E2bR6tmv9xXt8elXiVZHjrpEAWIPXCLKDV2X
 wFFJv+PXJcytm09t76ribPsymc9A9OaF5/oGzi4BveDwdlhVLazqTlpbNS/pGGzOKEJAKn
 Y6QVq0gH+zAg5BxquizJ2xvzZP8aZE8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-Sn-ZY8cfO-CI_5uqf-CTGg-1; Mon, 26 Dec 2022 02:49:26 -0500
X-MC-Unique: Sn-ZY8cfO-CI_5uqf-CTGg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5DCC380406F;
 Mon, 26 Dec 2022 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-100.pek2.redhat.com
 [10.72.13.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E0B9492B00;
 Mon, 26 Dec 2022 07:49:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/4] virtio_ring: switch to use BAD_RING()
Date: Mon, 26 Dec 2022 15:49:06 +0800
Message-Id: <20221226074908.8154-3-jasowang@redhat.com>
In-Reply-To: <20221226074908.8154-1-jasowang@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

Switch to reuse BAD_RING() to allow common logic to be implemented in
BAD_RING().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- switch to use BAD_RING in virtio_break_device()
---
 drivers/virtio/virtio_ring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689bb933b..5cfb2fa8abee 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -58,7 +58,8 @@
 	do {							\
 		dev_err(&_vq->vq.vdev->dev,			\
 			"%s:"fmt, (_vq)->vq.name, ##args);	\
-		(_vq)->broken = true;				\
+		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
+		WRITE_ONCE((_vq)->broken, true);		       \
 	} while (0)
 #define START_USE(vq)
 #define END_USE(vq)
@@ -2237,7 +2238,7 @@ bool virtqueue_notify(struct virtqueue *_vq)
 
 	/* Prod other side to tell it about changes. */
 	if (!vq->notify(_vq)) {
-		vq->broken = true;
+		BAD_RING(vq, "vq %d is broken\n", vq->vq.index);
 		return false;
 	}
 	return true;
@@ -2786,8 +2787,7 @@ void virtio_break_device(struct virtio_device *dev)
 	list_for_each_entry(_vq, &dev->vqs, list) {
 		struct vring_virtqueue *vq = to_vvq(_vq);
 
-		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
-		WRITE_ONCE(vq->broken, true);
+		BAD_RING(vq, "Device break vq %d", _vq->index);
 	}
 	spin_unlock(&dev->vqs_list_lock);
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
