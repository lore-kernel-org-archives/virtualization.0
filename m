Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46AC2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 10:32:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D87461C69
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 10:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D87461C69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D62C2832AA;
	Mon, 28 Jun 2021 10:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fT3vLOkAOWdD; Mon, 28 Jun 2021 10:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D571583192;
	Mon, 28 Jun 2021 10:32:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1055C001A;
	Mon, 28 Jun 2021 10:32:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D69D3C000E;
 Mon, 28 Jun 2021 10:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD4F240300;
 Mon, 28 Jun 2021 10:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WawlaGEAb7mX; Mon, 28 Jun 2021 10:32:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 004D7402EF;
 Mon, 28 Jun 2021 10:32:19 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id t80so21110oie.8;
 Mon, 28 Jun 2021 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6SpmYjbDA2VZHCXdxYH4FRULNvA8XJh57E6gm5kBBno=;
 b=bBPVx4kN1TQSF0nMAFDpW4r1UGnnSIGVX27v0ZRLe1ULEwqQjLcFClaipmcwk39YDX
 BWwF7NeoW8kIJPBx4EqjkxsmV77VAlu6Ol3ota6Ujnmh2O3TzDJTWIbalSbz3oF+8vmx
 zO33XGdiHBPr2TlJDH3gdRmZRVMZYMQbJwc9yAfYQbObeZPHI0jm/dn33AleRs3vuw/2
 C/arSWK8k5IPHg2P8Qb7zmzhbwldGNaII6OTZQmPMICRwV5mAURBeEfmGz+97VF8ZRxD
 vFZd9x9pBTTnN0dENlQzbcNqCuDwAKOE5qB779vDqIgAteKSLK0YB3pvHUwzO8Xqqlic
 or5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6SpmYjbDA2VZHCXdxYH4FRULNvA8XJh57E6gm5kBBno=;
 b=sTif+ULYyIt9WBEKnzY0RIKyjJDxoUobUfqcn/mW8b5aYbrFpLE2tjkt9NyoLsyp1o
 LjvQz/0B2eysDGVZmQi4SuzN2gq2A9m+Y0f+PoUWjYjwz4jBkVaVa8Bucm2QwTuAmhOg
 jN7wBzneadajbvUGzWmjLyIuzZ+xogA3670CXnoskpbGgesAnx0X2vprpBhsRe98814e
 SwUuTdqrVNwlgJY1Qa4yI11EIGd57ydEaqYbFl4WdFzVr5IJkV2asnh4d91WJt2VMFFO
 +OGe3DQ8ay9yJxELKjDUAwoHf76WY/lQrFBG5pRvqsG5naJV2ERmWlUHDuHkde4f2XIm
 WE2A==
X-Gm-Message-State: AOAM531KUHIytAudzjXdHXgeeu9poXhte+6tHnEIyrr0zRR5RhXNg5cR
 l0Da6ObuZMI2RKgaVtwoe4/8iZ/9HHi5HE8zmKw=
X-Google-Smtp-Source: ABdhPJz8sBzkpgKrdhDCiR0zOFyxKvu+Kl0oVp23M/rlBJq8t/JdaWYpv3ZBMKnc68C9wmbmNRUL8I523Qt8bIiGeW8=
X-Received: by 2002:a05:6808:25a:: with SMTP id
 m26mr20025949oie.52.1624876338975; 
 Mon, 28 Jun 2021 03:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
In-Reply-To: <20210628103309.GA205554@storage2.sh.intel.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 28 Jun 2021 18:32:07 +0800
Message-ID: <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To: Liu Xiaodong <xiaodong.liu@intel.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, dan.carpenter@oracle.com,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, axboe@kernel.dk, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

