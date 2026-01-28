Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32A28CF6F
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597345; cv=none; b=VCk3timq9w7An5V4c+OBENEWFkdlPMYj1HvXefiavbI921tlHvNaRLEWPL2qsabF/5q6YfvozZtemC+De2oeYtLAgBnOYPP/Jmt8D7nNVcusHHt/UwIHkysORWIYGxJ9lmzUVOh0qPtEI6sFKr3zY0+kKViKHUljK1oV/CgLGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597345; c=relaxed/simple;
	bh=WC/kp/3pb+xjmgQjdWs4L2k/DJqsjynrUsgVTKZyg4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mtmRMyq20pENF7k/tYMFT/1ZMo67iwPF/rqbF3fAA2rH1Lvw6KBDWZ/rcdFv4nwZ21djoImgqxg4qzfbsqGdmZ+6HstiXNPaTF+J2iGloTpUWywbcZkVQlxXvFif6FmRUlk9o++2FN2UY+cq9ahlfMPWv4oLe+m/4y1a7X7vX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSJ4tEyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSJ4tEyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769597343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akES2HBrjOOJMcYlD7o6JMYnRn/dV8UGPZwe32MKvI8=;
	b=WSJ4tEyiXEEXNl+xtY2fZLh6Li6pVIvcZAgUs+g2Y+nAR8Q82AtgWHdVPZWyuaiWvj69i5
	GMwRIhvjod+gvzPM/1uq/kLIMLv2w83dlbp4nsAroTgmxu6YWVcGuEBduZA/tD3OnoLZOJ
	NoiLsDhtniZZcZeZPljKHzYYE9YxKuI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-tipP2MbIPSaeW4ihgaNoMQ-1; Wed, 28 Jan 2026 05:49:02 -0500
X-MC-Unique: tipP2MbIPSaeW4ihgaNoMQ-1
X-Mimecast-MFC-AGG-ID: tipP2MbIPSaeW4ihgaNoMQ_1769597341
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fe16b481so4966377f8f.3
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 02:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597341; x=1770202141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akES2HBrjOOJMcYlD7o6JMYnRn/dV8UGPZwe32MKvI8=;
        b=r8qc4d6BOFtbEUsZp7r9ZKUJHlAu3kU6LfAY3aw5Slzvv0ByRfj58UkfKgZczakWrg
         imORCp+4gzYdySqj6CQP00VA38nVBzToBNpdnLaBIEVa3JSPScwJvm6i/uSlX6LB2NkL
         3+rR2PPJPqBZqKDUiz3TWl+84ZV6xR5B0akAUtYDZkqVrRO0S6MKAZ5XZamF49IPtpVx
         y2Fi5BfV+yiYZkpi3UEsDtbKmjzcfOqK+JuVUiqV3EiMxkHZrtt4W5CwoBP2TGuPZIA1
         QXQsS62SE6oIMFJVGenvsbqN/d9iCw02kHX/lcguW+/B6iK8qWqw3ZqylrE72spPJXfx
         JrkA==
X-Forwarded-Encrypted: i=1; AJvYcCVarE6jiR4wFnm2iOGsiM2LkaQkojAX1NTbH/QFS3wJjqmfq5zdox4ThOqIWLngiPnF4D0AvJ8PltHDaO0LbA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgw+E1rGev9cSF5SzjIdoXcnWkJxIrulWvAA3auxMEOozTThA1
	105OyNhDLLIM0M8eeI4S5NRu3HnWGNMrUGxl02WcMDGWBsbQXv1nf3BSp+rGZ1bPEzml5pxlQwB
	S2WXselmiVw9Vh1XurHwltp+ybSL1aDRqy20ZB9zpl1WoGoN4Q4eBtp/qEp/rJOWD6seG
X-Gm-Gg: AZuq6aI8PWTEM2Hvp2tO/hVRbnIcwA/wDVrSpxkHTntQqY/7et/mSDw3o0gJ9k2AHdO
	nxMBvRL8ic+yAQu0XUvzx+26jIGMUNCivKNIu462PMbjPhvqkDXiuCVSQAD7AWp94Q/qCdEG6GB
	OFrxdmZV/L9qr9juXzWJSopb6SgEXf3JCeXL602VdCiPYbifrcGlYYlrx7mARhMWUg/CUj7XjQc
	7Y5fDJFYQLDIjXOtp96GXxQ4k7MyTO5LvvamrY219OhEMpubeoGKg1M5UTm6pNm6bKCKxKqOMZc
	TT24zVVUKQl0YQIAg0pB7yuieFYCVekmUc4r7TbpbJBje0OUPkPlOa3hqY5CZJBmiFuU1ABigus
	AJkeN8dckzyfJ1vCql0G2DAG20hwXkF62lg==
