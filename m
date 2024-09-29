Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6717C8B
	for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632296; cv=none; b=KrYBG3w1fPJbfuPjsvXyqGVcZRPoHawHSenW3GznXvT4FOKdDjQUy3k4JUmZeISBoHW7njRUNIa2Yh9bxJAHakuSQQ+whaIzfhz3JNcp7tzHvW8wxhZdbhxDAN3h8kkAYDkQEvO+5N4/cx92xparHHHzPaLrOH8obxvhJYd7RRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632296; c=relaxed/simple;
	bh=NdXt8T5bGuAMI6gSN9cwiPJWgF0RKgU6uOaQTMHkGn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UFWBdbTYCTGVbwlE+mwP7gMjnRggAodxBieu8b3OtjNBLDITOwa9k11klx0XIfGzCuYCzNdWJeTX7L8HgegQMYSVePgq6znbPp61o/emoag1rjqXR0FgQ/jcPBpz+Rf/DMmorhqCqtsdX5kvglaR0aHM4+tosMEmyWbEsGW1ZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCVyqWoj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCVyqWoj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727632293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBo6Js+KrmXcDaOCykB3DnpCL6RVyY4y0Ygmd00mTE0=;
	b=cCVyqWojFTGwp7UabGStSycZpZloXQU6VJgJELeJ4WS946Oeezwc9gbUcw5t6JTrea5Te8
	Lcx3rYdSzcU4A6N4GHemeMPNJPwN2n6qGzZX/tazkegHD6n/n3li9Xh9zDltRskHsntjWO
	7+nl4M0/oY/oStCOGuiaS9aPQQW4VNY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-wOLDTwHwN5u729Ey8Yzebg-1; Sun, 29 Sep 2024 13:51:32 -0400
X-MC-Unique: wOLDTwHwN5u729Ey8Yzebg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c879b8cfaaso2860221a12.2
        for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 10:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727632291; x=1728237091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBo6Js+KrmXcDaOCykB3DnpCL6RVyY4y0Ygmd00mTE0=;
        b=rAOK0XkCjm6qt+62hxztOIKaWW+sxFlFwbiKhbObI409MxgSwfvg/IQGDcSXZKBZt0
         cA4l7a5EfQkkWotvzBUnIgFnG0Wgx4myUXwK5jz4iLRjz91ndTXsUPRxX8rXmboNycPd
         bKUMsOajROymg4Z6FJ6lag7zBbigworm0uRnoJYoXkheBd5ONtCOTQK/htOLZNbzy0VL
         ObSr3E7mOxcfTYlUuluvIPNWQg/KWc+yPQOq1bMZZEnQMKbmwXy5Y0ou5GzinZrgIImH
         8qevCfhnvBO0DhMHxqCOEpHEwWZaf0bA44RCK/XU14fftXgCeisvNbOmOj5LMlr+BXKq
         fr7A==
X-Forwarded-Encrypted: i=1; AJvYcCVT6P7icBO+1dert7ZKPF2U1RK0/BEzF+GQ+i2g/YyxCvAGCOcgFv04D3yjtrat0/Cmuoud58/81trOy8S94g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8wonO+5cre1gunBGq1gw6l6em1nuimmdHTeeMv+o/QNVjLHTE
	orTdexNmzw+sHOly76McNToNZNS8KkT8HucEytFhIQMHir+asXB2mJ0JmQdeet5c9cOyE/15vi1
	tmvZsw53FIhZbArBv4Pp00ou97dSJ4h/E+dWhY/AwOeyJJMwpbeoXeBQxMfVtqqWe
X-Received: by 2002:a05:6402:50d4:b0:5c5:c4b9:e68f with SMTP id 4fb4d7f45d1cf-5c8824ccc1dmr9028051a12.5.1727632291057;
        Sun, 29 Sep 2024 10:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGzR/0OEFOcQb9FWIscGFAyeuagjIVEK9ss9ZaEtpJFtI7YKhtQArRYH/c9F8IVcR1d4ye1A==
