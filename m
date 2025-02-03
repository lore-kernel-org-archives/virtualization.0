Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC5209668
	for <virtualization@lists.linux.dev>; Mon,  3 Feb 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594153; cv=none; b=ARs8YMaKjwLXobTqLJV6AgTlesYDlY0gZ6pumtFB7IiikDyDvjQhY3v2FzoTCtGbloy9HqEdbNrY7JPg18xuq52HsPPAEiIEcVm1TULcIOkbm4QNNwwBJsxkGsmQ4h6+LvpZpKQ5HhNdEZLDwTRcsaKsMRGcxk6izNrcKx8Tcm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594153; c=relaxed/simple;
	bh=15kWMmNxkUMTSvkiTnVBrfsxV44/Ms3rMk3fOE2f0Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NQxaULYGgjOgCsps2srXUq8LU7ZPBam9RhP03juLcZE5JTqfPpCVPBvXHgb+zbeyX9aKNU9xYTt3OAe52vvNE+upN3ICM9v9RBzxYgi1k9Q/SOoSi+y/mGW3iSQULmTzikxQkqTAf/YFurhP8tY3DDgKgYqPD7uEx5NAiYvKLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKJbdo8h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKJbdo8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738594148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4CveGpWscXAPpXhsgoWdG7ssIIW1D0dKJfj/YwXZHk=;
	b=CKJbdo8h0PimArjgtG4wsdd1NQXGPjhDkcnxu07y5TyFIDcAzZIVwnWfyYO/HSyVv+IdIM
	EhM0sMJaUIGg7k19kgfbOMbPwl+IyAZTmL0jBnjtsJmnx3z4hXo0htA40j0GM9YTFHZ+V3
	cxEPhDObCEISwC2r/FIOulk+7suHZRQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-feHgvUysOx-1WDfxXVHO_A-1; Mon, 03 Feb 2025 09:49:05 -0500
X-MC-Unique: feHgvUysOx-1WDfxXVHO_A-1
X-Mimecast-MFC-AGG-ID: feHgvUysOx-1WDfxXVHO_A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a873178f2so1945398f8f.1
        for <virtualization@lists.linux.dev>; Mon, 03 Feb 2025 06:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738594144; x=1739198944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4CveGpWscXAPpXhsgoWdG7ssIIW1D0dKJfj/YwXZHk=;
        b=FxgXEPr5HpAvf7953HidG7OQqVHr9N7wLIG5Gk0KdBDPSyjdHCHLhmRQhI1Tldvv6K
         KrgjtNCU/FHb+LSw3HJUgqQuU2WWZHQJ00ztBGlkDFKFXeTh7PFUfF7NJ979eU8iPja4
         IZUDV8V2PGLvu22amQK2EU/tQZOD/It8HoHKsPks8CjMCneuvA0IB16mgzXf2qxUg+5m
         xNXKL/ikHmlcco8xBFLmORvgL2pQPiWeOQqOQkdnTlTTe9DqeYrjFcGwYNQsNq3tvQr2
         emEWFeaEifwMbD04dWic1HKPSjHqYVoRM2qRYr7vQ6J1H1j1pR7plZqNXw+x2CmS18nT
         UoDw==
X-Forwarded-Encrypted: i=1; AJvYcCUCyMHaJJA9WUwAIvjI9oQWGxFjpZYFyWPpKmZlYhy9pHajEOfhuiYPb1KO9w0D17jfpwLFHqomliyDLQMwtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZLA995u3cA1wWnaYGYhtfQKRkiUCB9honPtBQFtasYkQi+kJ/
	ZzW1kYwjM6lQcYDhE7wt7kkgKFttxrUia7p5Hbc4GlVAo2/4Y/toxiCGnEpx7+GnOYZQd2KAfOm
	AdaL4w4Nkfp3CKA/nEhKG9S3ZdoVYpZBu+8gVYRsc4Hx65GMBPzc5YZqzdPd++x+B
