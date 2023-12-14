Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE95B1E4
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igJrMp+M"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30BF94202D
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 15:06:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30BF94202D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=igJrMp+M
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rj73hGBYVVak
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 15:06:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B963742029
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 15:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B963742029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702566381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/fnZVD/TpczYzAgpPRnWa80wduq8gU6m4PRxtm2obs=;
	b=igJrMp+MnReIbalz140/83Kl0e7rrqUpuo0hhmbUoSfPUPih4i1av9g4E/iIEZnbmfHCdg
	7IJwT4iHmaL/Zyw7ckvOSSNOhdKv3S0f1JUpl3PzUvZX7Bq0QJabi0y6Vayv838iTZiod8
	bSBOC7Ez5c/RIrUqngt6uWAgNgkuCDU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-dHs-3RCaMESmTeiSkaWpWg-1; Thu, 14 Dec 2023 10:06:19 -0500
X-MC-Unique: dHs-3RCaMESmTeiSkaWpWg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a19c5cbbe86so480631666b.1
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 07:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566378; x=1703171178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/fnZVD/TpczYzAgpPRnWa80wduq8gU6m4PRxtm2obs=;
        b=BS3UOw+/F7e1v9IWfwiZqBRbtue1EntXUuK5eAzC52lZB62o1GSw1Q7LVvApF8HzNG
         eo+KNHQBK7IUSG47teGpRfKb3X6e5ObRnjXN2ITggYvPkQYBFs93plaov4uWwRFhiy5a
         uXaUjIijQ21kbkIFb6qPC6kl2mkvGICpMgEMTvspku+KdMyL03k/0Du5MXXMHIk1GxCu
         8YlwJdzEgw+UEyb2d9BwVjzBjjF7MnB+NKxt7CYX5/9zF1ncthMKy6PHH9cYyVMnnQ/E
         4BbQYZm2YmbOEM7gadhO7gHBkz2KopemAFz1d0gAlIPI+jBOOm0wy6DKdk6tSJ/4MLuL
         KhWQ==
X-Gm-Message-State: AOJu0YzxrB9y9+Y/7qKCsk93i4y8/1d6flM/Nk7Cni0XFU9lcjn5cKM8
	45WGwDuPg0WItm9fYFcJehEhxV3ZriTLsZdLhebyUIz9j02LfvhkY9D53whPuKGW5QvE2AKbqoO
	/iu9/6j9L0k2mJIicfnebvtgbazsSUkAwDvdqkdwzew==
X-Received: by 2002:a17:907:86a8:b0:a1b:75f6:daf2 with SMTP id qa40-20020a17090786a800b00a1b75f6daf2mr4536187ejc.97.1702566378560;
        Thu, 14 Dec 2023 07:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBb5MhD+T4i8/uTSf2eMBA+0nXKZ7Rl7ZbRUT8iK35ieCUfNsptfQLtrgLJvwvX5SKbPE8AA==
X-Received: by 2002:a17:907:86a8:b0:a1b:75f6:daf2 with SMTP id qa40-20020a17090786a800b00a1b75f6daf2mr4536171ejc.97.1702566378071;
        Thu, 14 Dec 2023 07:06:18 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a1d06fb6800sm9368867ejc.36.2023.12.14.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:06:15 -0800 (PST)
Date: Thu, 14 Dec 2023 10:05:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, jasowang@redhat.com, jgg@nvidia.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	parav@nvidia.com, feliu@nvidia.com, jiri@nvidia.com,
	kevin.tian@intel.com, joao.m.martins@oracle.com,
	si-wei.liu@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V7 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231214100403-mutt-send-email-mst@kernel.org>
