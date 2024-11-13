Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECC18CC10
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540325; cv=none; b=XxRK6w1pQEO/iZS6Nkyk+DcuAsIc7q/UDewR7k5XPGbWk997UvuvNMphVy33jgcKT6KBiPWI49bt1ZD4RDwvvEZa8BWgyhTdlk3ikN3fPuCnu5OK95tdqKxTwRgq757ZoysrNs/H3rItgX503jWsmcyl9Dg/pEJkdTZUrIL/tG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540325; c=relaxed/simple;
	bh=c5dYtWrY11OG4lgQlqIZVJE4vP5JPLMTqoyIrqudnWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nheu7IiO/qdU6DQk8mp5U6LoCiKbkwgZDqn8hYbXifKh/VKtNAb5UOGubCt242P4Uk8sKN1DSDFM25Mm7c1CoGMwevB5e6ovUe44neOoKS/w/O9Deo5/l38Y80/egQQb2t9XrRbaHFm/x+ZnSxYJMaHUjksfTBBUWAh00tOtrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrOojgLJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrOojgLJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731540322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzPWmh0C8RYeAeZIKKXP7q682GlgR+SBS+qZzgFuwNs=;
	b=JrOojgLJc48x9O04lakp0xc7Rrdy/gaRUhbkOdSI7xaFHmZZ0LVcZah1tvHeKrSc8b8Thl
	1NMWPDC008PyWMMaS2ubThucJ2QiiZMRcvBVlPhcPS2AS82Q2ZlMz5rGvvnJ+g+08aInZl
	XksBSnPVc2Oly/rTurZRRg/IhN1tENY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-tKbQbcCCM22FUjYW1qd1QA-1; Wed, 13 Nov 2024 18:25:21 -0500
X-MC-Unique: tKbQbcCCM22FUjYW1qd1QA-1
X-Mimecast-MFC-AGG-ID: tKbQbcCCM22FUjYW1qd1QA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso283375e9.2
        for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 15:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731540320; x=1732145120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzPWmh0C8RYeAeZIKKXP7q682GlgR+SBS+qZzgFuwNs=;
        b=oG5P+A4zgnaNOndkG/wmuBn+AAb4096+mh5iqqXxZp/IYMUH0ZGFnsoq1SNJj6CC6M
         sgRst8NU1GPAfZ95G0UVh2NxaaL1bsekLOMbpNXRdW5jUiMRYVseU4BaayZu5MMyn1S3
         v8Rc4UEQwSb5pLwW9qrvRoo+BZGufnp0q4a5TdDVIg7aA/LvO13Y27c5gBeLMm95qsIT
         8ZWeO1IKQ21XlDTWNNpTiM8XIBYb92k7iN3Z03agePaNFH98vbYlLAwbvM5p0QZGhuuo
         j935bLFZAGVAgD3ZlU/ORjxvBs08rMep4/lUAEZVLcK1VpKYF98kOGvezvQxqo5bKasR
         qepg==
X-Forwarded-Encrypted: i=1; AJvYcCXIUkcLn59bKiRnFaZWEOzto1HcNco7KGG1Z1CUb8x7JoZBRbZk9+RN45qFptMvYw+YQpM1wpLPwKa83v5oxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy47DaMwS8WaNt0wEai+v3tewYLDLJ5+W/TDgKQMnlZ732+oR/A
	6RsCl8gQj4X5hwNvIGah4yFdXY/XITtGxl24TknNBm1lTbb3AJ1faf4X2wRgZ43Ptkkj08XVSkm
	dLqjsaveoyCwhtAVkYa9y0vLe+knswHo7gOzs+v+5TDSdTtg2I967QCYj0/QN0Waw
X-Received: by 2002:a05:600c:3d8d:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-432da76ec4amr935405e9.7.1731540320198;
        Wed, 13 Nov 2024 15:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDNE+4rEsYxD1YNYi7V9qyaFYVxzcxTW8otS2BtZTbP6JFcM1ds70h/SDQ68r3Vw5bW0apPw==
