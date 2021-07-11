Return-Path: <SRS0=5BC2=MD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E5DC07E9E
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 04:24:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BF8613AE
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 04:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BF8613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B94C7402F6;
	Sun, 11 Jul 2021 04:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yo8-kUrePj4x; Sun, 11 Jul 2021 04:24:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 352314012B;
	Sun, 11 Jul 2021 04:24:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07CFBC001A;
	Sun, 11 Jul 2021 04:24:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6641C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDAB960650
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mv7fetJ3qRpK
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEE056060E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625977446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=02U4tJtEiOM0qkKaodpq8DMAnRGvc/YpIqhPzDDp4BM=;
 b=VSwTbdlxn8dQzwfr8DAMCDF9pyK8sGqOkjo9o7ld0fJyfbbxPe/pYPVlvDwp6aP+e97GWb
 KULnzuT8+eF3FwnHzwOGmxn65Oq5k9yclBueTWMDQyvm4ESsSgmuzq5yeLjqtnjLx6tNoh
 hRKvgdA1yhHQ8Jjp3k7YyL2pG7qX2fg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-xuFWag7hNcmkks4igP9ASw-1; Sun, 11 Jul 2021 00:24:05 -0400
X-MC-Unique: xuFWag7hNcmkks4igP9ASw-1
Received: by mail-ed1-f70.google.com with SMTP id
 da21-20020a0564021775b02903997f7760a6so7765492edb.10
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 21:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=02U4tJtEiOM0qkKaodpq8DMAnRGvc/YpIqhPzDDp4BM=;
 b=RM2KTxKcJtFHg9P7xO/TkYHimXAq9PUTq7hlI4cBzytgYHACTlhpYVaa+J7TNSPjzC
 Ic+HfNwC+RK5WpvNNEqSSXLFVAau2cJu9usfEUna8miuJIVi5OR8K256/ZJvwAccFtae
 2sPylosXirIstoBAJT4pSwCmKH/3yu05bGhkRY8eoWqR+G0vtgVw2UiQJIcsVxOT27og
 9b9EGgBQfq2I4eleZFNaMHBdUHvesLAhmZ7W+3seQAQSBizPJc1HWB3qRZ4sScMFawcU
 5ciWhmmVpeQTisSREidUHLELalsu465bKAnNjWUukR0lSz0+PriXoa6yhIX6sAxMXrw2
 Buvg==
X-Gm-Message-State: AOAM530T3Twls4gnqPqh9nQBWwKE48wUqu1ypNyAD3C45R5RJvN9rDPE
 /Xy+8etfRCSAEeF+HKTk/kodsISJ6ogdADHnsb+fbwv62UoWKST2PNU9KFbkeZMIY68drkCSnyr
 4F6unQ4QgaUFQCGdgEnR5ihF13VVmCQygQxm5CdgTWw==
X-Received: by 2002:a17:907:2067:: with SMTP id
 qp7mr10660534ejb.225.1625977444534; 
 Sat, 10 Jul 2021 21:24:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws63KcGvr+pdP3lOGZXLaXHF/jMHxo99OfYK1sKTi6JsWEKwIv7VTilCS2Xif47SisBKLkUQ==
X-Received: by 2002:a17:907:2067:: with SMTP id
 qp7mr10660506ejb.225.1625977444236; 
 Sat, 10 Jul 2021 21:24:04 -0700 (PDT)
Received: from redhat.com ([2.55.136.76])
 by smtp.gmail.com with ESMTPSA id i11sm5521539edu.97.2021.07.10.21.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jul 2021 21:24:03 -0700 (PDT)
Date: Sun, 11 Jul 2021 00:23:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.12 42/43] virtio: fix up virtio_disable_cb
Message-ID: <20210711002242-mutt-send-email-mst@kernel.org>
References: <20210710234915.3220342-1-sashal@kernel.org>
 <20210710234915.3220342-42-sashal@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210710234915.3220342-42-sashal@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

On Sat, Jul 10, 2021 at 07:49:14PM -0400, Sasha Levin wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> [ Upstream commit 8d622d21d24803408b256d96463eac4574dcf067 ]
> 
> virtio_disable_cb is currently a nop for split ring with event index.
> This is because it used to be always called from a callback when we know
> device won't trigger more events until we update the index.  However,
> now that we run with interrupts enabled a lot we also poll without a
> callback so that is different: disabling callbacks will help reduce the
> number of spurious interrupts.
> Further, if using event index with a packed ring, and if being called
> from a callback, we actually do disable interrupts which is unnecessary.
> 
> Fix both issues by tracking whenever we get a callback. If that is
> the case disabling interrupts with event index can be a nop.
> If not the case disable interrupts. Note: with a split ring
> there's no explicit "no interrupts" value. For now we write
> a fixed value so our chance of triggering an interupt
> is 1/ring size. It's probably better to write something
> related to the last used index there to reduce the chance
> even further. For now I'm keeping it simple.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I am not sure we want this in stable yet. It should in theory
fix the reported interrupt storms but the reporter is on vacation.

> ---
>  drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..88f0b16b11b8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -113,6 +113,9 @@ struct vring_virtqueue {
>  	/* Last used index we've seen. */
>  	u16 last_used_idx;
>  
> +	/* Hint for event idx: already triggered no need to disable. */
> +	bool event_triggered;
> +
>  	union {
>  		/* Available for split ring */
>  		struct {
> @@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>  
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> +		if (vq->event)
> +			/* TODO: this is a hack. Figure out a cleaner value to write. */
> +			vring_used_event(&vq->split.vring) = 0x0;
> +		else
>  			vq->split.vring.avail->flags =
>  				cpu_to_virtio16(_vq->vdev,
>  						vq->split.avail_flags_shadow);
> @@ -1605,6 +1611,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->packed_ring = true;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
> @@ -1919,6 +1926,12 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	/* If device triggered an event already it won't trigger one again:
> +	 * no need to disable.
> +	 */
> +	if (vq->event_triggered)
> +		return;
> +
>  	if (vq->packed_ring)
>  		virtqueue_disable_cb_packed(_vq);
>  	else
> @@ -1942,6 +1955,9 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (vq->event_triggered)
> +		vq->event_triggered = false;
> +
>  	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
>  				 virtqueue_enable_cb_prepare_split(_vq);
>  }
> @@ -2005,6 +2021,9 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (vq->event_triggered)
> +		vq->event_triggered = false;
> +
>  	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
>  				 virtqueue_enable_cb_delayed_split(_vq);
>  }
> @@ -2044,6 +2063,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  	if (unlikely(vq->broken))
>  		return IRQ_HANDLED;
>  
> +	/* Just a hint for performance: so it's ok that this can be racy! */
> +	if (vq->event)
> +		vq->event_triggered = true;
> +
>  	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>  	if (vq->vq.callback)
>  		vq->vq.callback(&vq->vq);
> @@ -2083,6 +2106,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
>  #ifdef DEBUG
> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
