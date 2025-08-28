Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AB27B359
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373006; cv=none; b=a8mkv4IWct/5R6my20XJwObuZ0PmQ0B5xMMHxksCNL/SiiaY6d6zEIDx7u+r+ecubDEzZpNY/+nX2jBJYee0SyI/SvMQeCnoLTw/usaEaQN2Nek39XPZ6uOUql3MB0ja6myyhhr+8AHwvTycs3v2fzioH7aleauU0wsVb/aNft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373006; c=relaxed/simple;
	bh=X5/mm30DCcXHuNcOaAjmcKM10wUx1QZvOoXLHltdXw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hXJQEwX+b3jAuGEBclIBWVL+6nLrKDr66B5sM23WsTGtTQ5qRq0dikixSDmqipHk2cuxQa/n6sQBAg++m7Ol/Ck/kok2miTva8xvhKvJn1JWai3jpGJrm6XNFOvQtLAEpJs5AJFGWW5e5bqu26b2hOeh3uXjWYzlyqPkfPZhzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMc3BEyq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMc3BEyq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756373003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRf45igs8DyZy1Xb/KozNOVC9d10iPYkxYVMeNdvMcE=;
	b=QMc3BEyqSeaupnrejRVfW68swkuDoRTyymeg7qXcAo07OvdP1eUd/CDh4sy8Hz4+UsXb0Y
	GOK/zJr69WtzOl5PvshVm8iCDz9YU9JTeadu5qlddqFWChduyUBnOAw4/5lX/QlRqE7pdJ
	0kCG5Ei4Iu4fYys6LTG7gdcT8r0Kzbw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-KUZEdhUrMMu3HL5hzfjjGQ-1; Thu, 28 Aug 2025 05:23:22 -0400
X-MC-Unique: KUZEdhUrMMu3HL5hzfjjGQ-1
X-Mimecast-MFC-AGG-ID: KUZEdhUrMMu3HL5hzfjjGQ_1756373001
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0514a5so2465935e9.1
        for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 02:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373001; x=1756977801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRf45igs8DyZy1Xb/KozNOVC9d10iPYkxYVMeNdvMcE=;
        b=ss0n4SrIgvVGZIZXWMLr9ToFsf32RW8jl+nNiyy5LXOFBlou9UWghLxWX9NR4QHQt/
         DLYSYa7JxbWn8FrAkv3+OmfaFj8ajRq2Ov2j02WDVTDjo5YtgXxAZQxJQ32AlCNgotuN
         GcUfHGQ7AMT73gIFDNwmEzCe9bc+mIFT+jjqBPDfErPrHVeVwkf+AzyOsq2x/wODbs/c
         1eUO1H3VmuDU/6eU8cwHy2aqF87uMp6NrWsjyjmWIXCCEyzXQOqRaCfkRP38m/x8Qqgn
         dKK/yXUHP+n0FX9ZJ+fr/6N3AJpfkDmOhLnCyXLirzBjmOtPuAnaizGUrXMdgZ7pIZEj
         240g==
X-Forwarded-Encrypted: i=1; AJvYcCVa+xlR6QfEhqMsv5edakgYYI9h7Y1yY/hYADPjl03neeaTEZjWe+9Q08KZHqrJMjdUMV2QJNN55bYBwau1MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsXMX7F46XIJ5pFM7HadF3iI1xzddl0LvjevWodX2rY+4A5K//
	E319D90RaGT7g1zOiV8CboQsOHFj26lheP83Tadc5E7hYboW38oowyJzO6PTdvBMj/D25jIDGv+
	tYngtHwqXGvxUTGLGOeAHE9R4hSJjri2rLipWDwiTZav+lzV7w59jfQKw3unu8T2q4+z5
X-Gm-Gg: ASbGncusLwFebcKwZfBCHFQuFviyHrSlcd9HL0Zcebmft+8q12MgG7jnJDKKkfKNIJ0
	kxJ3vK4Svvi/JAVSTXXwxwUxF/0tF45UfcW4kbCRUG4eXpSN9kDlE77btupP1BZl0ifb7WrC06U
	MsTa7702T2VbeKFkPUvdu1N5taGWMnNtuA4Vyg8BeEMOXlfdSbhFVVATbsFCZjTlUu1ImN/3tNA
	8FGVoVVbyJ1hAB+Cecx0VmX4tQ1oMnwM45sfeXSDV4f2+uR3eQmMmaNka8krTp1SWMapWLbyegE
	dTI7TwndEJ6oUBY/OJgOoKv8Vuqo8C7o
X-Received: by 2002:a05:600c:4715:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-45b517406fcmr176501465e9.0.1756373000895;
        Thu, 28 Aug 2025 02:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEua+jNTn1N9k+3zdhlbKarEWIC5ym4baEN46OI/f8wqkIX9E9+c1gWJ0ujKRXU1OZ4SThfzg==
X-Received: by 2002:a05:600c:4715:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-45b517406fcmr176501195e9.0.1756373000384;
        Thu, 28 Aug 2025 02:23:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797ce6d4sm23246455e9.14.2025.08.28.02.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:23:19 -0700 (PDT)
