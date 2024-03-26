Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73371727
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445944; cv=none; b=IJxHIHJq/mfKcronKil+nSwgdmTYBe/gYuuShNWpM/4R3KLfia3qjXdfFPRIcdKBM+Ez331sti8dwyF/I92JyaaGc8g15K1/uJ+97BBquC+psrgzeiRdGj5aia0D5jFEKt+2lRIINOeAem5CBer+66kSh+HX5FFvV3OCOvYclRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445944; c=relaxed/simple;
	bh=SxX4N38CRIZ9wOS6MJ+Zdg1b6RZz4tLgVJyZOhtiMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXXGJQzEHd8TQlTKHnDu/XCCnxmPkQkdxNvGF2ee3lWBC4uNFKd3P+k+tSZT8p3LOhfp0VWfAatPDwGKqhYZTCkTofLxV5oVOr8bUQ2idwuMguTyxGxE+5T8SQkdnNNx+lQ/iH59aJrBUjDnG4Sl5kuW9+6/LjfzJB5RzJ4iQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsIYwwBj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsIYwwBj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4140eed8a4fso51005e9.0
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711445941; x=1712050741; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBfa7bD+DHZlqzDRNnmeC7FlWZiV7yjPXXmtlDzPpsM=;
        b=gsIYwwBjFfm9ltUTFFO5WpSFOVtTbH0ixxBZF03WILPcbIUv0m+TlXutzs4IohIWaI
         HcV4ts1zVaao5zTIZF3FL9X50f1IScXNHPDK784cYzXbxUn4+tc2dC7dbPCBYUP6u92P
         FnRRegcpCSn3ZGx7SPKbq5qmlxxsLlLoKp2a8w4dNowwwymk3SdJXgDMFhP2BzirjF8A
         7UjbiBi/+6goBOPcbyL39BM2EfrYj/uxVuUiQXSsbZ5MBznDysCDotbjuYjfARGNbJPE
         F7/roeiS3SvxE/0w9Xkn0AoBcahu2hnpiZp0Na+L7uTQOtCS56In5XL0VCH/cUAx71jI
         y0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711445941; x=1712050741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBfa7bD+DHZlqzDRNnmeC7FlWZiV7yjPXXmtlDzPpsM=;
        b=SIXBtAh5I6RqH6jo47GuXc/+7n8MH2pJyacdNCLiDhsHAMflWfYIRuyISp1KE93D8z
         y1pLjGqHDiI4N6PUUjzDOnb5UTBw/U4vNKY9Es7I1UYQOXkPPwOcDuDbQ4WCOidZC7uU
         4L7bM2bQMfExUh8jZTRlHVvzPR/78sdCkl7dVmJk5db9B+976B2IPJKVjthoL7RRFEcO
         BUFcwyx04HJYQBW72SGVZLvThReywfJ0/+bSL2co5AGKTpre13YGguCkYs0clCQZgqVK
         vAIdAeBYkJyE4UK9Tr6q0nooM3fggxomlL5URYJNhZXQ0eKF/mQylb7x2I7An+JHPWHG
         XNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWCpmMq898XCL9pv3bLC8ITYnD9tKeBYG9SRi+zfMAMgfXMeJOfOSqIq6b0aEIF6l7MkNRIWdGcyDeLCJVJe2sBWcrJpKigSZ1+s1Ma9hg=
X-Gm-Message-State: AOJu0YyttZfnN2XKRqkRs23lt1BwJZZP2k0T8W3DFqRZ+dKwOBST8kLP
	IiVgrP4eJkYLgULXzAn+9GjXVjOCV/LYEhjwI3ytpOzmT5VM5uNBi/I0/5Yg9A==
X-Google-Smtp-Source: AGHT+IE+q/VP+Y5OuAlcSHXpSI2sdtUwAKOteOf+H3BRkrfJpESuCtSgjAvRcoND0mJ6ryAOmNSbIQ==
X-Received: by 2002:a05:600c:6cf:b0:414:908c:460d with SMTP id b15-20020a05600c06cf00b00414908c460dmr19791wmn.7.1711445940511;
        Tue, 26 Mar 2024 02:39:00 -0700 (PDT)
Received: from google.com (105.93.155.104.bc.googleusercontent.com. [104.155.93.105])
        by smtp.gmail.com with ESMTPSA id g23-20020a19e057000000b00513d244005asm1491791lfj.199.2024.03.26.02.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:39:00 -0700 (PDT)
Date: Tue, 26 Mar 2024 09:38:55 +0000
From: Keir Fraser <keirf@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <ZgKXr8IQ51xBECuP@google.com>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326033809-mutt-send-email-mst@kernel.org>

On Tue, Mar 26, 2024 at 03:49:02AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 25, 2024 at 05:34:29PM +1000, Gavin Shan wrote:
> > 
> > On 3/20/24 17:14, Michael S. Tsirkin wrote:
> > > On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
> > > > On 3/20/24 10:49, Michael S. Tsirkin wrote:>
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 6f7e5010a673..79456706d0bd 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > >    	/* Put entry in available array (but don't update avail->idx until they
> > > > >    	 * do sync). */
> > > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
> > > > > +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
> > > > >    	/* Descriptors and available array need to be set before we expose the
> > > > >    	 * new available array entries. */
> > > > > 
> > 
> > Ok, Michael. I continued with my debugging code. It still looks like a
> > hardware bug on NVidia's grace-hopper. I really think NVidia needs to be
> > involved for the discussion, as suggested by you.
> 
> Do you have a support contact at Nvidia to report this?
> 
> > Firstly, I bind the vhost process and vCPU thread to CPU#71 and CPU#70.
> > Note that I have only one vCPU in my configuration.
> 
> Interesting but is guest built with CONFIG_SMP set?

arm64 is always built CONFIG_SMP.

> > Secondly, the debugging code is enhanced so that the available head for
> > (last_avail_idx - 1) is read for twice and recorded. It means the available
> > head for one specific available index is read for twice. I do see the
> > available heads are different from the consecutive reads. More details
> > are shared as below.
> > 
> > From the guest side
> > ===================
> > 
> > virtio_net virtio0: output.0:id 86 is not a head!
> > head to be released: 047 062 112
> > 
> > avail_idx:
> > 000  49665
> > 001  49666  <--
> >  :
> > 015  49664
> 
> what are these #s 49665 and so on?
> and how large is the ring?
> I am guessing 49664 is the index ring size is 16 and
> 49664 % 16 == 0

More than that, 49664 % 256 == 0

So again there seems to be an error in the vicinity of roll-over of
the idx low byte, as I observed in the earlier log. Surely this is
more than coincidence?

 -- Keir

> > avail_head:
> 
> 
> is this the avail ring contents?
> 
> > 000  062
> > 001  047  <--
> >  :
> > 015  112
> 
> 
> What are these arrows pointing at, btw?
> 
> 
> > From the host side
> > ==================
> > 
> > avail_idx
> > 000  49663
> > 001  49666  <---
> >  :
> > 
> > avail_head
> > 000  062  (062)
> > 001  047  (047)  <---
> >  :
> > 015  086  (112)          // head 086 is returned from the first read,
> >                          // but head 112 is returned from the second read
> > 
> > vhost_get_vq_desc: Inconsistent head in two read (86 -> 112) for avail_idx 49664
> > 
> > Thanks,
> > Gavin
> 
> OK thanks so this proves it is actually the avail ring value.
> 
> -- 
> MST
> 
