Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 19:37:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3C560EFE
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 19:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA3C560EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 666ED4056A;
	Wed, 27 Oct 2021 19:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C9ldGQWDCgRB; Wed, 27 Oct 2021 19:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BBBCE40562;
	Wed, 27 Oct 2021 19:37:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96108C0012;
	Wed, 27 Oct 2021 19:37:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B433C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4410B40564
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hZOPSZXLtWlo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:37:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A37140562
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635363428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TyWbseVcIvJiB/y7F+AQk9e5SoEkEaCHQO94xB0lAow=;
 b=VKnh0LJh3aqvGODUX8F8oMY7C2Vo32IbAYvNYwK7H8XbaCmyhvzC44fdY2VCfBpD9NCme5
 cnb8ryp11P6UK2Orul2kEhS9CpMw7YP93SiIXRnifqdngT913TrJzKmcTpps0NJzgWBaEb
 mUTUuVoGbOZGWlgT3RuLPYgZkHpJK+g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-FFs_zESIO2qJui98RxHnqA-1; Wed, 27 Oct 2021 15:37:04 -0400
X-MC-Unique: FFs_zESIO2qJui98RxHnqA-1
Received: by mail-ed1-f72.google.com with SMTP id
 m16-20020a056402431000b003dd2005af01so3330528edc.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 12:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TyWbseVcIvJiB/y7F+AQk9e5SoEkEaCHQO94xB0lAow=;
 b=RsQv2tqSWMh9+u9x2DuW8i9ahchlbBfWlus76GjJHq2eKRWe6MOKYW46mA/bZ3M4IG
 IKnL022V2xhcAWyV9+t3KQcyrCCu1WlmJb/zmstRwNuRJkFWMApveatQT4tbmszKobPe
 TNX9Jdc01XWaDZcOWGwKehG/os+MyLCWGmW1OmKspS2oaiMiFAXZ7IOmc95mgAnzxwj8
 TbJ8Ga1H0qPtMxSCqFUkiQYqIDv+zZPBvr+Ck6jCGm0vvCpfImp0a83TohqfwAumZT7k
 1N+XOIMXcAslb6YBHqXGAV5KEEXjorlb3gYVCp7G3rlYYu+dhbhcXf3AltSGTJBAovNj
 badg==
X-Gm-Message-State: AOAM5310zXsG0j06Fev3Lu4h1yhWIG/3wjTagtkoMd8pTpGJF6ORWCHh
 tpQtdZzWxQMjV/8HDMrKgfbumNt+pnvo17TRsz/Hl4RBD26F0pfC5/houuVkbcklqR2m8TJ1c8u
 wvYG26XDURZHpSh8MYq8cbHrlpVYBIgGJQga7+noD0Q==
X-Received: by 2002:a05:6402:10cd:: with SMTP id
 p13mr41189087edu.111.1635363423399; 
 Wed, 27 Oct 2021 12:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaqOD6uea1lUYf7AdF5P8EDeIgspaeRBq2vHi/VPjOWrW95ZNai33V1+zqnc+0wZyHKtsfxQ==
X-Received: by 2002:a05:6402:10cd:: with SMTP id
 p13mr41189060edu.111.1635363423177; 
 Wed, 27 Oct 2021 12:37:03 -0700 (PDT)
Received: from redhat.com ([2.55.137.59])
 by smtp.gmail.com with ESMTPSA id gt36sm405080ejc.13.2021.10.27.12.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 12:37:02 -0700 (PDT)
Date: Wed, 27 Oct 2021 15:36:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/3] virtio: cache indirect desc for split
Message-ID: <20211027153545-mutt-send-email-mst@kernel.org>
References: <20211027061913.76276-1-xuanzhuo@linux.alibaba.com>
 <20211027061913.76276-2-xuanzhuo@linux.alibaba.com>
 <d6a38629-cb0a-be7b-5256-30ed8b34ee76@oracle.com>
MIME-Version: 1.0
In-Reply-To: <d6a38629-cb0a-be7b-5256-30ed8b34ee76@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
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

