Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E5819
	for <virtualization@lists.linux.dev>; Tue, 18 Feb 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739837564; cv=none; b=JWzspElYSrtxP6k8PRDHUDz53Ug7uJL/GQxaNTdnN3Arqgodc2WtObEfurmhQ++cET+xWXWiG0ox/LuhGN39PH4sre1uGFKFNDCOT+fnysz4+on7UFseiP+jrDvJcKR/Rrl2NhCVx2hSD9zjZz9jMl42vp5R4DpPua/DFNkBlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739837564; c=relaxed/simple;
	bh=uC8cKZgH5jtMxAMxHIrCMiEUZs5Vp6M4wFq3dcuatR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BfoSkA4zZkyxZ67+EpVm1hNkrX+/HJ1IGXR+rpBMUFW5LZpKY/+ABTTC998E2KQczWVLUCUD/H5LLCS9m2CuAwYJxxKZF7emdQBp3sQYc6AHBRLTmQP4fgdpdDKc7eo8z85SvCOqeSn3Si8Q8vZy/jNcXvoNELUR90EijqYeAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZ2nxg7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ2nxg7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739837560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B02gyojDUiuYtKrTl8LJtiDNK23qLyYF7c8avrsDEN4=;
	b=TZ2nxg7MC1XHdHarv2RLtVzKPor0oMukXir+T47sCDhJBPlCJhOJPNw1L8g3sMgTYcrnnu
	oQdMAXeHH4D2uSB0BujxJdbqa3LkjtL0/C4/qyD7Tq4fZEMn5wLOfP5pbKytZNTh1RODgh
	4og43UOMybXCX3gEa28M2cf9ZVdHQjQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-aU1Sb-agOpabASKGlLYo0Q-1; Mon, 17 Feb 2025 19:12:39 -0500
X-MC-Unique: aU1Sb-agOpabASKGlLYo0Q-1
X-Mimecast-MFC-AGG-ID: aU1Sb-agOpabASKGlLYo0Q_1739837558
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43961fb0bafso24918125e9.2
        for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 16:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739837558; x=1740442358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B02gyojDUiuYtKrTl8LJtiDNK23qLyYF7c8avrsDEN4=;
        b=Gc6NfcujuBr7Ti6xTaXwubKqbWkkweGN+BBFdQbynYvrI8WRRsXRjuaimgDo0Vz3Fa
         6qSHJ2ATKHi6jpd2FzTd6jbsEmE1jxHWJH+CMbe/WlmWlyFJWAe5hDRiEobXZpF420iX
         t/pWiVCfmp74wklq+nZZlgaUsen/UnFgnZuGmx4VS0iAwG6e7voB/RsaKNXvDC+VG2Ki
         AcqN9RuybGWKt+4DfWzlsE28v4BFUa2Dm5L0hS+QHzIi36hsvgxbQ9GFwHks+JiIanEY
         n+x+MALz5sQfSRua92S+LBpHvVjqUzjQ4awaou7wuSVLrDGe/Ij2jRD/ZrLN2gO6qfiF
         KLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5zdFWVuJLRuTQ0CChcrSPCfEPpP2Ymln/18VE402QUv6hI8xhEJvaXklj8lTf/8AT57XvcqZoRnleSOUpIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3Wmyt2ajjuh1s0CC9LWoip93cb/SW/1T3F0lFFteQkyQskuWO
	k6WIK+vqPi4OflgIMTJ954G8ALKItkJDCrzef7Dd0i7Sbt/XaVWZDZXH3PW1XI4FPX4QX8TGtPj
	CDdZNM0KtQkCU2tl/7hriE1a/1IFLufglrHpGsQaep/0+hmWpmv6ebb7EGi9TMqkh