X-Gm-Gg: ASbGncsz/FycE1XpJP6mL0zIjsEQ2DctuYWh/o/puzOOuvS9dhWGscW5iwKoLpHaZiz
	4ELC6wdalLkFRYN2RdVGAjzhL351wHZfEz2AeVqIN9/xTN10BoX7TTS0Xra6dmGvf8LuVcxUjmW
	sBYDZrAuPsfWwU4lgGGgSc4TDIl8ddjuXHXhn+DBFXUSRRwcjBNIT5HPzkZt0VKp7BwR3k8h5PL
	B/NptXhiSUAnZAblKuzHC6cPHOMmmuVwBpvJ/j4CUdyPize44jh3G8YH8WKXYfQ2eqk0FewUMQ=
X-Received: by 2002:a05:6000:2a9:b0:385:fbb7:672d with SMTP id ffacd0b85a97d-38c5209753cmr17471725f8f.52.1738594143832;
        Mon, 03 Feb 2025 06:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFyFH+M2Te1TzwrsPgiAkNfzpyODrQhYKLHyFrAPwNqv4qZzpsT+b1HGtHLK7rKOHLDFMakQ==
X-Received: by 2002:a05:6000:2a9:b0:385:fbb7:672d with SMTP id ffacd0b85a97d-38c5209753cmr17471694f8f.52.1738594143415;
        Mon, 03 Feb 2025 06:49:03 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f2:ac69:6791:4264:88f3:ab93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244f0d2sm160681555e9.30.2025.02.03.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:49:02 -0800 (PST)
Date: Mon, 3 Feb 2025 09:48:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20250203094700-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LepqJbteK6q-HpETosK8aYu4t0c2UUFg_IfvgzXWX6c_1738594144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> Hi Kirill, Michael
> 
> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > accesses during the hang.
> > 
> > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > 	...
> > 
> > It was traced down to virtio-console. Kexec works fine if virtio-console
> > is not in use.
> > 
> > Looks like virtio-console continues to write to the MMIO even after
> > underlying virtio-pci device is removed.
> > 
> > The problem can be mitigated by removing all virtio devices on virtio
> > bus shutdown.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> 
> Gentle ping on that patch that seems to have fallen though the cracks.
> 
> I think this fix is really needed. I have another test case with a
> rebooting guest exposed with virtio-net (backed by vhost-net) and
> viommu. Since there is currently no shutdown for the virtio-net, on
> reboot, the IOMMU is disabled through the native_machine_shutdown()/
> x86_platform.iommu_shutdown() while the virtio-net is still alive.
> 
> Normally device_shutdown() should call virtio-net shutdown before the
> IOMMU tear down and we wouldn't see any spurious transactions after
> iommu shutdown.
> 
> With that fix, the above test case is fixed and I do not see spurious
> vhost IOTLB miss spurious requests.
> 
> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
> IOTLB callbacks when IOMMU gets disabled,
> https://lore.kernel.org/all/20250120173339.865681-1-eric.auger@redhat.com/)
> 
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 
> > ---
> >  drivers/virtio/virtio.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index a9b93e99c23a..6c2f908eb22c 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> >  	of_node_put(dev->dev.of_node);
> >  }
> >  
> > +static void virtio_dev_shutdown(struct device *_d)
> > +{
> > +	struct virtio_device *dev = dev_to_virtio(_d);
> > +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > +
> > +	if (drv && drv->remove)
> > +		drv->remove(dev);


I am concerned that full remove is a heavyweight operation.
Do not want to slow down reboots even more.
How about just doing a reset, instead?

> > +}
> > +
> >  static const struct bus_type virtio_bus = {
> >  	.name  = "virtio",
> >  	.match = virtio_dev_match,
> > @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> >  	.uevent = virtio_uevent,
> >  	.probe = virtio_dev_probe,
> >  	.remove = virtio_dev_remove,
> > +	.shutdown = virtio_dev_shutdown,
> >  };
> >  
> >  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)

