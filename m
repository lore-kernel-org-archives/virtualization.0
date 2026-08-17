Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591241D202
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970481; cv=none; b=L1gY5WpXMnQ+61fFL88iYwDD0HnVoatsw99avQ4TtIqFrnYuiaBipK6Vp9YqBpkhh6z+/WjpP8qLcskKyrZWn5rhqSt1yUmtwFcuY2dsbEIilleB5szBBbeSGrIIaatpziYEC4lfnpRC7qcAH4L2XZmoNAMk489pHbtjYVhlVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970481; c=relaxed/simple;
	bh=XpzDSGLqZ8oshW6QLL6AkRrKripZJSM32hTiHlFT9Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p+GLn+x/kqEZ/13GAEODsJTBQOlApWxBGaAq5cZnYJOORFowMQGahp97qkjtf4rz7VKYmdLY1hQV6Tx38bg3rg3vn2mj1R2HAI0gdNB/CSiT3AOLjTNEqHSgdVDLzoxvceGI9FMcFGKwZdTu21ZOJ2DRZ7goOD/vKcCyjYjpCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4ykMbQ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4ykMbQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786970478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QT5P0FjYJIXNb5bpOKh/Iv+72OmLL9osWf81HjiuK1Q=;
	b=a4ykMbQ4xJdtpUQiDa0Af8pS+G2QWT6mhvb1vckttMX39NUyMFFBUKEP9h6OczsHJDXoWz
	QIQGW+a2An6FW8yv4tztK8unHcG3YXraQzrLz4BU8vzE7yV88YE6/gNuH3fKnakLYr2LZZ
	IGcbAFnSjjFJIJIa5twfBhTRU8y98n4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-eJYPm-oAMICfhn-Lh8_ukg-1; Mon, 17 Aug 2026 08:41:15 -0400
X-MC-Unique: eJYPm-oAMICfhn-Lh8_ukg-1
X-Mimecast-MFC-AGG-ID: eJYPm-oAMICfhn-Lh8_ukg_1786970474
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15e555a164so284592066b.1
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 05:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970474; x=1787575274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QT5P0FjYJIXNb5bpOKh/Iv+72OmLL9osWf81HjiuK1Q=;
        b=cfbpsOE4kiospYMAg51LR9sM9VloxjFFk+jIdbnUFBXqO6DsnN7k6cTn4TkOUi6jZG
         ae+QhaEN/5/6QBjnYg4WvMdTYLVTVw+rK1FysyyDFDOGL3uV+0iI6Wp6jX3+NU6NLVfr
         XW94nIx+E3kPZxB1zmOad85SiCGK7QiObHiS1PIITtBnKITRU2ZVip6/9iasSAx8ru7J
         ibGCm7MBRsmQ6zfp3eQPsW/eYpsSvTnnqpjrR06H2FyuO9mq2abY0+ilio5fvZiQDllr
         78xhAzXyCPQiInGpiVPny5dyqFICw/T5DHyAgnjcMzVC6gDgq/vyh2eE4ZsbYxo9ykab
         tfUg==
X-Forwarded-Encrypted: i=1; AHgh+RqNgJUkhkwqA7uma3eYTkjOxKIsPAKqIFcy+oR5p0Pw7Ws/SYFB1E7M2PapmKFX7dz0jc29pggDkAVLvGznNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXXtO0EuAJc+URnzzpIkOniWEdIhfIj+O+BapNkUiQa8m4B4X9
	OqRsbYNQSH6ATnEcHi/CAyNmqPsIrtlbLnM9FY9IP7nmm6MdMBoomZnlrxH0FbqIMGfrhTgmLRU
	xX5TNQwqYha08A1K/rT6/QXZ6+DT3Mtjb7LvhxHKXcNzR5VmG6hFnlXdgSbnSgdD4RSji
X-Gm-Gg: AR+sD11TI6ecgAp1Vc0NbW1VEDWWaYAKe7AbCJyuIoWGf0exRjqhZuvN+8MF4zS1NNV
	USeTF74AXpNzvo16x96l8GwsjdDwoWdWHFauOXZkeGDuwqcdXx76sUDY0z1M6ysC3G33qXx40Jr
	mjcvSjXK3NowIlSvBi1fVVGxU0bI/Da2iMil4YYHoRCIr9ZL0P0tY3w+dISIeeSvGSHN+dCwAwE
	7OsZcQqBYX6A95dxl0xFuhgo6DOVB/l/uH3zKqq73bUtvAZLy2Aa22p4qMr4HStpc/G0nbVhi8J
	POsoJIKgrlOdXGQse2WjsBEH2/Mog6zenhS21kbcXhO9eRJk/EEXsyxNdUegdeLCMB1Vktu/JGP
	l5WuFe/2o4wTlVN3BdG5ykRKb
X-Received: by 2002:a17:907:d0f:b0:c08:580e:899a with SMTP id a640c23a62f3a-c212aa1d477mr1206731366b.10.1786970474023;
        Mon, 17 Aug 2026 05:41:14 -0700 (PDT)
X-Received: by 2002:a17:907:d0f:b0:c08:580e:899a with SMTP id a640c23a62f3a-c212aa1d477mr1206726566b.10.1786970473289;
        Mon, 17 Aug 2026 05:41:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-107.inter.net.il. [80.230.47.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fea2cdcsm52972566b.18.2026.08.17.05.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:41:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 08:41:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-blk: clamp max_segments when indirect descriptors
 are disabled
Message-ID: <20260817084042-mutt-send-email-mst@kernel.org>
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <aoK8fF27_nu1ux9s@infradead.org>
 <CADhvd_MfDwX=Ebwt3XQJrzYkvACGCdAq1VYT585Bv2v37Zu2rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CADhvd_MfDwX=Ebwt3XQJrzYkvACGCdAq1VYT585Bv2v37Zu2rg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a3PAZWFQDrdegmVZyLDMa7nXaBJXs9_vAPyCP1RmRHY_1786970474
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2026 at 10:08:21AM +0200, Sergii Ushakov wrote:
> On Mon, 17 Aug 2026 at 09:47, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Aug 14, 2026 at 12:59:54PM +0200, Sergii Ushakov wrote:
> > > When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> > > scatter-gather segment in a request must consume a physical slot in
> > > the virtqueue ring.
> > >
> > > If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> > > virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> > > defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> > > compound bio arrives from the page cache, virtqueue_add_split() rejects
> > > the request with -ENOSPC and triggers:
> > >
> > >   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
> > >   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> > >
> > > This permanently wedges the blk-mq queue and blocks all subsequent disk
> > > I/O in uninterruptible sleep (D state).
> > >
> > > Add a virtio_blk.max_segments module parameter to allow runtime cmdline
> > > overrides, and automatically clamp sg_elems to
> > > (virtqueue_get_vring_size - 2) when indirect descriptors are disabled.
> >
> > What is the reason for the override?
> 
> The module parameter was intended for two main reasons:
> 1. A safety fallback for non-compliant/buggy hypervisors that may have
>    internal segment limits lower than the advertised ring size without
>    advertising VIRTIO_BLK_F_SEG_MAX.
> 2. Debugging and performance benchmarking of smaller scatter-gather lists
>    without needing kernel rebuilds.
> That said, the automatic clamping to (vring_size - 2) resolves the
> hang and panic out-of-the-box. If the preference is to avoid adding a new
> module parameter, we may drop it and keep only the automatic
> clamping.

sounds better to me.