X-Received: by 2002:a5d:588f:0:b0:42f:bbc6:edaf with SMTP id ffacd0b85a97d-435dd0baf9fmr6455487f8f.37.1769597340679;
        Wed, 28 Jan 2026 02:49:00 -0800 (PST)
X-Received: by 2002:a5d:588f:0:b0:42f:bbc6:edaf with SMTP id ffacd0b85a97d-435dd0baf9fmr6455460f8f.37.1769597340217;
        Wed, 28 Jan 2026 02:49:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322eefsm5993981f8f.30.2026.01.28.02.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:48:59 -0800 (PST)
Date: Wed, 28 Jan 2026 05:48:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] virtio: silence KCSAN warning in
 virtqueue_get_buf_ctx_split
Message-ID: <20260128054415-mutt-send-email-mst@kernel.org>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
 <20260127152524.200465-2-johannes.thumshirn@wdc.com>
 <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
 <42d57017-88b6-4ab6-8fa9-10658d268fb6@wdc.com>
 <4fde2f6e-d272-4aa8-9701-63bc6b7e7d16@amazon.com>
 <9004e3b6-fbd0-42a8-b722-bf6d25833dd7@wdc.com>
 <87ee6ad5-7c58-4e40-92fe-57305ce2b00a@amazon.com>
 <20260128053356-mutt-send-email-mst@kernel.org>
 <d80b0dd5-1db2-4796-bb88-37212f6a4d24@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d80b0dd5-1db2-4796-bb88-37212f6a4d24@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UHxQXZpQns94INTo-W-vxDChStSiD04WHWub0dKVl7o_1769597341
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2026 at 11:38:48AM +0100, Alexander Graf wrote:
> 
> On 28.01.26 11:34, Michael S. Tsirkin wrote:
> > On Wed, Jan 28, 2026 at 11:30:20AM +0100, Alexander Graf wrote:
> > > On 28.01.26 10:13, Johannes Thumshirn wrote:
> > > > On 1/28/26 10:03 AM, Alexander Graf wrote:
> > > > > On 28.01.26 09:47, Johannes Thumshirn wrote:
> > > > > > On 1/27/26 5:30 PM, Alexander Graf wrote:
> > > > > > > This patches the split vring format, but does not touch the packed one.
> > > > > > > What happens if you run the same test with the packed format? You can do
> > > > > > > so by passing "packed=on" as argument to your -device parameter.
> > > > > > This opened up a whole new can of worms... :(
> > > > > That's what I expected :).
> > > > > 
> > > > > How do other DMA based devices handle this? Is the real problem that
> > > > > virtio by default does not use the DMA API and so it confuses generic
> > > > > KCSAN logic that would otherwise track DMA regions as "can be modified
> > > > > by DMA at any time"?
> > > > > 
> > > > > If that is the case, maybe what we really want is to force enable use of
> > > > > the DMA API when KCSAN is active. Does something like the (whitespace
> > > > > broken) patch below work?
> > > > > 
> > > > > Alex
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index ddab68959671..b1dd790ce622 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -284,6 +284,13 @@ static bool vring_use_map_api(const struct
> > > > > virtio_device *vdev)
> > > > >          if (xen_domain())
> > > > >              return true;
> > > > > 
> > > > > +    /*
> > > > > +     * KCSAN needs to track who can modify memory. DMA API gets
> > > > > +     * us that, so always use it.
> > > > > +     */
> > > > > +    if (IS_ENABLED(CONFIG_KCSAN))
> > > > > +        return true;
> > > > > +
> > > > >          return false;
> > > > >      }
> > > > Unfortunately this doesn't get us any further (I'd love though, it looks
> > > > way cleaner!)
> > > > 
> > > > I still see the KCSAN messages even on boot.
> > > 
> > > Ah, looks like the important bit for KCSAN is not the mapping mechanism,
> > > it's the actual compiler annotation for the read. So these virtio ring reads
> > > should all be annotated as READ_ONCE() to make sure KCSAN knows the read
> > > itself is atomic.
> > > 
> > > Alex
> > > 
> > so then:
> > 
> >         return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> >                         READ_ONCE(vq->split.vring.used->idx));
> 
> 
> Yes, which is on the verge of getting unreadable.

Well we can wrap virtio16_to_cpu and READ_ONCE in a single macro
if you like.  VIRTIO16_READ ?


> I'll work with Johannes on
> v3. We'll play with ways to make it a bit more maintainable. Please discard
> the current patches for now.

Sure.

> 
> Alex
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597

