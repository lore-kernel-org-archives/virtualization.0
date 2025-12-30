Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9641A9FA0
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100376; cv=none; b=uy/kInyvb3w+a/dbXG3bQK0ZZP6fzuhUb0sk9FkQ9i6H+lIVoIuH6gcc7QbMjZVWTq9aIIxOw/BdmkPw+QWaaf29sfkwO/m1vX8SCyvmVq6v3cjXbSUZHsbs1vpqHaOcOYRYrQll5LwVGEJaeHGdnG+XP1U4X4n7eBDGsWxnt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100376; c=relaxed/simple;
	bh=yshyoaf7aBfz+NMN2fw0sj4I02giqCATUhq7XTqk+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A3u3PeEl1woQhVGgDH1KSabUqogNTDZknVWtazoWscmOhb3lyXuLiUuGWxaS5yTJnXaSs0YA8+1D/xzFRdtgcG7Ey+VGLKXko0wrwKlpn3i3Av4m0fM4BHFRJhot8VbOwgej6QWFFvZm9MigtwXmxnmnqb53k8aseVoAi1j36v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLal6/B4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLal6/B4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767100373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4qKNRGg/6WWGMgB9lM5TR4Ah2AajR+atlTUoRuUE38=;
	b=eLal6/B4bmhInI0kPTvVc7x81z7Z6LCHMv2VLD20EL3hJFpHBJ8MeEbNlLbnU2gfsvPKMA
	E3IxGNbzjenyt3efh8cKV4t00Ej+V7vzN67a8hr92Otcei3V7hVtsFpNFb0AXLeOprHNr7
	L4cJYDEuvHKR9usda51MQ5oiAmtw3KM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-F02qU1YeMHyt5CZZMBOruQ-1; Tue, 30 Dec 2025 08:12:52 -0500
X-MC-Unique: F02qU1YeMHyt5CZZMBOruQ-1
X-Mimecast-MFC-AGG-ID: F02qU1YeMHyt5CZZMBOruQ_1767100371
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-431026b6252so9520845f8f.1
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 05:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767100371; x=1767705171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4qKNRGg/6WWGMgB9lM5TR4Ah2AajR+atlTUoRuUE38=;
        b=aTdUEEqwJAASewx/ZhqdS90jhP8i9UUMynaypHVUhvncfSlBCVhw0u15y00KOf8pdN
         90bf4vd9OYEhgFTscUhc4VK6MmamVGeSOTEsIAmm+e0yz0rrJR6UhPQ9SDtFJf+3b0Lw
         UqYc2i1sRHv26krkx/avGsjM1WWxbnZjQ1qWP+L/z4Tk6g4ovg9FC3u6OrQJiiwQ7lat
         wisFWCqJUt3N2JHlOBtyQu0MvAaxoEdBtkwF/IZbEkHW7nyZgwfW+g+p0T/LE+ZMElhA
         2bb8V7dBK9CLtSTh5pDKK2l7rMgVPDuJeMZ4SIrx9tuRaehOSd2cOt5LyWkDtylSZYYs
         WoEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEla5TEIjDrT966jA+GHAjDFTQZiAmd/+PiWkGKkg6cnwP4PueUo9oGoVPWxCN5hvlZk5qMfNANy347djrxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMfOvmzMpYPx5NqBUegZTzr51pa1ERW6zlmcBJnjVHoHADLxde
	2Il3afws3vVX5NCcWLkvTKZrqXCvgdjDz2UdamqhgrugKBq4PC9XweeiJ/Tw53nlTKp6ZT1kTTy
	7VcRxTjA1+W2qbXF0qcG31mxv1optu8gHvlIuQJTXP5sAf5J2tu8XBkAXbuy0co/ahbkH
