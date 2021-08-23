Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B65AC4338F
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 21:20:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22481613CD
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 21:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22481613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E363660678;
	Mon, 23 Aug 2021 21:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XL0N3r1eveie; Mon, 23 Aug 2021 21:20:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68A6160664;
	Mon, 23 Aug 2021 21:20:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48619C001A;
	Mon, 23 Aug 2021 21:20:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BA9CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 21:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 470CD80CFF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 21:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MqPfxkUGjrSD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 21:20:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 135E480CF6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629753603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbEqjMJoQt3yLrlY+GFqpGqyp8tEIHBCyDKiHKEv/pY=;
 b=A5rlO3WGqP06XnfEHUNXwgYs7z2HVT9WTynRagJrH18sTFJs+XcecoZ1Tre5U9H5sOukSZ
 uYhGGmlINv+r6xXYOyHVf++5p3yv8MZyBG1JdQbs2D9QXrXSvFwAW/M5h9A2F6wJ805CW4
 0HUQX3ujKaMph2DCrB0kq8767qJstb0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-w_dPsQzSPoK3WvIwj9DBHg-1; Mon, 23 Aug 2021 17:20:02 -0400
X-MC-Unique: w_dPsQzSPoK3WvIwj9DBHg-1
Received: by mail-ed1-f71.google.com with SMTP id
 k13-20020aa7c04d000000b003bf04c03fc4so9467702edo.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 14:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lbEqjMJoQt3yLrlY+GFqpGqyp8tEIHBCyDKiHKEv/pY=;
 b=T7QgH1wfQse4pXdXx4BHhBBQNCxVMFT7PWm0g13VHC2ypWTtLVorsocbb+2PfaCe3U
 x7O9iEW2V1Ur9Kex5HA/Gm9Z4x+YjAOZOCj1/lrMwid8dzfpHxX4dliMo3iKVuV40X7W
 lSdvVV3wh7AwKsN1UVlnAm/hoPvaOzKHWnKWkx6XAwq3tUeNj7nUFGU7duRtdQMPYkRS
 2rks0+2H+ImZRGXv5OcDXidEsZDIfN3NkdPp0SjJw7nzvk7WfMLAFciKpXwV8zcvzEqv
 LW6hVPGVIVLn7HzSwvQLCbAyELdR11qR2+4x35aM7VjS2lCCoaKpN5CKtHJ0fuopg2xN
 PkUw==
X-Gm-Message-State: AOAM530Y7LGNTMoDpkT6VzocCPAa9IBE8AlSG5Kcu5p2ke7EfOrGHHIs
 6JPH6FCAWmPMVu70wM31u4UMSriug/ZQeSFzh+IuTKtLuysN172ecTqjcdoqM4dZjAMs/S2VV9Z
 2UerUf9MUincd45su0crkIl774wASQ7Q9dyTu3vh7pA==
X-Received: by 2002:a17:906:3e59:: with SMTP id
 t25mr37538272eji.24.1629753601614; 
 Mon, 23 Aug 2021 14:20:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzIHZ0Z0HNuaN8AoD24ulxJU892EPBBSYFsufMqZCOer/+b6UyS89yQ4kH2OcGDMz/lsPACw==
X-Received: by 2002:a17:906:3e59:: with SMTP id
 t25mr37538256eji.24.1629753601471; 
 Mon, 23 Aug 2021 14:20:01 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
 by smtp.gmail.com with ESMTPSA id t1sm5488155edq.31.2021.08.23.14.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 14:20:00 -0700 (PDT)
Date: Mon, 23 Aug 2021 17:19:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] vhost: add support for mandatory barriers
Message-ID: <20210823171609-mutt-send-email-mst@kernel.org>
References: <20210823081437.14274-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
In-Reply-To: <20210823081437.14274-1-vincent.whitchurch@axis.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@axis.com
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

On Mon, Aug 23, 2021 at 10:14:37AM +0200, Vincent Whitchurch wrote:
> vhost always uses SMP-conditional barriers, but these may not be
> sufficient when vhost is used to communicate between heterogeneous
> processors in an AMP configuration, especially since they're NOPs on
> !SMP builds.
> 
> To solve this, use the virtio_*() barrier functions and ask them for
> non-weak barriers if requested by userspace.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

I am inclined to say let's (ab)use VIRTIO_F_ORDER_PLATFORM for this.
Jason what do you think?

Also is the use of DMA variants really the intended thing here? Could
you point me at some examples please?


