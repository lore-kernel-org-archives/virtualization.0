Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E79CCDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 18:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54B2383065;
	Wed, 18 Oct 2023 18:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54B2383065
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IGcc1yJo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iqij30TrSz_2; Wed, 18 Oct 2023 18:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2525583083;
	Wed, 18 Oct 2023 18:29:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2525583083
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB77EC0071;
	Wed, 18 Oct 2023 18:29:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65FC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 18:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D8CF42202
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 18:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D8CF42202
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IGcc1yJo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFAyFMlJQld9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 18:29:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1D3142201
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 18:29:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1D3142201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697653776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7R6RTAkgPJ3A2Sl/SrJ6GMc2ikyq7O3Z+XFs2kp36A8=;
 b=IGcc1yJoXPULEBTMurcpQiVlb4sO5Zn2ULT61K6aFeBdIgOJdH5Vk8dDCs+6CjrU8LBg43
 pvw8mHsBNRSnJmxmLB/uv0+iB5d6Qf0xvhWjjfLx065FPkCeUK8QlSdqe1cw7GBf+OlCgy
 nRn8jvBDQdmoW8yej9+D/HAbvUh+eIQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-ik0yePtCPVqwiTUSrdXXGA-1; Wed, 18 Oct 2023 14:29:29 -0400
X-MC-Unique: ik0yePtCPVqwiTUSrdXXGA-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-780addd7382so588768139f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 11:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697653768; x=1698258568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7R6RTAkgPJ3A2Sl/SrJ6GMc2ikyq7O3Z+XFs2kp36A8=;
 b=dT14jei5ZXOdIMVufqKRNCbmwXgO1KY9YJSCa2rW6SBIw2fjNyE7R0UK6O0rlqjdaw
 5Ao5mc5wAlfEVNm8MmxJ8apHnujv+IgPeL3S8hrPsLNaWcUiSWc21DbiC6iCvff4wCFb
 ThblhAWKuq14XHVrIELtCv8cpdaglV05pLK9gfXRK/HERYDiXpzjX7L5igWOtOq5ZBs7
 kHJQkleuJrzeS0OLe6UlnNR3U9xkdVqBmSS8g5HQbIPuGGx/UAxufmij3pIXZMZD/JAx
 1CSWctiV5aojo17zwJD+0LatWq8hZmku7fAs2rB+q0P3LLB99NuMkIvmzplDIk7MXpLm
 3npw==
X-Gm-Message-State: AOJu0YxqQWh7W0wa4PhJ0Pn/spEg/ifpL4IS2tdzdqnRlTzpJYzCXfHG
 CERF15cqRlxV6cjWPtaW3W6skh6VSVrOYa/UhElku+oX7Bok1jl8xvnyNoxqvKWqbQt7yCi61QC
 qbjobHUmHTvj0ElErhUa8K1EGxMor5Jbk3hFWlYpgHQ==
X-Received: by 2002:a05:6602:2c90:b0:79f:e9ac:f60a with SMTP id
 i16-20020a0566022c9000b0079fe9acf60amr55509iow.20.1697653768612; 
 Wed, 18 Oct 2023 11:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZOgP35lJk8sk1selAnhrxsD5cVz/op+LUUohZIIuhrccEv2yoS+AMAHgBHkSLHcYMuVLrUw==
X-Received: by 2002:a05:6602:2c90:b0:79f:e9ac:f60a with SMTP id
 i16-20020a0566022c9000b0079fe9acf60amr55478iow.20.1697653768208; 
 Wed, 18 Oct 2023 11:29:28 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 i141-20020a6b3b93000000b007a667019071sm900347ioa.22.2023.10.18.11.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 11:29:27 -0700 (PDT)
Date: Wed, 18 Oct 2023 12:29:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231018122925.3fde9405.alex.williamson@redhat.com>
In-Reply-To: <20231018163333.GZ3952@nvidia.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231017142448.08673cdc.alex.williamson@redhat.com>
 <20231018163333.GZ3952@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 18 Oct 2023 13:33:33 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Oct 17, 2023 at 02:24:48PM -0600, Alex Williamson wrote:
