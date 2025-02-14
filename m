Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EB20C00B
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535400; cv=none; b=Oyji3iJqChFbEDacLblbqoRjM3JBHdAAlrWJ/ZhF6EblvuF++D/89ZuryvVRC4EhV4dxna1CKCwa1b51YvoV6O9C7K0PTm/2bI/A8usCd+/Zml3Hmw7L7kO5tbHm2b+C7hz2ljvmTVdOqolJJmARAFMJklCSC4EklsnBXb7SXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535400; c=relaxed/simple;
	bh=/o8fcaoZZy95Ve/jJBOP4FiNXTZNLQeMk1Fa6jY4dMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QeiCqN2QrMC6OEViR7BauBjhZcQyNIXwefsYXUaACBEctKExmeFGLN3Tn1BM33jlXqXBsB3OeS+Lycc1r1sQCbfpnHoHnTOv/mOnbAm7S67bpIFwOnq21kL9C/EvXZ6riccx7k5QXUKoilJHRaD12DD6/XyTOjH5Zrg1HSlt9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egZvpCyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egZvpCyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739535397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA+7Z+yJbgdcOkkvDK35ReVebQSawPFeyqsCedXlO0E=;
	b=egZvpCySG0l0NyzZqc1UpMWKA2UTAPMtpuaf73ppYiVWnLu2sW7QCX3HZqsemOn+ses5Pz
	J3CFsnErQr5Tzskl8e62cQoYxx8X7frVNaLe5Gw8PV9XufC8Tqi81IMPrG/lTGzuF33029
	Laq4BDm06aC8OQtkMKNPq8WaSC+hPOw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68--d_mjT3wOxKtcfIVsPTGSQ-1; Fri, 14 Feb 2025 07:16:36 -0500
X-MC-Unique: -d_mjT3wOxKtcfIVsPTGSQ-1
X-Mimecast-MFC-AGG-ID: -d_mjT3wOxKtcfIVsPTGSQ_1739535395
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab7f6d9f4bfso184617766b.1
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 04:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535395; x=1740140195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA+7Z+yJbgdcOkkvDK35ReVebQSawPFeyqsCedXlO0E=;
        b=VgWFQR/b3HB5a5Fg3MmMXE5p39zmOHySKC2TSdwvIwY1yFa+ZXel1SEpH3tt09s1+k
         i1G+63A76sLXifnsvouLahVjHEAPottg5MsW19skS2RIGF16D4YTMckiQ5CgpdPgiHUi
         Xu/tY5eVGBkkiaaCAP8tVAQMeZhPVqQ5EvJztvuned8R47QCMnKO+Szk4gvxITnggsmW
         ghZQq5wBZ2zazVgpvEdWHfxA9dGEEH5dyO0Pszg5MNT3sm0gg4iGxmILpaCfP4qbf9xq
         9JIEu6HiPDS98+7VBeVaUk7Lmte3vVohOpWTXPdZuud8icLIabNbHWmpm5XectbvqBBg
         8PTA==
X-Forwarded-Encrypted: i=1; AJvYcCXayUZm5wojpf4A1/Y4KHEn6i8Zlr5X6D+fS+M8v0MPskl6tPQWL2k2+Kene40tkbzEBBIS15D7jXCi8IRh3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSw04FKI450WFkZyZbK4nW1qAgS5lVfwmqvdvbRAgc083OdvEs
	hPXW5wCDQHZ9/Jj6vjZ0AfE/EHA+ArxEjjqth+0ya/dH8zwk9NOcxlvj5aJCw+Q5DveaHYGGZsn
	OEHfpcmDzYpw+w+3T0GGADwd7KT916qhAJa+eNyzuuF1jDKTFj++Bca5h1oJDNKRC