X-Gm-Gg: ASbGncs9H4RwhU7FW4lz9R8HJOllLU7yxEeXUNd6gABz0glHMfCC3EXTeBYgLvAR2OP
	Hz96VZnd9QKiCM5vDrJfdqJ9uhUANMCVdyL5QbqAi2BphM4e9qXZs1MMtf2guBRP8HMIrJspZ8M
	Zf/68pBwCyf7S/ZZUu2rMY2H1+0BVs3MnOVKogm5VskX7i03QlJkMEansg8JoXA8sVEoXcBIDSP
	Emb0+pIlJwypmlomgmRLHGy7L2DT7gaWZgO6cEGuFVrEMbFmiYv7XSJS7zt1fLWaH+qoMk=
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr42542975e9.30.1739837558453;
        Mon, 17 Feb 2025 16:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5kjO9h+qY7R0mzmILuEK/JSqwr6CGQLnkfN78PWHYwp+tnpQVFFvr841liMidGooiybCi0g==
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr42542725e9.30.1739837557989;
        Mon, 17 Feb 2025 16:12:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:7ef9:8f0d:a8:10c1:4db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858ec5fasm39352515e9.29.2025.02.17.16.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 16:12:37 -0800 (PST)
Date: Mon, 17 Feb 2025 19:12:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc: Eric Auger <eauger@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20250217191103-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
 <20250214070904-mutt-send-email-mst@kernel.org>
 <a48ec78d-a86f-4332-87d0-e6071f72a7d1@redhat.com>
 <ee89c12c-a252-4c6d-a062-4fb57f2c85a9@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ee89c12c-a252-4c6d-a062-4fb57f2c85a9@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wdrTrksKvL63efM7Kh9Sc-E7RvAZXhvNIpKB6c12Me4_1739837558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Feb 18, 2025 at 07:57:23AM +0800, Ning, Hongyu wrote:
> 
> 
> On 2025/2/17 17:25, Eric Auger wrote:
> > Hi Michael, Hongyu,
> > 
> > On 2/14/25 1:16 PM, Michael S. Tsirkin wrote:
> > > On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
> > > > Hi,
> > > > 
> > > > On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> > > > > 
> > > > > 
> > > > > On 2025/2/6 16:59, Eric Auger wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 2/4/25 12:46 PM, Eric Auger wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> > > > > > > > > Hi Kirill, Michael
> > > > > > > > > 
> > > > > > > > > On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> > > > > > > > > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > > > > > > > > accesses during the hang.
> > > > > > > > > > 
> > > > > > > > > >      Invalid read at addr 0x102877002, size 2, region '(null)',
> > > > > > > > > > reason: rejected
> > > > > > > > > >      Invalid write at addr 0x102877A44, size 2, region '(null)',
> > > > > > > > > > reason: rejected
> > > > > > > > > >      ...
> > > > > > > > > > 
> > > > > > > > > > It was traced down to virtio-console. Kexec works fine if virtio-
> > > > > > > > > > console
> > > > > > > > > > is not in use.
> > > > > > > > > > 
> > > > > > > > > > Looks like virtio-console continues to write to the MMIO even after
> > > > > > > > > > underlying virtio-pci device is removed.
> > > > > > > > > > 
> > > > > > > > > > The problem can be mitigated by removing all virtio devices on virtio
> > > > > > > > > > bus shutdown.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > > > > > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > > > > > > > > 
> > > > > > > > > Gentle ping on that patch that seems to have fallen though the cracks.
> > > > > > > > > 
> > > > > > > > > I think this fix is really needed. I have another test case with a
> > > > > > > > > rebooting guest exposed with virtio-net (backed by vhost-net) and
> > > > > > > > > viommu. Since there is currently no shutdown for the virtio-net, on
> > > > > > > > > reboot, the IOMMU is disabled through the native_machine_shutdown()/
> > > > > > > > > x86_platform.iommu_shutdown() while the virtio-net is still alive.
> > > > > > > > > 
> > > > > > > > > Normally device_shutdown() should call virtio-net shutdown before the
> > > > > > > > > IOMMU tear down and we wouldn't see any spurious transactions after
> > > > > > > > > iommu shutdown.
> > > > > > > > > 
> > > > > > > > > With that fix, the above test case is fixed and I do not see spurious
> > > > > > > > > vhost IOTLB miss spurious requests.
> > > > > > > > > 
> > > > > > > > > For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
> > > > > > > > > IOTLB callbacks when IOMMU gets disabled,
> > > > > > > > > https://lore.kernel.org/all/20250120173339.865681-1-
> > > > > > > > > eric.auger@redhat.com/)
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > > > > > > > Tested-by: Eric Auger <eric.auger@redhat.com>
> > > > > > > > > 
> > > > > > > > > Thanks
> > > > > > > > > 
> > > > > > > > > Eric
> > > > > > > > > 
> > > > > > > > > > ---
> > > > > > > > > >    drivers/virtio/virtio.c | 10 ++++++++++
> > > > > > > > > >    1 file changed, 10 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > > > > index a9b93e99c23a..6c2f908eb22c 100644
> > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> > > > > > > > > >        of_node_put(dev->dev.of_node);
> > > > > > > > > >    }
> > > > > > > > > >    +static void virtio_dev_shutdown(struct device *_d)
> > > > > > > > > > +{
> > > > > > > > > > +    struct virtio_device *dev = dev_to_virtio(_d);
> > > > > > > > > > +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > > > > > > > > > +
> > > > > > > > > > +    if (drv && drv->remove)
> > > > > > > > > > +        drv->remove(dev);
> > > > > > > > 
> > > > > > > > 
> > > > > > > > I am concerned that full remove is a heavyweight operation.
> > > > > > > > Do not want to slow down reboots even more.
> > > > > > > > How about just doing a reset, instead?
> > > > > > > 
> > > > > > > I tested with
> > > > > > > 
> > > > > > > static void virtio_dev_shutdown(struct device *_d)
> > > > > > > {
> > > > > > >           struct virtio_device *dev = dev_to_virtio(_d);
> > > > > > > 
> > > > > > >           virtio_reset_device(dev);
> > > > > > > }
> > > > > > > 
> > > > > > > 
> > > > > > > and it fixes my issue.
> > > > > > > 
> > > > > > > Kirill, would that fix you issue too?
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > sorry for my late response, I synced with Kirill offline and did a retest.
> > > > > 
> > > > > The issue is still reproduced on my side, kexec will be stuck in case of
> > > > > "console=hvc0" append in kernel cmdline and even with such patch applied.
> > > > 
> > > > Thanks for testing!
> > > > 
> > > > Michael, it looks like the initial patch from Kyrill is the one that
> > > > fixes both issues. virtio_reset_device() usage does not work for the
> > > > initial bug report while it works for me. Other ideas?
> > > > 
> > > > Thanks
> > > > 
> > > > Eric
> > > 
> > > Ah, wait a second.
> > > 
> > > Looks like virtio-console continues to write to the MMIO even after
> > > underlying virtio-pci device is removed.
> > > 
> > > Hmm. I am not sure why that is a problem, but I assume some hypervisors just
> > > hang the system if you try to kick them after reset.
> > > Unfortunate that spec did not disallow it.
> > > 
> > > If we want to prevent that, we want to do something like this:
> > > 
> > > 
> > > 	/*
> > > 	 * Some devices get wedged if you kick them after they are
> > > 	 * reset. Mark all vqs as broken to make sure we don't.
> > > 	 */
> > >          virtio_break_device(dev);
> > >          /*
> > >           * The below virtio_synchronize_cbs() guarantees that any
> > >           * interrupt for this line arriving after
> > >           * virtio_synchronize_vqs() has completed is guaranteed to see
> > >           * vq->broken as true.
> > >           */
> > >          virtio_synchronize_cbs(dev);
> > >          dev->config->reset(dev);
> > > 
> > > 
> > > I assume this still works for you, yes?
> > Would that still been done in the virtio_dev_shutdown()?
> > 
> > Is that what you tested Hongyu?
> 
> Hi Eric,
> 
> my patch applied based on Michael's comments:
> 
> ---
>  drivers/virtio/virtio.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ba37665188b5..458dc28be060 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -395,6 +395,25 @@ static const struct cpumask
> *virtio_irq_get_affinity(struct device *_d,
>         return dev->config->get_vq_affinity(dev, irq_vec);
>  }
> 
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +        struct virtio_device *dev = dev_to_virtio(_d);
> +        /*
> +         * Some devices get wedged if you kick them after they are
> +         * reset. Mark all vqs as broken to make sure we don't.
> +         */
> +        virtio_break_device(dev);
> +        /*
> +         * The below virtio_synchronize_cbs() guarantees that any
> +         * interrupt for this line arriving after
> +         * virtio_synchronize_vqs() has completed is guaranteed to see
> +         * vq->broken as true.
> +         */
> +        virtio_synchronize_cbs(dev);
> +        dev->config->reset(dev);
> +       //virtio_reset_device(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>         .name  = "virtio",
>         .match = virtio_dev_match,
> @@ -403,6 +422,7 @@ static const struct bus_type virtio_bus = {
>         .probe = virtio_dev_probe,
>         .remove = virtio_dev_remove,
>         .irq_get_affinity = virtio_irq_get_affinity,
> +       .shutdown = virtio_dev_shutdown,
>  };
> 
>  int __register_virtio_driver(struct virtio_driver *driver, struct module
> *owner)
> --
> 2.43.0



yes, that's the patch. Does it work for you? Addresses the
problem? If yes I'll repost.

> 
> > 
> > Eric
> > > 
> > > 
> > > 
> > > > > 
> > > > > my kernel code base is 6.14.0-rc2.
> > > > > 
> > > > > let me know if any more experiments needed.
> > > > > 
> > > > > ---
> > > > >   drivers/virtio/virtio.c | 8 ++++++++
> > > > >   1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > index ba37665188b5..f9f885d04763 100644
> > > > > --- a/drivers/virtio/virtio.c
> > > > > +++ b/drivers/virtio/virtio.c
> > > > > @@ -395,6 +395,13 @@ static const struct cpumask
> > > > > *virtio_irq_get_affinity(struct device *_d,
> > > > >          return dev->config->get_vq_affinity(dev, irq_vec);
> > > > >   }
> > > > > 
> > > > > +static void virtio_dev_shutdown(struct device *_d)
> > > > > +{
> > > > > +        struct virtio_device *dev = dev_to_virtio(_d);
> > > > > +
> > > > > +        virtio_reset_device(dev);
> > > > > +}
> > > > > +
> > > > >   static const struct bus_type virtio_bus = {
> > > > >          .name  = "virtio",
> > > > >          .match = virtio_dev_match,
> > > > > @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
> > > > >          .probe = virtio_dev_probe,
> > > > >          .remove = virtio_dev_remove,
> > > > >          .irq_get_affinity = virtio_irq_get_affinity,
> > > > > +       .shutdown = virtio_dev_shutdown,
> > > > >   };
> > > > > 
> > > > >   int __register_virtio_driver(struct virtio_driver *driver, struct
> > > > > module *owner)
> > > > > -- 
> > > > > 2.43.0
> > > > > 
> > > > > 
> > > > > > gentle ping.
> > > > > > 
> > > > > > this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
> > > > > > the above addition I get rid of spurious warning in qemu on guest reboot.
> > > > > > 
> > > > > > qemu-system-aarch64: virtio: zero sized buffers are not allowed
> > > > > > qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
> > > > > > argument (22)
> > > > > > 
> > > > > > Would you mind if I respin?
> > > > > > 
> > > > > > Thanks
> > > > > > 
> > > > > > Eric
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Thanks
> > > > > > > 
> > > > > > > Eric
> > > > > > > > 
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >    static const struct bus_type virtio_bus = {
> > > > > > > > > >        .name  = "virtio",
> > > > > > > > > >        .match = virtio_dev_match,
> > > > > > > > > > @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> > > > > > > > > >        .uevent = virtio_uevent,
> > > > > > > > > >        .probe = virtio_dev_probe,
> > > > > > > > > >        .remove = virtio_dev_remove,
> > > > > > > > > > +    .shutdown = virtio_dev_shutdown,
> > > > > > > > > >    };
> > > > > > > > > >      int __register_virtio_driver(struct virtio_driver *driver,
> > > > > > > > > > struct module *owner)
> > > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > 
> > > 
> > 
> > 

