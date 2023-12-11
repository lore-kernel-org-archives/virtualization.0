Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC94B48CEB
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUkhUNlC"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62335822F5
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 16:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62335822F5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FUkhUNlC
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JH7HTR7c2tx8
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Dec 2023 16:55:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1E6E82152
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 16:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1E6E82152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702313714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KGVc8/OL2lxNoufsjp3KG2GQ05JrCvcQkaObosImAkA=;
	b=FUkhUNlC/TNefLT3BpQNrkZ8tW/5CpJgM6bMe5H9fTLBuNQv+m8PN2CuNDNUhBCjiijQz3
	w6d0taox7bk31lY5tXLfGMPkApq9V4NLa4O5ZxUa2A9q9AKHbrCnUy9u/eJDbquEPto4Od
	xWCFqxSCeptAoLSyScqr+CYMfPToVrE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-CqHxuNdMNMa2T5hGtOj5Og-1; Mon, 11 Dec 2023 11:55:12 -0500
X-MC-Unique: CqHxuNdMNMa2T5hGtOj5Og-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c2c6f0893so30162185e9.3
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 08:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702313711; x=1702918511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGVc8/OL2lxNoufsjp3KG2GQ05JrCvcQkaObosImAkA=;
        b=riPGlkziRfaFO2QVHAd5AlpaRyoZdxUoQ9lFD+lc56FE83tDMFspGQxk0mEtoJ0e2y
         K3qCYfs9IS7bAkpTb6CtgNEb+Y6BHykgzWHCGaVm0GjmctKrgQilBMs8Gd2eoXLTB0WC
         1mhp03lR61ILQjXwvlaVeTiw0N0UKGMRpWPkAGgxnQUuwHXSf9xeXWJ4fvC5LbiLAP9x
         bMwrgSu2V+KDNbnz9E9moX0/NTd3J+OqS7nFEbS7H3/V6rC0taW3HoRfb/XhMVNv+WBw
         og2UmFia9q4+iAheAmefPpkBjJAB7NxXYjaiAyvYkt1fZrQ5Ql/YoDwjlD3v7OM+MarG
         pE3Q==
X-Gm-Message-State: AOJu0Yx/t6j/OjogBi/BGRWDPLM9AefAIbHQMxJexOTgkDV3VExn/H37
	hJT2BkpjZNuzKJsMI6zBUAAYILsa82ugNoFfPrbUW/Is+x5VoslexuKDobNMdstxxz7sHIdTqor
	10LtC9jRuQjggrN3IRCc4Ov1ls9GH30G83/nCdzs60g==
X-Received: by 2002:a05:600c:2201:b0:40c:35d4:9548 with SMTP id z1-20020a05600c220100b0040c35d49548mr2462662wml.63.1702313710780;
        Mon, 11 Dec 2023 08:55:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzjNDK9WpG8IKx8a2ioYx0oita2p1G4RmuZ2ECJdz5Bkkj5r/ZtyNU6NakoWKt8XaykgS8zA==
X-Received: by 2002:a05:600c:2201:b0:40c:35d4:9548 with SMTP id z1-20020a05600c220100b0040c35d49548mr2462654wml.63.1702313710354;
        Mon, 11 Dec 2023 08:55:10 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0040b30be6244sm13580784wmq.24.2023.12.11.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:55:09 -0800 (PST)
Date: Mon, 11 Dec 2023 11:55:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: alex.williamson@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, parav@nvidia.com,
	feliu@nvidia.com, jiri@nvidia.com, kevin.tian@intel.com,
	joao.m.martins@oracle.com, si-wei.liu@oracle.com, leonro@nvidia.com,
	maorg@nvidia.com, jasowang@redhat.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V7 vfio 0/9] Introduce a vfio driver over virtio devices
