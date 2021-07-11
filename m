Return-Path: <SRS0=5BC2=MD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2AEC07E9B
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 04:24:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825E6613AB
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 04:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825E6613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DCDD40536;
	Sun, 11 Jul 2021 04:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCyY16LNY7gE; Sun, 11 Jul 2021 04:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 795044050D;
	Sun, 11 Jul 2021 04:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5182EC001A;
	Sun, 11 Jul 2021 04:24:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 941F6C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82D2160650
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cAqUNfPdSSsx
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B413E6060E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 04:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625977493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZYL5aYn0xhNCuQJ4VSpLl42cD0uGgHWKGK+S3b+4Xw=;
 b=cngJLw/A1N13PH08P/KAR/BG3PazcuyO0ZUJSWxZtuldlFt/oEmE2CAaG+y74BL973dOxg
 owTpDpj5E3pdZraDh2Sqgr/GCtPsh7AMqustpkdjQjBZMilbUGE+X+eTf/PSrHWoRXpbKT
 6RF+ARTbFmXtI78w7I2CqkH3RYV9X4Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-NWqPhOlxP6KB5xNocNL4cA-1; Sun, 11 Jul 2021 00:24:51 -0400
X-MC-Unique: NWqPhOlxP6KB5xNocNL4cA-1
Received: by mail-ed1-f69.google.com with SMTP id
 w1-20020a0564022681b0290394cedd8a6aso7781025edd.14
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 21:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aZYL5aYn0xhNCuQJ4VSpLl42cD0uGgHWKGK+S3b+4Xw=;
 b=CKTeBC2dOkRf58iBl6W8J5xHLFvTsTBy2NUYI8BfXDAEPm7tWVwcQ1aGP+aMlb/F51
 YB4b1mpUZ1dm+/XZi36OG4GdzoPjy4gNGZXL/GUPEyRibFm/naIa7es/hA1DrjkvE+cQ
 u1G6kfR7BRPtd1KxC10QOYfu0N9S1k2vrz6RRuJ1Bx1HpKn+aZfxZZJcHZawDg1Et5zR
 CvH/EuCfnQru/mYOEQinBgkAcNONi4gT8qhIT3a7LI01z8gIMUMhYB/DQH0HcGiAf4UT
 AuW0MOHQ8rTDlEk/rfQAGtNEVqb+pBOUeqjr86ARBmxcKWMyoqmTLWFMsrINVx6YnOSB
 Xlkg==
X-Gm-Message-State: AOAM531LMDFcfNGni6I54A2VwQeeA9b0LtsgozDCtso00Pimt+4dTCPY
 iSXPtHWWW8JwQmXm5esD4t9+0AsDQ3IpK5RvOLzEM2U3PMNFbZTq2LK67c+XZa7im9guk3hLVOV
 AYkKRQkAjoWqu0CUBK808q2T5hI9DGzAi0T4HlQS8fA==
X-Received: by 2002:a17:907:3f21:: with SMTP id
 hq33mr46593698ejc.101.1625977490665; 
 Sat, 10 Jul 2021 21:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2631mvc12XNn+pwQYGuAoTleaNH4+BbnJXIlHyuX714kOlbFAfCmFuHzVyxmLUCkbND1PJQ==
X-Received: by 2002:a17:907:3f21:: with SMTP id
 hq33mr46593678ejc.101.1625977490452; 
 Sat, 10 Jul 2021 21:24:50 -0700 (PDT)
Received: from redhat.com ([2.55.136.76])
 by smtp.gmail.com with ESMTPSA id c2sm4560282ejz.73.2021.07.10.21.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jul 2021 21:24:49 -0700 (PDT)
Date: Sun, 11 Jul 2021 00:24:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 28/28] virtio: fix up virtio_disable_cb
Message-ID: <20210711002423-mutt-send-email-mst@kernel.org>
References: <20210710235107.3221840-1-sashal@kernel.org>
 <20210710235107.3221840-28-sashal@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210710235107.3221840-28-sashal@kernel.org>
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

On Sat, Jul 10, 2021 at 07:51:07PM -0400, Sasha Levin wrote:
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

I don't think we should have it in stable just yet.
Let's make sure it fixes the issue first.

> ---
>  drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 97e8a195e18f..b6e1e0598529 100644
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
