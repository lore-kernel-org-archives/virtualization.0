Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42E1C5D61
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583666; cv=none; b=rHZN8F+Z58fiY5wbv2H/KH/skmqdyJEZL0JNmu9OA8THWCjZSMCXZM2M6psqpMkPy+0HKCKbtacv3KeSnPH3XI3+M8GdG0yK4Ts8JlzeA9DkcnOawbTAgFJAvNcwTJCziqA1s41pAmcFKYFHkj9DRI55pvp1d1rlW09WYtUZD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583666; c=relaxed/simple;
	bh=74wRxD2l9NYLAbB9LebrUEkWa4OpLYkBLpC76xxkA/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MzqyVynGqpA/89LX1NaKw1uqGQ1Z6UHDShQoJIChtxbT8hq2FywgVluqo6Y+oHC2WshUYYuelpQLGQvba4tyU3zhr5ZowHhqZzRllWaOtDhkDo5LVINjQTabc0O10Rtuj6osIHEP0ubgAxYx0iRf+SMqsWPVP+NPz/Upp3+y6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WN6zGm2n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WN6zGm2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737583664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjdmbjBOcMVmlf2psJyAfY3tW761wBaRxSZPkXVWANY=;
	b=WN6zGm2nT7WY30RGXSj0RhjdLo4e09xe775NkokbmDDW+nvhKWtYqMj8nc5yU87HmIs3Dt
	ytRgx4suvZ0o5z+8ImFhFbuJ2aC7FVfGk7S5VzujnOl/A6m77UGFFGxDLBieRQxWldRIr1
	eBHvmex4uQOcofA1hP8ympxMaQ8GM0A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-a2BRQ_lPNni90Dm4K3z5-w-1; Wed, 22 Jan 2025 17:07:42 -0500
X-MC-Unique: a2BRQ_lPNni90Dm4K3z5-w-1
X-Mimecast-MFC-AGG-ID: a2BRQ_lPNni90Dm4K3z5-w
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d9fb24f87bso289141a12.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 14:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583661; x=1738188461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjdmbjBOcMVmlf2psJyAfY3tW761wBaRxSZPkXVWANY=;
        b=vGMYLZWPkFMP4X2mcRsutEZCMoxQMHxzAyjl4Fr/zjLtDDzZZBkQtr2/Z3qJFBHbT7
         nifHJd3Kjb1x1qjol5IbBlphBKV8O3m27OYiqA/2C4QaH1hRYR746yIqYFSRwtni+jCM
         jI+hRJ7yYQMlTIPEditYBRNiSWCzfIT5p+8TPG8BnUpqEee6WYklIuqzQF0VaBhEVt5I
         XCrbIheIsHh074YxB1eZiBO5S70iz6vE9Wvv9EwXBLc5ZWchrDZjSP3XxojxzBZ9At82
         KClxmCO/hLR4JCIgMt6iFyUjUZgCeso3pxkcbLAdiavhk2DVRvqTaCYlOLCtYOifxOLG
         FBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV1JXP2i1ucA8lmtcT2vLgHmQbL1/iCve8knCc8a76tdMBlKDwRH0UpvK2QFSYVqUzu5f3wBjA+TBuoyRaMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy8D29B6ExfgP/gaeAQrvGp1bExkc66Ck0HdLy2KgI4/0ysoin
	8tJP2nUsemEABRMwPbC15Yntx+YiLy6ilnKt+096nzw3ukYEnjDVckuMNrzanZdr/Dfl2cFA+Ow
	W1TZSdHAfA1UhSF0OTC8Sp/6sWkY3u6E+2dgKRSy8ZbM3yvbm47HpyXy1jSHkAy+T
X-Gm-Gg: ASbGncuVFscz9oE6rNL23ytQhSaALTVjg1I6GvfHsHkQGcyYwl7Wu3og3DWsDrdQ7cC
	3i4XzGpB2STI2rDgnHfoxNIabNsKnOhhK3I8MkCnHXiaUDptQl7b8XKIjgggnP509BA1wi8tZxt
	pRfyhkCKM3EfQGnQ1MPx8Sg6tgNby1RBUovLV6fwduBGC4URK0nDZkFvO4IWDZVEUYVFGwX3P0d
	KoD/9voYUy5FuBfi/QwV98rvwapML3yccdeRA1QO6B5swYUdRaDqgMcgjs4zPL4vg==
X-Received: by 2002:a05:6402:849:b0:5d0:d91d:c195 with SMTP id 4fb4d7f45d1cf-5db7db06f81mr20073889a12.32.1737583661647;
        Wed, 22 Jan 2025 14:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+VdiTrhSWqrbzQ+FfBJ/MkrLYio8KHyB6V6/BJIlVFbB7omc0W4ZRr8xC2O258A5DQTwKzQ==
X-Received: by 2002:a05:6402:849:b0:5d0:d91d:c195 with SMTP id 4fb4d7f45d1cf-5db7db06f81mr20073870a12.32.1737583661282;
        Wed, 22 Jan 2025 14:07:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb769dsm8921797a12.50.2025.01.22.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:07:39 -0800 (PST)
Date: Wed, 22 Jan 2025 17:07:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: "Boyer, Andrew" <Andrew.Boyer@amd.com>,
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
Message-ID: <20250122165854-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CF3QOXWoznK41-X3TSELW8IQwAJFsFwhl6E2Zm0bCGQ_1737583662
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> [...]
> 
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > > > >  {
> > > > >    struct virtio_blk *vblk = hctx->queue->queuedata;
> > > > >    struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > > > > -   bool kick;
> > > > >    spin_lock_irq(&vq->lock);
> > > > > -   kick = virtqueue_kick_prepare(vq->vq);
> > > > > +   virtqueue_kick(vq->vq);
> > > > >    spin_unlock_irq(&vq->lock);
> > > > > -
> > > > > -   if (kick)
> > > > > -           virtqueue_notify(vq->vq);
> > > > >  }
> > > > 
> > > > I would assume this will be a performance nightmare for normal IO.
> > > 
> > 
> > Hello Michael and Christian and Jason,
> > Thank you for taking a look.
> > 
> > Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> 
> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> Really, dont do it.


The issue is with hardware that wants a copy of an index sent to
it in a notification. Now, you have a race:


thread 1:

	index = 1
		-> 			-> send 1 to hardware
           

thread 2:

	index = 2
		-> send 2 to hardware




the spec unfortunately does not say whether that is legal.

As far as I could tell, the device can easily use the
wrap counter inside the notification to detect this
and simply discard the "1" notification.


If not, I'd like to understand why.

Thanks!


-- 
MST