Message-ID: <20231211115432-mutt-send-email-mst@kernel.org>
References: <20231207102820.74820-1-yishaih@nvidia.com>
 <7929884c-f8f3-4977-9474-33830cde0a07@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7929884c-f8f3-4977-9474-33830cde0a07@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 10:28:23AM +0200, Yishai Hadas wrote:
> On 07/12/2023 12:28, Yishai Hadas wrote:
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
> > Changes from V6: https://lore.kernel.org/kvm/20231206083857.241946-1-yishaih@nvidia.com/
> > Vfio:
> > - Put the pm_runtime stuff into translate_io_bar_to_mem_bar() and
> >    organize the callers to be more success oriented, as suggested by Jason.
> > - Add missing 'ops' (i.e. 'detach_ioas' and 'device_feature'), as mentioned by Jason.
> > - Clean virtiovf_bar0_exists() to cast to bool automatically, as
> >    suggested by Jason.
> > - Add Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>.
> > 
> > Changes from V5: https://lore.kernel.org/kvm/20231205170623.197877-1-yishaih@nvidia.com/
> > Vfio:
> > - Rename vfio_pci_iowrite64 to vfio_pci_core_iowrite64 as was mentioned
> >    by Alex.
> > 
> > Changes from V4: https://lore.kernel.org/all/20231129143746.6153-7-yishaih@nvidia.com/T/
> > Virtio:
> > - Drop the unused macro 'VIRTIO_ADMIN_MAX_CMD_OPCODE' as was asked by
> >    Michael.
> > - Add Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Vfio:
> > - Export vfio_pci_core_setup_barmap() in place and rename
> >    vfio_pci_iowrite/read<xxx> to have the 'core' prefix as part of the
> >    functions names, as was discussed with Alex.
> > - Improve packing of struct virtiovf_pci_core_device, as was suggested
> >    by Alex.
> > - Upon reset, set 'pci_cmd' back to zero, in addition, if
> >    the user didn't set the 'PCI_COMMAND_IO' bit, return -EIO upon any
> >    read/write towards the IO bar, as was suggested by Alex.
> > - Enforce by BUILD_BUG_ON that 'bar0_virtual_buf_size' is power of 2 as
> >    part of virtiovf_pci_init_device() and clean the 'sizing calculation'
> >    code accordingly, as was suggested by Alex.
> > 
> > Changes from V3: https://www.spinics.net/lists/kvm/msg333008.html
> > Virtio:
> > - Rebase on top of 6.7 rc3.
> > Vfio:
> > - Fix a typo, drop 'acc' from 'virtiovf_acc_vfio_pci_tran_ops'.
> > 
> > Changes from V2: https://lore.kernel.org/all/20231029155952.67686-8-yishaih@nvidia.com/T/
> > Virtio:
> > - Rebase on top of 6.7 rc1.
> > - Add a mutex to serialize admin commands execution and virtqueue
> >    deletion, as was suggested by Michael.
> > - Remove the 'ref_count' usage which is not needed any more.
> > - Reduce the depth of the admin vq to match a single command at a given time.
> > - Add a supported check upon command execution and move to use a single
> >    flow of virtqueue_exec_admin_cmd().
> > - Improve the description of the exported commands to better match the
> >    specification and the expected usage as was asked by Michael.
> > 
> > Vfio:
> > - Upon calling to virtio_pci_admin_legacy/common_device_io_read/write()
> >    supply the 'offset' within the relevant configuration area, following
> >    the virtio exported APIs.
> > 
> > Changes from V1: https://lore.kernel.org/all/20231023104548.07b3aa19.alex.williamson@redhat.com/T/
> > Virtio:
> > - Drop its first patch, it was accepted upstream already.
> > - Add a new patch (#6) which initializes the supported admin commands
> >    upon admin queue activation as was suggested by Michael.
> > - Split the legacy_io_read/write commands per common/device
> >    configuration as was asked by Michael.
> > - Don't expose any more the list query/used APIs outside of virtio.
> > - Instead, expose an API to check whether the legacy io functionality is
> >    supported as was suggested by Michael.
> > - Fix some Krobot's note by adding the missing include file.
> > 
> > Vfio:
> > - Refer specifically to virtio-net as part of the driver/module description
> >    as Alex asked.
> > - Change to check MSIX enablement based on the irq type of the given vfio
> >    core device. In addition, drop its capable checking from the probe flow
> >    as was asked by Alex.
> > - Adapt to use the new virtio exposed APIs and clean some code accordingly.
> > - Adapt to some cleaner style code in some places (if/else) as was suggested
> >    by Alex.
> > - Fix the range_intersect_range() function and adapt its usage as was
> >    pointed by Alex.
> > - Make struct virtiovf_pci_core_device better packed.
> > - Overwrite the subsystem vendor ID to be 0x1af4 as was discussed in
> >    the ML.
> > - Add support for the 'bar sizing negotiation' as was asked by Alex.
> > - Drop the 'acc' from the 'ops' as Alex asked.
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
> > Feng Liu (4):
> >    virtio: Define feature bit for administration virtqueue
> >    virtio-pci: Introduce admin virtqueue
> >    virtio-pci: Introduce admin command sending function
> >    virtio-pci: Introduce admin commands
> > 
> > Yishai Hadas (5):
> >    virtio-pci: Initialize the supported admin commands
> >    virtio-pci: Introduce APIs to execute legacy IO admin commands
> >    vfio/pci: Expose vfio_pci_core_setup_barmap()
> >    vfio/pci: Expose vfio_pci_core_iowrite/read##size()
> >    vfio/virtio: Introduce a vfio driver over virtio devices
> > 
> >   MAINTAINERS                            |   7 +
> >   drivers/vfio/pci/Kconfig               |   2 +
> >   drivers/vfio/pci/Makefile              |   2 +
> >   drivers/vfio/pci/vfio_pci_rdwr.c       |  57 +--
> >   drivers/vfio/pci/virtio/Kconfig        |  16 +
> >   drivers/vfio/pci/virtio/Makefile       |   4 +
> >   drivers/vfio/pci/virtio/main.c         | 567 +++++++++++++++++++++++++
> >   drivers/virtio/virtio.c                |  37 +-
> >   drivers/virtio/virtio_pci_common.c     |  14 +
> >   drivers/virtio/virtio_pci_common.h     |  21 +-
> >   drivers/virtio/virtio_pci_modern.c     | 503 +++++++++++++++++++++-
> >   drivers/virtio/virtio_pci_modern_dev.c |  24 +-
> >   include/linux/vfio_pci_core.h          |  20 +
> >   include/linux/virtio.h                 |   8 +
> >   include/linux/virtio_config.h          |   4 +
> >   include/linux/virtio_pci_admin.h       |  21 +
> >   include/linux/virtio_pci_modern.h      |   2 +
> >   include/uapi/linux/virtio_config.h     |   8 +-
> >   include/uapi/linux/virtio_pci.h        |  68 +++
> >   19 files changed, 1349 insertions(+), 36 deletions(-)
> >   create mode 100644 drivers/vfio/pci/virtio/Kconfig
> >   create mode 100644 drivers/vfio/pci/virtio/Makefile
> >   create mode 100644 drivers/vfio/pci/virtio/main.c
> >   create mode 100644 include/linux/virtio_pci_admin.h
> > 
> 
> Hi Michael and Alex,
> 
> It seems that we are done with all the last notes here.
> 
> Michael,
> Based on Alex's note here [1] "the preferred merge approach would be that
> virtio maintainers take patches 1-6 and provide a branch or tag I can merge
> to bring 7-9 in through the vfio tree"
> 
> Can that please be done to proceed here ?

Hmm ok. Next week-ish, too busy this week.


> [1] https://patchwork.kernel.org/project/kvm/patch/20231205170623.197877-9-yishaih@nvidia.com/
> 
> Thanks,
> Yishai

