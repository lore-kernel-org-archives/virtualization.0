Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24654C433FE
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 06:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AFAC04074E;
	Tue, 22 Nov 2022 06:35:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFAC04074E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZG4NDz+S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kyrVQoA7o7OV; Tue, 22 Nov 2022 06:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25B8440123;
	Tue, 22 Nov 2022 06:35:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25B8440123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1F4AC0033;
	Tue, 22 Nov 2022 06:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68CF7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F52E81F24
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:35:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F52E81F24
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZG4NDz+S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GNlrsmkrun78
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:35:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5749581F1D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5749581F1D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669098929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZM4Milkw2zAcnxczOyM+6GmizWf8KILpVjHb60djrcY=;
 b=ZG4NDz+SkxjWjN59USS8LeeoU/vq1yzBQ6XMn1/H4OVcbglH7G64JFdps59ALjw3MuhbeX
 6vRqtpqi9zFNNl5QnVHatmKOdXHdEPR7PdVt5bHi8k2ZlI9FTyG88zqfoITweqUEdxUOz9
 IdV60Vxq/0CUpD3mfkP6Elcgs6ghYag=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-189-dDSlwvR5M-ymOrNiitjEfQ-1; Tue, 22 Nov 2022 01:35:27 -0500
X-MC-Unique: dDSlwvR5M-ymOrNiitjEfQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 v10-20020a4a860a000000b00480b3e2b5afso6131413ooh.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 22:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZM4Milkw2zAcnxczOyM+6GmizWf8KILpVjHb60djrcY=;
 b=Dmj0HzUy8iE7heiINIuPlpxnzPVytUlOmPwSrekEEL48mesW0Z6skj7Zw6L6AR6jj3
 dgJ4xBUh2itsR+kfDkWF0OYkCxtZ098tsu+f2b9T8aStPi4fYzEiPd4Jj8+unVL4dAgq
 uy83XCu9/3xdl42BmsL4EVqqsi6u21gK0BIw/o6d+KeE93/fBp7QL1mq46NhEmodLeDE
 o/rWDaVZY4kbRc1Vtb3fgJ1kj14RNzgYOpF89Xo5gKD3HPT/KaFCcuMrnjnG1B0h23XR
 5ZMlq4uszYB3ABrOK1/O+tnSHcWSe4OEbWomhBaHuHSC73B3e1lji46ONMMSz6071Yut
 xQtw==
X-Gm-Message-State: ANoB5pmHRWwPGX/5IS81MigoHCZgp7ALbLuddlgF85cU+AnV5sjf9pYv
 NxZMV9a6mEeaPd9jOdjxe/sFMXuHaV8M5TZaOY25SuXiq+lkKpTvKUr2pSn5io7yMby2wsCwRPk
 Ashavx6aqTdSqmfnbN1sTeoS7IwMMjUIteydBx+4czRTSq8Y9TJHBvfulvw==
X-Received: by 2002:a05:6870:75c3:b0:142:f59e:e509 with SMTP id
 de3-20020a05687075c300b00142f59ee509mr3253192oab.280.1669098927223; 
 Mon, 21 Nov 2022 22:35:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6vSg7F+y2vJHrbB6OsZgWmO5m4FP8axc6WoQaZbYtPI7DfnvYv58geqUmrZr8Mjawq2/0avBZF87pMlvGQuGg=
X-Received: by 2002:a05:6870:75c3:b0:142:f59e:e509 with SMTP id
 de3-20020a05687075c300b00142f59ee509mr3253181oab.280.1669098927012; Mon, 21
 Nov 2022 22:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20221118225656.48309-1-snelson@pensando.io>
 <20221118225656.48309-20-snelson@pensando.io>
In-Reply-To: <20221118225656.48309-20-snelson@pensando.io>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Nov 2022 14:35:16 +0800
Message-ID: <CACGkMEsGnmMCPrLv=mRviOung4N0F8pvYaGsuKMCky58S3uq2g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 19/19] pds_vdpa: add Kconfig entry and
 pds_vdpa.rst
To: Shannon Nelson <snelson@pensando.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

