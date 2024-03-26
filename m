Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB31804F
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439352; cv=none; b=lnjbAZK6TXQ8NaGLvS5r7VYOsf/lve9LkpeQE4lw7OpSJmCHOUG21agzLDrWI++rEo/H79+gdj0K8aTpVtLDwIs7lrDGBdoVpoeQxv+bU8EaG5ohBTpDY+O48TvT9ZFwCyb9xk5Gos4W7ridMIN+TjlSzNoY+NzRKsfqMPqEVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439352; c=relaxed/simple;
	bh=YyI5P87eoxZmEYXRLjbKSoKqp/231zJ+E03srPerGOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FqAU0JhIVIrPCgZDLFR9e6GRNscUu2Ggp4bx5JMohaCIfnbU+eJprbmYq+TPP6q/PRoHTrTrfNqWUDtwobmcjBiwgYoMXZIbCnD5iA7avCB++7y46wRYmfEE1emKpbGxtssS3nUFHX6yQMGOaDWoH9sG/rae7IUu++wcoGGOgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EgmkFOMh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgmkFOMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711439349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1Uq7z4YPDu1tfLjrShk+kcEkEswJznbeM6Yc8BuQDY=;
	b=EgmkFOMhPPgmvLV2A9yV3L7OvFtJ+6f7lzKZU0HzePl8trQLARNFg0TV3zGC43/lU+ruxZ
	gTeWwIA2Aw4x6GXO7cj7wUXc+1xCVkD9mxeCRL2D4OmlKE/uZRzv9yO9Q3FcCebiO9JGmQ
	k21guD1UczypzDNk3jiNeylQNU0cBuI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-7oQ_FhqZMl63NMrK5GNJFg-1; Tue, 26 Mar 2024 03:49:08 -0400
X-MC-Unique: 7oQ_FhqZMl63NMrK5GNJFg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ec308655eso1321248f8f.0
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 00:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439347; x=1712044147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1Uq7z4YPDu1tfLjrShk+kcEkEswJznbeM6Yc8BuQDY=;
        b=XcYp52vecCp2qjQYTZyn/VRgtgXQ7D97ZVzIgj8RofyS7UucN13CcItJ8FgrPs8o7E
         SpksG2q2WyLZPCUy3t//EWXkGG3YhnzpIpJRX2JO0MgCpT61O//ohVhPl6EdS06Bq9h9
         u2fpGgdVKaHmhvfDIu8scLOazmBW7wvbydWVwIgzjaHb7O5ffJY8TPCVp0CY5AkOYvQG
         A+8TESeamiyZsf6QjJSygAFGKqpHxoHJQgdgm0P8Wtiky++UP4JcCGldtl49rJaB3KDR
         UJrnKPWlx6hJWPiDi6Csv9VZNzpqJ888SqzyLq0/E43RGQ00T1HEd6kVcWwjTf01rbos
         JEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk8bs5NhEahP0MN2otdRH7X49U/8cuX14i3+1UvZi41QK3vk8foBjxJjBmBynnlWe7kUIGrUTVoow8iZ77leBlfPYULqbKYdu9Z1SHvYs=
X-Gm-Message-State: AOJu0Yy2M7pQ4dtmQAEd6ifWE56m++8MMsOtVdKUiXFs6+awc1mHXJ+7
	lczoqKfizYkZIU5QMm36gOtCcrq6ea+IKxIeOtVfdhq+EjYuRibOk+oMihaVtvLMEK0IPklGcEQ
	tTBffyAfIq2tnR5V40QBbuWae/QIk4sXSs9bKSlEVHCLv7nvzUMgD6DvbeGjZMAJw
X-Received: by 2002:a5d:6e01:0:b0:33c:deed:6745 with SMTP id h1-20020a5d6e01000000b0033cdeed6745mr7043790wrz.13.1711439346717;
        Tue, 26 Mar 2024 00:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDZ76bKRqpYhB8UU97OH4GlDC/CvSpy1jx/iBj2k9Bsb4KVn/8tVO+C3bjtFRt0oGNKjWMFw==
X-Received: by 2002:a5d:6e01:0:b0:33c:deed:6745 with SMTP id h1-20020a5d6e01000000b0033cdeed6745mr7043768wrz.13.1711439346203;
        Tue, 26 Mar 2024 00:49:06 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e8:4f00:4a9d:49ee:c7ac:ea36])
        by smtp.gmail.com with ESMTPSA id u13-20020a056000038d00b00341c934ae4asm6449808wrf.75.2024.03.26.00.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:49:05 -0700 (PDT)
Date: Tue, 26 Mar 2024 03:49:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240326033809-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2024 at 05:34:29PM +1000, Gavin Shan wrote:
> 
> On 3/20/24 17:14, Michael S. Tsirkin wrote:
> > On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
> > > On 3/20/24 10:49, Michael S. Tsirkin wrote:>
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 6f7e5010a673..79456706d0bd 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >    	/* Put entry in available array (but don't update avail->idx until they
> > > >    	 * do sync). */
> > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
> > > > +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
> > > >    	/* Descriptors and available array need to be set before we expose the
> > > >    	 * new available array entries. */
> > > > 
> 
> Ok, Michael. I continued with my debugging code. It still looks like a
> hardware bug on NVidia's grace-hopper. I really think NVidia needs to be
> involved for the discussion, as suggested by you.

Do you have a support contact at Nvidia to report this?

> Firstly, I bind the vhost process and vCPU thread to CPU#71 and CPU#70.
> Note that I have only one vCPU in my configuration.

Interesting but is guest built with CONFIG_SMP set?

> Secondly, the debugging code is enhanced so that the available head for
> (last_avail_idx - 1) is read for twice and recorded. It means the available
> head for one specific available index is read for twice. I do see the
> available heads are different from the consecutive reads. More details
> are shared as below.
> 
> From the guest side
> ===================
> 
> virtio_net virtio0: output.0:id 86 is not a head!
> head to be released: 047 062 112
> 
> avail_idx:
> 000  49665
> 001  49666  <--
>  :
> 015  49664

what are these #s 49665 and so on?
and how large is the ring?
I am guessing 49664 is the index ring size is 16 and
49664 % 16 == 0

> avail_head:


is this the avail ring contents?

> 000  062
> 001  047  <--
>  :
> 015  112


What are these arrows pointing at, btw?


> From the host side
> ==================
> 
> avail_idx
> 000  49663
> 001  49666  <---
>  :
> 
> avail_head
> 000  062  (062)
> 001  047  (047)  <---
>  :
> 015  086  (112)          // head 086 is returned from the first read,
>                          // but head 112 is returned from the second read
> 
> vhost_get_vq_desc: Inconsistent head in two read (86 -> 112) for avail_idx 49664
> 
> Thanks,
> Gavin

OK thanks so this proves it is actually the avail ring value.

-- 
MST