On Mon, 28 Jun 2021 at 10:55, Liu Xiaodong <xiaodong.liu@intel.com> wrote:
>
> On Tue, Jun 15, 2021 at 10:13:21PM +0800, Xie Yongji wrote:
> >
> > This series introduces a framework that makes it possible to implement
> > software-emulated vDPA devices in userspace. And to make it simple, the
> > emulated vDPA device's control path is handled in the kernel and only the
> > data path is implemented in the userspace.
> >
> > Since the emuldated vDPA device's control path is handled in the kernel,
> > a message mechnism is introduced to make userspace be aware of the data
> > path related changes. Userspace can use read()/write() to receive/reply
> > the control messages.
> >
> > In the data path, the core is mapping dma buffer into VDUSE daemon's
> > address space, which can be implemented in different ways depending on
> > the vdpa bus to which the vDPA device is attached.
> >
> > In virtio-vdpa case, we implements a MMU-based on-chip IOMMU driver with
> > bounce-buffering mechanism to achieve that. And in vhost-vdpa case, the dma
> > buffer is reside in a userspace memory region which can be shared to the
> > VDUSE userspace processs via transferring the shmfd.
> >
> > The details and our user case is shown below:
> >
> > ------------------------    -------------------------   ----------------------------------------------
> > |            Container |    |              QEMU(VM) |   |                               VDUSE daemon |
> > |       ---------      |    |  -------------------  |   | ------------------------- ---------------- |
> > |       |dev/vdx|      |    |  |/dev/vhost-vdpa-x|  |   | | vDPA device emulation | | block driver | |
> > ------------+-----------     -----------+------------   -------------+----------------------+---------
> >             |                           |                            |                      |
> >             |                           |                            |                      |
> > ------------+---------------------------+----------------------------+----------------------+---------
> > |    | block device |           |  vhost device |            | vduse driver |          | TCP/IP |    |
> > |    -------+--------           --------+--------            -------+--------          -----+----    |
> > |           |                           |                           |                       |        |
> > | ----------+----------       ----------+-----------         -------+-------                |        |
> > | | virtio-blk driver |       |  vhost-vdpa driver |         | vdpa device |                |        |
> > | ----------+----------       ----------+-----------         -------+-------                |        |
> > |           |      virtio bus           |                           |                       |        |
> > |   --------+----+-----------           |                           |                       |        |
> > |                |                      |                           |                       |        |
> > |      ----------+----------            |                           |                       |        |
> > |      | virtio-blk device |            |                           |                       |        |
> > |      ----------+----------            |                           |                       |        |
> > |                |                      |                           |                       |        |
> > |     -----------+-----------           |                           |                       |        |
> > |     |  virtio-vdpa driver |           |                           |                       |        |
> > |     -----------+-----------           |                           |                       |        |
> > |                |                      |                           |    vdpa bus           |        |
> > |     -----------+----------------------+---------------------------+------------           |        |
> > |                                                                                        ---+---     |
> > -----------------------------------------------------------------------------------------| NIC |------
> >                                                                                          ---+---
> >                                                                                             |
> >                                                                                    ---------+---------
> >                                                                                    | Remote Storages |
> >                                                                                    -------------------
> >
> > We make use of it to implement a block device connecting to
> > our distributed storage, which can be used both in containers and
> > VMs. Thus, we can have an unified technology stack in this two cases.
> >
> > To test it with null-blk:
> >
> >   $ qemu-storage-daemon \
> >       --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
> >       --monitor chardev=charmonitor \
> >       --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
> >       --export type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128
> >
> > The qemu-storage-daemon can be found at https://github.com/bytedance/qemu/tree/vduse
> >
> > To make the userspace VDUSE processes such as qemu-storage-daemon able to
> > be run by an unprivileged user. We did some works on virtio driver to avoid
> > trusting device, including:
> >
> >   - validating the used length:
> >
> >     * https://lore.kernel.org/lkml/20210531135852.113-1-xieyongji@bytedance.com/
> >     * https://lore.kernel.org/lkml/20210525125622.1203-1-xieyongji@bytedance.com/
> >
> >   - validating the device config:
> >
> >     * https://lore.kernel.org/lkml/20210615104810.151-1-xieyongji@bytedance.com/
> >
> >   - validating the device response:
> >
> >     * https://lore.kernel.org/lkml/20210615105218.214-1-xieyongji@bytedance.com/
> >
> > Since I'm not sure if I missing something during auditing, especially on some
> > virtio device drivers that I'm not familiar with, we limit the supported device
> > type to virtio block device currently. The support for other device types can be
> > added after the security issue of corresponding device driver is clarified or
> > fixed in the future.
> >
> > Future work:
> >   - Improve performance
> >   - Userspace library (find a way to reuse device emulation code in qemu/rust-vmm)
> >   - Support more device types
> >
> > V7 to V8:
> > - Rebased to newest kernel tree
> > - Rework VDUSE driver to handle the device's control path in kernel
> > - Limit the supported device type to virtio block device
> > - Export free_iova_fast()
> > - Remove the virtio-blk and virtio-scsi patches (will send them alone)
> > - Remove all module parameters
> > - Use the same MAJOR for both control device and VDUSE devices
> > - Avoid eventfd cleanup in vduse_dev_release()
> >
> > V6 to V7:
> > - Export alloc_iova_fast()
> > - Add get_config_size() callback
> > - Add some patches to avoid trusting virtio devices
> > - Add limited device emulation
> > - Add some documents
> > - Use workqueue to inject config irq
> > - Add parameter on vq irq injecting
> > - Rename vduse_domain_get_mapping_page() to vduse_domain_get_coherent_page()
> > - Add WARN_ON() to catch message failure
> > - Add some padding/reserved fields to uAPI structure
> > - Fix some bugs
> > - Rebase to vhost.git
> >
> > V5 to V6:
> > - Export receive_fd() instead of __receive_fd()
> > - Factor out the unmapping logic of pa and va separatedly
> > - Remove the logic of bounce page allocation in page fault handler
> > - Use PAGE_SIZE as IOVA allocation granule
> > - Add EPOLLOUT support
> > - Enable setting API version in userspace
> > - Fix some bugs
> >
> > V4 to V5:
> > - Remove the patch for irq binding
> > - Use a single IOTLB for all types of mapping
> > - Factor out vhost_vdpa_pa_map()
> > - Add some sample codes in document
> > - Use receice_fd_user() to pass file descriptor
> > - Fix some bugs
> >
> > V3 to V4:
> > - Rebase to vhost.git
> > - Split some patches
> > - Add some documents
> > - Use ioctl to inject interrupt rather than eventfd
> > - Enable config interrupt support
> > - Support binding irq to the specified cpu
> > - Add two module parameter to limit bounce/iova size
> > - Create char device rather than anon inode per vduse
> > - Reuse vhost IOTLB for iova domain
> > - Rework the message mechnism in control path
> >
> > V2 to V3:
> > - Rework the MMU-based IOMMU driver
> > - Use the iova domain as iova allocator instead of genpool
> > - Support transferring vma->vm_file in vhost-vdpa
> > - Add SVA support in vhost-vdpa
> > - Remove the patches on bounce pages reclaim
> >
> > V1 to V2:
> > - Add vhost-vdpa support
> > - Add some documents
> > - Based on the vdpa management tool
> > - Introduce a workqueue for irq injection
> > - Replace interval tree with array map to store the iova_map
> >
> > Xie Yongji (10):
> >   iova: Export alloc_iova_fast() and free_iova_fast();
> >   file: Export receive_fd() to modules
> >   eventfd: Increase the recursion depth of eventfd_signal()
> >   vhost-iotlb: Add an opaque pointer for vhost IOTLB
> >   vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
> >   vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
> >   vdpa: Support transferring virtual addressing during DMA mapping
> >   vduse: Implement an MMU-based IOMMU driver
> >   vduse: Introduce VDUSE - vDPA Device in Userspace
> >   Documentation: Add documentation for VDUSE
> >
> >  Documentation/userspace-api/index.rst              |    1 +
> >  Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
> >  Documentation/userspace-api/vduse.rst              |  222 +++
> >  drivers/iommu/iova.c                               |    2 +
> >  drivers/vdpa/Kconfig                               |   10 +
> >  drivers/vdpa/Makefile                              |    1 +
> >  drivers/vdpa/ifcvf/ifcvf_main.c                    |    2 +-
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c                  |    2 +-
> >  drivers/vdpa/vdpa.c                                |    9 +-
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c                   |    8 +-
> >  drivers/vdpa/vdpa_user/Makefile                    |    5 +
> >  drivers/vdpa/vdpa_user/iova_domain.c               |  545 ++++++++
> >  drivers/vdpa/vdpa_user/iova_domain.h               |   73 +
> >  drivers/vdpa/vdpa_user/vduse_dev.c                 | 1453 ++++++++++++++++++++
> >  drivers/vdpa/virtio_pci/vp_vdpa.c                  |    2 +-
> >  drivers/vhost/iotlb.c                              |   20 +-
> >  drivers/vhost/vdpa.c                               |  148 +-
> >  fs/eventfd.c                                       |    2 +-
> >  fs/file.c                                          |    6 +
> >  include/linux/eventfd.h                            |    5 +-
> >  include/linux/file.h                               |    7 +-
> >  include/linux/vdpa.h                               |   21 +-
> >  include/linux/vhost_iotlb.h                        |    3 +
> >  include/uapi/linux/vduse.h                         |  143 ++
> >  24 files changed, 2641 insertions(+), 50 deletions(-)
> >  create mode 100644 Documentation/userspace-api/vduse.rst
> >  create mode 100644 drivers/vdpa/vdpa_user/Makefile
> >  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
> >  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
> >  create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
> >  create mode 100644 include/uapi/linux/vduse.h
> >
> > --
> > 2.11.0
>
> Hi, Yongji
>
> Great work! your method is really wise that implements a software IOMMU
> so that data path gets processed by userspace application efficiently.
> Sorry, I've just realized your work and patches.
>
>
> I was working on a similar thing aiming to get vhost-user-blk device
> from SPDK vhost-target to be exported as local host kernel block device.
> It's diagram is like this:
>
>
>                                 -----------------------------
> ------------------------        |    -----------------      |    ---------------------------------------
> |   <RunC Container>   |     <<<<<<<<| Shared-Memory |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>        |
> |       ---------      |     v  |    -----------------      |    |                            v        |
> |       |dev/vdx|      |     v  |   <virtio-local-agent>    |    |      <Vhost-user Target>   v        |
> ------------+-----------     v  | ------------------------  |    |  --------------------------v------  |
>             |                v  | |/dev/virtio-local-ctrl|  |    |  | unix socket |   |block driver |  |
>             |                v  ------------+----------------    --------+--------------------v---------
>             |                v              |                            |                    v
> ------------+----------------v--------------+----------------------------+--------------------v--------|
> |    | block device |        v      |  Misc device |                     |                    v        |
> |    -------+--------        v      --------+-------                     |                    v        |
> |           |                v              |                            |                    v        |
> | ----------+----------      v              |                            |                    v        |
> | | virtio-blk driver |      v              |                            |                    v        |
> | ----------+----------      v              |                            |                    v        |
> |           | virtio bus     v              |                            |                    v        |
> |   --------+---+-------     v              |                            |                    v        |
> |               |            v              |                            |                    v        |
> |               |            v              |                            |                    v        |
> |     ----------+----------  v     ---------+-----------                 |                    v        |
> |     | virtio-blk device |--<----| virtio-local driver |----------------<                    v        |
> |     ----------+----------       ----------+-----------                                      v        |
> |                                                                                    ---------+--------|
> -------------------------------------------------------------------------------------| RNIC |--| PCIe |-
>                                                                                      ----+---  | NVMe |
>                                                                                          |     --------
>                                                                                 ---------+---------
>                                                                                 | Remote Storages |
>                                                                                 -------------------
>

