Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868321AE86E
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526173; cv=none; b=qn3kwN04RPvhwlNAG8U5OtlTwDvo50HcmUIlfm1rYvI1s2jmdJE+DZIBrMb9K06eyhuEvvzAit3fn4P/qh+72YuKvTqI1sRvIHN91FpA30uC0lH6tL2ZGHOQrySf9guHcvkOiavGh3ixwc18j6kOoQSR2DR4hVcFC+SAfiWz4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526173; c=relaxed/simple;
	bh=A4Wxx4RnOLiOZh6dos1eIsNYxgKM/mW4e1Psbcjc49g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r9Hb7iyEXQyWKwNTwtGTK42N0EX0rk8ICxLH/DRpxsvsHmGVR5SA20Fc8KZfTf0DNCGjcJI1/tQhqOm4fVd0CVD3LhMlS/xNbJis+7anmzt9gcg1CbZqSj0Mr+Yo9Grmbi/ZI9UOwrXUKFq8AxkN/KtG3CgNWO0wkoaW2ZETbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE6IVRfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE6IVRfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722526170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGVKiWUoGR4X8/xGRUkrTDVz6Jho0JKzSVqodGS4FcY=;
	b=XE6IVRfx7hK7qBwJwY36iAJwBdg7k8ciSvK42lVADsUiYLjH31cmW8XuMcfGduY1zFrVjU
	l1e41UlOJE5Tv/C6G+mwBdb9gS91x0R6Rrs16KYHUNd1pWkt4VASRDRozxgQEz9sj0JfHd
	xRpRg8agLfiMqTRjTS2LHNnftG6hI30=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-RE0m--uEPUmCysIrc9nzZA-1; Thu, 01 Aug 2024 11:29:29 -0400
X-MC-Unique: RE0m--uEPUmCysIrc9nzZA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57c93227bbeso6668284a12.3
        for <virtualization@lists.linux.dev>; Thu, 01 Aug 2024 08:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526168; x=1723130968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGVKiWUoGR4X8/xGRUkrTDVz6Jho0JKzSVqodGS4FcY=;
        b=TkSz+PklwBEOVzkGIURu+OFK4oCN86cpAQBy2R9HyGJqSwepNi7aopn2IFdwgPTElN
         J+K+36uHvAAng+DpKIzjArn7j6NXJLNpILSenM6CNxRXWLYI22WWq/DS6sQd8UkobK0J
         VjXslxy44ZBj7jUeHhMJR53seZAuJ8iy2g2CTWCfzozSJohCOqQ+Gw/VqUNv/81SJFG1
         CVHgkmqC+7JA/JCKhIMjP8++8BSn++AvQx6C2Pl2PvGbw+feHTPan/CWcrNPy5pll4Lz
         ZTCPAv+AOVflRcSZ2o7wPYJlLojiwlGY3yxdTOHrZG3YJ6Izer9NPfpIR1keDSznXepL
         /qEg==
X-Forwarded-Encrypted: i=1; AJvYcCVgKMBAG+QFzoOOZVe0H2UiNGVraskkPbt1OzYfXfPR6sKEjL47yF/m5qzIdkSa+stL3QOjTf7RLTr6Me57Qo2iw4b6/4225lEeiAhtvY8=
X-Gm-Message-State: AOJu0YzHhM05koyMPstCGDU/P0mq2K9RnOrk/afM9DzjqX0E/WE7DW3m
	xcA4F6s+iwNCfU8zhkcSYN0iJINhxFPG8X/Iu84GEk9eXipBapdPuXb6ZBOZzc5Vd/lVYGWKe06
	VmdgjXWaCFR+aaaPdiO0uoR65R+5pAt6lW70JzFAUVs6F6LGzKHPJ1ERYM98FsnQG
X-Received: by 2002:aa7:c3cc:0:b0:5af:2e08:d362 with SMTP id 4fb4d7f45d1cf-5b7f540af9fmr474386a12.23.1722526167934;
        Thu, 01 Aug 2024 08:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe61CmSqSH53nLXMqrYJlig+emZoMGr+cx0T73r3+YRu8PxByvS0d8rIxZdQ4r5OdF9MwCbg==
X-Received: by 2002:aa7:c3cc:0:b0:5af:2e08:d362 with SMTP id 4fb4d7f45d1cf-5b7f540af9fmr474343a12.23.1722526166780;
        Thu, 01 Aug 2024 08:29:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af758a6c36sm8784425a12.73.2024.08.01.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:29:25 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:29:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, virtualization@lists.linux.dev, axboe@kernel.dk,
	kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
