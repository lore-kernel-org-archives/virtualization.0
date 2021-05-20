Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79DBC43461
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 06:06:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606C261028
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 06:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606C261028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C99040E7C;
	Thu, 20 May 2021 06:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2J56tYaFgZT4; Thu, 20 May 2021 06:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DAA54069F;
	Thu, 20 May 2021 06:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD5E3C0023;
	Thu, 20 May 2021 06:06:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD38CC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 06:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F27940176
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 06:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qkcad7BK7OiA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 06:06:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A2CD400AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 06:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621490791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/1MIfmT5d7xpyyAPbT+NBT+vAsBIaGQZ8sMh4JJUuw=;
 b=MvpSemq4wo+K4EByrrNzUSll4lx2LaZVDX+WK/9Qux8U/7rnagsJmpOjQLsiziqLwYezte
 0hXmLffZVK7cIVNVqTVqonVDve1Ztjw8o+4ZqvA6D+N6dE5xV5zHcWGUhUZ+5EcK/Vv2ji
 jTXd/Lo+9APC2obKPSo7DNNvGjnQU/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-cNKHIUuWN-6-aieNY9SSMw-1; Thu, 20 May 2021 02:06:27 -0400
X-MC-Unique: cNKHIUuWN-6-aieNY9SSMw-1
Received: by mail-wm1-f72.google.com with SMTP id
 n127-20020a1c27850000b02901717a27c785so1973215wmn.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 23:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F/1MIfmT5d7xpyyAPbT+NBT+vAsBIaGQZ8sMh4JJUuw=;
 b=Yrpn0g6IS44C6mu9hRUo9XN678VTKgXr0h90XROqqmsPHz7d5gfO1iC1vB9pI0ex9S
 Ra5M+GHCWb6sFgrgR97onj56zqd0nQeUeP72k7alU8dGt7A+5cJDraboxV2mAgIQnTnt
 YPCtf+8gib/mE/YtE8JHmgxmC+XsLgIOn+mNHQZk6ZcK1VztAAFef4DmPr798X5Ii9C0
 BXGiPTZnvcGBt1kNGUVelblF7ZuCybOWhmGvWF6dy6UMDgQOpx5Qz8nWP1SFh+dRjsUr
 rl0oZUsl2gFnDlzXcD/2sCj6ErcjsbdRpgpkbw1WCTGoWkfnuQ81zmU9xYo2ZD6vhFqH
 S0ZQ==
X-Gm-Message-State: AOAM532c13RyUaw08z8lGPRbn+/R3cHUj7RAWPzkoUphJvSXH9v+Kt1Y
 UbnGjfrcN4z6W8R5KVgeYaqxOjZJIQU7Gwvhoe4ppxJKmpLliElEop82YQjpvmhMZKHxEPbpBLY
 I4RnXGQ/9x78K7kU1FpZDSbJGSB4OjHPZ8MnflvLUNw==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr2336147wrm.202.1621490786700; 
 Wed, 19 May 2021 23:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeXIT5VhQwzhhGvDu0MpkfAVRU4bmIpzgVNBr1qjZ/cad7jvRZV/tIhsD1+YU5BcQIXLJsag==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr2336119wrm.202.1621490786503; 
 Wed, 19 May 2021 23:06:26 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id h14sm8720465wmb.1.2021.05.19.23.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 23:06:25 -0700 (PDT)
Date: Thu, 20 May 2021 02:06:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v7 00/12] Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20210520014349-mutt-send-email-mst@kernel.org>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 corbet@lwn.net, netdev@vger.kernel.org, rdunlap@infradead.org,
 iommu@lists.linux-foundation.org, willy@infradead.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 christian.brauner@canonical.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, dan.carpenter@oracle.com,
 joro@8bytes.org, mika.penttila@nextfour.com
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