Oh, yes, this design is similar to VDUSE.

>
> I just draft out. an initial proof version. When seeing your RFC mail,
> I'm thinking that SPDK target may depends on your work, so I could
> directly drop mine.

Great to hear that! I think we can extend VDUSE to meet your needs.
But I prefer to do that after this initial version merged.

> But after a glance of the RFC patches, seems it is not so easy or
> efficient to get vduse leveraged by SPDK.
> (Please correct me, if I get wrong understanding on vduse. :) )
>
> The large barrier is bounce-buffer mapping: SPDK requires hugepages
> for NVMe over PCIe and RDMA, so take some preallcoated hugepages to
> map as bounce buffer is necessary. Or it's hard to avoid an extra
> memcpy from bounce-buffer to hugepage.
> If you can add an option to map hugepages as bounce-buffer,
> then SPDK could also be a potential user of vduse.
>

I think we can support registering user space memory for bounce-buffer
use like XDP does. But this needs to pin the pages, so I didn't
consider it in this initial version.

> It would be better if SPDK vhost-target could leverage the datapath of
> vduse directly and efficiently. Even the control path is vdpa based,
> we may work out one daemon as agent to bridge SPDK vhost-target with vduse.
> Then users who already deployed SPDK vhost-target, can smoothly run
> some agent daemon without code modification on SPDK vhost-target itself.

That's a good idea!

> (It is only better-to-have for SPDK vhost-target app, not mandatory for SPDK) :)
> At least, some small barrier is there that blocked a vhost-target use vduse
> datapath efficiently:
> - Current IO completion irq of vduse is IOCTL based. If add one option
> to get it eventfd based, then vhost-target can directly notify IO
> completion via negotiated eventfd.
>

Make sense. Actually we did use the eventfd mechanism for this purpose
in the old version. But using ioctl would be simple, so we choose it
in this initial version.

Thanks,
Yongji
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