X-Gm-Gg: ASbGncssVREAy4i8sIhpefqDz30ezz6A4x+wzQdMuSrtEFNnrKlvopGTJwOCB5qQVr/
	e4naEADE+UrbcTQEAeheQAxfAe2EpWzbDXuOnZ5F2dYZVPIp7TRPOVigVh6Shu8YOMHoEkt+vs/
	jGR9kk1kCwa407/dNx6nVuYAmu2QUKT/ChwPZmb6bQBHZPE3qn7KU0163Pg/s5APKnhabHdPV25
	7I2zekcZZ41dXILW9WdQQuR/0YNg4p/GByXtuwrVlJE/rhFO7OEhCmNxvOC1VsWsGa0+Q==
X-Received: by 2002:a17:907:d15:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-aba501bc5admr737240366b.51.1739535395122;
        Fri, 14 Feb 2025 04:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzflie8j7cMepDFh5VNqCOhDNeSL2Ik5idlR4ZEhXPbKFLX9WkajJhHZ7aepnfCQqle/r6yA==
X-Received: by 2002:a17:907:d15:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-aba501bc5admr737236866b.51.1739535394691;
        Fri, 14 Feb 2025 04:16:34 -0800 (PST)
Received: from redhat.com ([2.55.187.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322dbsm336512866b.10.2025.02.14.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:16:33 -0800 (PST)
Date: Fri, 14 Feb 2025 07:16:30 -0500
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
Message-ID: <20250214070904-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3aFWs3DhnVJuWNFbmWzOcHUCxMh8xConNfNF--ItiJE_1739535395
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
> Hi,
> 
> On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> > 
> > 
> > On 2025/2/6 16:59, Eric Auger wrote:
> >> Hi,
> >>
> >> On 2/4/25 12:46 PM, Eric Auger wrote:
> >>> Hi,
> >>>
> >>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> >>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> >>>>> Hi Kirill, Michael
> >>>>>
> >>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> >>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> >>>>>> accesses during the hang.
> >>>>>>
> >>>>>>     Invalid read at addr 0x102877002, size 2, region '(null)',
> >>>>>> reason: rejected
> >>>>>>     Invalid write at addr 0x102877A44, size 2, region '(null)',
> >>>>>> reason: rejected
> >>>>>>     ...
> >>>>>>
> >>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
> >>>>>> console
> >>>>>> is not in use.
> >>>>>>
> >>>>>> Looks like virtio-console continues to write to the MMIO even after
> >>>>>> underlying virtio-pci device is removed.
> >>>>>>
> >>>>>> The problem can be mitigated by removing all virtio devices on virtio
> >>>>>> bus shutdown.
> >>>>>>
> >>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> >>>>>
> >>>>> Gentle ping on that patch that seems to have fallen though the cracks.
> >>>>>
> >>>>> I think this fix is really needed. I have another test case with a
> >>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
> >>>>> viommu. Since there is currently no shutdown for the virtio-net, on
> >>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
> >>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
> >>>>>
> >>>>> Normally device_shutdown() should call virtio-net shutdown before the
> >>>>> IOMMU tear down and we wouldn't see any spurious transactions after
> >>>>> iommu shutdown.
> >>>>>
> >>>>> With that fix, the above test case is fixed and I do not see spurious
> >>>>> vhost IOTLB miss spurious requests.
> >>>>>
> >>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
> >>>>> IOTLB callbacks when IOMMU gets disabled,
> >>>>> https://lore.kernel.org/all/20250120173339.865681-1-
> >>>>> eric.auger@redhat.com/)
> >>>>>
> >>>>>
> >>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>> Eric
> >>>>>
> >>>>>> ---
> >>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
> >>>>>>   1 file changed, 10 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >>>>>> index a9b93e99c23a..6c2f908eb22c 100644
> >>>>>> --- a/drivers/virtio/virtio.c
> >>>>>> +++ b/drivers/virtio/virtio.c
> >>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> >>>>>>       of_node_put(dev->dev.of_node);
> >>>>>>   }
> >>>>>>   +static void virtio_dev_shutdown(struct device *_d)
> >>>>>> +{
> >>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
> >>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> >>>>>> +
> >>>>>> +    if (drv && drv->remove)
> >>>>>> +        drv->remove(dev);
> >>>>
> >>>>
> >>>> I am concerned that full remove is a heavyweight operation.
> >>>> Do not want to slow down reboots even more.
> >>>> How about just doing a reset, instead?
> >>>
> >>> I tested with
> >>>
> >>> static void virtio_dev_shutdown(struct device *_d)
> >>> {
> >>>          struct virtio_device *dev = dev_to_virtio(_d);
> >>>
> >>>          virtio_reset_device(dev);
> >>> }
> >>>
> >>>
> >>> and it fixes my issue.
> >>>
> >>> Kirill, would that fix you issue too?
> > 
> > Hi,
> > 
> > sorry for my late response, I synced with Kirill offline and did a retest.
> > 
> > The issue is still reproduced on my side, kexec will be stuck in case of
> > "console=hvc0" append in kernel cmdline and even with such patch applied.
> 
> Thanks for testing!
> 
> Michael, it looks like the initial patch from Kyrill is the one that
> fixes both issues. virtio_reset_device() usage does not work for the
> initial bug report while it works for me. Other ideas?
> 
> Thanks
> 
> Eric

Ah, wait a second.

Looks like virtio-console continues to write to the MMIO even after
underlying virtio-pci device is removed.

Hmm. I am not sure why that is a problem, but I assume some hypervisors just
hang the system if you try to kick them after reset.
Unfortunate that spec did not disallow it.

If we want to prevent that, we want to do something like this:


	/*
	 * Some devices get wedged if you kick them after they are
	 * reset. Mark all vqs as broken to make sure we don't.
	 */
        virtio_break_device(dev);
        /*
         * The below virtio_synchronize_cbs() guarantees that any
         * interrupt for this line arriving after
         * virtio_synchronize_vqs() has completed is guaranteed to see
         * vq->broken as true.
         */
        virtio_synchronize_cbs(dev);
        dev->config->reset(dev);


I assume this still works for you, yes?



> > 
> > my kernel code base is 6.14.0-rc2.
> > 
> > let me know if any more experiments needed.
> > 
> > ---
> >  drivers/virtio/virtio.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index ba37665188b5..f9f885d04763 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -395,6 +395,13 @@ static const struct cpumask
> > *virtio_irq_get_affinity(struct device *_d,
> >         return dev->config->get_vq_affinity(dev, irq_vec);
> >  }
> > 
> > +static void virtio_dev_shutdown(struct device *_d)
> > +{
> > +        struct virtio_device *dev = dev_to_virtio(_d);
> > +
> > +        virtio_reset_device(dev);
> > +}
> > +
> >  static const struct bus_type virtio_bus = {
> >         .name  = "virtio",
> >         .match = virtio_dev_match,
> > @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
> >         .probe = virtio_dev_probe,
> >         .remove = virtio_dev_remove,
> >         .irq_get_affinity = virtio_irq_get_affinity,
> > +       .shutdown = virtio_dev_shutdown,
> >  };
> > 
> >  int __register_virtio_driver(struct virtio_driver *driver, struct
> > module *owner)
> > -- 
> > 2.43.0
> > 
> > 
> >> gentle ping.
> >>
> >> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
> >> the above addition I get rid of spurious warning in qemu on guest reboot.
> >>
> >> qemu-system-aarch64: virtio: zero sized buffers are not allowed
> >> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
> >> argument (22)
> >>
> >> Would you mind if I respin?
> >>
> >> Thanks
> >>
> >> Eric
> >>
> >>
> >>
> >>
> >>>
> >>> Thanks
> >>>
> >>> Eric
> >>>>
> >>>>>> +}
> >>>>>> +
> >>>>>>   static const struct bus_type virtio_bus = {
> >>>>>>       .name  = "virtio",
> >>>>>>       .match = virtio_dev_match,
> >>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
> >>>>>>       .uevent = virtio_uevent,
> >>>>>>       .probe = virtio_dev_probe,
> >>>>>>       .remove = virtio_dev_remove,
> >>>>>> +    .shutdown = virtio_dev_shutdown,
> >>>>>>   };
> >>>>>>     int __register_virtio_driver(struct virtio_driver *driver,
> >>>>>> struct module *owner)
> >>>>
> >>>
> >>
> > 

