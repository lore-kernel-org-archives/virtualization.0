Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881823BD0B
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819167; cv=none; b=aJLK/bMWs4A8RVODFNgpVtLml/r56rYh6wA5fMa7zzI+E1fk29iXNqBztdKQJ1qjGmDuApIFTQiv323+cwuVWN77K28/TgzFjQdO4XeN9A0Mn4ZmN2cZAqRo8GnsPzDaP0F4XScG+fs9fS6+NyX4DM99+xKf6180VLMglS5/wlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819167; c=relaxed/simple;
	bh=B7wXPyXUP2w07U8Up6D4wr9emBg7GtP6vgGU4Rn9vb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l7aaOI/JmQy3c8Luq0Ww8vFNoVo1gd5LuxSwhwqWGz5eKityCTD7snHwm1tJpj4mo0bt86z6L3OhKkkbjmcDjguvYc3sG0WbITKFfyt3mqjW5JQORFeoHmcen8LzULK6NR1kOgSX4PEWwtrxe2QkP4Xk6wUCFZCoqUI+Lh1J25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IewRUBxP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IewRUBxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747819164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/o09y9SC9Ywr/vW/q2zNIFJBJF7X0kmooxajrWqv/s=;
	b=IewRUBxPcrP8Z2LV9yz7vevwl7FMJXgYSNWgfs9L/wJWmF32yBcyWfbAl/rS5cRL0KdsgM
	9WWLZG2j20Fk8XTi3yTi+KFHf6fWFMfsLgEFx5kp4LKCwE4m3h/UTE2VNDNKPCpLgNZbCn
	Vo+zFxjCtuAyeqSDB6xic7lvQZSBq8U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-EmyEocTNPyqpMEGaMIs8Qw-1; Wed, 21 May 2025 05:19:22 -0400
X-MC-Unique: EmyEocTNPyqpMEGaMIs8Qw-1
X-Mimecast-MFC-AGG-ID: EmyEocTNPyqpMEGaMIs8Qw_1747819161
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3696a0ce6so1676577f8f.3
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 02:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747819161; x=1748423961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/o09y9SC9Ywr/vW/q2zNIFJBJF7X0kmooxajrWqv/s=;
        b=jEfZThPKNNWI0R7I6SKhRfHSRieqIVNOsJSuUgDzBkbuMpt4tJ6YNO1t82adF35ORS
         OoK4PuaJ2y7flbG+YpT8OCqSc/1hJX8SP5Lev/8vqwV2u2fJqooIMPbjxLkFHerCnCXw
         +jbagz442YQeQHC9GXjj+DkJrbWyelteDN5n5c2b4Anb+8dlUcKBCwTZRUJX46yIeoN0
         LKx3SsHJiYwNpf72etiZn6zYEfd7JG7vrRjav0yNaoLWUlb7WAKjOj3LY/pjiqNlQpBM
         BqowenMHi3vb2GjDUj3PMAlZkOxWeuCtVbsqhH5jyzqZAnkw5KvU+l6mDE+xNY+2Jbrf
         l8bA==
X-Forwarded-Encrypted: i=1; AJvYcCXA/uDU50fpvMNueRw3MLaAPLh34BHJNsRgD97T9zx4Nwn3XiHqR476W9GwbGGQXKPDPyJR8AmK8mjSdzr6yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUeaefT1cRs5p3awQwTUicoPDc4yAfkws9NhKcK8d14+kLJDyr
	bXmi0HRzCluI11WY+NSLWo5tEZdsdnrXCXlvgZgP01+i4FwDX++cLBpCfM4XZyLLNn8E1YrA/08
	liyegwnjWpekPdIsMPjEhL7wS42RNIJpSI+2MKPyuqkuQUHNzObiXEa3k64dSI8L8H1oa
X-Gm-Gg: ASbGnctwuhsqLLLLGqLLgcDJNT+j4gvJz/VM+qTlknrizc+tnPeC+7NgGqiktW8Q7Kx
	rwnMSqDY49B94omPsxTqbA/+F2b+hPtWJVPCgYqSDdszhatWQBAMU8kV1xzAB65gargNnU6BTfQ
	LG0L9l8gR6QO0H2efwo6UFgBk8ZRLVqUSgfRTANuWkEcoGYnLtEHmZCrGeSwnyCE52kNc8kzJqp
	I427vCpEYF2XO0c9V0dvRSpFdvOA58wqaQDuAZaTTcL5XL3ERgJlK5Ew0+C11vluHbqe4C8j7Pi
	Ter8tg==
