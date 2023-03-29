Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6980DC74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 16:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E49CC41EDA;
	Wed, 29 Mar 2023 16:40:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E49CC41EDA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HWZLCj2N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEo_5PJQIGEJ; Wed, 29 Mar 2023 16:40:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1645941ED3;
	Wed, 29 Mar 2023 16:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1645941ED3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4704C0037;
	Wed, 29 Mar 2023 16:40:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBE0BC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 876DF41ED6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 876DF41ED6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z8Hdxc77O22F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:40:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72FF041ED3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72FF041ED3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680108024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9R4dQgGGlVY8zkY31lqs8u3LNDE0nvPHRAHirYjox8=;
 b=HWZLCj2NQCySXg2UxHohBfyZjkT8JpZK7ydNYDkyocqwyT2cMlSmP5XGiF8U9r3BGHmpNn
 VB5SI8fdZg3iZ7QXlcZ1mvae2pku2FvXQNt0yPm5rB18QgaeGJJjQ3PoFDB3QQO7M1U5MZ
 /IE9WubSe+J8iaE37W1Z2sfacaMM/0w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-cJ4j8lFsNICGyPTG3Vss-A-1; Wed, 29 Mar 2023 12:40:22 -0400
X-MC-Unique: cJ4j8lFsNICGyPTG3Vss-A-1
Received: by mail-wr1-f69.google.com with SMTP id
 u27-20020adfa19b000000b002d3b9266941so1653376wru.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680108021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9R4dQgGGlVY8zkY31lqs8u3LNDE0nvPHRAHirYjox8=;
 b=30uf61ag2BMW/zVeTZsnDVbbvJDM1/pLkupPrFpEBcKhL++wAkV9skJLoMqNqJ3oPB
 gnD7gbrZOoEYo7fpqr2PUVjEetm3OERkAYa7BZnRZ1mm106lZtJcjgoyWY+N8tfrcend
 UZE+7pHPQNDxQ5qnHL037ql5lg187ynbTe5re+uhpXVhbE5tV4GvfzUUNCMqr5pORE7G
 mP5a1ZchQVE52E2wOgdK/9H7KM17vDQR/1/KRqL5RART/GW2xfGhxWyqs2rPFAu2bEQQ
 l53Ez8b839/EkstHUyzunHjpYym3i660DqIc4itqBZihsuzbwIQ6eeTuIs3bISeNgn8U
 HG6A==
X-Gm-Message-State: AAQBX9do1Zvr+OOG5Pj/vQpuoKYVt4wrAc8yet09HwRHWQM3sG2rUk7Y
 H9iYos29HmXUQMTp4/MSl7A1GLVQcevkgbBzA4MZn1yFblvF0lcPVpZAGwkGuuKBrLGcONPybBt
 2fFtAPtckvNH5qoVc8CXZt2DNZ+1gLlccCQ6nIpNBcw==
X-Received: by 2002:adf:d845:0:b0:2d1:a818:6c23 with SMTP id
 k5-20020adfd845000000b002d1a8186c23mr17410925wrl.39.1680108021732; 
 Wed, 29 Mar 2023 09:40:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bQ0LdVLiDEupFUiWeoiSdx+xdmLBgLdlDZ/ocnEGz4nkOZ/HhHR1pPL/wxyNwPMzwhHoc9ww==
X-Received: by 2002:adf:d845:0:b0:2d1:a818:6c23 with SMTP id
 k5-20020adfd845000000b002d1a8186c23mr17410911wrl.39.1680108021447; 
 Wed, 29 Mar 2023 09:40:21 -0700 (PDT)
Received: from redhat.com ([2.52.18.165]) by smtp.gmail.com with ESMTPSA id
 a4-20020adffb84000000b002d322b9a7f5sm30550080wrr.88.2023.03.29.09.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 09:40:21 -0700 (PDT)
Date: Wed, 29 Mar 2023 12:40:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [PATCH v4] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329123959-mutt-send-email-mst@kernel.org>
References: <20230329102300.61000-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230329102300.61000-1-huangjie.albert@bytedance.com>
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

On Wed, Mar 29, 2023 at 06:23:00PM +0800, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This bring more interruptions.
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
> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
> 
> v2->v3:
> -update the interrupt disable flag even with the event_triggered is set,
> -instead of checking whether event_triggered is set in
> -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
> -not called virtqueue_{enable/disable}_cb to miss notifications.
> 
> v3->v4:
> -remove change for
> -"if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)"
> -in virtqueue_disable_cb_packed
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Can you confirm you tested 9p and it still works fine?

> ---
>  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..ec7ab8e04846 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -931,6 +931,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
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
> @@ -1761,6 +1769,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>  
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
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
> @@ -2462,12 +2478,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
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
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