On Mon, May 17, 2021 at 05:55:01PM +0800, Xie Yongji wrote:
> This series introduces a framework, which can be used to implement
> vDPA Devices in a userspace program. The work consist of two parts:
> control path forwarding and data path offloading.
> 
> In the control path, the VDUSE driver will make use of message
> mechnism to forward the config operation from vdpa bus driver
> to userspace. Userspace can use read()/write() to receive/reply
> those control messages.
> 
> In the data path, the core is mapping dma buffer into VDUSE
> daemon's address space, which can be implemented in different ways
> depending on the vdpa bus to which the vDPA device is attached.
> 
> In virtio-vdpa case, we implements a MMU-based on-chip IOMMU driver with
> bounce-buffering mechanism to achieve that. And in vhost-vdpa case, the dma
> buffer is reside in a userspace memory region which can be shared to the
> VDUSE userspace processs via transferring the shmfd.
> 
> The details and our user case is shown below:
> 
> ------------------------    -------------------------   ----------------------------------------------
> |            Container |    |              QEMU(VM) |   |                               VDUSE daemon |
> |       ---------      |    |  -------------------  |   | ------------------------- ---------------- |
> |       |dev/vdx|      |    |  |/dev/vhost-vdpa-x|  |   | | vDPA device emulation | | block driver | |
> ------------+-----------     -----------+------------   -------------+----------------------+---------
>             |                           |                            |                      |
>             |                           |                            |                      |
> ------------+---------------------------+----------------------------+----------------------+---------
> |    | block device |           |  vhost device |            | vduse driver |          | TCP/IP |    |
> |    -------+--------           --------+--------            -------+--------          -----+----    |
> |           |                           |                           |                       |        |
> | ----------+----------       ----------+-----------         -------+-------                |        |
> | | virtio-blk driver |       |  vhost-vdpa driver |         | vdpa device |                |        |
> | ----------+----------       ----------+-----------         -------+-------                |        |
> |           |      virtio bus           |                           |                       |        |
> |   --------+----+-----------           |                           |                       |        |
> |                |                      |                           |                       |        |
> |      ----------+----------            |                           |                       |        |
> |      | virtio-blk device |            |                           |                       |        |
> |      ----------+----------            |                           |                       |        |
> |                |                      |                           |                       |        |
> |     -----------+-----------           |                           |                       |        |
> |     |  virtio-vdpa driver |           |                           |                       |        |
> |     -----------+-----------           |                           |                       |        |
> |                |                      |                           |    vdpa bus           |        |
> |     -----------+----------------------+---------------------------+------------           |        |
> |                                                                                        ---+---     |
> -----------------------------------------------------------------------------------------| NIC |------
>                                                                                          ---+---
>                                                                                             |
>                                                                                    ---------+---------
>                                                                                    | Remote Storages |
>                                                                                    -------------------
> 
> We make use of it to implement a block device connecting to
> our distributed storage, which can be used both in containers and
> VMs. Thus, we can have an unified technology stack in this two cases.
> 
> To test it with null-blk:
> 
>   $ qemu-storage-daemon \
>       --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
>       --monitor chardev=charmonitor \
>       --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
>       --export type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128
> 
> The qemu-storage-daemon can be found at https://github.com/bytedance/qemu/tree/vduse
> 
> To make the userspace VDUSE processes such as qemu-storage-daemon able to
> run unprivileged. We did some works on virtio driver to avoid trusting
> device, including:
> 
>   - validating the device status:
> 
>     * https://lore.kernel.org/lkml/20210517093428.670-1-xieyongji@bytedance.com/
> 
>   - validating the used length: 
> 
>     * https://lore.kernel.org/lkml/20210517090836.533-1-xieyongji@bytedance.com/
> 
>   - validating the device config:
>     
>     * patch 4 ("virtio-blk: Add validation for block size in config space")
> 
>   - validating the device response:
> 
>     * patch 5 ("virtio_scsi: Add validation for residual bytes from response")
> 
> Since I'm not sure if I missing something during auditing, especially on some
> virtio device drivers that I'm not familiar with, now we only support emualting
> a few vDPA devices by default, including: virtio-net device, virtio-blk device,
> virtio-scsi device and virtio-fs device. This limitaion can help to reduce
> security risks.

I suspect there are a lot of assumptions even with these 4.
Just what are the security assumptions and guarantees here?
E.g. it seems pretty clear that exposing a malformed FS
to a random kernel config can cause untold mischief.

Things like virtnet_send_command are also an easy way for
the device to DOS the kernel. And before you try to add
an arbitrary timeout there - please don't,
the fix is moving things that must be guaranteed into kernel
and making things that are not guaranteed asynchronous.
Right now there are some things that happen with locks taken,
where if we don't wait for device we lose the ability to report failures
to userspace. E.g. all kind of netlink things are like this.
One can think of a bunch of ways to address this, this
needs to be discussed with the relevant subsystem maintainers.


If I were you I would start with one type of device, and as simple one
as possible.



> When a sysadmin trusts the userspace process enough, it can relax
> the limitation with a 'allow_unsafe_device_emulation' module parameter.

That's not a great security interface. It's a global module specific knob
that just allows any userspace to emulate anything at all.
Coming up with a reasonable interface isn't going to be easy.
For now maybe just have people patch their kernels if they want to
move fast and break things.