> > On Tue, 17 Oct 2023 16:42:17 +0300
> > Yishai Hadas <yishaih@nvidia.com> wrote:  
> > > +static int virtiovf_pci_probe(struct pci_dev *pdev,
> > > +			      const struct pci_device_id *id)
> > > +{
> > > +	const struct vfio_device_ops *ops = &virtiovf_acc_vfio_pci_ops;
> > > +	struct virtiovf_pci_core_device *virtvdev;
> > > +	int ret;
> > > +
> > > +	if (pdev->is_virtfn && virtiovf_support_legacy_access(pdev) &&
> > > +	    !virtiovf_bar0_exists(pdev) && pdev->msix_cap)
> > > +		ops = &virtiovf_acc_vfio_pci_tran_ops;  
> > 
> > This is still an issue for me, it's a very narrow use case where we
> > have a modern device and want to enable legacy support.  Implementing an
> > IO BAR and mangling the device ID seems like it should be an opt-in,
> > not standard behavior for any compatible device.  Users should
> > generally expect that the device they see in the host is the device
> > they see in the guest.  They might even rely on that principle.  
> 
> I think this should be configured when the VF is provisioned. If the
> user does not want legacy IO bar support then the VFIO VF function
> should not advertise the capability, and they won't get driver
> support.
> 
> I think that is a very reasonable way to approach this - it is how we
> approached similar problems for mlx5. The provisioning interface is
> what "profiles" the VF, regardless of if VFIO is driving it or not.

It seems like a huge assumption that every device is going to allow
this degree of specification in provisioning VFs.  mlx5 is a vendor
specific driver, it can make such assumptions in design philosophy.

> > We can't use the argument that users wanting the default device should
> > use vfio-pci rather than virtio-vfio-pci because we've already defined
> > the algorithm by which libvirt should choose a variant driver for a
> > device.  libvirt will choose this driver for all virtio-net devices.  
> 
> Well, we can if the use case is niche. I think profiling a virtio VF
> to support legacy IO bar emulation and then not wanting to use it is
> a niche case.
> 
> The same argument is going come with live migration. This same driver
> will still bind and enable live migration if the virtio function is
> profiled to support it. If you don't want that in your system then
> don't profile the VF for migration support.

What in the virtio or SR-IOV spec requires a vendor to make this
configurable?

> > This driver effectively has the option to expose two different profiles
> > for the device, native or transitional.  We've discussed profile
> > support for variant drivers previously as an equivalent functionality
> > to mdev types, but the only use case for this currently is out-of-tree.
> > I think this might be the opportunity to define how device profiles are
> > exposed and selected in a variant driver.  
> 
> Honestly, I've been trying to keep this out of VFIO...
> 
> The function is profiled when it is created, by whatever created
> it. As in the other thread we have a vast amount of variation in what
> is required to provision the function in the first place. "Legacy IO
> BAR emulation support" is just one thing. virtio-net needs to be
> hooked up to real network and get a MAC, virtio-blk needs to be hooked
> up to real storage and get a media. At a minimum. This is big and
> complicated.
> 
> It may not even be the x86 running VFIO that is doing this
> provisioning, the PCI function may come pre-provisioned from a DPU.
> 
> It feels better to keep that all in one place, in whatever external
> thing is preparing the function before giving it to VFIO. VFIO is
> concerned with operating a prepared function.
> 
> When we get to SIOV it should not be VFIO that is
> provisioning/creating functions. The owning driver should be doing
> this and routing the function to VFIO (eg with an aux device or
> otherwise)
> 
> This gets back to the qemu thread on the grace patch where we need to
> ask how does the libvirt world see this, given there is no good way to
> generically handle all scenarios without a userspace driver to operate
> elements.

So nothing here is really "all in one place", it may be in the
provisioning of the VF, outside of the scope of the host OS, it might
be a collection of scripts or operators with device or interface
specific tooling to configure the device.  Sometimes this configuration
will be before the device is probed by the vfio-pci variant driver,
sometimes in between probing and opening the device.

I don't see why it becomes out of scope if the variant driver itself
provides some means for selecting a device profile.  We have evidence
both from mdev vGPUs and here (imo) that we can expect to see that
behavior, so why wouldn't we want to attempt some basic shared
interface for variant drivers to implement for selecting such a profile
rather than add to this hodgepodge 

> > Jason had previously suggested a devlink interface for this, but I
> > understand that path had been shot down by devlink developers.    
> 
> I think we go some things support but supporting all things was shot
> down.
> 
> > Another obvious option is sysfs, where we might imagine an optional
> > "profiles" directory, perhaps under vfio-dev.  Attributes of
> > "available" and "current" could allow discovery and selection of a
> > profile similar to mdev types.  
> 
> IMHO it is a far too complex problem for sysfs.

Isn't it then just like devlink, not a silver bullet, but useful for
some configuration?  AIUI, devlink shot down a means to list available
profiles for a device and a means to select one of those profiles.
There are a variety of attributes in sysfs which perform this sort of
behavior.  Specifying a specific profile in sysfs can be difficult, and
I'm not proposing sysfs profile support as a mandatory feature, but I'm
also not a fan of the vendor specific sysfs approach that out of tree
drivers have taken.

The mdev type interface is certainly not perfect, but from it we've
been able to develop mdevctl to allow persistent and complex
configurations of mdev devices.  I'd like to see the ability to do
something like that with variant drivers that offer multiple profiles
without always depending on vendor specific interfaces.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