X-Received: by 2002:a05:600c:3d8d:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-432da76ec4amr935285e9.7.1731540319813;
        Wed, 13 Nov 2024 15:25:19 -0800 (PST)
Received: from redhat.com ([2.55.171.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d9d0a4absm4692895e9.24.2024.11.13.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:25:18 -0800 (PST)
Date: Wed, 13 Nov 2024 18:25:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 2/6] virtio_blk: reverse request order in virtio_queue_rqs
Message-ID: <20241113182448-mutt-send-email-mst@kernel.org>
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241113152050.157179-3-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XDnlp8omaHaNOVp5IamRr__09oNceRr_sap_8M3YfOk_1731540320
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2024 at 04:20:42PM +0100, Christoph Hellwig wrote:
> blk_mq_flush_plug_list submits requests in the reverse order that they
> were submitted, which leads to a rather suboptimal I/O pattern especially
> in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it
> always pops the requests from the passed in request list, and then adds
> them to the head of a local submit list.  This actually simplifies the
> code a bit as it removes the complicated list splicing, at the cost of
> extra updates of the rq_next pointer.  As that should be cache hot
> anyway it should be an easy price to pay.
> 
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 46 +++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0e99a4714928..b25f7c06a28e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -471,18 +471,18 @@ static bool virtblk_prep_rq_batch(struct request *req)
>  	return virtblk_prep_rq(req->mq_hctx, vblk, req, vbr) == BLK_STS_OK;
>  }
>  
> -static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
> +static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  					struct request **rqlist)
>  {
> +	struct request *req;
>  	unsigned long flags;
> -	int err;
>  	bool kick;
>  
>  	spin_lock_irqsave(&vq->lock, flags);
>  
> -	while (!rq_list_empty(*rqlist)) {
> -		struct request *req = rq_list_pop(rqlist);
> +	while ((req = rq_list_pop(rqlist))) {
>  		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> +		int err;
>  
>  		err = virtblk_add_req(vq->vq, vbr);
>  		if (err) {
> @@ -495,37 +495,33 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  	kick = virtqueue_kick_prepare(vq->vq);
>  	spin_unlock_irqrestore(&vq->lock, flags);
>  
> -	return kick;
> +	if (kick)
> +		virtqueue_notify(vq->vq);
>  }
>  
>  static void virtio_queue_rqs(struct request **rqlist)
>  {
> -	struct request *req, *next, *prev = NULL;
> +	struct request *submit_list = NULL;
>  	struct request *requeue_list = NULL;
> +	struct request **requeue_lastp = &requeue_list;
> +	struct virtio_blk_vq *vq = NULL;
> +	struct request *req;
>  
> -	rq_list_for_each_safe(rqlist, req, next) {
> -		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> -		bool kick;
> -
> -		if (!virtblk_prep_rq_batch(req)) {
> -			rq_list_move(rqlist, &requeue_list, req, prev);
> -			req = prev;
> -			if (!req)
> -				continue;
> -		}
> +	while ((req = rq_list_pop(rqlist))) {
> +		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req->mq_hctx);
>  
> -		if (!next || req->mq_hctx != next->mq_hctx) {
> -			req->rq_next = NULL;
> -			kick = virtblk_add_req_batch(vq, rqlist);
> -			if (kick)
> -				virtqueue_notify(vq->vq);
> +		if (vq && vq != this_vq)
> +			virtblk_add_req_batch(vq, &submit_list);
> +		vq = this_vq;
>  
> -			*rqlist = next;
> -			prev = NULL;
> -		} else
> -			prev = req;
> +		if (virtblk_prep_rq_batch(req))
> +			rq_list_add(&submit_list, req); /* reverse order */
> +		else
> +			rq_list_add_tail(&requeue_lastp, req);
>  	}
>  
> +	if (vq)
> +		virtblk_add_req_batch(vq, &submit_list);
>  	*rqlist = requeue_list;
>  }



looks ok from virtio POV

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> 2.45.2

