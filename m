Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8F5C74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 16:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 769E361523;
	Wed, 29 Mar 2023 16:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 769E361523
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4GM0FUN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 196BLj-713gd; Wed, 29 Mar 2023 16:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B214961464;
	Wed, 29 Mar 2023 16:26:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B214961464
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85369C0037;
	Wed, 29 Mar 2023 16:26:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0647AC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C912641D3A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C912641D3A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4GM0FUN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOIezNvZyN2h
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B148F4000B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B148F4000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680107177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1QMeWDDRRF1UyQKkjOF9xaUDyLXaqabC3JIGztQRh24=;
 b=e4GM0FUNw2fXCzdfamsubHZvDgzf0VZUVcEQRrJWXt31IXxxGh4GU3BcG5+BgpW+7jEA2J
 71CTP5qMwZl6FM/4juD4CYJQ37P5GMcN2dT0oiW8DcY2V0UBLzJsBlJ0bH4Or3oZXhCxjR
 +ZFjIvpKKdiOiDKHYMQ3BrmFPCcQ4kE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-ScRA8CBNNsimG2WV3NzNAQ-1; Wed, 29 Mar 2023 12:26:15 -0400
X-MC-Unique: ScRA8CBNNsimG2WV3NzNAQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 o37-20020a05600c512500b003edd119ec9eso8115383wms.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680107174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QMeWDDRRF1UyQKkjOF9xaUDyLXaqabC3JIGztQRh24=;
 b=FUtG9ogqbBxwg5UoKH9TsVfrcmUFmk7Kgrdj/ECnBHPVQI5zHM8569Qp5FJcsPVCbH
 zm+CAXHoV/aZ6BUDXFU9Fv2EDB+WTOV2JRL6oPUQOlyLmwtHS98/pJ36MW5xqUP2jpw0
 jqk+msIVuYYSQRHd+PPtHAEs/oGkIhLpmuqJe1b440i4lI2KgjuKNT8SyBuXHvKKwYVY
 4wCb9VrTe+It91Sa4Ci28ckYDOt2EAW+D8oicTWznwNqyvK9+pASPQZRnS71jvAs6HPi
 kRSFKH6FlrUzGhEqPOZBjLW0Na66OIdqtoq1fyttSaDwJuts3eUHT11UdPcV0t/gpCYc
 h7Vw==
X-Gm-Message-State: AAQBX9dxWK2sWMPSTcEE4A9HR+ikBwyf5+Gore1+3MGXX+1GQiHdq3wU
 l1Ge94lKczrguqNWPPlGfdBR+tBjURXI6RAOmm4LOgnvxFfXtMCYxajwdu4hRVUfgO3H/2UfLpB
 qpnKC8NNwvcdj419+qMfMdy4sYrrplftPX7LSMQnMxQ==
X-Received: by 2002:a7b:c006:0:b0:3ea:fc95:7bf with SMTP id
 c6-20020a7bc006000000b003eafc9507bfmr10207780wmb.30.1680107174531; 
 Wed, 29 Mar 2023 09:26:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZrR1tSknZVZ/c/aJTzooFZR2BKVt06DJ9es+d4wlckyD1UzYVce7RYEdvWTe1HUMX9eAtn8g==
X-Received: by 2002:a7b:c006:0:b0:3ea:fc95:7bf with SMTP id
 c6-20020a7bc006000000b003eafc9507bfmr10207761wmb.30.1680107174161; 
 Wed, 29 Mar 2023 09:26:14 -0700 (PDT)
Received: from redhat.com ([2.52.18.165]) by smtp.gmail.com with ESMTPSA id
 s17-20020a05600c45d100b003ed51cdb94csm2886365wmo.26.2023.03.29.09.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 09:26:13 -0700 (PDT)
Date: Wed, 29 Mar 2023 12:26:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [PATCH v3] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329121354-mutt-send-email-mst@kernel.org>
References: <20230329012908-mutt-send-email-mst@kernel.org>
 <20230329072135.44757-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230329072135.44757-1-huangjie.albert@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ican't parse the subject at all. I think the subject from v2
was fine - we are skipping event index updates on get buf.
Or maybe go higher level and describe the effect of the patch:

virtio_ring: reduce interrupt rate with event idx enabled


On Wed, Mar 29, 2023 at 03:21:35PM +0800, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false.

this last sentence is redundant

> Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This bring more interruptions.

This will bring more interrupts. And pls add space after ".".

> 
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
> 
> To fix:
> update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to vq
> when we call virtqueue_disable_cb even the event_triggered is set to true.

bad grammar here and way too much detail.  better:

	make disable_cb set VRING_AVAIL_F_NO_INTERRUPT or
	VRING_PACKED_EVENT_FLAG_DISABLE in flags shadow to make get_buf
	correctly detect that callbacks are disabled.

> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
>

put changelog after --- please.
 
> v2->v3:
> -update the interrupt disable flag even with the event_triggered is set,
> -instead of checking whether event_triggered is set in
> -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
> -not called virtqueue_{enable/disable}_cb to miss notifications.
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 307e139cb11d..ad74463a48ee 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -812,6 +812,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>  
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		if (vq->event)
>  			/* TODO: this is a hack. Figure out a cleaner value to write. */
>  			vring_used_event(&vq->split.vring) = 0x0;
> @@ -1544,8 +1552,16 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
> +	if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DISABLE)) {


Why are you making this change? It's not great because it
only works because VRING_PACKED_EVENT_FLAG_DISABLE happens
to equal 0x1. does not the patch work with the original
if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)
?

Besides, if you are making unrelated changes commit log should
describe them.

>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		vq->packed.vring.driver->flags =
>  			cpu_to_le16(vq->packed.event_flags_shadow);
>  	}
> @@ -2063,12 +2079,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	/* If device triggered an event already it won't trigger one again:
> -	 * no need to disable.
> -	 */
> -	if (vq->event_triggered)
> -		return;
> -
>  	if (vq->packed_ring)
>  		virtqueue_disable_cb_packed(_vq);
>  	else
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
