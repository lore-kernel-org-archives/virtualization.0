Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D2EC74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 16:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC3FB61516;
	Wed, 29 Mar 2023 16:36:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC3FB61516
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVI51Qot
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ov0XtzVfH94X; Wed, 29 Mar 2023 16:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B161614B4;
	Wed, 29 Mar 2023 16:36:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B161614B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A50AC0037;
	Wed, 29 Mar 2023 16:36:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8500FC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 535588417C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 535588417C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVI51Qot
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uAinYpuPw_8l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 512928417A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 512928417A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680107808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldMAeFakoVxongrnXNG07Qemx9ue6UmllaaxOMmybkQ=;
 b=cVI51QotQMAOPNVLuZiOThk8TSBmCRchz5J/ED5AZZF3kItdNiVI+h7eCdVaMIQDck+OUB
 MY/2GHIGjK9eaGXbkc80UHV1l4csrUSMFdZenCsKQ1cTnHRPj7fepRnNchId5OS8kErOZd
 tUL6QJipt4nOYKxALP1dljyQF+bArEY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-KSu6TbhKOHO1OZoyQlM5Jg-1; Wed, 29 Mar 2023 12:36:46 -0400
X-MC-Unique: KSu6TbhKOHO1OZoyQlM5Jg-1
Received: by mail-wr1-f69.google.com with SMTP id
 j17-20020adfb311000000b002d660153278so1683061wrd.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680107806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldMAeFakoVxongrnXNG07Qemx9ue6UmllaaxOMmybkQ=;
 b=JXTfoPZf1LmBjD9ym4sFHOkAbnJrzFJual1ikGtR4sb28zXNdQaIrWfJmZ2yf6frE+
 iYPJQYP+OTi7gMFOp5fM0OaPF7GQpENvymfhyXMIa+jx6WXwQ7//0+L8HjBJQvbSbXyY
 VmDtQQmdZStYOFvIk/upS3cgMo7vr/7B1mpE++O8AijGK+bmcS7fkKhFtGz4MF0una76
 hTQ1RaOMMYpr+2Ut+LimTamx1jIyrT2PIQlMrwIHQJLlWv1zaTi95K89f0h4sQgyxxbo
 1+wl92n1HlFR4BLCxZeK4KetRtbC9Fkk6/IjLH5jtua3sf6gSz0z0iS+OJVuW9cVg311
 NduQ==
X-Gm-Message-State: AAQBX9fGBOgy6HvYMYXbM889nk/advX1qE5eGhxZpFGDxUAYU9P4zjhY
 AGQFMDrMaKydN3BJC51VZl05zt3xgxbBcVankx6+dU3vit2w+4T1WO6mGwx4Ms6yh5EwkC/5BMP
 bBWRRqfCPdBh69n6s6MoR/d5+VcHF7YqOzd/iPGIOiw==
X-Received: by 2002:adf:decf:0:b0:2cf:f30f:cc04 with SMTP id
 i15-20020adfdecf000000b002cff30fcc04mr14240679wrn.27.1680107805854; 
 Wed, 29 Mar 2023 09:36:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z5BstaP0SIWlL7B+yT9cBx93Rz7ef9lbximjW91GJq3IF02TSPgsvVmlwSCFY8rhw/kJXS8w==
X-Received: by 2002:adf:decf:0:b0:2cf:f30f:cc04 with SMTP id
 i15-20020adfdecf000000b002cff30fcc04mr14240665wrn.27.1680107805520; 
 Wed, 29 Mar 2023 09:36:45 -0700 (PDT)
Received: from redhat.com ([2.52.18.165]) by smtp.gmail.com with ESMTPSA id
 v7-20020a5d4b07000000b002c56af32e8csm30386163wrq.35.2023.03.29.09.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 09:36:45 -0700 (PDT)
Date: Wed, 29 Mar 2023 12:36:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [PATCH v4] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329123444-mutt-send-email-mst@kernel.org>
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

Patch is ok so I rewrote the commit log and applied.
Please do not add signed-off-by tags by others -
read up what this tag means.
I also rewrote your Signed-off-by to have your name
formatted same as in email - hope that is ok.


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
