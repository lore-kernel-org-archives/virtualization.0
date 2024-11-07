Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A21CF7BB
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014767; cv=none; b=ErcdKYYU68m8L23q2Z6BeZFcMKTX2LZmbMihsMTQmBVPCdWHU4hqLMpjBntg8j1FXwez82SucjfU6zwhTsBxNwQUbpdSyoUWIoDtHXOtR4aMrj4uMrlV27UayNJvL6mU4XZSyDfwwTtSFS4H70gpQEj/aCZM2gYlEWOm8RD4ahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014767; c=relaxed/simple;
	bh=7mNr472skOMI05DZeL7/dwZKVuuOev3mLuFJV5f60Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5kdLSGpZP7eAuxYAZZzXiQHI1TL3yeYRNC9wQOhMeGJUwh4POzNO+tbYQDX4VySaYc58thhoCmSEXHLSPbJLeyNGfkphmbi6EClkHZizx5IbQJuCmamqulP2QePSE07bXux/7daXxygdcsZ1Gti+j3UjX7ZZvHSxSF9N9WSIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=As+LWmPw; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="As+LWmPw"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6556543116
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 21:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.69
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAHYix4sxt9L for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Nov 2024 21:26:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CFE5D43038
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFE5D43038
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=As+LWmPw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CFE5D43038
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 21:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731014759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmsOWfwsziCzZJBNX81X+q9iuqLz9aGWKvYC2tUlck4=;
	b=As+LWmPw3KRM7b1Ov4WqKpGQH8Qnj0/67Z6kjV4YUS2YEwl107fNjHs3KjZLP7Pm6nVTCg
	Wu+vGOaa3cR3z5pW9FK+grbIDrnODSuk9HTOsJphqUclSz+xIkJQ2xJmolVRZZiKHQxDGd
	EqNVvtkCl87y/zubOul5WyZLHNarcWs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-EIHLHmfvNwqSLUMaeQFMHA-1; Thu, 07 Nov 2024 16:25:58 -0500
X-MC-Unique: EIHLHmfvNwqSLUMaeQFMHA-1
X-Mimecast-MFC-AGG-ID: EIHLHmfvNwqSLUMaeQFMHA
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab67710b5so30013139f.3
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Nov 2024 13:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014758; x=1731619558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrUNH9vtPlvjlTDQFOqG7/QZPSEZTHrrvLFCVTsPcHI=;
        b=h5szJL4FscYdlR76+nbtwvsdKO3LH1RTqLoxFRQHMmDcIfkj1xh5i3X3QMBf7iKugS
         KrI4KB/P4X2Hy3668z1hxC4jGfaUJtIRaI1ByXZnBdipp6N9nYBVtR48OaNjcDd6Guy6
         7UoWRaE+j8J14HMeRAIUxASHgOt5p1bnd0x7Z7oEPjHNG8VdEVIgosA9ptY8m3ursFDi
         ssZ4XlvGcNU347YyL/IUpUv2dF2uJZ5QYhT95G03KsRL0RxG7mSVGBioFVUaba1MFXim
         RnesOQIyGtO/p5AsMJKRJPqUrcjB6oDC1nJzDrBTFS48adfBi/9+MYx7aKSinP/w80aq
         zDkg==
X-Forwarded-Encrypted: i=1; AJvYcCU8DU51AzxL2JP0leXBwdHXJnOmPavfr2OGDO4E/YZ14ioF79LLuvwFkHF3MfjGSzMt1n6ibOP93/UoPGoltw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyREGjl8enRr2WSNxmZJnHHpojz3CN5eevE4hGU10G5ICnhGkQ8
	4x4DhG736sUgecpKzj73D58fZ5ERdGDZUy2XiXnV8B0yi0kYfqur7FKeBVuDsHGUsiUCP0w793C
	bcKXuirGIVfwdNuqRzNfHm4LKZBnPSEYClV36dcvGhp379bZ90ryGyqrrKZz+Emwnhx2lP4GqAn
	ljdeo=
X-Received: by 2002:a05:6602:1550:b0:83a:92e5:7eeb with SMTP id ca18e2360f4ac-83e03082657mr15267639f.0.1731014757793;
        Thu, 07 Nov 2024 13:25:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp7eXeRbz62660yxPzQ0ijKk6KzJLsBL0eubgfdPA83fTKv0fV4hT1Cus63N4TbXPmff2OIQ==