> Future work:
>   - Improve performance
>   - Userspace library (find a way to reuse device emulation code in qemu/rust-vmm)
> 
> V6 to V7:
> - Export alloc_iova_fast()
> - Add get_config_size() callback
> - Add some patches to avoid trusting virtio devices
> - Add limited device emulation
> - Add some documents
> - Use workqueue to inject config irq
> - Add parameter on vq irq injecting
> - Rename vduse_domain_get_mapping_page() to vduse_domain_get_coherent_page()
> - Add WARN_ON() to catch message failure
> - Add some padding/reserved fields to uAPI structure
> - Fix some bugs
> - Rebase to vhost.git
> 
> V5 to V6:
> - Export receive_fd() instead of __receive_fd()
> - Factor out the unmapping logic of pa and va separatedly
> - Remove the logic of bounce page allocation in page fault handler
> - Use PAGE_SIZE as IOVA allocation granule
> - Add EPOLLOUT support
> - Enable setting API version in userspace
> - Fix some bugs
> 
> V4 to V5:
> - Remove the patch for irq binding
> - Use a single IOTLB for all types of mapping
> - Factor out vhost_vdpa_pa_map()
> - Add some sample codes in document
> - Use receice_fd_user() to pass file descriptor
> - Fix some bugs
> 
> V3 to V4:
> - Rebase to vhost.git
> - Split some patches
> - Add some documents
> - Use ioctl to inject interrupt rather than eventfd
> - Enable config interrupt support
> - Support binding irq to the specified cpu
> - Add two module parameter to limit bounce/iova size
> - Create char device rather than anon inode per vduse
> - Reuse vhost IOTLB for iova domain
> - Rework the message mechnism in control path
> 
> V2 to V3:
> - Rework the MMU-based IOMMU driver
> - Use the iova domain as iova allocator instead of genpool
> - Support transferring vma->vm_file in vhost-vdpa
> - Add SVA support in vhost-vdpa
> - Remove the patches on bounce pages reclaim
> 
> V1 to V2:
> - Add vhost-vdpa support
> - Add some documents
> - Based on the vdpa management tool
> - Introduce a workqueue for irq injection
> - Replace interval tree with array map to store the iova_map
> 
> Xie Yongji (12):
>   iova: Export alloc_iova_fast()
>   file: Export receive_fd() to modules
>   eventfd: Increase the recursion depth of eventfd_signal()
>   virtio-blk: Add validation for block size in config space
>   virtio_scsi: Add validation for residual bytes from response
>   vhost-iotlb: Add an opaque pointer for vhost IOTLB
>   vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
>   vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
>   vdpa: Support transferring virtual addressing during DMA mapping
>   vduse: Implement an MMU-based IOMMU driver
>   vduse: Introduce VDUSE - vDPA Device in Userspace
>   Documentation: Add documentation for VDUSE
> 
>  Documentation/userspace-api/index.rst              |    1 +
>  Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
>  Documentation/userspace-api/vduse.rst              |  243 ++++
>  drivers/block/virtio_blk.c                         |    2 +-
>  drivers/iommu/iova.c                               |    1 +
>  drivers/scsi/virtio_scsi.c                         |    2 +-
>  drivers/vdpa/Kconfig                               |   10 +
>  drivers/vdpa/Makefile                              |    1 +
>  drivers/vdpa/ifcvf/ifcvf_main.c                    |    2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c                  |    2 +-
>  drivers/vdpa/vdpa.c                                |    9 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c                   |    8 +-
>  drivers/vdpa/vdpa_user/Makefile                    |    5 +
>  drivers/vdpa/vdpa_user/iova_domain.c               |  531 +++++++
>  drivers/vdpa/vdpa_user/iova_domain.h               |   70 +
>  drivers/vdpa/vdpa_user/vduse_dev.c                 | 1453 ++++++++++++++++++++
>  drivers/vdpa/virtio_pci/vp_vdpa.c                  |    2 +-
>  drivers/vhost/iotlb.c                              |   20 +-
>  drivers/vhost/vdpa.c                               |  148 +-
>  fs/eventfd.c                                       |    2 +-
>  fs/file.c                                          |    6 +
>  include/linux/eventfd.h                            |    5 +-
>  include/linux/file.h                               |    7 +-
>  include/linux/vdpa.h                               |   21 +-
>  include/linux/vhost_iotlb.h                        |    3 +
>  include/uapi/linux/vduse.h                         |  178 +++
>  26 files changed, 2681 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/userspace-api/vduse.rst
>  create mode 100644 drivers/vdpa/vdpa_user/Makefile
>  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
>  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
>  create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
>  create mode 100644 include/uapi/linux/vduse.h
> 
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
