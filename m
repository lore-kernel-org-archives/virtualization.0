Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785D390C95
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349108; cv=none; b=SpfKOYLqR2OwTWOOhfOmrNnMFDQbnG5FSzL3I+PGrNDaF3VUfBa41Agl0bG/lOV1m88V6FAQbVBeiFgeAJRIBg329yyXWQ6og/mbXjmAVDrCHgSHn8QOBp0ppIYtxz09bV/gbm1yo7zo26iv/sERWpv+igVn4MQHUpLHT0dtw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349108; c=relaxed/simple;
	bh=+lkuVQnHgrhF7fjMdkJDE/fkoUTrWZAAHCdTOrn70ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=POrA6+mXw2ph+9kRETLcLwsl5pl38dgqQnNXbucrAh4gLWedC5btoD+xJMG89uEABjFeMXlUUoOH9tCFnRMjpS9kjel7OI+12Dbm0Majh/DFSXxafK6PG4nnK34N/uwK1eegvVTqRnS2Y89fZaGjqLr4wmnP6yE9l1dFSYSE2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flsLNBX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flsLNBX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786349105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+a+0U5GgUWNz5gXhQg+X0ag29Jj0knQnRmccGbHPwc=;
	b=flsLNBX2c/kJfYqhHn32viV+AGYEzz92YBbsXbZPHMkE5eMmDpOZ2PeYr4cNN6RcC3xQZa
	wmNOYhxCDUNKS98Y12kYTvP5iy+Ftl2E/QlXx80Y+jadxdqlxotyyyNZTybpfD2jpCEoC9
	wNslmqVehVQHAV5jbg6ix1PG5QyLKy8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-j9y_bZmsM7iFTJWpWFIjQg-1; Mon, 10 Aug 2026 04:05:02 -0400
X-MC-Unique: j9y_bZmsM7iFTJWpWFIjQg-1
X-Mimecast-MFC-AGG-ID: j9y_bZmsM7iFTJWpWFIjQg_1786349102
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so1618550f8f.2
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 01:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349101; x=1786953901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+a+0U5GgUWNz5gXhQg+X0ag29Jj0knQnRmccGbHPwc=;
        b=bwAPpy9oS8rJBnm9+VIMkNLNjlDbQrQUpI2zc75/2ZRPwEJg5K+j0VmKxfd50wJrwV
         4njfyu5mglsvrJliTYOLMvDQKK3bWZEdNsic6qGkZ10kllGDkT1M3EeDmbPWjUEt1L+G
         Eh+j0ghjg16qEllU5aPqQ8clnMVN1/TgxvgQLdobcDNuJSu8QUIVOy6rxDGcfpBDTjHU
         B0YUZycGokIYYAhCCTzseUCQKqDvRkQoYZzSbGkSprkco2XZynNUaBkW8ej+fLp8NXe0
         NQrrJh35EsE9pqPDzhMt831hbvurrLsSnCxJeeaESPfi1xpC4SWDeZkvXzhXPK/KUJbc
         9Ibw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9FInIJ+MkS9tUcHYxwCkfTx5mX2AU18gtlqh1RDC/tZrHFRuun9OftjPpIyep/eqzE/Y7AyurYSQpY3w0zg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmr41/dHiIB9QaFphDhKTLGKp6xUhwzn78g1uHbwxLxEMsa8Fl
	bvpptrQqTvXTF/ZNido/TIgMt3JN+gceGh6H3LgNzxhRhRfheIjTm3/ilfdw8VMu8PXBzgFFA2G
	IdJshZEN4qJKiTdxWAIM/DhETmYkSvMXG3XPbTWLidDhdnKIY22In/p3B9PMg9J7KKxmr
X-Gm-Gg: AR+sD12SxlJj0VR5cSM7GAPG64W3TtT5oW2eQjpjHr8yuGtbLTIjGJmcGCfAX4UIHig
	qeMyIxxc6dkYgeNHsNVxBLLR+mKKoFMgawJTAK2G57syvXDa0bdLxP6G/zwxe1CLoY77aFvCn1R
	zWIo9++9SlK5jrevjpkH+94vWPgld7vLKqq7ZcNeOKLDo7t4g4HMTwFuI8nBl9I0XfPSEaNl0kU
	eoG9MIAUp25k+dHxcUiWR9oi8U4hhRBAGWaC+7gGgQ9CmYuvbfBiBIuvHi5RIj5RUjch8YwXDv3
	50DHMyb5RKLZW7Wkqh2d5cwCyyc0+b34f/4v+DGmNWw92QYAbeRHxSKs44LO8PGw/sw91y60UBY
	cuf7xzwurdqdu5b3fybudzg==
X-Received: by 2002:a05:6000:430a:b0:47f:71a6:970e with SMTP id ffacd0b85a97d-47ffd203e5emr38268912f8f.2.1786349101191;
        Mon, 10 Aug 2026 01:05:01 -0700 (PDT)