On Sat, Nov 19, 2022 at 6:57 AM Shannon Nelson <snelson@pensando.io> wrote:
>
> Signed-off-by: Shannon Nelson <snelson@pensando.io>
> ---
>  .../ethernet/pensando/pds_vdpa.rst            | 85 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  drivers/vdpa/Kconfig                          |  7 ++
>  3 files changed, 93 insertions(+)
>  create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/pds_vdpa.rst
>
> diff --git a/Documentation/networking/device_drivers/ethernet/pensando/pds_vdpa.rst b/Documentation/networking/device_drivers/ethernet/pensando/pds_vdpa.rst
> new file mode 100644
> index 000000000000..c517f337d212
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/pensando/pds_vdpa.rst
> @@ -0,0 +1,85 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. note: can be edited and viewed with /usr/bin/formiko-vim
> +
> +==========================================================
> +PCI vDPA driver for the Pensando(R) DSC adapter family
> +==========================================================
> +
> +Pensando vDPA VF Device Driver
> +Copyright(c) 2022 Pensando Systems, Inc
> +
> +Overview
> +========
> +
> +The ``pds_vdpa`` driver is a PCI and auxiliary bus driver and supplies
> +a vDPA device for use by the virtio network stack.  It is used with
> +the Pensando Virtual Function devices that offer vDPA and virtio queue
> +services.  It depends on the ``pds_core`` driver and hardware for the PF
> +and for device configuration services.
> +
> +Using the device
> +================
> +
> +The ``pds_vdpa`` device is enabled via multiple configuration steps and
> +depends on the ``pds_core`` driver to create and enable SR-IOV Virtual
> +Function devices.
> +
> +Shown below are the steps to bind the driver to a VF and also to the
> +associated auxiliary device created by the ``pds_core`` driver. This
> +example assumes the pds_core and pds_vdpa modules are already
> +loaded.
> +
> +.. code-block:: bash
> +
> +  #!/bin/bash
> +
> +  modprobe pds_core
> +  modprobe pds_vdpa
> +
> +  PF_BDF=`grep "vDPA.*1" /sys/kernel/debug/pds_core/*/viftypes | head -1 | awk -F / '{print $6}'`
> +
> +  # Enable vDPA VF auxiliary device(s) in the PF
> +  devlink dev param set pci/$PF_BDF name enable_vnet value true cmode runtime
> +
> +  # Create a VF for vDPA use
> +  echo 1 > /sys/bus/pci/drivers/pds_core/$PF_BDF/sriov_numvfs
> +
> +  # Find the vDPA services/devices available
> +  PDS_VDPA_MGMT=`vdpa mgmtdev show | grep vDPA | head -1 | cut -d: -f1`
> +
> +  # Create a vDPA device for use in virtio network configurations
> +  vdpa dev add name vdpa1 mgmtdev $PDS_VDPA_MGMT mac 00:11:22:33:44:55
> +
> +  # Set up an ethernet interface on the vdpa device
> +  modprobe virtio_vdpa
> +
> +
> +
> +Enabling the driver
> +===================
> +
> +The driver is enabled via the standard kernel configuration system,
> +using the make command::
> +
> +  make oldconfig/menuconfig/etc.
> +
> +The driver is located in the menu structure at:
> +
> +  -> Device Drivers
> +    -> Network device support (NETDEVICES [=y])
> +      -> Ethernet driver support
> +        -> Pensando devices
> +          -> Pensando Ethernet PDS_VDPA Support
> +
> +Support
> +=======
> +
> +For general Linux networking support, please use the netdev mailing
> +list, which is monitored by Pensando personnel::
> +
> +  netdev@vger.kernel.org
> +
> +For more specific support needs, please use the Pensando driver support
> +email::
> +
> +  drivers@pensando.io
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a4f989fa8192..a4d96e854757 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16152,6 +16152,7 @@ L:      netdev@vger.kernel.org
>  S:     Supported
>  F:     Documentation/networking/device_drivers/ethernet/pensando/
>  F:     drivers/net/ethernet/pensando/
> +F:     drivers/vdpa/pds/
>  F:     include/linux/pds/
>
>  PER-CPU MEMORY ALLOCATOR
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d037611..1c44df18f3da 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -86,4 +86,11 @@ config ALIBABA_ENI_VDPA
>           VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
>           virtio 0.9.5 specification.
>
> +config PDS_VDPA
> +       tristate "vDPA driver for Pensando DSC devices"
> +       select VHOST_RING

Any reason it needs to select on vringh?

Thanks

> +       depends on PDS_CORE
> +       help
> +         VDPA network driver for Pensando's PDS Core devices.
> +
>  endif # VDPA
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