On Wed, Oct 27, 2021 at 09:33:46AM -0700, Dongli Zhang wrote:
> 
> 
> On 10/26/21 11:19 PM, Xuan Zhuo wrote:
> > In the case of using indirect, indirect desc must be allocated and
> > released each time, which increases a lot of cpu overhead.
> > 
> > Here, a cache is added for indirect. If the number of indirect desc to be
> > applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> > the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> > 
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio.c      |  6 ++++
> >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++++++++++++------
> >  include/linux/virtio.h       | 10 ++++++
> >  3 files changed, 70 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 0a5b54034d4b..04bcb74e5b9a 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(is_virtio_device);
> >  
> > +void virtio_use_desc_cache(struct virtio_device *dev, bool val)
> > +{
> > +	dev->desc_cache = val;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_use_desc_cache);
> > +
> >  void unregister_virtio_device(struct virtio_device *dev)
> >  {
> >  	int index = dev->index; /* save for after device release */
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dd95dfd85e98..0b9a8544b0e8 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -117,6 +117,10 @@ struct vring_virtqueue {
> >  	/* Hint for event idx: already triggered no need to disable. */
> >  	bool event_triggered;
> >  
> > +	/* Is indirect cache used? */
> > +	bool use_desc_cache;
> > +	void *desc_cache_chain;
> > +
> >  	union {
> >  		/* Available for split ring */
> >  		struct {
> > @@ -423,12 +427,47 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> >  	return extra[i].next;
> >  }
> >  
> > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > +#define VIRT_QUEUE_CACHE_DESC_NUM 4
> > +
> > +static void desc_cache_chain_free_split(void *chain)
> > +{
> > +	struct vring_desc *desc;
> > +
> > +	while (chain) {
> > +		desc = chain;
> > +		chain = (void *)desc->addr;
> > +		kfree(desc);
> > +	}
> > +}
> > +
> > +static void desc_cache_put_split(struct vring_virtqueue *vq,
> > +				 struct vring_desc *desc, int n)
> > +{
> > +	if (vq->use_desc_cache && n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > +		desc->addr = (u64)vq->desc_cache_chain;
> > +		vq->desc_cache_chain = desc;
> > +	} else {
> > +		kfree(desc);
> > +	}
> > +}
> > +
> > +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
> >  					       unsigned int total_sg,
> >  					       gfp_t gfp)
> >  {
> >  	struct vring_desc *desc;
> > -	unsigned int i;
> > +	unsigned int i, n;
> > +
> > +	if (vq->use_desc_cache && total_sg <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > +		if (vq->desc_cache_chain) {
> > +			desc = vq->desc_cache_chain;
> > +			vq->desc_cache_chain = (void *)desc->addr;
> > +			goto got;
> > +		}
> > +		n = VIRT_QUEUE_CACHE_DESC_NUM;
> 
> How about to make the VIRT_QUEUE_CACHE_DESC_NUM configurable (at least during
> driver probing) unless there is a reason that the default value is 4.
> 
> Thank you very much!
> 
> Dongli Zhang


I would start with some experimentation showing that it actually makes a
difference in performance.

> 
> 
> > +	} else {
> > +		n = total_sg;
> > +	}
> >  
> >  	/*
> >  	 * We require lowmem mappings for the descriptors because
> > @@ -437,12 +476,13 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> >  	 */
> >  	gfp &= ~__GFP_HIGHMEM;
> >  
> > -	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> > +	desc = kmalloc_array(n, sizeof(struct vring_desc), gfp);
> >  	if (!desc)
> >  		return NULL;
> >  
> > +got:
> >  	for (i = 0; i < total_sg; i++)
> > -		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
> > +		desc[i].next = cpu_to_virtio16(vq->vq.vdev, i + 1);
> >  	return desc;
> >  }
> >  
> > @@ -508,7 +548,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	head = vq->free_head;
> >  
> >  	if (virtqueue_use_indirect(_vq, total_sg))
> > -		desc = alloc_indirect_split(_vq, total_sg, gfp);
> > +		desc = alloc_indirect_split(vq, total_sg, gfp);
> >  	else {
> >  		desc = NULL;
> >  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> > @@ -652,7 +692,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	}
> >  
> >  	if (indirect)
> > -		kfree(desc);
> > +		desc_cache_put_split(vq, desc, total_sg);
> >  
> >  	END_USE(vq);
> >  	return -ENOMEM;
> > @@ -717,7 +757,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  	if (vq->indirect) {
> >  		struct vring_desc *indir_desc =
> >  				vq->split.desc_state[head].indir_desc;
> > -		u32 len;
> > +		u32 len, n;
> >  
> >  		/* Free the indirect table, if any, now that it's unmapped. */
> >  		if (!indir_desc)
> > @@ -729,10 +769,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  				VRING_DESC_F_INDIRECT));
> >  		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> >  
> > -		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> > +		n = len / sizeof(struct vring_desc);
> > +
> > +		for (j = 0; j < n; j++)
> >  			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> >  
> > -		kfree(indir_desc);
> > +		desc_cache_put_split(vq, indir_desc, n);
> >  		vq->split.desc_state[head].indir_desc = NULL;
> >  	} else if (ctx) {
> >  		*ctx = vq->split.desc_state[head].indir_desc;
> > @@ -2199,6 +2241,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> >  		!context;
> >  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > +	vq->desc_cache_chain = NULL;
> > +	vq->use_desc_cache = vdev->desc_cache;
> >  
> >  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >  		vq->weak_barriers = false;
> > @@ -2329,6 +2373,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >  	if (!vq->packed_ring) {
> >  		kfree(vq->split.desc_state);
> >  		kfree(vq->split.desc_extra);
> > +		desc_cache_chain_free_split(vq->desc_cache_chain);
> >  	}
> >  	kfree(vq);
> >  }
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..d84b7b8f4070 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -109,6 +109,7 @@ struct virtio_device {
> >  	bool failed;
> >  	bool config_enabled;
> >  	bool config_change_pending;
> > +	bool desc_cache;
> >  	spinlock_t config_lock;
> >  	spinlock_t vqs_list_lock; /* Protects VQs list access */
> >  	struct device dev;
> > @@ -130,6 +131,15 @@ int register_virtio_device(struct virtio_device *dev);
> >  void unregister_virtio_device(struct virtio_device *dev);
> >  bool is_virtio_device(struct device *dev);
> >  
> > +/**
> > + * virtio_use_desc_cache - virtio ring use desc cache
> > + *
> > + * virtio will cache the allocated indirect desc.
> > + *
> > + * This function must be called before find_vqs.
> > + */
> > +void virtio_use_desc_cache(struct virtio_device *dev, bool val);
> > +
> >  void virtio_break_device(struct virtio_device *dev);
> >  
> >  void virtio_config_changed(struct virtio_device *dev);
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
