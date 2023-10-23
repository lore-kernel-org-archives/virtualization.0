Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80860C004C0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 15:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F38D481ED3;
	Mon, 23 Oct 2023 15:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F38D481ED3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hXwoYepA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XBtnWVAazin; Mon, 23 Oct 2023 15:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2274681EB3;
	Mon, 23 Oct 2023 15:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2274681EB3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8F53C0039;
	Mon, 23 Oct 2023 15:33:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF6BCC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6FBF42153
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6FBF42153
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hXwoYepA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jhxe9X5S5Dyw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:33:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 441FB42159
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 441FB42159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698075208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVyXYnNlesI1s2bnyJgk2UUZk/foyIhU6sDI+zB3eeI=;
 b=hXwoYepAbKqLuKWbW+bQEzIKwnUvKe2pNci9lGTo6K2pVJg+xeT3xgxNA2awgid8gy9ENj
 4Vc6sLnEb3Wb9KDm6/1Z9NZwwIkthziIojIzJC7kvooUmOQGt9LMGVCJ4AXWp3svYVdwUi
 5P4HVICUgrJvSgWszq1K6V2UOfJB6tE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-UyI8bcEpPnaylS8pU2JkFg-1; Mon, 23 Oct 2023 11:33:26 -0400
X-MC-Unique: UyI8bcEpPnaylS8pU2JkFg-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7a66847671eso451146039f.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 08:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698075205; x=1698680005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVyXYnNlesI1s2bnyJgk2UUZk/foyIhU6sDI+zB3eeI=;
 b=S8eeCb/VqYf24iyzAxZ8YHq+/hWUO0WcO68cNA/5/5H0+IMMKbsK2JSSWTmGnAY3To
 09Ac0GeTYQRmfpydyV7Wx2rCbnKDslThiUCGNJ4c916NEoRizC+Qc4Od8wFwUHOEntze
 XixBstachMNNLfeeWwZ5Y13RtS2X9MypuQaPwrfVB4TkTugWGDRwlbQXHBrrYf4ZA/LR
 tlDKT2ICMyVcJ2yn0Sdu/LF0qMtHIfO/+s7qXKaL1+yu2h4zbQWD4OuAUQea0M6hSals
 XyrxytfwFj99uQdc3I/W4s0/zhvfHuJ/PLOs+TukXe5WuoL3ciZ7qGdqF9SccDsXVYVx
 zEoQ==
X-Gm-Message-State: AOJu0YyCZ5r1xRrSpbEZgz8arB28InscZw6AeboY8dZ5KaJKcxYkWcqV
 YTBhbq7tuHTS0n1K4xJemYqmtUhs+2Q0qlDEM/qYAzb3njayss4C+n2a9zWrlayaVmcI6bPx1OS
 /UItHATXYiRwMofaUVQNN23pXFEfQaYxKvDjJfcApGA==
X-Received: by 2002:a05:6602:1689:b0:7a9:629f:3c5a with SMTP id
 s9-20020a056602168900b007a9629f3c5amr2485996iow.14.1698075205144; 
 Mon, 23 Oct 2023 08:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNHX8s1tVCBgdJ5d5FeQxPsEYzG+wkzJ4SpEaHuHvDxZeHq0lJujXcwqErqJeqpLdvp+UkIg==
X-Received: by 2002:a05:6602:1689:b0:7a9:629f:3c5a with SMTP id
 s9-20020a056602168900b007a9629f3c5amr2485973iow.14.1698075204809; 
 Mon, 23 Oct 2023 08:33:24 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 d26-20020a056602185a00b0079fbb834232sm2459860ioi.19.2023.10.23.08.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:33:24 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:33:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 0/9] Introduce a vfio driver over virtio devices
