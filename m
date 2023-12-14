Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A0D274
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8rvy7Vt"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A443040540
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 06:38:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A443040540
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D8rvy7Vt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WFzrvFn-Vz4V
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 06:38:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE9E44047D
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 06:38:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE9E44047D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702535936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CStFjsje2guvaYKG3OMp/CQkO/Z19E4xLoQuKFDnmtM=;
	b=D8rvy7VtGTUbeuHrBPR8lMvhToaMJAZmpzkKcDaDwdT20o24z6y19U0RXgpNDd+ZXbmfsO
	cKCwefktY3+wyPgYkQYH6cXQcBX1tmF75bYmMkg93uC53RrhBlMzSfafN5jH8ZXK59tXxX
	VoKdb4rdcdR5TvaOIOTEXBNJtCbpYVg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-OzneMgxxP8qSqNogdBKCHg-1; Thu, 14 Dec 2023 01:38:54 -0500
X-MC-Unique: OzneMgxxP8qSqNogdBKCHg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33608afc552so5850993f8f.2
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 22:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535933; x=1703140733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CStFjsje2guvaYKG3OMp/CQkO/Z19E4xLoQuKFDnmtM=;
        b=IVmHXijvrLShW5Us7AfPvHw1txLlQNjoUy/FLQZH4WrQgNxY1L80wO+csNzltG+2yR
         9GmVqq8WqZDHN3SPFsA0nqelRgA7jaIVKdbIZf/yipkZtZ2RjDMvX5uqj6/mKi5yVsjI
         Ba2NIuT591fDvvu1t7HeT+wyoMdRv9xnIg3jwSdEyAA8HHCyDfN84dWMVfDzPHpTx9oj
         H0dyCC4FpOtOSs2Y3k8oS+aIlkmzcjFfdlAoqvOWxbrkuArrkGPY08j+bmDklG73PUeS
         0DqnIpsJPon6gC4RLDSJIc77F+lNGuc7D/9eB0eORBhtYPHc8/KEq8KOrBdh1PB/GUvu
         ICpg==
X-Gm-Message-State: AOJu0Yw3LcJkLLiPXB0ITWhAMc8hCVd5KHLyoHUDUCBwSwUyNQ1E0Qtx
	e1TBNjVMRRJ9Yx0SbXNfEcWAgSmnpvmaIc26wVbTEirkDTxrEhfj2QXLAj7+N236uxCKdScSYe9
	r1V9huF6WfBp0W3KyTXbg5bQe38sC4ZEwP/wn0NErsw==
X-Received: by 2002:a05:600c:358c:b0:408:37d4:b5ba with SMTP id p12-20020a05600c358c00b0040837d4b5bamr3984314wmq.12.1702535933636;
        Wed, 13 Dec 2023 22:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqpUZZPugAckon48anwdvP475bOlG0WqJqvBm/iyVY7c0+ENzMrUOmafn3ZDwWrobosExGDw==
X-Received: by 2002:a05:600c:358c:b0:408:37d4:b5ba with SMTP id p12-20020a05600c358c00b0040837d4b5bamr3984304wmq.12.1702535933297;
        Wed, 13 Dec 2023 22:38:53 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id vx4-20020a170907a78400b00a0a2553ec99sm8883448ejc.65.2023.12.13.22.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:38:52 -0800 (PST)
Date: Thu, 14 Dec 2023 01:38:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: alex.williamson@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	parav@nvidia.com, feliu@nvidia.com, jiri@nvidia.com,
	kevin.tian@intel.com, joao.m.martins@oracle.com,
	si-wei.liu@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V7 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231214013642-mutt-send-email-mst@kernel.org>
References: <20231207102820.74820-1-yishaih@nvidia.com>
 <20231207102820.74820-10-yishaih@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231207102820.74820-10-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 12:28:20PM +0200, Yishai Hadas wrote:
> Introduce a vfio driver over virtio devices to support the legacy
> interface functionality for VFs.
> 
> Background, from the virtio spec [1].
> --------------------------------------------------------------------
> In some systems, there is a need to support a virtio legacy driver with
> a device that does not directly support the legacy interface. In such
> scenarios, a group owner device can provide the legacy interface
> functionality for the group member devices. The driver of the owner
> device can then access the legacy interface of a member device on behalf
> of the legacy member device driver.
> 
> For example, with the SR-IOV group type, group members (VFs) can not
> present the legacy interface in an I/O BAR in BAR0 as expected by the
> legacy pci driver. If the legacy driver is running inside a virtual
> machine, the hypervisor executing the virtual machine can present a
> virtual device with an I/O BAR in BAR0. The hypervisor intercepts the
> legacy driver accesses to this I/O BAR and forwards them to the group
> owner device (PF) using group administration commands.
> --------------------------------------------------------------------
> 
> Specifically, this driver adds support for a virtio-net VF to be exposed
> as a transitional device to a guest driver and allows the legacy IO BAR
> functionality on top.
> 
> This allows a VM which uses a legacy virtio-net driver in the guest to
> work transparently over a VF which its driver in the host is that new
> driver.
> 
> The driver can be extended easily to support some other types of virtio
> devices (e.g virtio-blk), by adding in a few places the specific type
> properties as was done for virtio-net.
> 
> For now, only the virtio-net use case was tested and as such we introduce
> the support only for such a device.
> 
> Practically,
> Upon probing a VF for a virtio-net device, in case its PF supports
> legacy access over the virtio admin commands and the VF doesn't have BAR
> 0, we set some specific 'vfio_device_ops' to be able to simulate in SW a
> transitional device with I/O BAR in BAR 0.
> 
> The existence of the simulated I/O bar is reported later on by
> overwriting the VFIO_DEVICE_GET_REGION_INFO command and the device
> exposes itself as a transitional device by overwriting some properties
> upon reading its config space.
> 
> Once we report the existence of I/O BAR as BAR 0 a legacy driver in the
> guest may use it via read/write calls according to the virtio
> specification.
> 
> Any read/write towards the control parts of the BAR will be captured by
> the new driver and will be translated into admin commands towards the
> device.
> 
> Any data path read/write access (i.e. virtio driver notifications) will
> be forwarded to the physical BAR which its properties were supplied by
> the admin command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO upon the
> probing/init flow.
> 
> With that code in place a legacy driver in the guest has the look and
> feel as if having a transitional device with legacy support for both its
> control and data path flows.
> 
> [1]
> https://github.com/oasis-tcs/virtio-spec/commit/03c2d32e5093ca9f2a17797242fbef88efe94b8c
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  MAINTAINERS                      |   7 +
>  drivers/vfio/pci/Kconfig         |   2 +
>  drivers/vfio/pci/Makefile        |   2 +
>  drivers/vfio/pci/virtio/Kconfig  |  16 +
>  drivers/vfio/pci/virtio/Makefile |   4 +
>  drivers/vfio/pci/virtio/main.c   | 567 +++++++++++++++++++++++++++++++
>  6 files changed, 598 insertions(+)
>  create mode 100644 drivers/vfio/pci/virtio/Kconfig
>  create mode 100644 drivers/vfio/pci/virtio/Makefile
>  create mode 100644 drivers/vfio/pci/virtio/main.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 012df8ccf34e..b246b769092d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22872,6 +22872,13 @@ L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/pci/mlx5/
>  
> +VFIO VIRTIO PCI DRIVER
> +M:	Yishai Hadas <yishaih@nvidia.com>
> +L:	kvm@vger.kernel.org
> +L:	virtualization@lists.linux-foundation.org
> +S:	Maintained
> +F:	drivers/vfio/pci/virtio
> +
>  VFIO PCI DEVICE SPECIFIC DRIVERS
>  R:	Jason Gunthorpe <jgg@nvidia.com>
>  R:	Yishai Hadas <yishaih@nvidia.com>
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 8125e5f37832..18c397df566d 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -65,4 +65,6 @@ source "drivers/vfio/pci/hisilicon/Kconfig"
>  
>  source "drivers/vfio/pci/pds/Kconfig"
>  
> +source "drivers/vfio/pci/virtio/Kconfig"
> +
>  endmenu
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 45167be462d8..046139a4eca5 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -13,3 +13,5 @@ obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
>  obj-$(CONFIG_HISI_ACC_VFIO_PCI) += hisilicon/
>  
>  obj-$(CONFIG_PDS_VFIO_PCI) += pds/
> +
> +obj-$(CONFIG_VIRTIO_VFIO_PCI) += virtio/
> diff --git a/drivers/vfio/pci/virtio/Kconfig b/drivers/vfio/pci/virtio/Kconfig
> new file mode 100644
> index 000000000000..3a6707639220
> --- /dev/null
> +++ b/drivers/vfio/pci/virtio/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VIRTIO_VFIO_PCI
> +        tristate "VFIO support for VIRTIO NET PCI devices"
> +        depends on VIRTIO_PCI
> +        select VFIO_PCI_CORE
> +        help
> +          This provides support for exposing VIRTIO NET VF devices which support
> +          legacy IO access, using the VFIO framework that can work with a legacy
> +          virtio driver in the guest.
> +          Based on PCIe spec, VFs do not support I/O Space; thus, VF BARs shall
> +          not indicate I/O Space.
> +          As of that this driver emulated I/O BAR in software to let a VF be
> +          seen as a transitional device in the guest and let it work with
> +          a legacy driver.
> +
> +          If you don't know what to do here, say N.

BTW shouldn't this driver be limited to X86? Things like lack of memory
barriers will make legacy virtio racy on e.g. ARM will they not?
And endian-ness will be broken on PPC ...

-- 
MST

