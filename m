Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386018BBB0
	for <virtualization@lists.linux.dev>; Wed,  9 Oct 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466289; cv=none; b=jaaNVM3jWT7z1WgsKJ6VqHdO0UxySbddQdqrURqVFQYe4KQgjHWNa7oBWG1AFUkUtebwUhc4xJfD7e6m3KfGTfcgrmrvN9KmB3pa9CF2LzYufPqwiYGjUihyHtRTIFIkeNBMNhig58lmmUwxjOaNBZswT5PEkDIJb/ZNSVQEbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466289; c=relaxed/simple;
	bh=MSsRkyxd4YCq1P/nIdg1QoS4gpOdr7CrMOLPycpmuyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hoMrG69H/l8z0gGOWxjQFrcz2n6REyElkY0uIEfcK4Ir6EBMsjT7MPHjPX/tXnfJU5dVgxuiF+iiTYIFl3zPpDhi63OTrqMa3Sskf2dN86r8L/XZIAvXcV884MdfdwcW754wX2PqYVCJs78vywjPR96n02ppJ2bxtMYXD3LYD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ED3Jbhdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ED3Jbhdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728466286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCFyjwOoC1GNagB+SZBXr7exz3s6qJ62KHoxnPNxysM=;
	b=ED3Jbhdn6UL9FlPutzFpVvogDGK2vuQExBqCld9RjxqLTf82ivmojPC18vHhdoaKx7IBGt
	oS5vjocGLW0VUFOH1lD05HPGsR+Nl5Et+jOFk1FM09+MIuaN/QKgeteEKDDTCfrTs0if/i
	yvFWVUB4DAS4xJTZUi+BnlBk/PFBtZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-16R0QecsPhWQ8Bsp8h6Seg-1; Wed, 09 Oct 2024 05:31:24 -0400
X-MC-Unique: 16R0QecsPhWQ8Bsp8h6Seg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb857fc7dso56695555e9.0
        for <virtualization@lists.linux.dev>; Wed, 09 Oct 2024 02:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728466283; x=1729071083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCFyjwOoC1GNagB+SZBXr7exz3s6qJ62KHoxnPNxysM=;
        b=fRgspK4QVkf9mkVXan4Dpo3e+bceIhNmb5hpKCR/jSvQ2plvuKEg8SkthLjOz803K3
         klj/nE9LExzOgREoPvInuRZ42hWxijFZ/ZH0Lbryz24Ssm/5gNmqbiEvV0H72VpTKh0M
         lQ8335vD7WlpJIGTXxZ7uJ0KRKwaJ6zPN1Et7nz3OmyLw//V/RrDAE1ysFpMfhUZlCz9
         jCmGPsXqpFnOYE2qBthrsDsB45wamQ25hLkowXdkzcwnejFN/PsJ/5QXdg5/4YUu8nhW
         4kO33PQ1Wo2zaApNvScPoVYhJZOED8Bt91WyMh4msO0+U+cIAbX5/NwQnDSaNsa85muU
         ztdA==
X-Forwarded-Encrypted: i=1; AJvYcCXGru/4HfZaDn6vwNAr8CaDVlr4m2VTEK+nnQJRDxqKMGPZPQ/x1U4vsQ63YtTYwsFZDhQ20DT47gwnuYYfWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ/QxK5jC6oYbJo8BZr5/Sh3NJY0Z/xokLRcNH2WBy9p7zeyxE
	u1zrrfM+j+H8qQ88LRJNWqOTv3Bz1wonyft68klqh0rAOtD/PmeFDYJbfSeI+/beBNCotjYcaMV
	YvsU2oIxD962yhWPrtXsqkuIhftV5LRCaVeMUnAcLxeVwIhsNJvdrP9yDAZV4mSXc
X-Received: by 2002:a05:600c:1d0b:b0:430:52ec:1e2b with SMTP id 5b1f17b1804b1-430d70b3d4fmr14594865e9.29.1728466283334;
        Wed, 09 Oct 2024 02:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvfvQ3xJ1v2u/B8SD19ktVTygvA0+NwszyORhaVheRQwm929K9gwmJ2BzvJ5NC8g+yrnDMJg==
X-Received: by 2002:a05:600c:1d0b:b0:430:52ec:1e2b with SMTP id 5b1f17b1804b1-430d70b3d4fmr14594635e9.29.1728466282886;
        Wed, 09 Oct 2024 02:31:22 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:fb13:fd72:22f:64e2:b824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1698c803sm9824580f8f.113.2024.10.09.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:31:22 -0700 (PDT)
