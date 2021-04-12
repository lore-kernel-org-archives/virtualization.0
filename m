Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B77C433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:33:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE2161358
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE2161358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAF4983DAE;
	Mon, 12 Apr 2021 22:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYnBbb_zAE5x; Mon, 12 Apr 2021 22:33:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DFC383DAB;
	Mon, 12 Apr 2021 22:33:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27596C000B;
	Mon, 12 Apr 2021 22:33:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F0D1C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1D87605DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KvyUyHc7EBQG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:33:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18E30605C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618266831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kDYC/0JEgwH/dQyAoKRIGlbZ//2y9RqMa3XQD3efgMY=;
 b=NGk1iL2Vh8v3fLQOHJiUqvZszsATTCc8BeG5owW9SvspkiHkssvUH45pvtOouB2V2kk1Ci
 p8rcCcw5OEncfhMFQAdd9xz0NiF7W960NZzLWZXIFLdaWYPGUdjl6FMVdqnGHlclq4aMiB
 9PNwRUUIaDxEzefu8qtTKjd/gQFEv2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-4siW00cpOEeA6FXC1-LAdw-1; Mon, 12 Apr 2021 18:33:50 -0400
X-MC-Unique: 4siW00cpOEeA6FXC1-LAdw-1
Received: by mail-wm1-f70.google.com with SMTP id
 t83-20020a1cc3560000b029011f8f517694so276395wmf.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 15:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kDYC/0JEgwH/dQyAoKRIGlbZ//2y9RqMa3XQD3efgMY=;
 b=Q2nLTSQLQNA6aHjEu9BNsmhrmyab3ETqwCL9esC6gIKQdGEWdPP9CxTzzXJFYr67kI
 3d4WJprKnSHwTHbFSiuLGxl6ymBI0Jgopof/vDKxVNKfNY64aTA/55IADR37H+UejGEP
 S67VI7wxVbqmGhyxumVFklhPoOh/fiA37yFSqOjpmv8eAi4NRLMrDpduTRV9mF08muJw
 iSneTTul2K3VPvba3S4C95SBIMfLUxqnsMVmAs8c9y9n7Gyk4zbhJn4DyV46dn634yS3
 SlBBQc4ukAI74G3unDCIbYx3tzLYfgpxy1X2gBJPnIN8QDN9q++xJ7Fkj5XoWeH0IE3d
 /MIA==
X-Gm-Message-State: AOAM5317qGj5M6xdOVv5mzwdT+ufus7qoAztvonbQSqMaql3chN7o2n/
 gvJvu/lCAVmfRyKLKNOLAYXx36MMfs8sFWadtrnCMVMq/8ndiX8o+6Y5+8zeUOyV9QID4R7CVqQ
 pWlq2tHclttCA39dVYzIYZmBat0LN6fvxTHaKB26BZQ==
X-Received: by 2002:adf:df0a:: with SMTP id y10mr19746095wrl.246.1618266829124; 
 Mon, 12 Apr 2021 15:33:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuanvU3G286FyJLWeBqftN6+/9ZmG2RjPQ17fFEUGiVXPjlB6KaubOAPuXTHof1g4G0gV/JQ==
X-Received: by 2002:adf:df0a:: with SMTP id y10mr19746080wrl.246.1618266828954; 
 Mon, 12 Apr 2021 15:33:48 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id j6sm609841wmq.16.2021.04.12.15.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 15:33:48 -0700 (PDT)
Date: Mon, 12 Apr 2021 18:33:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <weiwan@google.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210412183141-mutt-send-email-mst@kernel.org>
References: <20210129002136.70865-1-weiwan@google.com>
 <20210412180353-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210412180353-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
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

On Mon, Apr 12, 2021 at 06:08:21PM -0400, Michael S. Tsirkin wrote:
> OK I started looking at this again. My idea is simple.
> A. disable callbacks before we try to drain skbs
> B. actually do disable callbacks even with event idx
> 
> To make B not regress, we need to
> C. detect the common case of disable after event triggering and skip the write then.
> 
> I added a new event_triggered flag for that.
> Completely untested - but then I could not see the warnings either.
> Would be very much interested to know whether this patch helps
> resolve the sruprious interrupt problem at all ...
> 
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hmm a slightly cleaner alternative is to clear the flag when enabling interrupts ...
I wonder which cacheline it's best to use for this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 82e520d2cb12..c23341b18eb5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1429,6 +1429,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
+		virtqueue_disable_cb(vq);
 		free_old_xmit_skbs(sq, true);
 		__netif_tx_unlock(txq);
 	}
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b53e9c1..88f0b16b11b8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -113,6 +113,9 @@ struct vring_virtqueue {
 	/* Last used index we've seen. */
 	u16 last_used_idx;
 
+	/* Hint for event idx: already triggered no need to disable. */
+	bool event_triggered;
+
 	union {
 		/* Available for split ring */
 		struct {
@@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
+		if (vq->event)
+			/* TODO: this is a hack. Figure out a cleaner value to write. */
+			vring_used_event(&vq->split.vring) = 0x0;
+		else
 			vq->split.vring.avail->flags =
 				cpu_to_virtio16(_vq->vdev,
 						vq->split.avail_flags_shadow);
@@ -1605,6 +1611,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->packed_ring = true;
 	vq->use_dma_api = vring_use_dma_api(vdev);
@@ -1919,6 +1926,12 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	/* If device triggered an event already it won't trigger one again:
+	 * no need to disable.
+	 */
+	if (vq->event_triggered)
+		return;
+
 	if (vq->packed_ring)
 		virtqueue_disable_cb_packed(_vq);
 	else
@@ -1942,6 +1955,9 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (vq->event_triggered)
+		vq->event_triggered = false;
+
 	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
 				 virtqueue_enable_cb_prepare_split(_vq);
 }
@@ -2005,6 +2021,9 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (vq->event_triggered)
+		vq->event_triggered = false;
+
 	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
 				 virtqueue_enable_cb_delayed_split(_vq);
 }
@@ -2044,6 +2063,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 	if (unlikely(vq->broken))
 		return IRQ_HANDLED;
 
+	/* Just a hint for performance: so it's ok that this can be racy! */
+	if (vq->event)
+		vq->event_triggered = true;
+
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
 		vq->vq.callback(&vq->vq);
@@ -2083,6 +2106,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 #ifdef DEBUG

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
