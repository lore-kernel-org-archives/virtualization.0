Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712791A76AE
	for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834428; cv=none; b=h6XUaxKdCEe6gojUxXZq0AkbTmK74pquyXJZ0hE8A5urm1D1HCrXSYqwTBboY1+IWi3vT5ooUD+MDj5KvDLITclrElKbpTdWUS6ZdhMNau102bCYEjuhnh1u0tDriJry8FZATgg0asEP/MqWThZn3IWvtM6qpZwuWCzK9jPt868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834428; c=relaxed/simple;
	bh=viCMkJaguABg3O8W0SSjrxvUmaw6JK3mrEPIjSGKuq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BOMLJehIOIeN/nqDtFu6fN+fVhIve85fzSy0r6icwFLnGXUnoLiMYCvVe1rZcA8TsfHhlKIwcUabCyNwdit47BpLhLJFFl/rLR9SmrSaPOLSgDZKzBN6hOfGQYSATYz0d59TDVnDG3kOV1Ka8FZJYaAtYbR4nViscmdp/zg6rXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SY3p8HBV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY3p8HBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739834425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGgmxNh5kSJhTq/p1OO25Mo/qlvmdqIHbViecFk0pek=;
	b=SY3p8HBVAboem+yrs0rsT8TQpxN0QQlMC0TxAnYX5K3OqJLcZrC8BJQIv2kRTaSbCIrpjp
	vNz2ZP+/zHYQqKrsiSCjSExAHTVapeLUynpRQjC2KcQJx3eO4xYAhTjbEqmDLhRXfesnmX
	KqNjiCkH85YnblQYodKAImdDhfBkvp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-DzxIfI2kPrqWGt6FkxUOBw-1; Mon, 17 Feb 2025 18:20:23 -0500
X-MC-Unique: DzxIfI2kPrqWGt6FkxUOBw-1
X-Mimecast-MFC-AGG-ID: DzxIfI2kPrqWGt6FkxUOBw_1739834422
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43942e82719so43487155e9.2
        for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 15:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739834422; x=1740439222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGgmxNh5kSJhTq/p1OO25Mo/qlvmdqIHbViecFk0pek=;
        b=Qt3GrOs8Qho0zJgfBEg4vO0px+R0vpmzsmHZsBFZakKUUeInxA5qciqw7nw7HBeoer
         rYti+x5OE9YBMUGsAbGjWopiwErehos0OSVniy75w5m9YGYMv+1ghyB4DVUZOsARxJoo
         T7MQDPMzf6wZKqX6J7yN0B30yLivZ1fprL3weUqHIOEE+bxGARaP7z5D2Whcn0zkZ3VE
         LXpg4KX8aqwbqNMPbOYAmSgqyBxpduHi1aXWA/6xfqewMjNcE3geGfwHIh/nKB9X1ZEy
         JaW2+c9Pana/p6GvKNe9uNTV71TyQ2S9T8gmzP+VmZ+3dJrbD/9bv6/AagMKZTIoL4S0
         m+DA==
X-Forwarded-Encrypted: i=1; AJvYcCVsuEWs4idvaggI7xaVM2+EAM0TYmK+rN86kdd6PHXeC9aolq3y9QIajNPdIohdZ6NCwT6tMlgdoD8oXqKyLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp7ngWEfx7zv/VV8vzwyUS0NIHURzAbObL2tnyxW9UnHi5uMio
	fYbQEMDjdyC14MopRzs917ehv1mn4gohD60yBbt0+gkxfG/AskNqas01KabGac5g8qPHFdmpKwC
	vmHSkUR0n3FRO4Zo5Gl2MiODzkvx4bx+N881HQcaZppCJiH3D2+pO42w67x/4jWYT
X-Gm-Gg: ASbGncsCFtGDvwJtrZWnMrSXScQ//AizTu/XrPbEpmLNkloOvcx4hln684J6/UpG4RR
	Y5A1ksuZjMZt44gJTNm3TqaqK4Ek4z4fjQnWrKtsgD9LFfmMICK+h/JsFkyjXWGHOFLZGdUNeMX
	zOqp3Mg9fRSg1HKKcmn/N6Jq98Uk3NntSGO7AChLAaq5F1kG+DLEQyEkoTQSi7PWij8DGGSp/cN
	AGS1u+zuBmP/H6zYcPKN1OoIPMVaZJmjTekD2bORx9O6uI5oIqULzQmweoLv81ip4kvbto=
X-Received: by 2002:a05:6000:18a9:b0:38d:deb4:4ee8 with SMTP id ffacd0b85a97d-38f33f2f8d3mr12291308f8f.28.1739834422355;
        Mon, 17 Feb 2025 15:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqcUqQDWXyXS+yXasXUh7eawGe8/yKuXmNZtdELoNSjmvRkQUIzJNCr+BIjIBS93gCq7Ufug==