Date: Wed, 9 Oct 2024 05:31:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jianguo Sun <quic_jianguos@quicinc.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	Sreenad Menon <quic_sreemeno@quicinc.com>,
	Anant Goel <quic_anantg@quicinc.com>
Subject: Re: [PATCH v2] virtio: Add polling virtio-mmio device reset
 completion
Message-ID: <20241009053053-mutt-send-email-mst@kernel.org>
References: <20240926022557.8771-1-quic_jianguos@quicinc.com>
 <CACGkMEu-r2K1Xb-797YnK80-YeKEsErSe=BBP=xMbBvHcDv6qA@mail.gmail.com>
 <20240926020709-mutt-send-email-mst@kernel.org>
 <CACGkMEshXHRDtxeCJ2VOMh46NMJyYsEo_eFwa4_4TDTa0mA9XQ@mail.gmail.com>
 <20240929125700-mutt-send-email-mst@kernel.org>
 <CACGkMEvSOLA58rPqJfRZek=nk0n6Q8vL4iKrO056rGzWRrf6Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvSOLA58rPqJfRZek=nk0n6Q8vL4iKrO056rGzWRrf6Rg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 09, 2024 at 04:24:38PM +0800, Jason Wang wrote:
> On Mon, Sep 30, 2024 at 1:51 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 27, 2024 at 12:08:34PM +0800, Jason Wang wrote:
> > > On Thu, Sep 26, 2024 at 2:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Sep 26, 2024 at 11:21:25AM +0800, Jason Wang wrote:
> > > > > On Thu, Sep 26, 2024 at 10:27 AM Jianguo Sun <quic_jianguos@quicinc.com> wrote:
> > > > > >
> > > > > > We write 0 to device_status to initiate reset of a virtio-mmio device.
> > > > > > The reset operation itself may or may not be completed by the time
> > > > > > write instruction completes. Add polling device_status to return
> > > > > > 0 to ensure reset completion before reinitializing the device.
> > > > > >
> > > > > > Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
> > > > > > Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> > > > > > Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
> > > > > > Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_mmio.c | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > > > > index 90e784e7b721..cf1a4a3dd35d 100644
> > > > > > --- a/drivers/virtio/virtio_mmio.c
> > > > > > +++ b/drivers/virtio/virtio_mmio.c
> > > > > > @@ -70,6 +70,7 @@
> > > > > >  #include <linux/virtio_config.h>
> > > > > >  #include <uapi/linux/virtio_mmio.h>
> > > > > >  #include <linux/virtio_ring.h>
> > > > > > +#include <linux/delay.h>
> > > > > >
> > > > > >
> > > > > >
> > > > > > @@ -269,6 +270,11 @@ static void vm_reset(struct virtio_device *vdev)
> > > > > >
> > > > > >         /* 0 status means a reset. */
> > > > > >         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> > > > > > +       /* After writing 0 to device_status, the driver MUST wait for a read of
> > > > > > +        * device_status to return 0 before reinitializing the device.
> > > > > > +        */
> > > > >
> > > > > Is this copied from the spec? I can only see a similar description in
> > > > > the PCI but not MMIO part.
> > > >
> > > > Not in spec. We can add something like this in spec, but it
> > > > can not be a MUST, has to be a SHOULD.
> > > >
> > > > > > +       while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> > > > > > +               msleep(1);
> > > > >
> > > > > Again, we probably need a feature bit to unbreak existing MMIO devices?
> > > > >
> > > > > THanks
> > > >
> > > > We can do this unconditionally since legacy devices return 0
> > > > immediately,
> > >
> > > The problem is that we can't audit all legacy device implementations.
> > > Current driver still works if a device doesn't reset status to 0.
> >
> > These would be out of spec though, would they not?
> 
> Yes, but it would work. Should we care about those?

Not unless there's an actual, common device that does it.

> > The reset value for the register is 0, and it is R/W.
> >
> >
> > > > feature negotiation happens after reset, won't be useful
> > > > here.
> > >
> > > Right, as said in another thread, it could be mmio specific flag or version.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > > >  }
> > > > > >
> > > > > >
> > > > > > --
> > > > > > 2.17.1
> > > > > >
> > > >
> >
> 
> Thanks