X-Received: by 2002:a05:6402:50d4:b0:5c5:c4b9:e68f with SMTP id 4fb4d7f45d1cf-5c8824ccc1dmr9028037a12.5.1727632290585;
        Sun, 29 Sep 2024 10:51:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824949bdsm3410651a12.84.2024.09.29.10.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:51:28 -0700 (PDT)
Date: Sun, 29 Sep 2024 13:51:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jianguo Sun <quic_jianguos@quicinc.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	Sreenad Menon <quic_sreemeno@quicinc.com>,
	Anant Goel <quic_anantg@quicinc.com>
Subject: Re: [PATCH v2] virtio: Add polling virtio-mmio device reset
 completion
Message-ID: <20240929125700-mutt-send-email-mst@kernel.org>
References: <20240926022557.8771-1-quic_jianguos@quicinc.com>
 <CACGkMEu-r2K1Xb-797YnK80-YeKEsErSe=BBP=xMbBvHcDv6qA@mail.gmail.com>
 <20240926020709-mutt-send-email-mst@kernel.org>
 <CACGkMEshXHRDtxeCJ2VOMh46NMJyYsEo_eFwa4_4TDTa0mA9XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEshXHRDtxeCJ2VOMh46NMJyYsEo_eFwa4_4TDTa0mA9XQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 27, 2024 at 12:08:34PM +0800, Jason Wang wrote:
> On Thu, Sep 26, 2024 at 2:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 26, 2024 at 11:21:25AM +0800, Jason Wang wrote:
> > > On Thu, Sep 26, 2024 at 10:27 AM Jianguo Sun <quic_jianguos@quicinc.com> wrote:
> > > >
> > > > We write 0 to device_status to initiate reset of a virtio-mmio device.
> > > > The reset operation itself may or may not be completed by the time
> > > > write instruction completes. Add polling device_status to return
> > > > 0 to ensure reset completion before reinitializing the device.
> > > >
> > > > Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
> > > > Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> > > > Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
> > > > Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> > > > ---
> > > >  drivers/virtio/virtio_mmio.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > > index 90e784e7b721..cf1a4a3dd35d 100644
> > > > --- a/drivers/virtio/virtio_mmio.c
> > > > +++ b/drivers/virtio/virtio_mmio.c
> > > > @@ -70,6 +70,7 @@
> > > >  #include <linux/virtio_config.h>
> > > >  #include <uapi/linux/virtio_mmio.h>
> > > >  #include <linux/virtio_ring.h>
> > > > +#include <linux/delay.h>
> > > >
> > > >
> > > >
> > > > @@ -269,6 +270,11 @@ static void vm_reset(struct virtio_device *vdev)
> > > >
> > > >         /* 0 status means a reset. */
> > > >         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> > > > +       /* After writing 0 to device_status, the driver MUST wait for a read of
> > > > +        * device_status to return 0 before reinitializing the device.
> > > > +        */
> > >
> > > Is this copied from the spec? I can only see a similar description in
> > > the PCI but not MMIO part.
> >
> > Not in spec. We can add something like this in spec, but it
> > can not be a MUST, has to be a SHOULD.
> >
> > > > +       while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> > > > +               msleep(1);
> > >
> > > Again, we probably need a feature bit to unbreak existing MMIO devices?
> > >
> > > THanks
> >
> > We can do this unconditionally since legacy devices return 0
> > immediately,
> 
> The problem is that we can't audit all legacy device implementations.
> Current driver still works if a device doesn't reset status to 0.

These would be out of spec though, would they not?
The reset value for the register is 0, and it is R/W.


> > feature negotiation happens after reset, won't be useful
> > here.
> 
> Right, as said in another thread, it could be mmio specific flag or version.
> 
> Thanks
> 
> >
> >
> > > >  }
> > > >
> > > >
> > > > --
> > > > 2.17.1
> > > >
> >