X-Received: by 2002:a05:6602:1550:b0:83a:92e5:7eeb with SMTP id ca18e2360f4ac-83e03082657mr15266239f.0.1731014757262;
        Thu, 07 Nov 2024 13:25:57 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f8e2acesm477481173.113.2024.11.07.13.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:25:56 -0800 (PST)
Date: Thu, 7 Nov 2024 14:25:54 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <kvm@vger.kernel.org>,
 <virtualization@lists.linux-foundation.org>, <parav@nvidia.com>,
 <feliu@nvidia.com>, <kevin.tian@intel.com>, <joao.m.martins@oracle.com>,
 <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 vfio 7/7] vfio/virtio: Enable live migration once
 VIRTIO_PCI was configured
Message-ID: <20241107142554.1c38f347.alex.williamson@redhat.com>
In-Reply-To: <af8886fd-ec75-45fa-b627-2cd3c2ce905c@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-8-yishaih@nvidia.com>
	<20241105162904.34b2114d.alex.williamson@redhat.com>
	<20241106135909.GO458827@nvidia.com>
	<20241106152732.16ac48d3.alex.williamson@redhat.com>
	<af8886fd-ec75-45fa-b627-2cd3c2ce905c@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fGNkebEaxP7tMINHtlXgritGzgYTozuNlq9E5h9Vei0_1731014758
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 14:57:39 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 07/11/2024 0:27, Alex Williamson wrote:
> > On Wed, 6 Nov 2024 09:59:09 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  =20
> >> On Tue, Nov 05, 2024 at 04:29:04PM -0700, Alex Williamson wrote: =20
> >>>> @@ -1,7 +1,7 @@
> >>>>   # SPDX-License-Identifier: GPL-2.0-only
> >>>>   config VIRTIO_VFIO_PCI
> >>>>           tristate "VFIO support for VIRTIO NET PCI devices"
> >>>> -        depends on VIRTIO_PCI && VIRTIO_PCI_ADMIN_LEGACY
> >>>> +        depends on VIRTIO_PCI
> >>>>           select VFIO_PCI_CORE
> >>>>           help
> >>>>             This provides support for exposing VIRTIO NET VF devices=
 which support
> >>>> @@ -11,5 +11,7 @@ config VIRTIO_VFIO_PCI
> >>>>             As of that this driver emulates I/O BAR in software to l=
et a VF be
> >>>>             seen as a transitional device by its users and let it wo=
rk with
> >>>>             a legacy driver.
> >>>> +          In addition, it provides migration support for VIRTIO NET=
 VF devices
> >>>> +          using the VFIO framework. =20
> >>>
> >>> The first half of this now describes something that may or may not be
> >>> enabled by this config option and the additional help text for
> >>> migration is vague enough relative to PF requirements to get user
> >>> reports that the driver doesn't work as intended. =20
> >>
> >> Yes, I think the help should be clearer
> >> =20
> >>> For the former, maybe we still want a separate config item that's
> >>> optionally enabled if VIRTIO_VFIO_PCI && VFIO_PCI_ADMIN_LEGACY. =20
> >>
> >> If we are going to add a bunch of  #ifdefs/etc for ADMIN_LEGACY we
> >> may as well just use VIRTIO_PCI_ADMIN_LEGACY directly and not
> >> introduce another kconfig for it? =20
> >=20
> > I think that's what Yishai is proposing, but as we're adding a whole
> > new feature to the driver I'm concerned how the person configuring the
> > kernel knows which features from the description might be available in
> > the resulting driver.
> >=20
> > We could maybe solve that with a completely re-written help text that
> > describes the legacy feature as X86-only and migration as a separate
> > architecture independent feature, but people aren't great at reading
> > and part of the audience is going to see "X86" in their peripheral
> > vision and disable it, and maybe even complain that the text was
> > presented to them.
> >=20
> > OR, we can just add an optional sub-config bool that makes it easier to
> > describe the (new) main feature of the driver as supporting live
> > migration (on supported hardware) and the sub-config option as
> > providing legacy support (on supported hardware), and that sub-config
> > is only presented on X86, ie. ADMIN_LEGACY.
> >=20
> > Ultimately the code already needs to support #ifdefs for the latter and
> > I think it's more user friendly and versatile to have the separate
> > config option.
> >=20
> > NB. The sub-config should be default on for upgrade compatibility.
> >  =20
> >> Is there any reason to compile out the migration support for virtio?
> >> No other drivers were doing this? =20
> >=20
> > No other vfio-pci variant driver provides multiple, independent
> > features, so for instance to compile out migration support from the
> > vfio-pci-mlx5 driver is to simply disable the driver altogether.
> >  =20
> >> kconfig combinations are painful, it woudl be nice to not make too
> >> many.. =20
> >=20
> > I'm not arguing for a legacy-only, non-migration version (please speak
> > up if someone wants that).  The code already needs to support the
> > #ifdefs and I think reflecting that in a sub-config option helps
> > clarify what the driver is providing and conveniently makes it possible
> > to have a driver with exactly the same feature set across archs, if
> > desired.  Thanks,
> >  =20
>=20
> Since the live migration functionality is not architecture-dependent=20
> (unlike legacy access, which requires X86) and is likely to be the=20
> primary use of the driver, I would suggest keeping it outside of any=20
> #ifdef directives, as initially introduced in V1.
>=20
> To address the description issue and provide control for customers who=20
> may need the legacy access functionality, we could introduce a bool=20
> configuration option as a submenu under the driver=E2=80=99s main live mi=
gration=20
> feature.
>=20
> This approach will keep things simple and align with the typical use=20
> case of the driver.
>=20
> Something like the below [1] can do the job for that.
>=20
> Alex,
> Can that work for you ?
>=20
> By the way, you have suggested calling the config entry=20
> VFIO_PCI_ADMIN_LEGACY, don't we need to add here also the VIRTIO as a=20
> prefix ? (i.e. VIRTIO_VFIO_PCI_ADMIN_LEGACY)

