Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC058C001DF
	for <virtualization@archiver.kernel.org>; Sun, 22 Oct 2023 09:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68E57416E7;
	Sun, 22 Oct 2023 09:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68E57416E7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bx8exvHE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YHTdAZqbQEXV; Sun, 22 Oct 2023 09:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 013CD400AB;
	Sun, 22 Oct 2023 09:12:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 013CD400AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7991C0039;
	Sun, 22 Oct 2023 09:12:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58CF0C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 09:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25EB285334
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 09:12:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25EB285334
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bx8exvHE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pf3ww2gABu4u
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 09:12:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7E6185333
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 09:12:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7E6185333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697965956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNHUwQ+gSx+txVVRnUjc9VphJxZEWVVV7+qBxuJkqIU=;
 b=Bx8exvHEB7QwDginp7RAipxkn5F/H4GWGdwXeMLCm1RWsms4EZWHa84bSXeFHEaOpMVqOk
 I+F0rLKvJn0cGVqPjGm4Rp+FBgOhajOdqk0hiI/8hcI1vEoR6MS2SpDceqr17jqefweF5E
 KczXjY9p5stLeJAB8yd8tSEvvZ3FOrM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-OW7HCgBiNZacx9X5ZUKswQ-1; Sun, 22 Oct 2023 05:12:32 -0400
X-MC-Unique: OW7HCgBiNZacx9X5ZUKswQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079a3362afso2076117e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 02:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697965951; x=1698570751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNHUwQ+gSx+txVVRnUjc9VphJxZEWVVV7+qBxuJkqIU=;
 b=Z5+RoKDMkauiiJOiliUCH93cjOnENXsibQygTVwl7PgFArRJithoEvU4XXHKnbBa+k
 gBGQMN3TrgAZhs9wdajqRNJKuLFvf4+I+mA27k3e1hrRgCKgfBXy4oYLWLcWzdN9jlTW
 oyRiALxui7Zl0aIvJZQtL3LvUwNTdJ9+afdFH7ZtMpOCTxdZ7kcvbSnxFzeBDvyZ9m9i
 jzQqpY22fXm1TbN3ZiXV5LjusAIfA6eyZQ682uPwhMYv5yyUto0Zxy6hoR95hSmuh9Sv
 yvMU3W6KsIOTIS2oNV/rUCJ7vJJOgEq4YfwPb1XyAyyeVGdtxHZsaRIjQ/kj7AKDzyBN
 BtDA==
X-Gm-Message-State: AOJu0YxV7l9Q364C2pag4Iehf7J5tJp3k91FCBGKXi0zSTvv5R0QpoYE
 qDvvheiAislRsd15/wJ1le8Q/ihDliTf54FbOTaMe53yCd603DNdXGO1f8aNGHcPu+ZmjA7kuXJ
 Lugr8Lii8RRQSsTFuvlUjoNJqt/Wtl4Hs7q3mzmD7Ug==
X-Received: by 2002:a05:6512:2808:b0:507:aad2:96af with SMTP id
 cf8-20020a056512280800b00507aad296afmr4947046lfb.21.1697965951483; 
 Sun, 22 Oct 2023 02:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpDIoeiID5+q2VY1rvi6/lb0ytyuPiQ006kkqPOxg332Wg5GnoAZPGhKqjAFeJKhh9a1wY7Q==
X-Received: by 2002:a05:6512:2808:b0:507:aad2:96af with SMTP id
 cf8-20020a056512280800b00507aad296afmr4947030lfb.21.1697965951086; 
 Sun, 22 Oct 2023 02:12:31 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 fa10-20020a05600c518a00b004064741f855sm6376858wmb.47.2023.10.22.02.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:12:30 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:12:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 0/9] Introduce a vfio driver over virtio devices
Message-ID: <20231022051157-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <6e2c79c2-5d1d-3f3b-163b-29403c669049@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6e2c79c2-5d1d-3f3b-163b-29403c669049@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
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

On Sun, Oct 22, 2023 at 11:20:31AM +0300, Yishai Hadas wrote:
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

Not yet, will take a couple more days.

> IMO, we addressed all your notes on V0, I would be happy to get your
> feedback on V1 before sending V2.
> 
> In my TO-DO list for V2, have for now the below minor items.
> Virtio:
> Patch #6: Fix a krobot note where it needs to include the H file as part of
> the export symbols C file.
> Vfio:
> #patch #9: Rename the 'ops' variable to drop the 'acc' and potentially some
> rename in the description of the module with regards to 'family'.
> 
> Alex,
> Are you fine to leave the provisioning of the VF including the control of
> its transitional capability in the device hands as was suggested by Jason ?
> Any specific recommendation following the discussion in the ML, for the
> 'family' note ?
> 
> Once I'll have the above feedback I may prepare and send V2.
> 
> Yishai

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
