Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F942163BA
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417999; cv=none; b=VyfqWQRUguFVS8KOu1NddmtPWKdhUco20uUEOZrHwICoOkmExGvYk3Z3C9ViwREyKwxWINfiF7/kMrD+1znzSGhO37ZlJc+GlUB54xOK4qhEhbgJSd806vqmyjukFwDfYNgYq6pRDVae6u44tEw5/8ZCegVObb8hOIG27Bp3B5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417999; c=relaxed/simple;
	bh=uGiQxFy1s5xeq1KoKnvvc/uBnnzYKHTfVcJoqj87jNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ivhqu2I6wUpHE0rx2a8bHjqt/uPFzyKtrhF2AUF0ORECG2+uTeVWhKy/Qif8NFSm0HjAPk5RCrSqRH6KGVnry5suqIUm4f2PpqGe1s/GYkT+/jppZmVqGiftpiu4FX83fMloUCccS+fB7GzERb2HdHBEmxVWpdoRvoXrT3JI6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDP2GSKs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDP2GSKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736417996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDFZvC9ufxrWv6tOwpxDjE36uvyXj6GJcVYLoUQ5PZw=;
	b=BDP2GSKs6K3WTrJWUKPr3kptKn4XJclvM6jfbA8nguHdyNWKHNsrxrO2KEak6CXm012zfi
	BHj20Y5i34zxQiUbFas0HySqfsT/2PCL7uKRmkU5puZII+ZYjnYZ7jZGTmaoFFUf8BD6De
	vb1sfZwm/U6KP4nAYLy8GI0f2IHDDO8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-CG5LDTlPPCahFtjQF76icA-1; Thu, 09 Jan 2025 05:19:55 -0500
X-MC-Unique: CG5LDTlPPCahFtjQF76icA-1
X-Mimecast-MFC-AGG-ID: CG5LDTlPPCahFtjQF76icA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3ce91c403so719451a12.3
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 02:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417993; x=1737022793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDFZvC9ufxrWv6tOwpxDjE36uvyXj6GJcVYLoUQ5PZw=;
        b=MpNtnN2B+XHW23amGLf8qj4YCHzZ9Uc8ltljyBPGXBKybTIW7fWyKgmHKx9MMZ/JYY
         42FJccOKrtXY8RQ9fCJAyLqBQfECsft5fn4cRc/EFL3o/VAug/DmGO+1Y0QuHGnH2+ia
         iPivqOABxvi2g4YXd21jQwbNIrnrC2soW/oui24ieaX9fo3VIgGLrjnMXeii3jrkKeRL
         n7dTZqXewHu9v+HvhcnY2/fhK/HRZw5uSAARwP67MNyo94tS4MPMKDd27dhOZ33YkUP8
         v/s4cgjlzBlsjB2bTRcOiD7L9Ut9fkKO9E7YGweP8mtYQyYebcG3XLRuYFmiBHcRFJYc
         PYng==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZEf+Ryv/3Ii7wm6+QjUO3CCwopwfYh8pGG7AWYbzW8pbTAfDzswUU/igs/EmG03NU+Zm5t8lItAbjuD/EA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeSbkozR5+kzxy21/iBG9VavKfAKsE/f+VVJ9lZfovvPQJvFhC
	1cQbsrHfCo17erUAa0jIAx4SCzGnxFFoaGoImxUX3W/NH6NT8kF65zZJkJbLou/QpZsyhXRbrim
	XbTKgyk3qq33NZNg57qj2k2fUtbbw6u7WJlbekAnND4ECKlLvjwKSCGT33c8dXzJY
X-Gm-Gg: ASbGncvzp94Ee8/phyfn6ClT+KvkMdQ5nM/qSOTBpAZw6bEG57H6lNB3UCn+YafnDh4
	r/Olb5qgFBZqSF6SCqmvwoeZfSrHpakHZekN0Jm7g56Xdar3GCOCJjLhorvyddRPkRQWfGHd/qK
	YIrUwHjox04xVzgZBxjdiyAa18oMg3fBehvapYg0X6Asj2WWxmQsqgDp1B6kEOsPQFlWUlGxQU2
	FuqI5fSmBk1Gcnssk2JHh/Mm1XYDWN7QMj6vxgx2KNO9Z/vjVI=