X-Received: by 2002:a05:6000:430a:b0:47f:71a6:970e with SMTP id ffacd0b85a97d-47ffd203e5emr38268788f8f.2.1786349100617;
        Mon, 10 Aug 2026 01:05:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8b09sm35811136f8f.23.2026.08.10.01.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:05:00 -0700 (PDT)
Date: Mon, 10 Aug 2026 04:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
	David Airlie <airlied@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC PATCH 00/12] virtio: support devices that own their
 virtqueue memory
Message-ID: <20260810035246-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260810021450-mutt-send-email-mst@kernel.org>
 <c56fb4d0-33ef-4e9b-ac18-ac4e896957cd@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c56fb4d0-33ef-4e9b-ac18-ac4e896957cd@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R4g_-oMZQ3kc_jUPepXzeB7sZTStMeiHEJXOSoSvbg8_1786349102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2026 at 07:39:02AM +0000, Graf (AWS), Alexander wrote:
> Hey Michael,
> 
> Thanks a bunch for having a detailed and quick look!
> 
> On 10.08.26 08:23, Michael S. Tsirkin wrote:
> > On Sun, Aug 09, 2026 at 06:19:58PM +0000, Alexander Graf wrote:
> >> Virtio drivers use guest memory to back virtqueues and their buffers.
> >> That means a VMM needs to be able to map guest memory. That is ok in the
> >> normal virt case. It gets icky with confidential computing (where we use
> >> swiotlb as workaround) and it defeats the purpose of isolated vhost-user
> >> backing devices, because they end up with full RAM access to the guest.
> >>
> >> So instead, I'm proposing an extension to virtio which allows it to give
> >> each virtio device its own dedicated memory region to communicate with the
> >> host, called DMB (Device Memory Buffer). A trusted hypervisor can force
> >> DMB to be present, which then enables safer, more isolated and resilient
> >> communication between guest and host.
> >>
> >> With DMB, the device provides a shared memory region that both parties
> >> agree is the full memory map both have access to. All memory offsets
> >> that previously would have been into guest RAM, are then offsets into
> >> this shared memory buffer region. One nice property of this is that it
> >> is a generic mechanism in the virtio transport layer, so higher level
> >> drivers work unmodified.
> >>
> >> I was exploring to use swiotlb instead to create individual pools. But
> >> that approach has multiple downsides:
> >>
> >> 1. Swiotlb is an OS primitive which is not available in all Operating
> >> Systems. DMB however lives in the virtio transport layer, which means we
> >> can add support for it in any OS independent of generic layers. This
> >> helps with Windows support.
> >
> > How does it help, if you are going to put a pool in
> > the driver, put a pool in the driver. Maybe with virtio mem to
> > simplify allocation.
> 
> 
> I'm not sure I understand the suggestion :)
> 


I'm not sure what the problem is for windows :)

But if you want a chunk of contiguos memory that windows
does not poke at without a driver, virtio mem is that :)

> >
> >> 2. We munge DMA space together. DMB provides a separate DMA space per
> >> virtio device. This means we can for example implement a device in
> >> vhost-user and give the implementing process only visibility to the DMB
> >> region, not all of guest memory. That reduces the exposure the
> >> vhost-user provider has, improving security.
> >>
> >> 3. Devices can opt-in. A hypervisor can choose to use standard virtio
> >> semantics for self-implemented devices (e.g. NSM), while requiring DMB
> >> for devices implemented by less trustworthy providers. The
> >> non-trustworthy devices do not get any visibility into the trustworthy
> >> ones, even with DMB in place for both.
> >
> > So I am not sure whether the implication is that it's purely a software
> > construct. But if it is, can we extend virtio iommu to
> > add a way to discover and enforce trust boundaries?
> > And maybe translate offsets to BARs, if that is desired?
> >
> > It seems to be that the result would be that we don't need fiddly
> > special casing in virtio ring specifically, and a lot of things like
> > pre-mapped dma will begin to work.
> 
> 
> On thing I'm trying to avoid is dynamicity. Anything that dynamically 
> changes visibility or needs state tracking is something that can go 
> wrong. By keeping everything self-contained within the guest, I can 
> reason about what is visible and what is not easily. Especially for 
> confidential computing, IMHO static wins over dynamic in general.
> 
> Or did I misunderstand your suggestion?


I get this part. But we can absolutely make it static.


Let's start by replicating your functionality with virtio-iommu.  So:

-device is behind virtio-iommu
-virtio-iommu tells guest "this device can only consume memory from that range,"
-and maybe: ...and translation is 1:1 with this offset

if guest does not acknowledge it will just fail?


this covers the proposal here simply by using a dedicated range
per device, right?



But look what we can easily add later: share a range
between devices, now you can move data between them with zero copies.


Isn't that better?


> As to pure software construct: With CXL, you can implement the exact 
> same protocol on real hardware as well. All it takes is cache coherency 
> of the BAR (or whatever the transport uses) region.
> 
> 
> 
> Alex

Yes this is what I thought originally, that you intend to
do it in hardware. But re-reading it, it begins to look like
that's not really the case, it's only "theoretically possible"?



-- 
MST