Subject: Re: [PATCH 1/1] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240801112843-mutt-send-email-mst@kernel.org>
References: <20240801151137.14430-1-mgurtovoy@nvidia.com>
 <20240801111337-mutt-send-email-mst@kernel.org>
 <0888da3b-3283-405b-b1a8-a315e2623289@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0888da3b-3283-405b-b1a8-a315e2623289@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2024 at 06:17:21PM +0300, Max Gurtovoy wrote:
> 
> On 01/08/2024 18:13, Michael S. Tsirkin wrote:
> > On Thu, Aug 01, 2024 at 06:11:37PM +0300, Max Gurtovoy wrote:
> > > In this operation set the driver data of the hctx to point to the virtio
> > > block queue. By doing so, we can use this reference in the and reduce
> > in the .... ?
> 
> sorry for the type.
> 
> should be :
> 
> "By doing so, we can use this reference and reduce the number of operations in the fast path."

ok. what kind of benefit do you see with this patch?

> 
> > 
> > > the number of operations in the fast path.
> > > 
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 42 ++++++++++++++++++++------------------
> > >   1 file changed, 22 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 2351f411fa46..35a7a586f6f5 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -129,14 +129,6 @@ static inline blk_status_t virtblk_result(u8 status)
> > >   	}
> > >   }
> > > -static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> > > -{
> > > -	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > > -
> > > -	return vq;
> > > -}
> > > -
> > >   static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
> > >   {
> > >   	struct scatterlist out_hdr, in_hdr, *sgs[3];
> > > @@ -377,8 +369,7 @@ static void virtblk_done(struct virtqueue *vq)
> > >   static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > >   {
> > > -	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > >   	bool kick;
> > >   	spin_lock_irq(&vq->lock);
> > > @@ -428,10 +419,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > >   			   const struct blk_mq_queue_data *bd)
> > >   {
> > >   	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > >   	struct request *req = bd->rq;
> > >   	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> > >   	unsigned long flags;
> > > -	int qid = hctx->queue_num;
> > >   	bool notify = false;
> > >   	blk_status_t status;
> > >   	int err;
> > > @@ -440,26 +431,26 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > >   	if (unlikely(status))
> > >   		return status;
> > > -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > > -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > > +	spin_lock_irqsave(&vq->lock, flags);
> > > +	err = virtblk_add_req(vq->vq, vbr);
> > >   	if (err) {
> > > -		virtqueue_kick(vblk->vqs[qid].vq);
> > > +		virtqueue_kick(vq->vq);
> > >   		/* Don't stop the queue if -ENOMEM: we may have failed to
> > >   		 * bounce the buffer due to global resource outage.
> > >   		 */
> > >   		if (err == -ENOSPC)
> > >   			blk_mq_stop_hw_queue(hctx);
> > > -		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> > > +		spin_unlock_irqrestore(&vq->lock, flags);
> > >   		virtblk_unmap_data(req, vbr);
> > >   		return virtblk_fail_to_queue(req, err);
> > >   	}
> > > -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> > > +	if (bd->last && virtqueue_kick_prepare(vq->vq))
> > >   		notify = true;
> > > -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > >   	if (notify)
> > > -		virtqueue_notify(vblk->vqs[qid].vq);
> > > +		virtqueue_notify(vq->vq);
> > >   	return BLK_STS_OK;
> > >   }
> > > @@ -504,7 +495,7 @@ static void virtio_queue_rqs(struct request **rqlist)
> > >   	struct request *requeue_list = NULL;
> > >   	rq_list_for_each_safe(rqlist, req, next) {
> > > -		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> > > +		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> > >   		bool kick;
> > >   		if (!virtblk_prep_rq_batch(req)) {
> > > @@ -1164,6 +1155,16 @@ static const struct attribute_group *virtblk_attr_groups[] = {
> > >   	NULL,
> > >   };
> > > +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> > > +		unsigned int hctx_idx)
> > > +{
> > > +	struct virtio_blk *vblk = data;
> > > +	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> > > +
> > > +	hctx->driver_data = vq;
> > > +	return 0;
> > > +}
> > > +
> > >   static void virtblk_map_queues(struct blk_mq_tag_set *set)
> > >   {
> > >   	struct virtio_blk *vblk = set->driver_data;
> > > @@ -1205,7 +1206,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
> > >   static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > >   {
> > >   	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > -	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
> > > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > >   	struct virtblk_req *vbr;
> > >   	unsigned long flags;
> > >   	unsigned int len;
> > > @@ -1236,6 +1237,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
> > >   	.queue_rqs	= virtio_queue_rqs,
> > >   	.commit_rqs	= virtio_commit_rqs,
> > >   	.complete	= virtblk_request_done,
> > > +	.init_hctx	= virtblk_init_hctx,
> > >   	.map_queues	= virtblk_map_queues,
> > >   	.poll		= virtblk_poll,
> > >   };
> > > -- 
> > > 2.18.1