References: <20231207102820.74820-1-yishaih@nvidia.com>
 <20231207102820.74820-10-yishaih@nvidia.com>
 <20231214013642-mutt-send-email-mst@kernel.org>
 <ea0cdfc9-35f4-4cc1-b0de-aaef0bebeb51@nvidia.com>
 <20231214041515-mutt-send-email-mst@kernel.org>
 <37bcb2f0-a83d-4806-809c-ec5d004ddb20@nvidia.com>
 <20231214075905.59a4a3ba.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231214075905.59a4a3ba.alex.williamson@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2023 at 07:59:05AM -0700, Alex Williamson wrote:
> On Thu, 14 Dec 2023 11:37:10 +0200
> Yishai Hadas <yishaih@nvidia.com> wrote:
> 
> > On 14/12/2023 11:19, Michael S. Tsirkin wrote:
> > > On Thu, Dec 14, 2023 at 11:03:49AM +0200, Yishai Hadas wrote:  
> > >> On 14/12/2023 8:38, Michael S. Tsirkin wrote:  
> > >>> On Thu, Dec 07, 2023 at 12:28:20PM +0200, Yishai Hadas wrote:  
> > >>>> Introduce a vfio driver over virtio devices to support the legacy
> > >>>> interface functionality for VFs.
> > >>>>
> > >>>> Background, from the virtio spec [1].
> > >>>> --------------------------------------------------------------------
> > >>>> In some systems, there is a need to support a virtio legacy driver with
> > >>>> a device that does not directly support the legacy interface. In such
> > >>>> scenarios, a group owner device can provide the legacy interface
> > >>>> functionality for the group member devices. The driver of the owner
> > >>>> device can then access the legacy interface of a member device on behalf
> > >>>> of the legacy member device driver.
> > >>>>
> > >>>> For example, with the SR-IOV group type, group members (VFs) can not
> > >>>> present the legacy interface in an I/O BAR in BAR0 as expected by the
> > >>>> legacy pci driver. If the legacy driver is running inside a virtual
> > >>>> machine, the hypervisor executing the virtual machine can present a
> > >>>> virtual device with an I/O BAR in BAR0. The hypervisor intercepts the
> > >>>> legacy driver accesses to this I/O BAR and forwards them to the group
> > >>>> owner device (PF) using group administration commands.
> > >>>> --------------------------------------------------------------------
> > >>>>
> > >>>> Specifically, this driver adds support for a virtio-net VF to be exposed
> > >>>> as a transitional device to a guest driver and allows the legacy IO BAR
> > >>>> functionality on top.
> > >>>>
> > >>>> This allows a VM which uses a legacy virtio-net driver in the guest to
> > >>>> work transparently over a VF which its driver in the host is that new
> > >>>> driver.
> > >>>>
> > >>>> The driver can be extended easily to support some other types of virtio
> > >>>> devices (e.g virtio-blk), by adding in a few places the specific type
> > >>>> properties as was done for virtio-net.
> > >>>>
> > >>>> For now, only the virtio-net use case was tested and as such we introduce
> > >>>> the support only for such a device.
> > >>>>
> > >>>> Practically,
> > >>>> Upon probing a VF for a virtio-net device, in case its PF supports
> > >>>> legacy access over the virtio admin commands and the VF doesn't have BAR
> > >>>> 0, we set some specific 'vfio_device_ops' to be able to simulate in SW a
> > >>>> transitional device with I/O BAR in BAR 0.
> > >>>>
> > >>>> The existence of the simulated I/O bar is reported later on by
> > >>>> overwriting the VFIO_DEVICE_GET_REGION_INFO command and the device
> > >>>> exposes itself as a transitional device by overwriting some properties
> > >>>> upon reading its config space.
> > >>>>
> > >>>> Once we report the existence of I/O BAR as BAR 0 a legacy driver in the
> > >>>> guest may use it via read/write calls according to the virtio
> > >>>> specification.
> > >>>>
> > >>>> Any read/write towards the control parts of the BAR will be captured by
> > >>>> the new driver and will be translated into admin commands towards the
> > >>>> device.
> > >>>>
> > >>>> Any data path read/write access (i.e. virtio driver notifications) will
> > >>>> be forwarded to the physical BAR which its properties were supplied by
> > >>>> the admin command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO upon the
> > >>>> probing/init flow.
> > >>>>
> > >>>> With that code in place a legacy driver in the guest has the look and
> > >>>> feel as if having a transitional device with legacy support for both its
> > >>>> control and data path flows.
> > >>>>
> > >>>> [1]
> > >>>> https://github.com/oasis-tcs/virtio-spec/commit/03c2d32e5093ca9f2a17797242fbef88efe94b8c
> > >>>>
> > >>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > >>>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > >>>> ---
> > >>>>    MAINTAINERS                      |   7 +
> > >>>>    drivers/vfio/pci/Kconfig         |   2 +
> > >>>>    drivers/vfio/pci/Makefile        |   2 +
> > >>>>    drivers/vfio/pci/virtio/Kconfig  |  16 +
> > >>>>    drivers/vfio/pci/virtio/Makefile |   4 +
> > >>>>    drivers/vfio/pci/virtio/main.c   | 567 +++++++++++++++++++++++++++++++
> > >>>>    6 files changed, 598 insertions(+)
> > >>>>    create mode 100644 drivers/vfio/pci/virtio/Kconfig
> > >>>>    create mode 100644 drivers/vfio/pci/virtio/Makefile
> > >>>>    create mode 100644 drivers/vfio/pci/virtio/main.c
> > >>>>
> > >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>>> index 012df8ccf34e..b246b769092d 100644
> > >>>> --- a/MAINTAINERS
> > >>>> +++ b/MAINTAINERS
> > >>>> @@ -22872,6 +22872,13 @@ L:	kvm@vger.kernel.org
> > >>>>    S:	Maintained
> > >>>>    F:	drivers/vfio/pci/mlx5/
> > >>>> +VFIO VIRTIO PCI DRIVER
> > >>>> +M:	Yishai Hadas <yishaih@nvidia.com>
> > >>>> +L:	kvm@vger.kernel.org
> > >>>> +L:	virtualization@lists.linux-foundation.org
> > >>>> +S:	Maintained
> > >>>> +F:	drivers/vfio/pci/virtio
> > >>>> +
> > >>>>    VFIO PCI DEVICE SPECIFIC DRIVERS
> > >>>>    R:	Jason Gunthorpe <jgg@nvidia.com>
> > >>>>    R:	Yishai Hadas <yishaih@nvidia.com>
> > >>>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > >>>> index 8125e5f37832..18c397df566d 100644
> > >>>> --- a/drivers/vfio/pci/Kconfig
> > >>>> +++ b/drivers/vfio/pci/Kconfig
> > >>>> @@ -65,4 +65,6 @@ source "drivers/vfio/pci/hisilicon/Kconfig"
> > >>>>    source "drivers/vfio/pci/pds/Kconfig"
> > >>>> +source "drivers/vfio/pci/virtio/Kconfig"
> > >>>> +
> > >>>>    endmenu
> > >>>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> > >>>> index 45167be462d8..046139a4eca5 100644
> > >>>> --- a/drivers/vfio/pci/Makefile
> > >>>> +++ b/drivers/vfio/pci/Makefile
> > >>>> @@ -13,3 +13,5 @@ obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
> > >>>>    obj-$(CONFIG_HISI_ACC_VFIO_PCI) += hisilicon/
> > >>>>    obj-$(CONFIG_PDS_VFIO_PCI) += pds/
> > >>>> +
> > >>>> +obj-$(CONFIG_VIRTIO_VFIO_PCI) += virtio/
> > >>>> diff --git a/drivers/vfio/pci/virtio/Kconfig b/drivers/vfio/pci/virtio/Kconfig
> > >>>> new file mode 100644
> > >>>> index 000000000000..3a6707639220
> > >>>> --- /dev/null
> > >>>> +++ b/drivers/vfio/pci/virtio/Kconfig
> > >>>> @@ -0,0 +1,16 @@
> > >>>> +# SPDX-License-Identifier: GPL-2.0-only
> > >>>> +config VIRTIO_VFIO_PCI
> > >>>> +        tristate "VFIO support for VIRTIO NET PCI devices"
> > >>>> +        depends on VIRTIO_PCI
> > >>>> +        select VFIO_PCI_CORE
> > >>>> +        help
> > >>>> +          This provides support for exposing VIRTIO NET VF devices which support
> > >>>> +          legacy IO access, using the VFIO framework that can work with a legacy
> > >>>> +          virtio driver in the guest.
> > >>>> +          Based on PCIe spec, VFs do not support I/O Space; thus, VF BARs shall
> > >>>> +          not indicate I/O Space.
> > >>>> +          As of that this driver emulated I/O BAR in software to let a VF be
> > >>>> +          seen as a transitional device in the guest and let it work with
> > >>>> +          a legacy driver.
> > >>>> +
> > >>>> +          If you don't know what to do here, say N.  
> > >>>
> > >>> BTW shouldn't this driver be limited to X86? Things like lack of memory
> > >>> barriers will make legacy virtio racy on e.g. ARM will they not?
> > >>> And endian-ness will be broken on PPC ...
> > >>>  
> > >>
> > >> OK, if so, we can come with the below extra code.
> > >> Makes sense ?
> > >>
> > >> I'll squash it as part of V8 to the relevant patch.
> > >>
> > >> diff --git a/drivers/virtio/virtio_pci_modern.c
> > >> b/drivers/virtio/virtio_pci_modern.c
> > >> index 37a0035f8381..b652e91b9df4 100644
> > >> --- a/drivers/virtio/virtio_pci_modern.c
> > >> +++ b/drivers/virtio/virtio_pci_modern.c
> > >> @@ -794,6 +794,9 @@ bool virtio_pci_admin_has_legacy_io(struct pci_dev
> > >> *pdev)
> > >>          struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> > >>          struct virtio_pci_device *vp_dev;
> > >>
> > >> +#ifndef CONFIG_X86
> > >> +       return false;
> > >> +#endif
> > >>          if (!virtio_dev)
> > >>                  return false;
> > >>
> > >> Yishai  
> > > 
> > > Isn't there going to be a bunch more dead code that compiler won't be
> > > able to elide?
> > >   
> > 
> > On my setup the compiler didn't complain about dead-code (I simulated it 
> > by using ifdef CONFIG_X86 return false).
> > 
> > However, if we suspect that some compiler might complain, we can come 
> > with the below instead.
> > 
> > Do you prefer that ?
> > 
> > index 37a0035f8381..53e29824d404 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -782,6 +782,7 @@ static void vp_modern_destroy_avq(struct 
> > virtio_device *vdev)
> >           BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ) | \
> >           BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO))
> > 
> > +#ifdef CONFIG_X86
> >   /*
> >    * virtio_pci_admin_has_legacy_io - Checks whether the legacy IO
> >    * commands are supported
> > @@ -807,6 +808,12 @@ bool virtio_pci_admin_has_legacy_io(struct pci_dev 
> > *pdev)
> >                  return true;
> >          return false;
> >   }
> > +#else
> > +bool virtio_pci_admin_has_legacy_io(struct pci_dev *pdev)
> > +{
> > +       return false;
> > +}
> > +#endif
> >   EXPORT_SYMBOL_GPL(virtio_pci_admin_has_legacy_io);
> 
> Doesn't this also raise the question of the purpose of virtio-vfio-pci
> on non-x86?  Without any other features it offers nothing over vfio-pci
> and we should likely adjust the Kconfig for x86 or COMPILE_TEST.
> Thanks,
> 
> Alex

Kconfig dependency is what I had in mind, yes. The X86 specific code in
virtio_pci_modern.c can be moved to a separate file then use makefile
tricks to skip it on other platforms.

-- 
MST

