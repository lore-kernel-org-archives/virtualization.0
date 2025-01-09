Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E929218AC1
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430166; cv=none; b=sSxkEaGzeX8Ze0MiWFMFi4DkgjefG+cK7MNcU44RsEyGgjrwiRwZqhlptjdvODAEVBJn8ejktJQOJgm7zkQBV4BVssEnIpgAL3BdUZef0VMsSBbHjQrqmDnu6bYQYE7rJXsmFvFWN8SkIeDO9agOCMXB+UJ6wNUksBGv9QB9ECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430166; c=relaxed/simple;
	bh=D1tjE5WV0xVZYCiZTVJnAnSFOYdaDTE40svfqGvt1G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fDzxh69zueuBpPfnUOZWsGJv3YMlkEcbZNStOCvyj0c51aVgjV4FJB7djParCAERh+ehFmwyn06yJ5ysZklht3eTM0MR44xQLsHbZqkJK/yZvjEAnj6O1g9urdiOLWI2kJv4ZdUVX/G/5eqX83pWLYbRtnYs0RKFqRB9YYKW2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlORmiwv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlORmiwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736430163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgu9dbtLOnj3MXP8lMoAJCySQHxuL505OovVfJN6VOY=;
	b=KlORmiwvy/wpHR4nRrud6n7BJPSMsRgikC/ly03ZZxyXhhSt8XmienW30HIMotHk3c8WhL
	EZqOf+G4aKjBIhHlTWE0bwkV3IXd1O0n/yKQIW3eDbXTUkFj4uH034VBgMrCbSM+xob8/N
	juQ88tEAWvs9hr00iu9LzCZxEyUCe2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Jntj6V6pOwSWzFTRlB56kg-1; Thu, 09 Jan 2025 08:42:40 -0500
X-MC-Unique: Jntj6V6pOwSWzFTRlB56kg-1
X-Mimecast-MFC-AGG-ID: Jntj6V6pOwSWzFTRlB56kg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43582d49dacso6269455e9.2
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 05:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430159; x=1737034959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgu9dbtLOnj3MXP8lMoAJCySQHxuL505OovVfJN6VOY=;
        b=TDOy2G7Ocyc71p/nppKeViPgmBGtryPTMF+mralgqVcd9rqVMHDb3zk8Mqp2YjgMAz
         DLflrp5hWbZ6GCHUbXtTDI7Ul5uJbmAz6byFXn+BkMnZPehxVaWAE/0WCJSWf+cFA+4B
         UjqgEscaC6Uh3FOLA5irzBSfvk6Ozh48tOiW01V2AvhRORgz8xRntVzw0QPoxCYSD+A0
         B7qr0kJLT9uhVz/PB6jqxSg7IbQrvUGijj26jyzAh8w57J5EH2prsiL8WRIFCdj3ryAD
         W9qg5uvdEDKoBIke22ONdSUA4KRhDJLD9H3OHKlQpxkPqtcaDG7bnLkcDVLqU5QvDQiE
         1tDg==
X-Forwarded-Encrypted: i=1; AJvYcCUfgWvxJj6iFKPhe83Ir0IhWh69LmlR6VikNco5/SjMQLpd9hxj/WVVdWdvkeRvMunF3Hiu65iHD0jD08fFGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMSLIjikJNshz5xu4Ls0uJ/+X6vJmSXhfFYKept1j1CJk0DIyJ
	mP1vzNW031nPAYGhWvdgJJ3Z2XCBayFZQznmo9gL2A5bzshGcmBH7ifniBf9Nm3GlBcMj1lIh1e
	kPMXoprj8Q1X4F4rFQ9udt4NJtc1iuFlgdz2NxANUl9CGsPIF1j7uyjGxD9lvr+2o
X-Gm-Gg: ASbGncvP+M4HkaoeJVQiH01/41hmx+XjNskNaKYJYc7yqkrIwPBA2mHEVzZbqpFjP0E
	hoHUQihXP+pb9iwSiKY9LParyuGXtxJ7sBZxre6XYn+l7y5ecISCbRUyARFt6A7/gQV0UJFcDh+
	0S17jm9J063/TvYaVO0uKRuZbcLw5/neIlLxgJ8JdAnt8H80eFHJkppjpKbwezPY1kSZNWC43Q3
	iXemrycYLH6BB4J54zC/4llvb8NUkatUoD/EH1gwlmW7qetbmA=
X-Received: by 2002:a05:600c:4446:b0:434:f335:849 with SMTP id 5b1f17b1804b1-436e271cce0mr60626835e9.29.1736430159638;
        Thu, 09 Jan 2025 05:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWDZ/uz1Nn0qr7lYuRqwiS3nX0As1S7bC6v6LIqtZB2UDhqaEg4XL3T6juiTHl0iuzd3D6AA==
X-Received: by 2002:a05:600c:4446:b0:434:f335:849 with SMTP id 5b1f17b1804b1-436e271cce0mr60626385e9.29.1736430158984;
        Thu, 09 Jan 2025 05:42:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d3bsm21221385e9.31.2025.01.09.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:42:38 -0800 (PST)
Date: Thu, 9 Jan 2025 08:42:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Andrew Boyer <andrew.boyer@amd.com>,
	Viktor Prutyanov <viktor@daynix.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250109083907-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: efsiV_aKKQdpI9vTedbLz-MXQ5ULQslTztjgHPbAMZc_1736430160
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2025 at 01:01:20PM +0100, Christian Borntraeger wrote:
> 
> 
> Am 07.01.25 um 19:25 schrieb Andrew Boyer:
> > Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature
> > support") added notification data support to the core virtio driver
> > code. When this feature is enabled, the notification includes the
> > updated producer index for the queue. Thus it is now critical that
> > notifications arrive in order.
> > 
> > The virtio_blk driver has historically not worried about notification
> > ordering. Modify it so that the prepare and kick steps are both done
> > under the vq lock.
> > 
> > Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> > Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> > Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature support")
> > Cc: Viktor Prutyanov <viktor@daynix.com>
> > Cc: virtualization@lists.linux.dev
> > Cc: linux-block@vger.kernel.org
> > ---
> >   drivers/block/virtio_blk.c | 19 ++++---------------
> >   1 file changed, 4 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 3efe378f1386..14d9e66bb844 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >   {
> >   	struct virtio_blk *vblk = hctx->queue->queuedata;
> >   	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > -	bool kick;
> >   	spin_lock_irq(&vq->lock);
> > -	kick = virtqueue_kick_prepare(vq->vq);
> > +	virtqueue_kick(vq->vq);
> >   	spin_unlock_irq(&vq->lock);
> > -
> > -	if (kick)
> > -		virtqueue_notify(vq->vq);
> >   }
> 
> I would assume this will be a performance nightmare for normal IO.

Indeed.
AMD guys, can't device survive with reordered notifications?
Basically just drop a notification if you see index
going back?


-- 
MST