X-Received: by 2002:a05:6000:18a9:b0:38d:deb4:4ee8 with SMTP id ffacd0b85a97d-38f33f2f8d3mr12291287f8f.28.1739834421963;
        Mon, 17 Feb 2025 15:20:21 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:7ef9:8f0d:a8:10c1:4db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2580fe7dsm13409933f8f.0.2025.02.17.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 15:20:21 -0800 (PST)
Date: Mon, 17 Feb 2025 18:20:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20250217181953-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
 <20250214070904-mutt-send-email-mst@kernel.org>
 <a48ec78d-a86f-4332-87d0-e6071f72a7d1@redhat.com>
 <7fb416d6-00b5-4e28-b257-151d3289e76d@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7fb416d6-00b5-4e28-b257-151d3289e76d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rh9oyUp6AzNlSSgSPv8GdKzwXHY6FtM7ivBMZOIR0nE_1739834422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Feb 17, 2025 at 05:59:30PM +0100, Eric Auger wrote:
> Hi Michael,
> 
> On 2/17/25 10:25 AM, Eric Auger wrote:
> > Hi Michael, Hongyu,
> > 
> > On 2/14/25 1:16 PM, Michael S. Tsirkin wrote:
> >> On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
> >>> Hi,
> >>>
> >>> On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> >>>>
> >>>>
> >>>> On 2025/2/6 16:59, Eric Auger wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 2/4/25 12:46 PM, Eric Auger wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> >>>>>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> >>>>>>>> Hi Kirill, Michael
> >>>>>>>>
> >>>>>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> >>>>>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> >>>>>>>>> accesses during the hang.
> >>>>>>>>>
> >>>>>>>>>     Invalid read at addr 0x102877002, size 2, region '(null)',
> >>>>>>>>> reason: rejected
> >>>>>>>>>     Invalid write at addr 0x102877A44, size 2, region '(null)',
> >>>>>>>>> reason: rejected
> >>>>>>>>>     ...
> >>>>>>>>>
> >>>>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
> >>>>>>>>> console
> >>>>>>>>> is not in use.
> >>>>>>>>>
> >>>>>>>>> Looks like virtio-console continues to write to the MMIO even after
> >>>>>>>>> underlying virtio-pci device is removed.
> >>>>>>>>>
> >>>>>>>>> The problem can be mitigated by removing all virtio devices on virtio
> >>>>>>>>> bus shutdown.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>>>>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> >>>>>>>>
> >>>>>>>> Gentle ping on that patch that seems to have fallen though the cracks.
> >>>>>>>>
> >>>>>>>> I think this fix is really needed. I have another test case with a
> >>>>>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
> >>>>>>>> viommu. Since there is currently no shutdown for the virtio-net, on
> >>>>>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
> >>>>>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
> >>>>>>>>
> >>>>>>>> Normally device_shutdown() should call virtio-net shutdown before the
> >>>>>>>> IOMMU tear down and we wouldn't see any spurious transactions after
> >>>>>>>> iommu shutdown.
> >>>>>>>>
> >>>>>>>> With that fix, the above test case is fixed and I do not see spurious
> >>>>>>>> vhost IOTLB miss spurious requests.
> >>>>>>>>
> >>>>>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
> >>>>>>>> IOTLB callbacks when IOMMU gets disabled,
> >>>>>>>> https://lore.kernel.org/all/20250120173339.865681-1-
> >>>>>>>> eric.auger@redhat.com/)
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>>>>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
> >>>>>>>>
> >>>>>>>> Thanks
> >>>>>>>>
> >>>>>>>> Eric
> >>>>>>>>
> >>>>>>>>> ---
> >>>>>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
> >>>>>>>>>   1 file changed, 10 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >>>>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
> >>>>>>>>> --- a/drivers/virtio/virtio.c
> >>>>>>>>> +++ b/drivers/virtio/virtio.c
> >>>>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> >>>>>>>>>       of_node_put(dev->dev.of_node);
> >>>>>>>>>   }
> >>>>>>>>>   +static void virtio_dev_shutdown(struct device *_d)
> >>>>>>>>> +{
> >>>>>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
> >>>>>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> >>>>>>>>> +
> >>>>>>>>> +    if (drv && drv->remove)
> >>>>>>>>> +        drv->remove(dev);
> >>>>>>>
> >>>>>>>
> >>>>>>> I am concerned that full remove is a heavyweight operation.
> >>>>>>> Do not want to slow down reboots even more.
> >>>>>>> How about just doing a reset, instead?
> >>>>>>
> >>>>>> I tested with
> >>>>>>
> >>>>>> static void virtio_dev_shutdown(struct device *_d)
> >>>>>> {
> >>>>>>          struct virtio_device *dev = dev_to_virtio(_d);
> >>>>>>
> >>>>>>          virtio_reset_device(dev);
> >>>>>> }
> >>>>>>
> >>>>>>
> >>>>>> and it fixes my issue.
> >>>>>>
> >>>>>> Kirill, would that fix you issue too?
> >>>>
> >>>> Hi,
> >>>>
> >>>> sorry for my late response, I synced with Kirill offline and did a retest.
> >>>>
> >>>> The issue is still reproduced on my side, kexec will be stuck in case of
> >>>> "console=hvc0" append in kernel cmdline and even with such patch applied.
> >>>
> >>> Thanks for testing!
> >>>
> >>> Michael, it looks like the initial patch from Kyrill is the one that
> >>> fixes both issues. virtio_reset_device() usage does not work for the
> >>> initial bug report while it works for me. Other ideas?
> >>>
> >>> Thanks
> >>>
> >>> Eric
> >>
> >> Ah, wait a second.
> >>
> >> Looks like virtio-console continues to write to the MMIO even after
> >> underlying virtio-pci device is removed.
> >>
> >> Hmm. I am not sure why that is a problem, but I assume some hypervisors just
> >> hang the system if you try to kick them after reset.
> >> Unfortunate that spec did not disallow it.
> >>
> >> If we want to prevent that, we want to do something like this:
> >>
> >>
> >> 	/*
> >> 	 * Some devices get wedged if you kick them after they are
> >> 	 * reset. Mark all vqs as broken to make sure we don't.
> >> 	 */
> >>         virtio_break_device(dev);
> >>         /*
> >>          * The below virtio_synchronize_cbs() guarantees that any
> >>          * interrupt for this line arriving after
> >>          * virtio_synchronize_vqs() has completed is guaranteed to see
> >>          * vq->broken as true.
> >>          */
> >>         virtio_synchronize_cbs(dev);
> >>         dev->config->reset(dev);
> I have tested that code as an implentation of the virtio shutdown
> callback and yes it also fixes the viommu/vhost issue.
> 
> Michael, will you send a patch then?
> 
> Thanks
> 
> Eric


Was hoping for a confirmation from Ning.

> >>
> >>
> >> I assume this still works for you, yes?
> > Would that still been done in the virtio_dev_shutdown()?
> > 
> > Is that what you tested Hongyu?
> > 
> > Eric
> >>
> >>
> >>
> >>>>
> >>>> my kernel code base is 6.14.0-rc2.
> >>>>
> >>>> let me know if any more experiments needed.
> >>>>
> >>>> ---
> >>>>  drivers/virtio/virtio.c | 8 ++++++++
> >>>>  1 file changed, 8 insertions(+)
> >>>>
> >>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >>>> index ba37665188b5..f9f885d04763 100644
> >>>> --- a/drivers/virtio/virtio.c
> >>>> +++ b/drivers/virtio/virtio.c
> >>>> @@ -395,6 +395,13 @@ static const struct cpumask
> >>>> *virtio_irq_get_affinity(struct device *_d,
> >>>>         return dev->config->get_vq_affinity(dev, irq_vec);
> >>>>  }
> >>>>
> >>>> +static void virtio_dev_shutdown(struct device *_d)
> >>>> +{
> >>>> +        struct virtio_device *dev = dev_to_virtio(_d);
> >>>> +
> >>>> +        virtio_reset_device(dev);
> >>>> +}
> >>>> +
> >>>>  static const struct bus_type virtio_bus = {
> >>>>         .name  = "virtio",
> >>>>         .match = virtio_dev_match,
> >>>> @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
> >>>>         .probe = virtio_dev_probe,
> >>>>         .remove = virtio_dev_remove,
> >>>>         .irq_get_affinity = virtio_irq_get_affinity,
> >>>> +       .shutdown = virtio_dev_shutdown,
> >>>>  };
> >>>>
> >>>>  int __register_virtio_driver(struct virtio_driver *driver, struct
> >>>> module *owner)
> >>>> -- 
> >>>> 2.43.0
> >>>>
> >>>>
> >>>>> gentle ping.
> >>>>>
> >>>>> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
> >>>>> the above addition I get rid of spurious warning in qemu on guest reboot.
> >>>>>
> >>>>> qemu-system-aarch64: virtio: zero sized buffers are not allowed
> >>>>> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
> >>>>> argument (22)
> >>>>>
> >>>>> Would you mind if I respin?
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>> Eric
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>> Eric
> >>>>>>>
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>   static const struct bus_type virtio_bus = {
> >>>>>>>>>       .name  = "virtio",
> >>>>>>>>>       .match = virtio_dev_match,
> >>>>>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> >>>>>>>>>       .uevent = virtio_uevent,
> >>>>>>>>>       .probe = virtio_dev_probe,
> >>>>>>>>>       .remove = virtio_dev_remove,
> >>>>>>>>> +    .shutdown = virtio_dev_shutdown,
> >>>>>>>>>   };
> >>>>>>>>>     int __register_virtio_driver(struct virtio_driver *driver,
> >>>>>>>>> struct module *owner)
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>
> > 