> ---
>  drivers/vhost/vhost.c      | 23 ++++++++++++++---------
>  drivers/vhost/vhost.h      |  2 ++
>  include/uapi/linux/vhost.h |  2 ++
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b9e853e6094d..f7172e1bc395 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -500,6 +500,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  		vq->indirect = NULL;
>  		vq->heads = NULL;
>  		vq->dev = dev;
> +		vq->weak_barriers = true;
>  		mutex_init(&vq->mutex);
>  		vhost_vq_reset(dev, vq);
>  		if (vq->handle_kick)
> @@ -1801,6 +1802,10 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		if (ctx)
>  			eventfd_ctx_put(ctx);
>  		break;
> +	case VHOST_SET_STRONG_BARRIERS:
> +		for (i = 0; i < d->nvqs; ++i)
> +			d->vqs[i]->weak_barriers = false;
> +		break;
>  	default:
>  		r = -ENOIOCTLCMD;
>  		break;
> @@ -1927,7 +1932,7 @@ int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
>  	int i, r;
>  
>  	/* Make sure data written is seen before log. */
> -	smp_wmb();
> +	virtio_wmb(vq->weak_barriers);
>  
>  	if (vq->iotlb) {
>  		for (i = 0; i < count; i++) {
> @@ -1964,7 +1969,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
>  		return -EFAULT;
>  	if (unlikely(vq->log_used)) {
>  		/* Make sure the flag is seen before log. */
> -		smp_wmb();
> +		virtio_wmb(vq->weak_barriers);
>  		/* Log used flag write. */
>  		used = &vq->used->flags;
>  		log_used(vq, (used - (void __user *)vq->used),
> @@ -1982,7 +1987,7 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
>  	if (unlikely(vq->log_used)) {
>  		void __user *used;
>  		/* Make sure the event is seen before log. */
> -		smp_wmb();
> +		virtio_wmb(vq->weak_barriers);
>  		/* Log avail event write */
>  		used = vhost_avail_event(vq);
>  		log_used(vq, (used - (void __user *)vq->used),
> @@ -2228,7 +2233,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  		/* Only get avail ring entries after they have been
>  		 * exposed by guest.
>  		 */
> -		smp_rmb();
> +		virtio_rmb(vq->weak_barriers);
>  	}
>  
>  	/* Grab the next descriptor number they're advertising, and increment
> @@ -2367,7 +2372,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
>  	}
>  	if (unlikely(vq->log_used)) {
>  		/* Make sure data is seen before log. */
> -		smp_wmb();
> +		virtio_wmb(vq->weak_barriers);
>  		/* Log used ring entry write. */
>  		log_used(vq, ((void __user *)used - (void __user *)vq->used),
>  			 count * sizeof *used);
> @@ -2402,14 +2407,14 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
>  	r = __vhost_add_used_n(vq, heads, count);
>  
>  	/* Make sure buffer is written before we update index. */
> -	smp_wmb();
> +	virtio_wmb(vq->weak_barriers);
>  	if (vhost_put_used_idx(vq)) {
>  		vq_err(vq, "Failed to increment used idx");
>  		return -EFAULT;
>  	}
>  	if (unlikely(vq->log_used)) {
>  		/* Make sure used idx is seen before log. */
> -		smp_wmb();
> +		virtio_wmb(vq->weak_barriers);
>  		/* Log used index update. */
>  		log_used(vq, offsetof(struct vring_used, idx),
>  			 sizeof vq->used->idx);
> @@ -2428,7 +2433,7 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	/* Flush out used index updates. This is paired
>  	 * with the barrier that the Guest executes when enabling
>  	 * interrupts. */
> -	smp_mb();
> +	virtio_mb(vq->weak_barriers);
>  
>  	if (vhost_has_feature(vq, VIRTIO_F_NOTIFY_ON_EMPTY) &&
>  	    unlikely(vq->avail_idx == vq->last_avail_idx))
> @@ -2530,7 +2535,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	}
>  	/* They could have slipped one in as we were doing that: make
>  	 * sure it's written, then check again. */
> -	smp_mb();
> +	virtio_mb(vq->weak_barriers);
>  	r = vhost_get_avail_idx(vq, &avail_idx);
>  	if (r) {
>  		vq_err(vq, "Failed to check avail idx at %p: %d\n",
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 638bb640d6b4..5bd20d0db457 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -108,6 +108,8 @@ struct vhost_virtqueue {
>  	bool log_used;
>  	u64 log_addr;
>  
> +	bool weak_barriers;
> +
>  	struct iovec iov[UIO_MAXIOV];
>  	struct iovec iotlb_iov[64];
>  	struct iovec *indirect;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c998860d7bbc..4b8656307f51 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -97,6 +97,8 @@
>  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
>  #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
>  
> +#define VHOST_SET_STRONG_BARRIERS _IO(VHOST_VIRTIO, 0x27)
> +
>  /* VHOST_NET specific defines */
>  
>  /* Attach virtio net ring to a raw socket, or tap device.
> -- 
> 2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