Date: Thu, 28 Aug 2025 05:23:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250828051435-mutt-send-email-mst@kernel.org>
References: <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
 <20250827064404-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250828022502-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956D1AB42BFA9BF19AE134DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB71956D1AB42BFA9BF19AE134DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tsOsMKmZI-WqEACzk_o1h0I58-hEgHx__r5hwvmGc2c_1756373001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2025 at 06:59:26AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 28 August 2025 12:04 PM
> > 
> > On Thu, Aug 28, 2025 at 06:23:02AM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 27 August 2025 04:19 PM
> > > >
> > > > On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > > > > > If it does not, and a user pull out the working device,
> > > > > > > > > how does your patch help?
> > > > > > > > >
> > > > > > > > A driver must tell that it will not follow broken ancient
> > > > > > > > behaviour and at that
> > > > > > > point device would stop its ancient backward compatibility mode.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > I don't know what is "ancient backward compatibility mode".
> > > > > > >
> > > > > > Let me explain.
> > > > > > Sadly, CSPs virtio pci device implementation is done such a way
> > > > > > that, it
> > > > works with ancient Linux kernel which does not have commit
> > > > 43bb40c5b9265.
> > > > >
> > > > >
> > > > > OK we are getting new information here.
> > > > >
> > > > > So let me summarize. There's a virtual system that pretends, to
> > > > > the guest, that device was removed by surprise removal, but
> > > > > actually device is there and is still doing DMA.
> > > > > Is that a fair summary?
> > > >
> > > Yes.
> > >
> > > > If that is the case, the thing to do would be to try and detect the
> > > > fake removal and then work with device as usual - device not doing
> > > > DMA after removal is pretty fundamental, after all.
> > > >
> > > The issue is: one can build the device to stop the DMA.
> > > There is no predictable combination for the driver and device that can work
> > for the user.
> > > For example,
> > > Device that stops the dma will not work before the commit 43bb40c5b9265.
> > > Device that continues the dma will not work with whatever new
> > implementation done in future kernels.
> > >
> > > Hence the capability negotiation would be needed so that device can stop the
> > DMA, config interrupts etc.
> > 
> > So this is a broken implementation at the pci level. We really can't fix removal
> > for this device at all, except by fixing the device. 
> The device to be told how to behave with/without commit 43bb40c5b9265.
> Not sure what you mean by 'fix the device'.
> 
> Users are running stable kernel that has commit 43bb40c5b9265 and its broken setup for them.
> 
> > Whatever works, works by
> > chance.  Feature negotiation in spec is not the way to fix that, but some work
> > arounds in the driver to skip the device are acceptable, mostly to not bother
> > with it.
> >
> Why not?
> It sounds like we need feature bit like VERSION_1 or ORDER_PLATFORM.


Because the device is out of spec (PCI spec which virtio references).

Besides the bug is not in the device, it's in the pci emulation.


> To _fix_ a stable kernel, if you have a suggestion, please suggest.
> 
> > Pls document exactly how this pci looks. Does it have an id we can use to detect
> > it?
> >
> CSPs have different device and vendor id for vnet, blk vfs.
> Is that what you mean by id?

vendor id is one way, yes. maybe a revision check, too.

> > > > For example, how about reading device control+status?
> > > >
> > > Most platforms read 0xffff on non-existing device, but not sure if this the
> > standard or well defined.
> > 
> > IIRC it's in the pci spec as a note.
> > 
> Checking.
> 
> > > > If we get all ones device has been removed If we get 0 in bus
> > > > master: device has been removed but re-inserted Anything else is a
> > > > fake removal
> > > >
> > > Bus master check may pass, right returning all 1s, even if the device is
> > removed, isn't it?
> > 
> > 
> > So we check all ones 1st, only check bus master if not all ones?
> >
> Pci subsystem typically checks the vendor and device ids, and if its not all 1s, its safe enough check.
> 
> How about a fix something like this:
> 
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -746,12 +746,16 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  {
>         struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>         struct device *dev = get_device(&vp_dev->vdev.dev);
> +       u32 v;
> 
>         /*
>          * Device is marked broken on surprise removal so that virtio upper
>          * layers can abort any ongoing operation.
> +        * Make sure that device is truly removed by directly interacting
> +        * with the device (and not just depend on the slot registers).
>          */
> -       if (!pci_device_is_present(pci_dev))
> +       if (!pci_device_is_present(pci_dev) &&
> +           !pci_bus_read_dev_vendor_id(pci_dev->bus, pci_dev->devfn, &v, 0))
>                 virtio_break_device(&vp_dev->vdev);
> 
> So if the device is still there, it let it go through its usual cleanup flow.
> And post this fix, a proper implementation with callback etc that you described can be implemented.


I don't have a big problem with this, but I don't understand the
scenario now again. report_error_detected relies on dev->error_state and
bus read. error_state is set on AER reporting an error. This is
not what you described.

Does the patch actually solve the problem for you?

Also can we limit this to a specific vendor id, or something like that?


I also still like the idea of reading dev control and status, since
it always bothered me that there's a theoretical chance that device
is re-inserted and bus read will succeed. Or maybe I'm imagining it.


-- 
MST