X-Received: by 2002:a05:6000:3103:b0:3a3:6415:96c8 with SMTP id ffacd0b85a97d-3a364159712mr14162620f8f.41.1747819161445;
        Wed, 21 May 2025 02:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLmTcHyyqMuzgg9O5ETbsMsgVAw3A3cvgRdzmCanUIuc6/dYk73VWGritQ97Q4VSUoXhdZCA==
X-Received: by 2002:a05:6000:3103:b0:3a3:6415:96c8 with SMTP id ffacd0b85a97d-3a364159712mr14162590f8f.41.1747819161026;
        Wed, 21 May 2025 02:19:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6ffaa6esm63402155e9.16.2025.05.21.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 02:19:20 -0700 (PDT)
Date: Wed, 21 May 2025 05:19:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.or" <linux-block@vger.kernel.or>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521051556-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -4XKWuNlhrm5Nk6hsiI33HHwjnIen2eMFo4agzyGVFw_1747819161
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 21, 2025 1:48 PM
> > 
> > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests may not complete the
> > > device as the VQ is marked as broken. Due to this, the disk deletion
> > > hangs.
> > >
> > > Fix it by aborting the requests when the VQ is broken.
> > >
> > > With this fix now fio completes swiftly.
> > > An alternative of IO timeout has been considered, however when the
> > > driver knows about unresponsive block device, swiftly clearing them
> > > enables users and upper layers to react quickly.
> > >
> > > Verified with multiple device unplug iterations with pending requests
> > > in virtio used ring and some pending with the device.
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > >
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > > changelog:
> > > v0->v1:
> > > - Fixed comments from Stefan to rename a cleanup function
> > > - Improved logic for handling any outstanding requests
> > >   in bio layer
> > > - improved cancel callback to sync with ongoing done()
> > 
> > thanks for the patch!
> > questions:
> > 
> > 
> > > ---
> > >  drivers/block/virtio_blk.c | 95
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 7cffea01d868..5212afdbd3c7 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > blk_mq_hw_ctx *hctx,
> > >  	blk_status_t status;
> > >  	int err;
> > >
> > > +	/* Immediately fail all incoming requests if the vq is broken.
> > > +	 * Once the queue is unquiesced, upper block layer flushes any
> > pending
> > > +	 * queued requests; fail them right away.
> > > +	 */
> > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > +		return BLK_STS_IOERR;
> > > +
> > >  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
> > >  	if (unlikely(status))
> > >  		return status;
> > 
> > just below this:
> >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> >         err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> >         if (err) {
> > 
> > 
> > and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a broken vq.
> > 
> > Why do we need to check it one extra time here?
> > 
> It may work, but for some reason if the hw queue is stopped in this flow, it can hang the IOs flushing.

> I considered it risky to rely on the error code ENOSPC returned by non virtio-blk driver.
> In other words, if lower layer changed for some reason, we may end up in stopping the hw queue when broken, and requests would hang.
> 
> Compared to that one-time entry check seems more robust.

I don't get it.
Checking twice in a row is more robust?
What am I missing?
Can you describe the scenario in more detail?

> 
> > 
> > 
> > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
> > >  	while ((req = rq_list_pop(rqlist))) {
> > >  		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req-
> > >mq_hctx);
> > >
> > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > +			rq_list_add_tail(&requeue_list, req);
> > > +			continue;
> > > +		}
> > > +
> > >  		if (vq && vq != this_vq)
> > >  			virtblk_add_req_batch(vq, &submit_list);
> > >  		vq = this_vq;
> > 
> > similarly
> > 
> The error code is not surfacing up here from virtblk_add_req().


but wait a sec:

static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
                struct rq_list *rqlist)
{       
        struct request *req; 
        unsigned long flags;
        bool kick;
        
        spin_lock_irqsave(&vq->lock, flags);
        
        while ((req = rq_list_pop(rqlist))) {
                struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
                int err;
                        
                err = virtblk_add_req(vq->vq, vbr);
                if (err) {
                        virtblk_unmap_data(req, vbr);
                        virtblk_cleanup_cmd(req);
                        blk_mq_requeue_request(req, true);
                }
        }

        kick = virtqueue_kick_prepare(vq->vq);
        spin_unlock_irqrestore(&vq->lock, flags);

        if (kick)
                virtqueue_notify(vq->vq);
}


it actually handles the error internally?




> It would end up adding checking for special error code here as well to abort by translating broken VQ -> EIO to break the loop in virtblk_add_req_batch().
> 
> Weighing on specific error code-based data path that may require audit from lower layers now and future, an explicit check of broken in this layer could be better.
> 
> [..]


Checking add was successful is preferred because it has to be done
*anyway* - device can get broken after you check before add.

So I would like to understand why are we also checking explicitly and I
do not get it so far.

