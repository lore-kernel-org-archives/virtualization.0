Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0188C433B4
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:08:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CC8600D4
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CC8600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FB8760B18;
	Mon, 12 Apr 2021 22:08:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJQ80WMPi643; Mon, 12 Apr 2021 22:08:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C84E860B0D;
	Mon, 12 Apr 2021 22:08:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2673C000C;
	Mon, 12 Apr 2021 22:08:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE3DEC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0504404DB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GDivL5AyfFWn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:08:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDF2F40298
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618265304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AGL7wZWdJprmiLe0nt1hRgifCRO5IhlbubiT9W672a0=;
 b=bpV/lPOoRNUq1q731oRrr0c0LCNnAiOl/EFDxClN2EIQvTIIDi2rPms/7i03YFCADXq45y
 LI92LD+BLNmKaQNegNuziIu0oXpwqgAmtmC0eIuhHW9XsDHqZoOd4X2bysr11LXFkiYa4t
 fK0DXKRzf6M75TqWaX7maioe2Qe7W4g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-QuiEk1INPTShJgPZZA0TRQ-1; Mon, 12 Apr 2021 18:08:23 -0400
X-MC-Unique: QuiEk1INPTShJgPZZA0TRQ-1
Received: by mail-wr1-f69.google.com with SMTP id y4so2220592wrs.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 15:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:ccc;
 bh=AGL7wZWdJprmiLe0nt1hRgifCRO5IhlbubiT9W672a0=;
 b=fZmYvCwT//UGOQ8SceqHtbZrXAsZWJeFDKjzPGzMTkPfZcZhTYnN+Z0nIjfS53l/kJ
 SDbZc2F8iIX7xQH4lQunAX2tFuHjKAJjndAv0+qsCVX9MB5YwW7jsgtY8PxMD9qQ+fHp
 SycmHzf8hXXakfMwJYw6anUmSWa4pTYXNWuI7n9BukjxAbhuFE26gc10u66fadGfs1qi
 68anvR0i8jWMWxRzbUyHaERwRA5AGGK3dgq6N+pePMNqYcN/wz/kpXPF5SF/h1VkojBD
 Z+5xxV9UtTtk4G0J4mIiIZmbs6uMOM5JwUznI1v0mnfsBgEToi4SJ1vWVfk6TVmuZ6i4
 yJ0A==
X-Gm-Message-State: AOAM530zSOzXYVMWuM3zw+1ucCg9nqU0OPTiMk681VnfBL+x53rF+453
 Gz+DNqw2ZJZcIU93aIPZC2HHKNUhraQL4hHmK2AdfuL1MZggoSicsjF+qiW3XVXLoc29TRZrn5V
 L0y4of9EQuieK4yh8xGyWee08GriiiVlds7O0vrZmhQ==
X-Received: by 2002:a05:600c:329c:: with SMTP id
 t28mr1073712wmp.74.1618265302062; 
 Mon, 12 Apr 2021 15:08:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQq02VEH0x+yR4nCVseGnJU8z9TNWYz+YkkYnKTZ8stWzkVM0s8+ImnNF6USPPWg4NmHoYgQ==
X-Received: by 2002:a05:600c:329c:: with SMTP id
 t28mr1073698wmp.74.1618265301866; 
 Mon, 12 Apr 2021 15:08:21 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id v7sm17127237wrs.2.2021.04.12.15.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 15:08:19 -0700 (PDT)
Date: Mon, 12 Apr 2021 18:08:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <weiwan@google.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210412180353-mutt-send-email-mst@kernel.org>
References: <20210129002136.70865-1-weiwan@google.com>
MIME-Version: 1.0
In-Reply-To: <20210129002136.70865-1-weiwan@google.com>
Ccc: Eugenio Perez Martin <eperezma@redhat.com>
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

OK I started looking at this again. My idea is simple.
A. disable callbacks before we try to drain skbs
B. actually do disable callbacks even with event idx

To make B not regress, we need to
C. detect the common case of disable after event triggering and skip the write then.

I added a new event_triggered flag for that.
Completely untested - but then I could not see the warnings either.
Would be very much interested to know whether this patch helps
resolve the sruprious interrupt problem at all ...


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 82e520d2cb12..a91a2d6d1ee3 100644
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
index 71e16b53e9c1..213bfe8b6051 100644
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
@@ -1919,6 +1926,14 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	/* If device triggered an event already it won't trigger one again:
+	 * no need to disable.
+	 */
+	if (vq->event_triggered) {
+		vq->event_triggered = false;
+		return;
+	}
+
 	if (vq->packed_ring)
 		virtqueue_disable_cb_packed(_vq);
 	else
@@ -2044,6 +2059,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 	if (unlikely(vq->broken))
 		return IRQ_HANDLED;
 
+	/* Just a hint for performance: so it's ok that this can be racy! */
+	if (vq->event)
+		vq->event_triggered = true;
+
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
 		vq->vq.callback(&vq->vq);
@@ -2083,6 +2102,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
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