X-Received: by 2002:a05:6402:5241:b0:5d0:f904:c23d with SMTP id 4fb4d7f45d1cf-5d972e6e094mr5985348a12.28.1736417992880;
        Thu, 09 Jan 2025 02:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeBBoWzpbGVe1gFjSBCCyHS+IRJ7sCY3Bae6DxEpGXChaWI3GoCv0AgWmxcGb5rxQohjRKQA==
X-Received: by 2002:a05:6402:5241:b0:5d0:f904:c23d with SMTP id 4fb4d7f45d1cf-5d972e6e094mr5985315a12.28.1736417992509;
        Thu, 09 Jan 2025 02:19:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c366sm460727a12.17.2025.01.09.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:19:50 -0800 (PST)
Date: Thu, 9 Jan 2025 05:19:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Boyer <andrew.boyer@amd.com>
Cc: Viktor Prutyanov <viktor@daynix.com>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250109051337-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250107182516.48723-1-andrew.boyer@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c64dKZJGDR0I91eC5B67UDNnava3Dj2kMqFDIl8u8K8_1736417993
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2025 at 10:25:16AM -0800, Andrew Boyer wrote:
> Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature
> support") added notification data support to the core virtio driver
> code. When this feature is enabled, the notification includes the
> updated producer index for the queue. Thus it is now critical that
> notifications arrive in order.
> 
> The virtio_blk driver has historically not worried about notification
> ordering. Modify it so that the prepare and kick steps are both done
> under the vq lock.
> 
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature support")
> Cc: Viktor Prutyanov <viktor@daynix.com>
> Cc: virtualization@lists.linux.dev
> Cc: linux-block@vger.kernel.org


Hmm. Not good, notify can be very slow, holding a lock is a bad idea.
Basically, virtqueue_notify must work ouside of locks, this
means af8ececda185 is broken and we did not notice.

Let's fix it please.

Try some kind of compare and swap scheme where we detect that index
was updated since? Will allow skipping a notification, too.




> ---
>  drivers/block/virtio_blk.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3efe378f1386..14d9e66bb844 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
>  	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> -	bool kick;
>  
>  	spin_lock_irq(&vq->lock);
> -	kick = virtqueue_kick_prepare(vq->vq);
> +	virtqueue_kick(vq->vq);
>  	spin_unlock_irq(&vq->lock);
> -
> -	if (kick)
> -		virtqueue_notify(vq->vq);
>  }
>  
>  static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
> @@ -432,7 +428,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>  	unsigned long flags;
>  	int qid = hctx->queue_num;
> -	bool notify = false;
>  	blk_status_t status;
>  	int err;
>  
> @@ -454,12 +449,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		return virtblk_fail_to_queue(req, err);
>  	}
>  
> -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> -		notify = true;
> +	if (bd->last)
> +		virtqueue_kick(vblk->vqs[qid].vq);
>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  
> -	if (notify)
> -		virtqueue_notify(vblk->vqs[qid].vq);
>  	return BLK_STS_OK;
>  }
>  
> @@ -476,7 +469,6 @@ static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  {
>  	struct request *req;
>  	unsigned long flags;
> -	bool kick;
>  
>  	spin_lock_irqsave(&vq->lock, flags);
>  
> @@ -492,11 +484,8 @@ static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  		}
>  	}
>  
> -	kick = virtqueue_kick_prepare(vq->vq);
> +	virtqueue_kick(vq->vq);
>  	spin_unlock_irqrestore(&vq->lock, flags);
> -
> -	if (kick)
> -		virtqueue_notify(vq->vq);
>  }
>  
>  static void virtio_queue_rqs(struct rq_list *rqlist)
> -- 
> 2.17.1

