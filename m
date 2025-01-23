Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E920B208
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615828; cv=none; b=g/KnxftqXqOfJv13T8b9T9ym8y/UUCq5Z6P9Vw/BGj+4OWYtp5+syWoFA3Xj+wEflHvh9xUozsQ2O3gFzqVzYbke82I5nVEWTVVh3KfLPOMSyJijAHb4nvJ46eE9SaD4hiXCJWKLAeeDbTGgxR2Pyw2LIi+QlOpLkREX8O5rgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615828; c=relaxed/simple;
	bh=s9QPfHCug/TTc7ih5INLxhU5stPSkgxsIUYeD5PQ7SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uTHxsYdYMkbKyfA5INaQX5xhXX72tZ/doeY/UTXyPcA7zTyAhING7et2FU3V7exISkHKq3d+gjwFfei/zO7YukVt20kOYZWvkKijjhVCP8mw+0pGAsWCLUlzyGG0P9GA1Ruk6sD27goDCILUilQoYpqSXTW161nKWHpKVZ0joAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwqLxfei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwqLxfei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737615825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmWi+dVPUtT7M+4KcwcY+3ciCBE1YMwS0vc2Gr6Z8F4=;
	b=fwqLxfeiRiAM18TrEsx/F6AtwzJs64dTqNH8IkW6o9+eQhOXqoSZnjuFMc2WzedcBXxmaj
	3f3tZDo1K9oyyKp4pASdHIxW2kC/m714iI3KzI/0J9/ZsSS5fEptZ6ASu2TrCbxGXR6Vsu
	ZTvkYrTmcMZpByl1ERMN73McCiW5p4k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-cH1F78xgPOO02LX2qlOiGQ-1; Thu, 23 Jan 2025 02:03:43 -0500
X-MC-Unique: cH1F78xgPOO02LX2qlOiGQ-1
X-Mimecast-MFC-AGG-ID: cH1F78xgPOO02LX2qlOiGQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aaf8396f65fso53444566b.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 23:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737615822; x=1738220622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmWi+dVPUtT7M+4KcwcY+3ciCBE1YMwS0vc2Gr6Z8F4=;
        b=qEZdXmTq7nVTBXpxpiFbRkTQD46UzbGX99mJc7q20mN4H+Z5k6AckdCN6NgfHJgQiP
         YbRoA5Pw7u6yxD5SLEAr3jAw7WQfxzsZFl5snUHqSgZ9xcHStdvIazSq1aHA9DBsxDWQ
         wMWgzFtfbqwFmGzdMooEPPJvkZ9+Bhs0kgxYz1qHPKoK9jbbObwYoIeQrAZAfkGocoMg
         5UkV3KcF5+lEWUGlR5/8mxtaqjboQ1NPPGYKRWZpp3P5TcDxy/1lJJpYkiB9Rzp03GWm
         rUmNm3a7+c0CGVBY/yVUG00843Iw1kix0h6uLbVGlJoA3/eylR3RGZC4yAAdQZa81C0m
         E4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUDe7xUrDwlFTNu1Dhg0UGSNrHC9aaQDftQxNqd9c68wH6JqryBFiY2RVSGLqsLXVOF3d8xsSP0ZOndmKt3sA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRLCFwMzSxrrA/cAWikyaO6YT4REqlej425+yC5FJHmPsMN9Sr
	PAszh2Y3Fmmq121RlAvbrFE2iYVJiMPY6ZR3bzkTPr8wBuIO57T9aCAvHRY+5LsCGpePgnFKJft
	MWYX3sY1tz8ItICZfrSdQw8l13qSAbtS1tTW4BDXb+gUvjmdL6Hmdu35L9AqO6YES
X-Gm-Gg: ASbGncsFh97yGzeCvmExRHaHvzbVGE0zj+rdHH9ykvlqweBa6KFlyzl+mTd17HAeNqJ
	ZA+hhq96YJSe8SfVLj7y4qZ41mn5lgUy6wymo8g9C194IfaoA9JWTXZQ0Gwk9uFH4cxovJBEzHw
	D2L4Z8ZM90IY6J/tbBcNdUt3gGH2Eji/CZKJ+tfsCARB5wziZZmJt9nxs2+FMl3+G3V4JEllHUy
	hOg17YQAa15Ip9ZVNhCbaZflByWPdCbI4JLT0s8OJ8iFTMRSnTkufcPvrZpM+eR5g==
X-Received: by 2002:a17:907:7291:b0:aaf:3f57:9d2e with SMTP id a640c23a62f3a-ab38ad88887mr2332081866b.0.1737615821996;
        Wed, 22 Jan 2025 23:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6ZQ0xkB6wBE4/B7eKO7BqqlMTsLZBg+wFi6z+YZoVIIe62IALNtl9z3EO7Cew94iZ5rOxLg==
X-Received: by 2002:a17:907:7291:b0:aaf:3f57:9d2e with SMTP id a640c23a62f3a-ab38ad88887mr2332078066b.0.1737615821558;
        Wed, 22 Jan 2025 23:03:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce2105sm1026949766b.67.2025.01.22.23.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:03:40 -0800 (PST)
Date: Thu, 23 Jan 2025 02:03:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Boyer, Andrew" <Andrew.Boyer@amd.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>,
	"Hubbe, Allen" <Allen.Hubbe@amd.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250123015428-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <6BD82C41-B1C5-44C6-B485-9648C0ED964B@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6BD82C41-B1C5-44C6-B485-9648C0ED964B@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r1rFu5KRACkg66UxrEh_eNmmwxKDzcHRgWcbhwWln-M_1737615822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 22, 2025 at 05:49:18PM +0000, Boyer, Andrew wrote:
> 
> 
> > On Jan 22, 2025, at 12:33 PM, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> > 
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> > [...]
> > 
> >>>>> --- a/drivers/block/virtio_blk.c
> >>>>> +++ b/drivers/block/virtio_blk.c
> >>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >>>>> {
> >>>>>   struct virtio_blk *vblk = hctx->queue->queuedata;
> >>>>>   struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> >>>>> -   bool kick;
> >>>>>   spin_lock_irq(&vq->lock);
> >>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> >>>>> +   virtqueue_kick(vq->vq);
> >>>>>   spin_unlock_irq(&vq->lock);
> >>>>> -
> >>>>> -   if (kick)
> >>>>> -           virtqueue_notify(vq->vq);
> >>>>> }
> >>>> 
> >>>> I would assume this will be a performance nightmare for normal IO.
> >>> 
> >> 
> >> Hello Michael and Christian and Jason,
> >> Thank you for taking a look.
> >> 
> >> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> > 
> > The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> > Really, dont do it.
> 
> If holding a lock at all is unworkable, do you have a suggestion for how we might fix the correctness issue?
> Because this is definitely a correctness issue.
> 
> I don't see anything in the spec about requiring support for out-of-order notifications.
> 
> -Andrew

Yes we didn't think it through in the spec :(
So driver made one assumption, for performance,
and the device made another one, for simplicity.

The data needed for the device to solve it, is there in the
notification. We can make the safe choice with the lock, and add a
feature flag for devices who can handle out of order,
or make the current choice and add a feature flag for
devices that need a lock.

Let's continue the discussion in another thread whether
a hardware workaround is possible.


-- 
MST

