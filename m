Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F92AD11
	for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324547; cv=none; b=tnTOG/n8ebjKaiOIg0KmiORSG8awMXVX3PPPClDZOb3Hjq8awSPxn7mWHm7xQBY72mlnIc5TsifWTA+F1mV/4kxn75ohP3GFyQDb1D5f3aQkqR4N8ia7U253I15bbRHZ6rEPRRT3AL0hykvKreIHiSqtDGKuukiqbWih9cA96Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324547; c=relaxed/simple;
	bh=scVrc/yjK/SkdVvfg1LnSKpnjQsYCshbaq6radawkR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NS23MvpyfMz+6bBkEHJEvsOVxCJgIbem1mHPtElTI1UtCn1z6nKEvM810vCgph2cXKRTKYbXJ5RCBhFHx+vqaZRkyIkxj13vNG4PPvgBJ+Ptr+Hvzv/MxN8sRrUZBRKBSuIfE9n28tyvc5MwqwgFXHR4ZxX7X1IVe2TyiKnrNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ0h82jG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ0h82jG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738324544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A82Hxy6SJcFBD073DJAR0nQpQvHwFh9UPNmB7dDRDxw=;
	b=BZ0h82jGbKCpEpUmVhsZeooiWb92znNT2+U8KE1ISYxGDTXo3SvNcpU2O0TLwnQtM2WHnI
	AkoclTF38DlGTt+tSGrkwLE3QWW3kbB+SpMMzGk+89AHmXmNykYrsii7+wJKd8CdZEZBKG
	JQhvZVJ5f1Q36hqvU+2vJm2gaAUk8HI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-hzTl0yPbOPKOUHAKOtEaGQ-1; Fri, 31 Jan 2025 06:55:43 -0500
X-MC-Unique: hzTl0yPbOPKOUHAKOtEaGQ-1
X-Mimecast-MFC-AGG-ID: hzTl0yPbOPKOUHAKOtEaGQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so14430375e9.0
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 03:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738324542; x=1738929342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A82Hxy6SJcFBD073DJAR0nQpQvHwFh9UPNmB7dDRDxw=;
        b=bAtJ5W3i9ZAgocP6LiuqfrwKLaR31ytM6w8++FWOggwYJ2ww46FWeCNszskB5eY46c
         OpB/d4h8DSczW50Q9P72jF720QApSuWFZ4m8UIu0lYVPJoTOw2Ff+9te1U7cRqB4q9Nx
         ILPgsceDE+PQCxeX6Med22fr+JlJMprYkoRQol0xIZ+UZRkWdUP5bOwhBprDJwZNQ8kV
         WTSDf4F1v6lTZRlr5QWcYNtRW15NaalxowmQHNUAiK+1+rbxBPilQNVadJhRLKWchuVv
         gIw54uSV3g9X+HoxJT1b8pwOKJNpOWfkux9Y907H5H0G76SLOaiUfrYDGowlLRIcvphs
         qQZA==
X-Forwarded-Encrypted: i=1; AJvYcCWF/xxLjyc45ENlNQJO5QnCTyaS1on9IVqx5pmhJcCQ9c1wRsEaIn9Qs27+84YEhAJUg9knxqbLw/+GSyJo0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGnBZfr2xAMuSAmTeUZQ1zesdsg8qnlcMv7fqBHlqhsfUA7DqY
	8rUIOogKoYj0F9v/2vnVz53E/eK9xL/kf4xHFl95+GrDg6k2keTURuqax+9IfNvnj/jsnZDP1aI
	KoYHexsnu2fb9cFNMp6D+aHdrD7RAk7Z5SDKBgIHb8cUbOPFeItQIGsNrEZOL3qBY
X-Gm-Gg: ASbGncsHLfln2SEkuTMd4b8aFv9HS8Lb1ReY+ORfqQhRb4MX99mShgJUazlNMEx8MgN
	0qsTOdjJDqy6EafTvq0YSyn8o+m4BfSzKSqcYWpumIfKlXd22poP5QkSS9AmXoIR2GFo8c0Jo6d
	/eHQfR9pg7jPpT0yf2fnZYRL/l6ebaviGrwaA52JpJz0zbFVyZIl4YgRGxQZQZY+PiiqjC9qrL4
	U7yR9e3LGvVW7uo7YZ9I8cNZCwOI14VTQJWTErmH4WzvVI41Uox3OX32d4U2d/UO6ZFn721goHl
X-Received: by 2002:a05:600c:c17:b0:438:a290:3ce0 with SMTP id 5b1f17b1804b1-438dc3be2efmr102308105e9.8.1738324541666;
        Fri, 31 Jan 2025 03:55:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy3XXDXvUtmfGjiC0KpxrbpWF8jiQEcEO//6J+N25Sm2AQlT/WzpKdVXrYSGXtrNJ8Y8rAvg==
X-Received: by 2002:a05:600c:c17:b0:438:a290:3ce0 with SMTP id 5b1f17b1804b1-438dc3be2efmr102307855e9.8.1738324541230;
        Fri, 31 Jan 2025 03:55:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:25e:64cf:ae20:59ee:ed31:b415])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc26b15sm88397435e9.11.2025.01.31.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 03:55:40 -0800 (PST)
Date: Fri, 31 Jan 2025 06:55:36 -0500
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
Message-ID: <20250131065357-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: FmSQ4oj5AQR6mmuJv5a3e92EbEilNQDoDCUam6q3-TI_1738324542
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


OK I'll re-review. Thanks!

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

