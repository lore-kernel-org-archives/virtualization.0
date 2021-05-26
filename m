Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBECC4708A
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63A26143E
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63A26143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 757D5605E0;
	Wed, 26 May 2021 08:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4Iv22HJGSol; Wed, 26 May 2021 08:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 037306080C;
	Wed, 26 May 2021 08:24:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B2CC000E;
	Wed, 26 May 2021 08:24:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABD2C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5286403F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PYy-F_EqealG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B4B2401FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQ4VlAVqH25DzMLpMhdVuF4QUuvJ8Qp+k4bIKP2VcN4=;
 b=VbCJBpN5sfVfjhpT6yHTPPLNGbOld9cjVPoWj8oDGuQH01AKHcHD6EVRu2ToO13KBmOGTJ
 MoKHfJhGv2ohFRIVdtaGbMYtEICvHYV6h8/N7d5LT1MBYv0NbAIW9sPg9g2jAREEzDC3ef
 tvF9ldPM9xspWWn1rCNVKMb4JdtDoF0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-AIF2j-__Ng2Q7S_NqbI4Bg-1; Wed, 26 May 2021 04:24:44 -0400
X-MC-Unique: AIF2j-__Ng2Q7S_NqbI4Bg-1
Received: by mail-wr1-f69.google.com with SMTP id
 f19-20020adfb6130000b02901121afc9a31so39963wre.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xQ4VlAVqH25DzMLpMhdVuF4QUuvJ8Qp+k4bIKP2VcN4=;
 b=FPQWPYT8VMB1MUF6BiqpZ5daz6xc3gL7/Zwsqw2+BS7OiUrQ8Wbf507v+Y9eGGNijN
 a1W/kaPZYlZ8eBLNiaB665tFxnyFs1b6npVlTRsUo0fuFF6288BotmKHVrdXodzu5jiG
 ECaUnZC1VsvLDmvJ8XCp78vPKNspexpeEnEBW41dfYKsBys7Hfc6jOCswXgu4yRgKC/l
 6j2O62zv8vDtZqZCtHX+Kz+9oRQClLA5Ov3YFoUHV9NBuVEf60vLUqGOj9AFJ3owCBKT
 QStsVQAUBDClLUT42CjFUNDITphdB07sgV0iU1k0S00eJVSlx3CHF1g/tlTXMq8ni1y2
 54Eg==
X-Gm-Message-State: AOAM530NWVEEdlh68FNmgopkJgCs0lJ0CGaT0KSrfk+rBa0P8jgu66s2
 cLgw0Nk/JnbVOAJH8/ceZ/TaoNw42T/NkYVBrr+dP1gLDsS8Kk7z7TLqNTORbecIqpx9hJcHr9f
 kZtTxjcpzDUXeEfThTY5IQkRvg+UzIpqicnZUnrXQhg==
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr31087414wrx.252.1622017483279; 
 Wed, 26 May 2021 01:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBruCkcm4GOWWMpK9+L6RBQgOo0DFFffIWCQmTsoaoIsXJIdCDaUTvqMzWEVx0KNyBacvMzw==
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr31087397wrx.252.1622017483114; 
 Wed, 26 May 2021 01:24:43 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
 by smtp.gmail.com with ESMTPSA id r7sm5281221wmq.3.2021.05.26.01.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:24:42 -0700 (PDT)
Date: Wed, 26 May 2021 04:24:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] virtio: fix up virtio_disable_cb
Message-ID: <20210526082423.47837-4-mst@redhat.com>
References: <20210526082423.47837-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210526082423.47837-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

virtio_disable_cb is currently a nop for split ring with event index.
This is because it used to be always called from a callback when we know
device won't trigger more events until we update the index.  However,
now that we run with interrupts enabled a lot we also poll without a
callback so that is different: disabling callbacks will help reduce the
number of spurious interrupts.
Further, if using event index with a packed ring, and if being called
from a callback, we actually do disable interrupts which is unnecessary.

Fix both issues by tracking whenever we get a callback. If that is
the case disabling interrupts with event index can be a nop.
If not the case disable interrupts. Note: with a split ring
there's no explicit "no interrupts" value. For now we write
a fixed value so our chance of triggering an interupt
is 1/ring size. It's probably better to write something
related to the last used index there to reduce the chance
even further. For now I'm keeping it simple.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

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
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