Message-ID: <20231023093323.2a20b67c.alex.williamson@redhat.com>
In-Reply-To: <6e2c79c2-5d1d-3f3b-163b-29403c669049@nvidia.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <6e2c79c2-5d1d-3f3b-163b-29403c669049@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Sun, 22 Oct 2023 11:20:31 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 17/10/2023 16:42, Yishai Hadas wrote:
> > This series introduce a vfio driver over virtio devices to support the
> > legacy interface functionality for VFs.
> >
> > Background, from the virtio spec [1].
> > --------------------------------------------------------------------
> > In some systems, there is a need to support a virtio legacy driver with
> > a device that does not directly support the legacy interface. In such
> > scenarios, a group owner device can provide the legacy interface
> > functionality for the group member devices. The driver of the owner
> > device can then access the legacy interface of a member device on behalf
> > of the legacy member device driver.
> >
> > For example, with the SR-IOV group type, group members (VFs) can not
> > present the legacy interface in an I/O BAR in BAR0 as expected by the
> > legacy pci driver. If the legacy driver is running inside a virtual
> > machine, the hypervisor executing the virtual machine can present a
> > virtual device with an I/O BAR in BAR0. The hypervisor intercepts the
> > legacy driver accesses to this I/O BAR and forwards them to the group
> > owner device (PF) using group administration commands.
> > --------------------------------------------------------------------
> >
> > The first 6 patches are in the virtio area and handle the below:
> > - Fix common config map for modern device as was reported by Michael Tsirkin.
> > - Introduce the admin virtqueue infrastcture.
> > - Expose the layout of the commands that should be used for
> >    supporting the legacy access.
> > - Expose APIs to enable upper layers as of vfio, net, etc
> >    to execute admin commands.
> >
> > The above follows the virtio spec that was lastly accepted in that area
> > [1].
> >
> > The last 3 patches are in the vfio area and handle the below:
> > - Expose some APIs from vfio/pci to be used by the vfio/virtio driver.
> > - Introduce a vfio driver over virtio devices to support the legacy
> >    interface functionality for VFs.
> >
> > The series was tested successfully over virtio-net VFs in the host,
> > while running in the guest both modern and legacy drivers.
> >
> > [1]
> > https://github.com/oasis-tcs/virtio-spec/commit/03c2d32e5093ca9f2a17797242fbef88efe94b8c
> >
> > Changes from V0: https://www.spinics.net/lists/linux-virtualization/msg63802.html
> >
> > Virtio:
> > - Fix the common config map size issue that was reported by Michael
> >    Tsirkin.
> > - Do not use vp_dev->vqs[] array upon vp_del_vqs() as was asked by
> >    Michael, instead skip the AQ specifically.
> > - Move admin vq implementation into virtio_pci_modern.c as was asked by
> >    Michael.
> > - Rename structure virtio_avq to virtio_pci_admin_vq and some extra
> >    corresponding renames.
> > - Remove exported symbols virtio_pci_vf_get_pf_dev(),
> >    virtio_admin_cmd_exec() as now callers are local to the module.
> > - Handle inflight commands as part of the device reset flow.
> > - Introduce APIs per admin command in virtio-pci as was asked by Michael.
> >
> > Vfio:
> > - Change to use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL for
> >    vfio_pci_core_setup_barmap() and vfio_pci_iowrite#xxx() as pointed by
> >    Alex.
> > - Drop the intermediate patch which prepares the commands and calls the
> >    generic virtio admin command API (i.e. virtio_admin_cmd_exec()).
> > - Instead, call directly to the new APIs per admin command that are
> >    exported from Virtio - based on Michael's request.
> > - Enable only virtio-net as part of the pci_device_id table to enforce
> >    upon binding only what is supported as suggested by Alex.
> > - Add support for byte-wise access (read/write) over the device config
> >    region as was asked by Alex.
> > - Consider whether MSIX is practically enabled/disabled to choose the
> >    right opcode upon issuing read/write admin command, as mentioned
> >    by Michael.
> > - Move to use VIRTIO_PCI_CONFIG_OFF instead of adding some new defines
> >    as was suggested by Michael.
> > - Set the '.close_device' op to vfio_pci_core_close_device() as was
> >    pointed by Alex.
> > - Adapt to Vfio multi-line comment style in a few places.
> > - Add virtualization@lists.linux-foundation.org in the MAINTAINERS file
> >    to be CCed for the new driver as was suggested by Jason.
> >
> > Yishai
> >
> > Feng Liu (5):
> >    virtio-pci: Fix common config map for modern device
> >    virtio: Define feature bit for administration virtqueue
> >    virtio-pci: Introduce admin virtqueue
> >    virtio-pci: Introduce admin command sending function
> >    virtio-pci: Introduce admin commands
> >
> > Yishai Hadas (4):
> >    virtio-pci: Introduce APIs to execute legacy IO admin commands
> >    vfio/pci: Expose vfio_pci_core_setup_barmap()
> >    vfio/pci: Expose vfio_pci_iowrite/read##size()
> >    vfio/virtio: Introduce a vfio driver over virtio devices
> >
> >   MAINTAINERS                            |   7 +
> >   drivers/vfio/pci/Kconfig               |   2 +
> >   drivers/vfio/pci/Makefile              |   2 +
> >   drivers/vfio/pci/vfio_pci_core.c       |  25 ++
> >   drivers/vfio/pci/vfio_pci_rdwr.c       |  38 +-
> >   drivers/vfio/pci/virtio/Kconfig        |  15 +
> >   drivers/vfio/pci/virtio/Makefile       |   4 +
> >   drivers/vfio/pci/virtio/main.c         | 577 +++++++++++++++++++++++++
> >   drivers/virtio/virtio.c                |  37 +-
> >   drivers/virtio/virtio_pci_common.c     |  14 +
> >   drivers/virtio/virtio_pci_common.h     |  20 +-
> >   drivers/virtio/virtio_pci_modern.c     | 441 ++++++++++++++++++-
> >   drivers/virtio/virtio_pci_modern_dev.c |  24 +-
> >   include/linux/vfio_pci_core.h          |  20 +
> >   include/linux/virtio.h                 |   8 +
> >   include/linux/virtio_config.h          |   4 +
> >   include/linux/virtio_pci_admin.h       |  18 +
> >   include/linux/virtio_pci_modern.h      |   5 +
> >   include/uapi/linux/virtio_config.h     |   8 +-
> >   include/uapi/linux/virtio_pci.h        |  66 +++
> >   20 files changed, 1295 insertions(+), 40 deletions(-)
> >   create mode 100644 drivers/vfio/pci/virtio/Kconfig
> >   create mode 100644 drivers/vfio/pci/virtio/Makefile
> >   create mode 100644 drivers/vfio/pci/virtio/main.c
> >   create mode 100644 include/linux/virtio_pci_admin.h
> >  
> Hi Michael,
> 
> Did you have the chance to review the virtio part of that series ?
> 
> IMO, we addressed all your notes on V0, I would be happy to get your 
> feedback on V1 before sending V2.
> 
> In my TO-DO list for V2, have for now the below minor items.
> Virtio:
> Patch #6: Fix a krobot note where it needs to include the H file as part 
> of the export symbols C file.
> Vfio:
> #patch #9: Rename the 'ops' variable to drop the 'acc' and potentially 
> some rename in the description of the module with regards to 'family'.
> 
> Alex,
> Are you fine to leave the provisioning of the VF including the control 
> of its transitional capability in the device hands as was suggested by 
> Jason ?

If this is the standard we're going to follow, ie. profiling of a
device is expected to occur prior to the probe of the vfio-pci variant
driver, then we should get the out-of-tree NVIDIA vGPU driver on board
with this too.

> Any specific recommendation following the discussion in the ML, for the 
> 'family' note ?

It's not super important, it's just overly broad vs what's actually
implemented.  Limiting the description to virtio-net for the current
implementation is fine.

> Once I'll have the above feedback I may prepare and send V2.

I'll try to take a more thorough look, but also note my comments to
Ankit relative to config space emulation.  This driver correctly
implements the flags for the IO Port BAR, but does not support sizing
of the BAR through config space, which I think is a shortcoming
relative to that implemented by vfio-pci.  QEMU doesn't rely on this,
but we don't know there aren't other userspaces that depend on this
behavior.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