I think that was just a typo referring to VIRTIO_PCI_ADMIN_LEGACY.
Yes, appending _ADMIN_LEGACY to the main config option is fine.

> [1]
> # SPDX-License-Identifier: GPL-2.0-only
>=20
> config VIRTIO_VFIO_PCI
>          tristate "VFIO support for live migration over VIRTIO NET PCI
>                    devices"

Looking at other variant drivers, I think this should just be:

=09"VFIO support for VIRTIO NET PCI VF devices"

>          depends on VIRTIO_PCI
>          select VFIO_PCI_CORE
>          select IOMMUFD_DRIVER

IIUC, this is not a dependency, the device will just lack dirty page
tracking with either the type1 backend or when using iommufd when the
IOMMU hardware doesn't have dirty page tracking, therefore all VM
memory is perpetually dirty.  Do I have that right?

>          help
>            This provides migration support for VIRTIO NET PCI VF devices
>            using the VFIO framework.

This is still too open ended for me, there is specific PF support
required in the device to make this work.  Maybe...

=09This provides migration support for VIRTIO NET PCI VF devices
=09using the VFIO framework.  Migration support requires the
=09SR-IOV PF device to support specific VIRTIO extensions,
=09otherwise this driver provides no additional functionality
=09beyond vfio-pci.

=09Migration support in this driver relies on dirty page tracking
=09provided by the IOMMU hardware and exposed through IOMMUFD, any
=09other use cases are dis-recommended.

>            If you don't know what to do here, say N.
>=20
> config VFIO_PCI_ADMIN_LEGACY

VIRTIO_VFIO_PCI_ADMIN_LEGACY

>          bool "VFIO support for legacy I/O access for VIRTIO NET PCI
>                devices"

Maybe:

=09"Legacy I/O support for VIRTIO NET PCI VF devices"

>          depends on VIRTIO_VFIO_PCI && VIRTIO_PCI_ADMIN_LEGACY
>          default y
>          help
>            This provides support for exposing VIRTIO NET VF devices which
>            support legacy IO access, using the VFIO framework that can
>            work with a legacy virtio driver in the guest.
>            Based on PCIe spec, VFs do not support I/O Space.
>            As of that this driver emulates I/O BAR in software to let a
>            VF be seen as a transitional device by its users and let it
>            work with a legacy driver.

Maybe:

=09This extends the virtio-vfio-pci driver to support legacy I/O
=09access, allowing use of legacy virtio drivers with VIRTIO NET
=09PCI VF devices.  Legacy I/O support requires the SR-IOV PF
=09device to support and enable specific VIRTIO extensions,
=09otherwise this driver provides no additional functionality
=09beyond vfio-pci.

IMO, noting the PF requirement in each is important (feel free to
elaborate on specific VIRTIO extension requirements).  It doesn't seem
necessary to explain how the legacy compatibility works, only that this
driver makes the VF compatible with the legacy driver.

Are both of these options configurable at the PF in either firmware or
software?  I used "support and enable" in the legacy section assuming
that there is such a knob, but for migration it seems less necessary
that there's an enable step.  Please correct based on the actual
device behavior.  Thanks,

Alex