X-Gm-Gg: AY/fxX4dlYfu9Ff8OCLP4Hdv0WmRDL6+cHd9YJif8eUtHTjxNpptFToiis2DG8uTk1p
	IrxyRVPkAEKNztSGM1BVGttxr6gEFp/4laVDO79lBoYu1upxSPUi2y6BIOglp+mPFGEUeaJLlbz
	lvUxIyWO4Xmgg/OAQl56LGIc/6Vkh550cFGI5+RTqjzD1sPCdUOGxYEc/8WNgk/RRH960X8PZAS
	x8SMmz+/c/fl1YjmYvBxbrgWn2mteNPq4VGrehbM9+kHJt1vHLY/HOW/5tYOlAU55GVVxCL3ZbX
	V07Hg6jPOrOHbjzqp+l3d8GNLhypxNADDCenGrBNWZgNZ+3G17cW4wXjXB3LFR+bMl8ic69wcou
	fGR06Z0CJYT6Mm1lBQBqT53gFxxdkMJ4Kxg==
X-Received: by 2002:a05:6000:250a:b0:431:369:e7b with SMTP id ffacd0b85a97d-4324e4cd1eemr36325947f8f.18.1767100370785;
        Tue, 30 Dec 2025 05:12:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuV3/ZjKqoSSHFRBYNJUPg47idnrIgoJm7eIDekNLmSLi3bfRdDLg5urxUISPXXKwMDGaCjQ==
X-Received: by 2002:a05:6000:250a:b0:431:369:e7b with SMTP id ffacd0b85a97d-4324e4cd1eemr36325923f8f.18.1767100370365;
        Tue, 30 Dec 2025 05:12:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm67844200f8f.8.2025.12.30.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 05:12:49 -0800 (PST)
Date: Tue, 30 Dec 2025 08:12:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Cong Wang <cwang@multikernel.io>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix DMA cacheline overlap warning using
 coherent memory
Message-ID: <20251230081220-mutt-send-email-mst@kernel.org>
References: <20251228015451.1253271-1-xiyou.wangcong@gmail.com>
 <20251228104521-mutt-send-email-mst@kernel.org>
 <aVGz39EoF5ScJfIP@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aVGz39EoF5ScJfIP@pop-os.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1WSJxCnqUuNMqeY-5aNETB-S9hRZtIADXhSqEfRw4uo_1767100371
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 28, 2025 at 02:49:03PM -0800, Cong Wang wrote:
> On Sun, Dec 28, 2025 at 02:31:36PM -0500, Michael S. Tsirkin wrote:
> > On Sat, Dec 27, 2025 at 05:54:51PM -0800, Cong Wang wrote:
> > > From: Cong Wang <cwang@multikernel.io>
> > > 
> > > The virtio-vsock driver triggers a DMA debug warning during probe:
> > > 
> [...]
> > > This occurs because event_list[8] contains 8 struct virtio_vsock_event
> > > entries, each only 4 bytes (__le32 id). When virtio_vsock_event_fill()
> > > creates DMA mappings for all 8 events via virtqueue_add_inbuf(), these
> > > 32 bytes all fit within a single 64-byte cacheline.
> > > 
> > > The DMA debug subsystem warns about this because multiple DMA_FROM_DEVICE
> > > mappings within the same cacheline can cause data corruption: if the CPU
> > > writes to one event while the device is writing another event in the same
> > > cacheline, the CPU cache writeback could overwrite device data.
> > 
> > But the CPU never writes into one of these, or did I miss anything?
> > 
> > The real issue is other data in the same cache line?
> 
> You are right, it is misleading.
> 
> The CPU never writes to the event buffers themselves, it only reads them
> after the device writes. The problem is other struct fields in the same
> cacheline.
> 
> I will update the commit message.
> 
> > 
> > You want virtqueue_map_alloc_coherent/virtqueue_map_free_coherent
> > methinks.
> > 
> > Then you can use normal inbuf/outbut and not muck around with premapped.
> > 
> > 
> > I prefer keeping fancy premapped APIs for perf sensitive code,
> > let virtio manage DMA API otherwise.
> 
> Yes, I was not aware of these API's, they are indeed better than using
> DMA API's directly.
> 
> Thanks!
> Cong

BTW I sent an RFC fixing these bugs in all drivers. Review/testing would
be appreciated.

