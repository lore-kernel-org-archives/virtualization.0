Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313C7C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 17:08:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BFC60230
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 17:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5BFC60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84208404F4;
	Wed, 27 Oct 2021 17:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cU5U115U6CvD; Wed, 27 Oct 2021 17:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29E12403EF;
	Wed, 27 Oct 2021 17:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F10BBC0012;
	Wed, 27 Oct 2021 17:08:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89424C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 17:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7133F402DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 17:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qqBHOTtS_8nI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 17:08:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4784A402CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635354518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iy1QPbl+NGI8VooDFKsLzDrkTxssdpglKNEQwF6yv28=;
 b=HO/Ssyx1Pqo6RD+w2YrFYG6dZFJ2nVzldK6xsjTIippJoalMKVVTYZBCyrHaYXVG1/OOcA
 sYu8uqvE2u2/H+HNZBYBxK+NZPSQ/brU9mWdER2XQsdr/VSw8fk9KMA8pQlI8Qp83IW1eK
 rhJYcOvolZbHkPia95qrThqduAHV8yM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-lrGgQSArPrujmiY0TDboZw-1; Wed, 27 Oct 2021 13:07:26 -0400
X-MC-Unique: lrGgQSArPrujmiY0TDboZw-1
Received: by mail-wm1-f69.google.com with SMTP id
 j76-20020a1c234f000000b0032cd88916e5so789837wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 10:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Iy1QPbl+NGI8VooDFKsLzDrkTxssdpglKNEQwF6yv28=;
 b=dfOn+jouytdKp8YGpbEw0A+O1WOMFpOiJzm9mYQG9be56qmHBa/BEfGbnJxKH3vInH
 Bt4LT5IQr7IR5BijCrMLUnrq0hv3xC84f5sO9yW0/aj2CUqDXPPDP/pjA7ZbnzRGdfQ5
 FbUbphXgBnQZaka9/XAw6fHuYNGdibnJuIUebCjUbC7FmKH44obBQs4JwwmBYe8i8uUf
 RxtPZOP4pMrfXxLcPJ9oOu6cvBbOvYxniB+mNOBZE/uwW4lNnGtXvDYBlQVNBS3BCjmc
 P4yfHaJGjHkPmUJVJeh9IEJwXMuyRGauukQEge4WpvkNv+S797pIS5lGO7TNnrH/trYI
 uWlg==
X-Gm-Message-State: AOAM532j9jJQfhj6M4iKXOzhc04+qniQElir57Oq6tp51DqZm1jSBhgi
 mZkJsepntYOKiOshX8+oRMefCROtYNZ9vIPLTbgvjbbNzpFtIr+DvADZYN0zH7FygoL5wJI9wAK
 PUqOp7hTl0uJgVTZz8qSJvruVOuuqTeTxaC1T5oC1TA==
X-Received: by 2002:a1c:1d87:: with SMTP id d129mr6614296wmd.176.1635354445270; 
 Wed, 27 Oct 2021 10:07:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa7Q9RTjp2LDf1h+ESMQUn04bOSV913AYFeCXIIHWMw7nfUWMBBhkJYmr1cJGSWGvUAG8oig==
X-Received: by 2002:a1c:1d87:: with SMTP id d129mr6614284wmd.176.1635354445094; 
 Wed, 27 Oct 2021 10:07:25 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
 by smtp.gmail.com with ESMTPSA id l11sm407024wrt.49.2021.10.27.10.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 10:07:24 -0700 (PDT)
Date: Wed, 27 Oct 2021 13:07:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/3] virtio: cache indirect desc for split
Message-ID: <20211027130429-mutt-send-email-mst@kernel.org>
References: <20211027061913.76276-1-xuanzhuo@linux.alibaba.com>
 <20211027061913.76276-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211027061913.76276-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Wed, Oct 27, 2021 at 02:19:11PM +0800, Xuan Zhuo wrote:
> In the case of using indirect, indirect desc must be allocated and
> released each time, which increases a lot of cpu overhead.
> 
> Here, a cache is added for indirect. If the number of indirect desc to be
> applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio.c      |  6 ++++
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++++++++++++------
>  include/linux/virtio.h       | 10 ++++++
>  3 files changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..04bcb74e5b9a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(is_virtio_device);
>  
> +void virtio_use_desc_cache(struct virtio_device *dev, bool val)
> +{
> +	dev->desc_cache = val;
> +}
> +EXPORT_SYMBOL_GPL(virtio_use_desc_cache);
> +
>  void unregister_virtio_device(struct virtio_device *dev)
>  {
>  	int index = dev->index; /* save for after device release */
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..0b9a8544b0e8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -117,6 +117,10 @@ struct vring_virtqueue {
>  	/* Hint for event idx: already triggered no need to disable. */
>  	bool event_triggered;
>  
> +	/* Is indirect cache used? */
> +	bool use_desc_cache;
> +	void *desc_cache_chain;
> +
>  	union {
>  		/* Available for split ring */
>  		struct {
> @@ -423,12 +427,47 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  	return extra[i].next;
>  }
>  
> -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> +#define VIRT_QUEUE_CACHE_DESC_NUM 4
> +
> +static void desc_cache_chain_free_split(void *chain)
> +{
> +	struct vring_desc *desc;
> +
> +	while (chain) {
> +		desc = chain;
> +		chain = (void *)desc->addr;
> +		kfree(desc);
> +	}
> +}
> +
> +static void desc_cache_put_split(struct vring_virtqueue *vq,
> +				 struct vring_desc *desc, int n)
> +{
> +	if (vq->use_desc_cache && n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> +		desc->addr = (u64)vq->desc_cache_chain;
> +		vq->desc_cache_chain = desc;
> +	} else {
> +		kfree(desc);
> +	}
> +}
> +


So I have a question here. What happens if we just do:

if (n <= VIRT_QUEUE_CACHE_DESC_NUM) {
	return kmem_cache_alloc(VIRT_QUEUE_CACHE_DESC_NUM * sizeof desc, gfp)
} else {
	return kmalloc_arrat(n, sizeof desc, gfp)
}

A small change and won't we reap most performance benefits?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
